package com.c3rberuss.crediapp;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.Dialog;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.os.SystemClock;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.amn.easysharedpreferences.EasySharedPreferenceConfig;
import com.c3rberuss.crediapp.activities.CalculadoraActivity;
import com.c3rberuss.crediapp.activities.ClientesActivity;
import com.c3rberuss.crediapp.activities.CobrosDiaActivity;
import com.c3rberuss.crediapp.activities.ListaCandidatosActivity;
import com.c3rberuss.crediapp.activities.ListaSolicitudesActivity;
import com.c3rberuss.crediapp.activities.LoginActivity;
import com.c3rberuss.crediapp.activities.PrestamosActivity;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Abono;
import com.c3rberuss.crediapp.entities.ArchivoLog;
import com.c3rberuss.crediapp.entities.ClienteLog;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.entities.FiadorLog;
import com.c3rberuss.crediapp.entities.GarantiaLog;
import com.c3rberuss.crediapp.entities.PrestamoDetalleLog;
import com.c3rberuss.crediapp.entities.PrestamoLog;
import com.c3rberuss.crediapp.entities.ReferenciaLog;
import com.c3rberuss.crediapp.entities.ResponseServer;
import com.c3rberuss.crediapp.entities.SolicitudCreditoLog;
import com.c3rberuss.crediapp.entities.SolicitudDetalleLog;
import com.c3rberuss.crediapp.entities.Usuario;
import com.c3rberuss.crediapp.providers.WebService;
import com.c3rberuss.crediapp.utils.Dialogs;
import com.c3rberuss.crediapp.utils.Email;
import com.c3rberuss.crediapp.utils.Functions;
import com.c3rberuss.crediapp.utils.Permisos;
import com.c3rberuss.crediapp.utils.Stats;
import com.c3rberuss.crediapp.utils.deleteAsyncTask;
import com.c3rberuss.crediapp.utils.insertAsyncTask;
import com.google.gson.GsonBuilder;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {

    public static WebService ws;
    @BindView(R.id.cardClientes)
    CardView cardClientes;
    @BindView(R.id.cardPrestamo)
    CardView cardPrestamo;
    @BindView(R.id.cardVerificaciones)
    CardView cardVerificaciones;
    @BindView(R.id.cardCalcular)
    CardView cardCalcular;
    @BindView(R.id.cardSincronizarPrestamos)
    CardView cardSincronizarPrestamos;
    @BindView(R.id.cardCobrosProcesados)
    CardView cardCobrosProcesados;
    @BindView(R.id.cardCobrosPendientes)
    CardView cardCobrosPendientes;
    @BindView(R.id.lblSinSincronizar)
    TextView sinSincronizar;
    @BindView(R.id.lblCobrosPendientes)
    TextView lblCobrosPendientes;
    @BindView(R.id.lblCobrosProcesados)
    TextView lblCobrosProcesados;
    @BindView(R.id.cardRefinanciamiento)
    CardView cardRefinanciamiento;

    Menu global_menu;

    private Retrofit retrofit;

    private AppDatabase db;
    private Dialog dialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setLanguage(this);

        setContentView(R.layout.activity_main);
        ButterKnife.bind(this);

        EasySharedPreferenceConfig.Companion
                .initDefault(new EasySharedPreferenceConfig.Builder()
                        .inputFileName("crediapp_preferences").inputMode(Context.MODE_PRIVATE).build());

        this.retrofit = new Retrofit.Builder().baseUrl(WebService.SERVER_URL)
                .addConverterFactory(GsonConverterFactory.create(new GsonBuilder().serializeNulls().create()))
                .build();

        ws = retrofit.create(WebService.class);


        db = AppDatabase.getInstance(this);


        if (!EasySharedPreference.Companion.getBoolean("sesion_activa", false)) {
            goToLogin();
        }else{
            ///
            //

            enableConnection();

            Functions.permisosApp(MainActivity.this);

            dialog = Functions.progressDialog(this, "Descargando datos del servidor, por favor espere.");

            if (EasySharedPreference.Companion.getBoolean("primer_inicio", true)) {
                db.getCobrosProcesados().deleteAll();
                db.prestamoDao().deleteAll2();
                db.prestamoDetalleDao().deleteAll2();
                db.getAbonoDao().deleteAll();
                EasySharedPreference.Companion.putBoolean("primer_inicio", false);
            }

            ws.validar().enqueue(new Callback<ResponseServer>() {
                @Override
                public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                    if (response.code() == 200) {
                        if (response.body().getStatus().equals("MANTENIMIENTO")) {

                            Dialogs.appVersionAntigua(MainActivity.this, "Mantenimiento", response.body().getMessage(), kAlertDialog -> {

                                kAlertDialog.dismiss();
                                MainActivity.this.finish();
                            }).show();

                        } else {
                            Dialogs.appVersionAntigua(MainActivity.this, "App desactualizada", response.body().getMessage(), kAlertDialog -> {

                                final Intent intent = new Intent(Intent.ACTION_VIEW);
                                //Copy App URL from Google Play Store.
                                intent.setData(Uri.parse("https://play.google.com/store/apps/details?id=com.c3rberuss.crediapp&hl=es"));
                                startActivity(intent);

                                kAlertDialog.dismiss();
                                MainActivity.this.finish();
                            }).show();
                        }

                    }
                }

                @Override
                public void onFailure(Call<ResponseServer> call, Throwable t) {

                }
            });

            if(Functions.canUpdateNow(this)){
                updatePermisos(this);
            }

            cardPrestamo.setVisibility(Permisos.tiene("admin_solicitudes", this));
            cardClientes.setVisibility(Permisos.tiene("admin_clientes", this));
            cardRefinanciamiento.setVisibility(Permisos.tiene("refinanciar", this));
            cardVerificaciones.setVisibility(Permisos.tiene("admin_cobro", this));

            //cardSincronizarPrestamos.setVisibility(Permisos.tiene("admin_cobro", this));
            cardCobrosPendientes.setVisibility(Permisos.tiene("admin_cobro", this));
            cardCobrosProcesados.setVisibility(Permisos.tiene("admin_cobro", this));
            cardCalcular.setVisibility(Permisos.tiene("calcular_cuotas", this));

            db.prestamoDao().getCountPrestamosPendientes(Functions.getFecha()).observe(this, value -> {
                lblCobrosPendientes.setText(String.valueOf(value));
            });

            db.prestamoDao().getCountNoSincronizado().observe(this, value -> {
                sinSincronizar.setText(String.valueOf(value));
            });

            db.getCobrosProcesados().getCount(db.getUsuarioDao().getId()).observe(this, val -> {
                lblCobrosProcesados.setText(String.valueOf(val == null ? 0 : val));
            });
            //startService(new Intent(this, TrackingService.class));

            setupSincronizador();
            //startService(new Intent(this, TrackingService.class));

            Functions.startService(MainActivity.this);


            Log.e("TIME", Functions.getTimeBefore(15));
        }

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);

        global_menu = menu;

        for (int i = 0; i < menu.size(); i++) {

            if (menu.getItem(i).getItemId() == R.id.backup) {
                if (Permisos.tiene_("sincronizar_cambios", this)) {
                    menu.getItem(i).setVisible(true);
                } else {
                    menu.getItem(i).setVisible(false);
                }
            } else if (menu.getItem(i).getItemId() == R.id.delete) {
                if (Permisos.tiene_("eliminar_datos", this)) {
                    menu.getItem(i).setVisible(true);
                } else {
                    menu.getItem(i).setVisible(false);
                }
            }

        }

        return true;
    }


    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        switch (item.getItemId()) {
            case R.id.menu_logout:
                System.out.println("LOGOUT :)");
                EasySharedPreference.Companion.putBoolean("sesion_activa", false);

/*                final Intent intentTrack = new Intent(this, TrackingService.class);
                stopService(intentTrack);*/

                final Intent intent = new Intent(this, LoginActivity.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
                startActivity(intent);
                this.finish();
                break;
            case R.id.backup:
                System.out.println("BACKUP :)");
                backup();
                break;
            case R.id.update:
                System.out.println("UPDATE :)");
                //new insertAsyncTask(db, dialog).execute();
                updatePermisos(this);
                break;

            case R.id.delete:
                System.out.println("DELETE :)");
                final Dialog dialogDelete = Functions.progressDialog(this, "Eliminando datos, por favor espere.");
                new deleteAsyncTask(db, dialogDelete).execute();
                updatePermisos(this);
                break;
        }

        return true;
    }

    @OnClick({R.id.cardClientes, R.id.cardPrestamo, R.id.cardVerificaciones, R.id.cardCalcular, R.id.cardRefinanciamiento, R.id.cardSincronizarPrestamos, R.id.cardCobrosProcesados, R.id.cardCobrosPendientes})
    public void onViewClicked(View view) {

        Intent intent;

        switch (view.getId()) {
            case R.id.cardClientes:
                intent = new Intent(this, ClientesActivity.class);
                startActivity(intent);
                break;
            case R.id.cardPrestamo:
                intent = new Intent(this, ListaSolicitudesActivity.class);
                startActivity(intent);
                break;
            case R.id.cardVerificaciones:
                intent = new Intent(this, PrestamosActivity.class);
                startActivity(intent);
                break;
            case R.id.cardCalcular:
                intent = new Intent(this, CalculadoraActivity.class);
                startActivity(intent);
                break;
            case R.id.cardRefinanciamiento:
                intent = new Intent(this, ListaCandidatosActivity.class);
                startActivity(intent);
                break;
            case R.id.cardSincronizarPrestamos:
                //getTasks();
                //Functions.subirCambios(this, true);
                Functions.subirCambiosNoAsync(this);
                break;
            case R.id.cardCobrosProcesados:
                //showTotalCobros();
                intent = new Intent(this, CobrosDiaActivity.class);
                startActivity(intent);
                break;
        }
    }

    public void setupSincronizador() {

/*        final Intent alarmIntent = new Intent(this, Sincronizador.class);
        final PendingIntent pendingIntent = PendingIntent.getBroadcast(this, 666, alarmIntent, PendingIntent.FLAG_UPDATE_CURRENT);
        final AlarmManager alarmManager = (AlarmManager) getSystemService(Context.ALARM_SERVICE);

        final long afterOneMinute = SystemClock.elapsedRealtime() + (10 * 60 * 1000);
        alarmManager.setInexactRepeating(AlarmManager.ELAPSED_REALTIME_WAKEUP,
                afterOneMinute,
                10 * 60 * 1000,
                pendingIntent);*/


        final Intent backupIntent = new Intent(this, Stats.class);
        final PendingIntent backupPendingIntent = PendingIntent.getBroadcast(this, 555, backupIntent, PendingIntent.FLAG_UPDATE_CURRENT);
        final AlarmManager backupAlarmManager = (AlarmManager) getSystemService(Context.ALARM_SERVICE);

        backupAlarmManager.setInexactRepeating(AlarmManager.ELAPSED_REALTIME_WAKEUP,
                SystemClock.elapsedRealtime() + (60 * 1000),
                (300 * 60 * 1000),
                backupPendingIntent);
    }

    @Override
    protected void onStart() {
        super.onStart();
        //Functions.permisosApp(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
        //Functions.permisosApp(this);
    }

    private void enableConnection(){
        WifiManager wifiManager = (WifiManager)getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        ConnectivityManager connectivityManager = (ConnectivityManager) getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE);

        if(!wifiManager.isWifiEnabled()){
            wifiManager.setWifiEnabled(true);
        }
    }

    private void backup() {

        final List<String> urls = new ArrayList<>();

        String url_tmp;

        final List<ClienteLog> clientes = db.getLogDao().getClientes();

        url_tmp = Functions.toCSV(ClienteLog.class, clientes, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        final List<PrestamoDetalleLog> prestamosDetalle = db.getLogDao().getPrestamosDetalle();

        url_tmp = Functions.toCSV(PrestamoDetalleLog.class, prestamosDetalle, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        final List<PrestamoLog> prestamoLogs = db.getLogDao().getPrestamos();
        url_tmp = Functions.toCSV(PrestamoLog.class, prestamoLogs, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        final List<ArchivoLog> archivoLogs = db.getLogDao().getArchivos();
        url_tmp = Functions.toCSV(ArchivoLog.class, archivoLogs, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        final List<GarantiaLog> garantiaLogs = db.getLogDao().getGarantias();
        url_tmp = Functions.toCSV(GarantiaLog.class, garantiaLogs, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        final List<ReferenciaLog> referenciaLogs = db.getLogDao().getReferencias();
        url_tmp = Functions.toCSV(ReferenciaLog.class, referenciaLogs, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        final List<FiadorLog> fiadorLogs = db.getLogDao().getFiadores();
        url_tmp = Functions.toCSV(FiadorLog.class, fiadorLogs, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        final List<SolicitudCreditoLog> solicitudCreditoLogs = db.getLogDao().getSolicitudes();
        url_tmp = Functions.toCSV(SolicitudCreditoLog.class, solicitudCreditoLogs, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        final List<SolicitudDetalleLog> solicitudDetalleLogs = db.getLogDao().getSolicitudesDetalle();
        url_tmp = Functions.toCSV(SolicitudDetalleLog.class, solicitudDetalleLogs, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        final List<CobroProcesado> cobroProcesados = db.getCobrosProcesados().getAll();
        url_tmp = Functions.toCSV(CobroProcesado.class, cobroProcesados, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }


        final List<Abono> abonos = db.getCobrosProcesados().getAllAbono();
        url_tmp = Functions.toCSV(Abono.class, abonos, this);

        if (!url_tmp.isEmpty()) {
            urls.add(url_tmp);
        }

        if (urls.size() > 0) {
            Email.sendMultiFiles(urls, "Últimos procesos realizados desde la app", "Backup Manual - " + db.getUsuarioDao().getNombre());
            Dialogs.success(this, "Éxito", "Archivos generados!", null).show();
        }


    }

    private void updatePermisos(Context context) {

/*        final Dialog verificar = Functions.progressDialog(context, "Verificando credenciales, espere un momento.");
        verificar.show();

        final OnVerify onVerify = new OnVerify() {
            @Override
            public void verify(boolean successful, Usuario usuario) {

                if(successful){

                    db.getUsuarioDao().deleteAll();
                    db.getUsuarioDao().insert(usuario);

                    db.getPermisoDao().deleteAll();
                    db.getPermisoDao().insert(usuario.getPermisos());

                    cardPrestamo.setVisibility(Permisos.tiene("admin_solicitudes", MainActivity.this));
                    cardClientes.setVisibility(Permisos.tiene("admin_clientes", MainActivity.this));
                    cardRefinanciamiento.setVisibility(Permisos.tiene("refinanciar", MainActivity.this));
                    cardVerificaciones.setVisibility(Permisos.tiene("admin_cobro", MainActivity.this));

                    //cardSincronizarPrestamos.setVisibility(Permisos.tiene("admin_cobro", MainActivity.this));
                    cardCobrosPendientes.setVisibility(Permisos.tiene("admin_cobro", MainActivity.this));
                    cardCobrosProcesados.setVisibility(Permisos.tiene("admin_cobro", MainActivity.this));
                    cardCalcular.setVisibility(Permisos.tiene("calcular_cuotas", MainActivity.this));

                    if (global_menu != null) {

                        for (int i = 0; i < global_menu.size(); i++) {

                            if (global_menu.getItem(i).getItemId() == R.id.backup) {
                                System.out.println("BACKUP");
                                if (Permisos.tiene_("sincronizar_cambios", context)) {
                                    global_menu.getItem(i).setVisible(true);
                                } else {
                                    global_menu.getItem(i).setVisible(false);
                                }
                            } else if (global_menu.getItem(i).getItemId() == R.id.delete) {
                                System.out.println("DELETE");
                                if (Permisos.tiene_("eliminar_datos", context)) {
                                    global_menu.getItem(i).setVisible(true);
                                } else {
                                    global_menu.getItem(i).setVisible(false);
                                }
                            }

                        }
                    }

                    verificar.dismiss();

                    //obtener todo
                    new insertAsyncTask(db, dialog).execute();
                    //fin obtener todo

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        System.out.println("START SERVICE");
                        startForegroundService(new Intent(MainActivity.this, TrackingService.class));
                    } else {
                        System.out.println("START SERVICE 2");
                        startService(new Intent(MainActivity.this, TrackingService.class));
                    }

                }else{
                    verificar.dismiss();
                    EasySharedPreference.Companion.putBoolean("sesion_activa", false);
                    db.getUsuarioDao().delete();

                    goToLogin();
                }

            }

            @Override
            public void ondefault() {
                goToLogin();
            }
        };

        new VerificarCrendencialesTask(onVerify,this).execute(this);*/

        if (EasySharedPreference.Companion.getBoolean("sesion_activa", false)) {

            final Dialog verificar = Functions.progressDialog(this, "Verificando credenciales, espere un momento.");
            verificar.show();

            ws.auth(EasySharedPreference.Companion.getString("usr", "c3rberuss"),
                    EasySharedPreference.Companion.getString("pss", "0000")).enqueue(new Callback<Usuario>() {
                @Override
                public void onResponse(Call<Usuario> call, Response<Usuario> response) {
                    if (response.isSuccessful() && response.code() == 200) {

                        db.getUsuarioDao().deleteAll();
                        db.getUsuarioDao().insert(response.body());

                        db.getPermisoDao().deleteAll();
                        db.getPermisoDao().insert(response.body().getPermisos());

                        cardPrestamo.setVisibility(Permisos.tiene("admin_solicitudes", MainActivity.this));
                        cardClientes.setVisibility(Permisos.tiene("admin_clientes", MainActivity.this));
                        cardRefinanciamiento.setVisibility(Permisos.tiene("refinanciar", MainActivity.this));
                        cardVerificaciones.setVisibility(Permisos.tiene("admin_cobro", MainActivity.this));

                        //cardSincronizarPrestamos.setVisibility(Permisos.tiene("admin_cobro", MainActivity.this));
                        cardCobrosPendientes.setVisibility(Permisos.tiene("admin_cobro", MainActivity.this));
                        cardCobrosProcesados.setVisibility(Permisos.tiene("admin_cobro", MainActivity.this));
                        cardCalcular.setVisibility(Permisos.tiene("calcular_cuotas", MainActivity.this));

                        if (global_menu != null) {

                            for (int i = 0; i < global_menu.size(); i++) {

                                if (global_menu.getItem(i).getItemId() == R.id.backup) {
                                    System.out.println("BACKUP");
                                    if (Permisos.tiene_("sincronizar_cambios", context)) {
                                        global_menu.getItem(i).setVisible(true);
                                    } else {
                                        global_menu.getItem(i).setVisible(false);
                                    }
                                } else if (global_menu.getItem(i).getItemId() == R.id.delete) {
                                    System.out.println("DELETE");
                                    if (Permisos.tiene_("eliminar_datos", context)) {
                                        global_menu.getItem(i).setVisible(true);
                                    } else {
                                        global_menu.getItem(i).setVisible(false);
                                    }
                                }

                            }
                        }

                        verificar.dismiss();

                        //obtener todo
                        new insertAsyncTask(db, dialog).execute();

                        //fin obtener todo

                        /*if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            System.out.println("START SERVICE");
                            startForegroundService(new Intent(MainActivity.this, TrackingService.class));
                        } else {
                            System.out.println("START SERVICE 2");
                            startService(new Intent(MainActivity.this, TrackingService.class));
                        }*/

                    } else {
                        verificar.dismiss();
                        EasySharedPreference.Companion.putBoolean("sesion_activa", false);
                        db.getUsuarioDao().delete();

                        goToLogin();
                    }

                }

                @Override
                public void onFailure(Call<Usuario> call, Throwable t) {
                    verificar.dismiss();
                }
            });

        } else {
            goToLogin();
        }
    }

    private void setLanguage(Activity activity) {

        final Locale localizacion = new Locale("es", "SV");

        Locale.setDefault(localizacion);
        Configuration config = new Configuration();
        config.locale = localizacion;
        activity.getBaseContext().getResources()
                .updateConfiguration(config, this.getResources().getDisplayMetrics());
    }

    private void showTotalCobros() {

        final Dialog dialog = new Dialog(this);
        dialog.setContentView(R.layout.cobros_hoy_layout);

        final TextView lblTotalCobros = dialog.findViewById(R.id.lblTotalCobros);
        final Button btnAceptar = dialog.findViewById(R.id.btnAceptar);

        db.getCobrosProcesados().getTotal(db.getUsuarioDao().getId()).observe(this, val -> {
            final String total = val == null ? "$0.0" : "$" + Functions.round2decimals(val);
            lblTotalCobros.setText(total);
        });

        btnAceptar.setOnClickListener(v -> dialog.dismiss());

        dialog.show();

    }

    private void goToLogin() {
        final Intent intent = new Intent(this, LoginActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
        startActivity(intent);
        this.finish();
    }

}
