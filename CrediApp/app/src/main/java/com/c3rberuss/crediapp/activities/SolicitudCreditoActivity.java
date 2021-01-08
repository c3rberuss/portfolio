package com.c3rberuss.crediapp.activities;

import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.MenuItem;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.Fiador;
import com.c3rberuss.crediapp.entities.Garantia;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.PlanRequisito;
import com.c3rberuss.crediapp.entities.SolicitudCredito;
import com.c3rberuss.crediapp.entities.SolicitudDetalle;
import com.c3rberuss.crediapp.forms.CuotasStep;
import com.c3rberuss.crediapp.forms.FiadorStep;
import com.c3rberuss.crediapp.forms.GarantiasStep;
import com.c3rberuss.crediapp.forms.InformacionGeneralStep;
import com.c3rberuss.crediapp.forms.PlanesStep;
import com.c3rberuss.crediapp.utils.Dialogs;
import com.c3rberuss.crediapp.utils.Functions;
import com.developer.kalert.KAlertDialog;
import com.google.gson.Gson;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import ernestoyaquello.com.verticalstepperform.VerticalStepperFormView;
import ernestoyaquello.com.verticalstepperform.listener.StepperFormListener;
import okhttp3.MultipartBody;

public class SolicitudCreditoActivity extends AppCompatActivity implements StepperFormListener {

    public static InformacionGeneralStep infoStep;
    private VerticalStepperFormView stepper;
    public static CuotasStep cuotasStep;
    public static PlanesStep planesStep;
    public static GarantiasStep garantiasStep;
    public static FiadorStep fiadorStep;
    private static Context context;
    private static LayoutInflater inflater;

    private static final String CERO = "0";

    private List<PlanRequisito> planes = new ArrayList<>();

    //Calendario para obtener fecha & hora
    public final Calendar c = Calendar.getInstance();

    //Variables para obtener la fecha
    final int mes = c.get(Calendar.MONTH);
    final int dia = c.get(Calendar.DAY_OF_MONTH);
    final int anio = c.get(Calendar.YEAR);

    private AppDatabase db;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Functions.setLanguage(this);

        setContentView(R.layout.activity_solicitud_credito);

        setTitle("Enviar solicitud de crédito");

        context = getApplicationContext();
        inflater = this.getLayoutInflater();

        db = AppDatabase.getInstance(this);

        /*MainActivity.ws.get_planes().enqueue(new Callback<List<Plan>>() {
            @Override
            public void onResponse(Call<List<Plan>> call, Response<List<Plan>> response) {
                if (response.code() == 200) {
                    planes.clear();
                    planes.addAll(response.body());
                    Log.d("STATUS", "OK");
                }else{
                    Log.d("STATUS", "?");
                }
            }

            @Override
            public void onFailure(Call<List<Plan>> call, Throwable t) {
                Log.e("ERROR", t.getMessage());
            }
        });*/

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);

        Functions.permisosApp(this);

        infoStep = new InformacionGeneralStep("Información General", this);
        cuotasStep = new CuotasStep("Cuotas", this);
        planesStep = new PlanesStep("Planes", this);
        garantiasStep = new GarantiasStep("Garantías", this);
        fiadorStep = new FiadorStep("Fiador", this);

        stepper = findViewById(R.id.stepper_form);

        stepper.setup(this, infoStep, planesStep ,garantiasStep, fiadorStep,cuotasStep)
                .lastStepNextButtonText("Enviar Solicitud")
                .displayBottomNavigation(false)
                .displayCancelButtonInLastStep(true)
                .confirmationStepTitle("Confimación")
                .stepNextButtonText("Continuar")
                .lastStepCancelButtonText("Cancelar")
                .init();


    }

    /*private void changeValues(String monto, String ncuotas, String porcent) {

        monto = monto.isEmpty() ? "0" : monto;
        porcent = porcent.isEmpty() ? "0" : porcent;
        ncuotas = ncuotas.isEmpty() ? "0" : ncuotas;

        final Double calc = Double.parseDouble(monto) + (Double.parseDouble(monto) * (Double.parseDouble(porcent) / 100));
        this.lbl_monto_final.setText(String.valueOf(calc));

        if (Double.parseDouble(ncuotas) < 1) {
            this.lbl_cuota.setText("0.0");
        } else {
            final DecimalFormat df = new DecimalFormat("####.##");
            df.setRoundingMode(RoundingMode.CEILING);

            this.lbl_cuota.setText(df.format(calc / Double.parseDouble(ncuotas)));
        }

    }*/

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }


    @Override
    public void onCompletedForm() {

        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        final SimpleDateFormat stf = new SimpleDateFormat("hh:mm:ss");

        final HashMap<String, Object> data_info = infoStep.getStepData();
        final Plan data_plan = planesStep.getStepData();
        final List<Garantia> data_garantias = garantiasStep.getStepData();
        final HashMap<String, Object> data_fiador = fiadorStep.getStepData();
        final HashMap<String, Object> data_cuotas = cuotasStep.getStepData();

        final SolicitudCredito solicitud = new SolicitudCredito();

        solicitud.setId_cliente(((Cliente) data_info.get("cliente")).getId_cliente());
        solicitud.setFecha(sdf.format(new Date()));
        solicitud.setHora(stf.format(new Date()));
        solicitud.setMonto((Float) data_cuotas.get("monto"));
        solicitud.setCuotas((Float) data_cuotas.get("cuotas"));
        solicitud.setCuota((Float) data_cuotas.get("cuota"));
        solicitud.setFrecuencia((Integer) data_cuotas.get("frecuencia"));
        solicitud.setPorcentaje((Float) data_cuotas.get("porcentaje"));
        solicitud.setFinal_((Float) data_cuotas.get("final"));
        solicitud.setSaldo((Float) data_cuotas.get("final"));
        solicitud.setPlan(data_plan.getId());
        solicitud.setEstado(0);
        solicitud.setDivcontrato((Boolean) data_cuotas.get("divcontrato"));
        solicitud.setId_vendedor(AppDatabase.getInstance(this).getUsuarioDao().getId());
        solicitud.setContrato((float) data_plan.getValor_contrato());
        solicitud.setDestino((String) data_info.get("destino"));
        solicitud.setProcesada(false);

        solicitud.setMora(data_plan.getMora());
        solicitud.setDias_mora(data_plan.getDias_mora());

        final List<SolicitudDetalle> cuotas = new ArrayList<>();
        final Fiador fiador = new Fiador();

        for (String s : (List<String>) data_cuotas.get("fechas")) {
            final SolicitudDetalle cuota = new SolicitudDetalle();

            final int n = ((List<String>) data_cuotas.get("fechas")).indexOf(s) + 1;

            cuota.setCorrelativo(String.format("%d/%d", n, ((List<String>) data_cuotas.get("fechas")).size()));
            cuota.setNcuota(n);
            cuota.setMonto(solicitud.getCuota());

            final String[] fecha = s.split("-");

            //fecha[2]+"-"+fecha[1]+"-"+fecha[0]

            cuota.setFecha_vence(fecha[2]+"-"+fecha[1]+"-"+fecha[0]);

            cuotas.add(cuota);
        }

        if(((Cliente) data_fiador.get("fiador")) != null){

            solicitud.setTiene_fiador(true);

            fiador.setIdFiador(((Cliente) data_fiador.get("fiador")).getId_cliente());

            if((Boolean) data_fiador.get("tiene_negocio")){
                fiador.setNegocio((String) data_fiador.get("nombre_negocio"));
                fiador.setActividad((String) data_fiador.get("actividad_negocio"));
                fiador.setDireccion((String) data_fiador.get("direccion_negocio"));
            }else{
                fiador.setNegocio("");
                fiador.setActividad("");
                fiador.setDireccion("");
            }

            fiador.setTieneNegocio((Boolean) data_fiador.get("tiene_negocio"));

            solicitud.setFiador(fiador);
        }

       /* if(AppDatabase.getInstance(this).getPlanesDao().fiadorRequerido(planesStep.getStepData().getId()) > 0 ){

            solicitud.setTiene_fiador(true);

            fiador.setIdFiador(((Cliente) data_fiador.get("fiador")).getId_cliente());

            if((Boolean) data_fiador.get("tiene_negocio")){
                fiador.setNegocio((String) data_fiador.get("nombre_negocio"));
                fiador.setActividad((String) data_fiador.get("actividad_negocio"));
                fiador.setDireccion((String) data_fiador.get("direccion_negocio"));
            }else{
                fiador.setNegocio("");
                fiador.setActividad("");
                fiador.setDireccion("");
            }

            fiador.setTieneNegocio((Boolean) data_fiador.get("tiene_negocio"));

            solicitud.setFiador(fiador);

        }*/


        Gson gson = new Gson();
        System.out.println(gson.toJson(solicitud));

        System.out.println(gson.toJson(cuotas));
        System.out.println(gson.toJson(data_garantias));

        solicitud.setDetalles(cuotas);

        solicitud.setGarantias(data_garantias);


        final List<MultipartBody.Part> archivos = new ArrayList<>();

        for(Garantia g: solicitud.getGarantias()){
            archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), g.getUrl()));
        }


        if(db.getSolicitudDao().tieneSolicitudPendiente(solicitud.getId_cliente()) == 0 &&
            db.prestamoDao().getPrestamoAprobado(solicitud.getId_cliente()) == 0){

            final Dialog dialog = Functions.progressDialog(this, "Enviando solicitud... Espere un momento.");
            dialog.show();

            //NUEVO

            solicitud.setSincronizada(false);
            long id_solicitud = db.getSolicitudDao().insert(solicitud);

            for(Garantia g: solicitud.getGarantias()){
                solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setSincronizada(false);
                solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setId_prestamo((int) id_solicitud);
                solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setFecha(Functions.getFecha());
            }


            for(SolicitudDetalle d: solicitud.getDetalles()){
                solicitud.getDetalles().get(solicitud.getDetalles().indexOf(d)).setSincronizado(false);
                solicitud.getDetalles().get(solicitud.getDetalles().indexOf(d)).setId_prestamo((int) id_solicitud);
            }

            if(solicitud.isTiene_fiador()){
                solicitud.getFiador().setSincronizado(false);
                solicitud.getFiador().setIdPrestamo((int)id_solicitud);
                fiador.setFecha(Functions.getFecha());
                db.getFiadorDao().insert(solicitud.getFiador());
            }

            db.getSolicitudDetalleDao().insert(solicitud.getDetalles());
            db.getGarantiaDao().insert(solicitud.getGarantias());


            dialog.dismiss();

            final KAlertDialog alert = Dialogs.success(SolicitudCreditoActivity.this,
                    "Exito", "Solicitud guardada exitosamente. ¡Recuede Sincronizar los datos!", v->{

                        v.dismiss();
                        finish();

                    });

            alert.show();

            //FIN NUEVO

            /*ApiProvider.getWebService().post_solicitud(solicitud).enqueue(new Callback<ResponseServer>() {
                @Override
                public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                    if(response.code() == 200){
                        dialog.cancel();

                        final Dialog dialog = Functions.progressDialog(SolicitudCreditoActivity.this, "Subiendo archivos...");
                        dialog.show();

                        ApiProvider.getWebService().subir_documentos(archivos).enqueue(new Callback<ResponseServer>() {
                            @Override
                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                                if(response.code() == 200){
                                    dialog.cancel();
                                    Functions.getSolicitudes(SolicitudCreditoActivity.this);
                                    Dialogs.success(SolicitudCreditoActivity.this, "Exito", "Solicitud enviada exitosamente", v->{
                                        v.dismiss();
                                        finish();
                                    }).show();
                                    Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");
                                }else{
                                    dialog.cancel();
                                    Log.e("UPLOAD", "ERROR AL SUBIR LOS ARCHIVOS");
                                }
                            }

                            @Override
                            public void onFailure(Call<ResponseServer> call, Throwable t) {
                                dialog.cancel();
                                Log.e("UPLOAD", t.getMessage());
                            }
                        });


                    }else{
                        dialog.cancel();
                        //Toast.makeText(context, String.valueOf(response.code()), Toast.LENGTH_LONG).show();
                    }
                }

                @Override
                public void onFailure(Call<ResponseServer> call, Throwable t) {

                    dialog.cancel();

                    //Toast.makeText(context, t.getMessage(), Toast.LENGTH_LONG).show();


                    solicitud.setSincronizada(false);
                    long id_solicitud = db.getSolicitudDao().insert(solicitud);

                    for(Garantia g: solicitud.getGarantias()){
                        solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setSincronizada(false);
                        solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setId_prestamo((int) id_solicitud);
                    }


                    for(SolicitudDetalle d: solicitud.getDetalles()){
                        solicitud.getDetalles().get(solicitud.getDetalles().indexOf(d)).setSincronizado(false);
                        solicitud.getDetalles().get(solicitud.getDetalles().indexOf(d)).setId_prestamo((int) id_solicitud);
                    }

                    if(solicitud.isTiene_fiador()){
                        solicitud.getFiador().setSincronizado(false);
                        solicitud.getFiador().setIdPrestamo((int)id_solicitud);
                        db.getFiadorDao().insert(solicitud.getFiador());
                    }

                    db.getSolicitudDetalleDao().insert(solicitud.getDetalles());
                    db.getGarantiaDao().insert(solicitud.getGarantias());

                    final KAlertDialog alert = Dialogs.success(SolicitudCreditoActivity.this,
                            "Error", "Solicitud no pudo ser enviada. Se guardará localmente y luego se envirá.", v->{
                                v.dismiss();
                                finish();
                            });
                    alert.changeAlertType(KAlertDialog.WARNING_TYPE);

                    alert.show();

                }
            });*/

        }else{

            Dialogs.error(this, "Error",
                    "Al parecer el cliente ya posee una solicitud de crédito.",
                   v->{
                        v.dismiss();
                        finish();
                   }).show();
        }

    }

    @Override
    public void onCancelledForm() {
        this.finish();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(requestCode == GarantiasStep.IMAGE_CAPTURE_GARANTIA && resultCode == RESULT_OK){
            //System.out.println("FUNCIONÓ");

            GarantiasStep.pathFoto = Functions.comprimirImagen(GarantiasStep.pathFoto, this);

            if(!GarantiasStep.pathFoto.isEmpty()){
                Picasso.get().load(new File(GarantiasStep.pathFoto))
                        .centerCrop()
                        .fit()
                        .into(garantiasStep.foto);
            }

        }else if(requestCode == GarantiasStep.IMAGE_CAPTURE_GARANTIA && resultCode == RESULT_CANCELED){
            Functions.borrarArchivo(GarantiasStep.pathFoto);
        }else if (requestCode == GarantiasStep.REQUEST_PICK_IMAGE_GAR && resultCode == RESULT_OK) {

            final Uri imageUri = data.getData();

            GarantiasStep.pathFoto = Functions.getRealPathFromURI(this, imageUri);
            GarantiasStep.pathFoto = Functions.comprimirImagen2(GarantiasStep.pathFoto, this);

            Picasso.get().load(new File(GarantiasStep.pathFoto))
                    .centerCrop()
                    .fit()
                    .into(garantiasStep.foto);


        }

    }
}
