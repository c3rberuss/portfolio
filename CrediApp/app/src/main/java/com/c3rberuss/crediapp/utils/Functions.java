package com.c3rberuss.crediapp.utils;

import android.Manifest;
import android.app.Activity;
import android.app.ActivityManager;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.core.app.ActivityCompat;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.c3rberuss.crediapp.MainActivity;
import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.activities.PrestamoDetalleActivity;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.ClienteDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDetalleDao;
import com.c3rberuss.crediapp.database.dao.SolicitudDao;
import com.c3rberuss.crediapp.database.dao.SolicitudDetalleDao;
import com.c3rberuss.crediapp.entities.Archivo;
import com.c3rberuss.crediapp.entities.ArchivoLog;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.ClienteLog;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.entities.FiadorLog;
import com.c3rberuss.crediapp.entities.Garantia;
import com.c3rberuss.crediapp.entities.GarantiaLog;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.entities.PrestamoDetalleLog;
import com.c3rberuss.crediapp.entities.PrestamoLog;
import com.c3rberuss.crediapp.entities.Referencia;
import com.c3rberuss.crediapp.entities.ReferenciaLog;
import com.c3rberuss.crediapp.entities.ResponseServer;
import com.c3rberuss.crediapp.entities.SolicitudCredito;
import com.c3rberuss.crediapp.entities.SolicitudCreditoLog;
import com.c3rberuss.crediapp.entities.SolicitudDetalle;
import com.c3rberuss.crediapp.entities.SolicitudDetalleLog;
import com.c3rberuss.crediapp.providers.ApiProvider;
import com.c3rberuss.crediapp.providers.WebService;
import com.appsoss.oss.notifications.Notification;
import com.appsoss.oss.notifications.NotificationConfig;
import com.google.gson.Gson;
import com.opencsv.CSVWriter;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.UUID;

import androidx.core.content.ContextCompat;
import id.zelory.compressor.Compressor;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import static com.c3rberuss.crediapp.utils.ArgType.*;

public class Functions {

    //private static Dialog dialog;

    public static HashMap<String, Float> calcularMontoCuota(float monto, float porcentaje, float ncuotas, float proporcion, boolean solointeres) {

        final float monto_original = monto;

        /*Log.e("PORCENTAJE1", String.valueOf(porcentaje));*/

        //proporcion = Math.ceil(ncuotas/proporcion);
        porcentaje = proporcion * (porcentaje / 100);
       /* Log.e("PORCENTAJE2", String.valueOf(porcentaje));
        Log.e("PROPORCION", String.valueOf(proporcion));

        Log.e("MONTO1", String.valueOf(monto));*/
        monto = monto * (1 + porcentaje);
        //Log.e("MONTO2", String.valueOf(monto));

        final float cuota = solointeres ? (monto - monto_original) / ncuotas : monto / ncuotas;

        final HashMap<String, Float> result = new HashMap<>();

        result.put("monto_final", monto);
        result.put("monto_final_", cuota * ncuotas);
        result.put("monto_original", monto_original);
        result.put("cuota", cuota);

        return result;
    }

    public static String intToString2Digits(int number) {
        return (number < 10) ? "0" + number : String.valueOf(number);
    }

    public static String numbersToDate(int day, int month, int year) {
        return intToString2Digits(day) + "-" + intToString2Digits(month + 1) + "-" + year;
    }

    @NonNull
    public static MultipartBody.Part prepareFilePart(String partName, String fileUri) {

        File file = new File(fileUri);

        // create RequestBody instance from file
        RequestBody requestFile =
                RequestBody.create(
                        MediaType.parse("*/*"),
                        file
                );

        System.out.println(fileUri);

        // MultipartBody.Part is used to send also the actual file name
        return MultipartBody.Part.createFormData(partName, file.getName(), requestFile);
    }

    public static String comprimirImagen(String imagen_original_path, Context context) {

        final File image = new File(imagen_original_path);

        if (image.length() < 1) {
            borrarArchivo(imagen_original_path);
            return "";
        }

        final String name = image.getName().substring(0, image.getName().length() - 4);

        final String path = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES).getPath();

        final File compressedImageFile;
        try {
            compressedImageFile = new Compressor(context)
                    .setMaxWidth(720)
                    .setMaxHeight(480)
                    .setQuality(90)
                    .setCompressFormat(Bitmap.CompressFormat.JPEG)
                    .setDestinationDirectoryPath(path)
                    .compressToFile(image, name + ".jpeg");

            Log.d("CREAR", "SE CREO LA IMAGEN COMPRIMIDA");

            if (image.delete()) {
                imagen_original_path = compressedImageFile.getAbsolutePath();

                return imagen_original_path;

//                Picasso.get()
//                        .load(compressedImageFile)
//                        .centerCrop()
//                        .fit()
//                        .placeholder(R.drawable.spin2)
//                        .error(R.drawable.nodisp)
//                        .into(preview);

/*                final MultipartBody.Part part = Functions.prepareFilePart(UUID.randomUUID().toString(), currentPhotoPath);

                if(!parts.contains(part)){
                    parts.add(part);
                }*/

            } else {
                Log.d("BORRAR_IMAGEN", "NO SE BORRO LA IMAGEN ORIGINAL");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return imagen_original_path;

    }

    public static String comprimirImagen2(String imagen_original_path, Context context) {

        final File image = new File(imagen_original_path);

        final String name = uniqid("IMG_", true);

        final String path = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES).getPath();

        final File compressedImageFile;
        try {
            compressedImageFile = new Compressor(context)
                    .setMaxWidth(720)
                    .setMaxHeight(480)
                    .setQuality(90)
                    .setCompressFormat(Bitmap.CompressFormat.JPEG)
                    .setDestinationDirectoryPath(path)
                    .compressToFile(image, name + ".jpeg");

            Log.d("CREAR", "SE CREO LA IMAGEN COMPRIMIDA");

            imagen_original_path = compressedImageFile.getAbsolutePath();

            return imagen_original_path;

        } catch (IOException e) {
            e.printStackTrace();
        }

        return imagen_original_path;

    }

    public static boolean borrarArchivo(String path) {
        final File file = new File(path);
        boolean status = false;


        if (file.exists()) {
            if (file.delete()) {
                status = true;
            }
        }

        return status;
    }


    //NUEVO

    public static String fechaDMY(String fecha) {
        String[] parts = fecha.split("-");
        String year = parts[0]; //
        String month = parts[1]; //
        String day = parts[2]; //
        String fechamdy = day + "-" + month + "-" + year;
        return fechamdy;
    }

    public static String fechaYMD(String fecha) {
        String[] parts = fecha.split("-");
        String year = parts[0]; //
        String month = parts[1]; //
        String day = parts[2]; //
        String fechaymd = year + "-" + month + "-" + day;
        return fechaymd;
    }

    public static String getHora() {
        Date anotherCurDate = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
        String hora = formatter.format(anotherCurDate);
        return hora;
    }

    public static String getFecha() {
        String format = "yyyy-MM-dd";
        String fecha = new SimpleDateFormat(format).format(new Date());
        return fecha;
    }

    public static String getHash() {
        //GENERAR HASH MD5
        MessageDigest digest = null;
        try {
            digest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        Random numAleatorio;
        numAleatorio = new Random();
        int aleat = numAleatorio.nextInt(500 - 1 + 1) + 1;
        String aleatorio = Integer.toString(aleat);
        byte[] encodedhash = digest.digest(
                aleatorio.getBytes(StandardCharsets.UTF_8));
        String hash = bytesToHex(encodedhash);
        return hash;
    }

    public static String bytesToHex(byte[] hash) {
        StringBuffer hexString = new StringBuffer();
        for (int i = 0; i < hash.length; i++) {
            String hex = Integer.toHexString(0xff & hash[i]);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }

    public static String sumarRestarDiasFecha(int dias) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date()); // Configuramos la fecha que se recibe
        calendar.add(Calendar.DAY_OF_YEAR, dias);  // numero de días a añadir, o restar en caso de días<0
        Date fecha_result = calendar.getTime(); // Devuelve el objeto Date con los nuevos días añadidos
        String fecha_actual = formatter.format(fecha_result);
        return fecha_actual;
    }

    public static int diasDiferenciaFechas(String fecha1, String fecha2) {
        //Primero colocar la fecha vencimiento y luego la fecha actual , si el valor da positivo quiere decir que ya se vencio
        int dias = 0;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Date fechaInicial = null;
        try {
            fechaInicial = dateFormat.parse(fecha1);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Date fechaFinal = null;
        try {
            fechaFinal = dateFormat.parse(fecha2);
        } catch (ParseException e) {
            e.printStackTrace();
        }


        dias = (int) ((fechaFinal.getTime() - fechaInicial.getTime()) / 86400000);
        Log.d("dias_dif:", "" + dias);
        return dias;
    }

    public static String round2(double valuex) {
        String value = Double.toString(valuex);
        value = value.replaceAll(",", ".");
        DecimalFormat df = new DecimalFormat("####.##");
        String value_fin = df.format(Double.parseDouble(value));
        value_fin = String.format("%.2f", Double.parseDouble(value_fin));
        return value_fin;
    }

    public static String removerTildes(String cadena) {
        return cadena.replace("Á", "A")
                .replace("É", "E")
                .replace("Í", "I")
                .replace("Ó", "O")
                .replace("Ú", "U")
                .replace("á", "a")
                .replace("é", "e")
                .replace("í", "i")
                .replace("ó", "o")
                .replace("ú", "u");
    }

    public static String uniqid(String prefix, boolean more_entropy) {
        long time = System.currentTimeMillis();
        //String uniqid = String.format("%fd%05f", Math.floor(time),(time-Math.floor(time))*1000000);
        //uniqid = uniqid.substring(0, 13);
        String uniqid = "";
        if (!more_entropy) {
            uniqid = String.format("%s%08x%05x", prefix, time / 1000, time);
        } else {
            SecureRandom sec = new SecureRandom();
            byte[] sbuf = sec.generateSeed(8);
            ByteBuffer bb = ByteBuffer.wrap(sbuf);

            uniqid = String.format("%s%08x%05x", prefix, time / 1000, time);
            uniqid += "." + String.format("%.8s", "" + bb.getLong() * -1);
        }

        uniqid = uniqid.replace(".", "");
        uniqid = uniqid.replace("-", "");

        return uniqid;
    }

    public static String round2decimals(double val) {
        final DecimalFormatSymbols otherSymbols = new DecimalFormatSymbols(Locale.getDefault());
        otherSymbols.setDecimalSeparator('.');
        otherSymbols.setGroupingSeparator(',');
        final DecimalFormat df = new DecimalFormat("#########.##", otherSymbols);
        df.setRoundingMode(RoundingMode.HALF_UP);
        return df.format(val);
    }

    public static void subirCambios(Context context, boolean accion) {

        final NotificationConfig config = new NotificationConfig();
        config.setAuto_cancel(true);
        config.setChannel_id("sincronizacion_servidor");
        config.setChannel_description("Sincroniza en segundo plano los datos de la app");
        config.setSound(false);
        config.setClase(MainActivity.class);
        config.setContext(context);
        config.setContent("Sincronizando datos con el servidor");
        config.setIcon(R.drawable.logo);
        config.setProgress(true);
        config.setName("Credi Master");
        config.setVibration(false);
        config.setLights(true);
        config.setLed_color(context.getResources().getColor(R.color.azul));


        new AsyncTask<Void, Void, Void>() {


            @Override
            protected Void doInBackground(Void... voids) {


                final AppDatabase db = AppDatabase.getInstance(context);
                final WebService ws = ApiProvider.getWebService();

                final List<Prestamo> prestamos = db.prestamoDao().getPrestamosNoSincronizados();

                if (prestamos.size() > 0) {


                    Notification.notify(config);

                    System.out.println("QTY: " + prestamos.size());

                    for (Prestamo p : prestamos) {
                        prestamos.get(prestamos.indexOf(p))
                                .setPrestamoDetalle(db.prestamoDetalleDao()
                                        .getPrestamoDetNoSincronizados(p.getId_prestamo()));
                    }

                    ws.enviar_prestamos(prestamos).enqueue(new Callback<Prestamo>() {
                        @Override
                        public void onResponse(Call<Prestamo> call, Response<Prestamo> response) {

                            if (response.code() == 200) {
                                Log.e("RESULT", "OK");

                                ws.obtener_prestamos().enqueue(new Callback<List<Prestamo>>() {
                                    @Override
                                    public void onResponse(Call<List<Prestamo>> call, Response<List<Prestamo>> response) {
                                        if (response.code() == 200) {

                                            for (Prestamo p : prestamos) {

                                                final CobroProcesado cobroProcesado =
                                                        new CobroProcesado(p.getPrestamodetalle().size(),
                                                                p.getId_prestamo(),
                                                                db.getUsuarioDao().getId());

                                                db.getCobrosProcesados().insert(cobroProcesado);

                                                db.getLogDao().insertPrestamo(PrestamoLog.fromPrestamo(p));

                                                for (PrestamoDetalle pd : p.getPrestamodetalle()) {
                                                    db.getLogDao().insertPrestamoDetalle(PrestamoDetalleLog.fromPrestamoDetalle(pd));
                                                }
                                            }

                                            db.prestamoDao().deleteAll();
                                            db.prestamoDao().insert(response.body());
                                            db.prestamoDetalleDao().deleteAll();

                                            for (Prestamo myPrestamo : response.body()) {
                                                if (myPrestamo.getPrestamodetalle() != null) {
                                                    db.prestamoDetalleDao().insert(myPrestamo.getPrestamodetalle());
                                                }
                                            }

                                            Notification.getManager(context).cancel(1122);

                                        }

                                        Notification.getManager(context).cancel(1122);
                                    }

                                    @Override
                                    public void onFailure(Call<List<Prestamo>> call, Throwable t) {
                                        Notification.getManager(context).cancel(1122);
                                    }
                                });

                            } else {
                                Log.e("RESULT", "FAIL");
                                Notification.getManager(context).cancel(1122);
                            }

                        }

                        @Override
                        public void onFailure(Call<Prestamo> call, Throwable t) {
                            Log.e("RESULT", t.getMessage());
                            Notification.getManager(context).cancel(1122);
                        }
                    });
                } else {
                    Log.e("SINCRONIZAR", "NO HAY DATOS");
                }

                final List<SolicitudCredito> solicitudes = db.getSolicitudDao().getNoSincronizadas();

                if (solicitudes.size() > 0) {


                    Notification.notify(config);

                    Gson gson = new Gson();

                    for (SolicitudCredito s : solicitudes) {

                        Log.e("SOLICITUDES", gson.toJson(s));

                        s.setDetalles(db.getSolicitudDetalleDao().getNoSincronizadas(s.getId_solicitud()));
                        s.setGarantias(db.getGarantiaDao().getNoSincronizadas(s.getId_solicitud()));
                        s.setFiador(db.getFiadorDao().getNoSincronizado(s.getId_solicitud()));

                        ws.post_solicitud(s).enqueue(new Callback<ResponseServer>() {
                            @Override
                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                                if (response.code() == 200) {
                                    Log.e("SINCRONIZACION", "SOLICITUD ENVIADA -> " + s.getId_solicitud());

                                    final List<MultipartBody.Part> archivos = new ArrayList<>();

                                    System.out.println(s.getGarantias().size());
                                    for (Garantia g : s.getGarantias()) {
                                        System.out.println(g.getUrl());
                                        archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), g.getUrl()));
                                    }

                                    if (archivos.size() > 0) {
                                        ApiProvider.getWebService().subir_documentos(archivos).enqueue(new Callback<ResponseServer>() {
                                            @Override
                                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                                                if (response.code() == 200) {
                                                    Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");

                                                    //LOG
                                                    saveSolicitud(db, s, 0);

                                                    if (s.isTiene_fiador()) {
                                                        db.getFiadorDao().delete(s.getFiador());
                                                    }

                                                    db.getSolicitudDetalleDao().deleteAllBySolicitud(s.getId_solicitud());
                                                    db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                                    db.getSolicitudDao().delete(s);
                                                } else {
                                                    Log.e("UPLOAD", "ERROR AL SUBIR LOS ARCHIVOS");
                                                }
                                            }

                                            @Override
                                            public void onFailure(Call<ResponseServer> call, Throwable t) {
                                                Log.e("UPLOAD", t.getMessage());
                                            }
                                        });

                                    } else {

                                        //LOG
                                        saveSolicitud(db, s, 0);

                                        if (s.isTiene_fiador()) {
                                            db.getFiadorDao().delete(s.getFiador());
                                        }

                                        db.getSolicitudDetalleDao().deleteAllBySolicitud(s.getId_solicitud());
                                        db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                        db.getSolicitudDao().delete(s);
                                    }

                                    Notification.getManager(context).cancel(1122);

                                } else {
                                    Log.e("SINCRONIZACION", "SOLICITUD NO ENVIADA -> " + response.code());
                                    Notification.getManager(context).cancel(1122);
                                }
                            }

                            @Override
                            public void onFailure(Call<ResponseServer> call, Throwable t) {
                                Notification.getManager(context).cancel(1122);
                            }
                        });

                    }

                    Notification.notify(config);

                    ws.obtener_solicitudes().enqueue(new Callback<List<SolicitudCredito>>() {
                        @Override
                        public void onResponse(Call<List<SolicitudCredito>> call, Response<List<SolicitudCredito>> response) {
                            if (response.code() == 200) {

                                db.getSolicitudDao().deleteAllSincronizados();
                                db.getSolicitudDao().insert(response.body());

                                db.getSolicitudDetalleDao().deleteAllSincronizados();
                                db.getGarantiaDao().deleteAllSincronizados();
                                db.getFiadorDao().deleteAllSincronizados();

                                for (SolicitudCredito s : response.body()) {
                                    db.getSolicitudDetalleDao().insert(s.getDetalles());
                                    /*db.getGarantiaDao().insert(s.getGarantias());
                                    db.getFiadorDao().insert(s.getFiador());*/
                                }
                            }

                            Notification.getManager(context).cancel(1122);

                        }

                        @Override
                        public void onFailure(Call<List<SolicitudCredito>> call, Throwable t) {
                            Notification.getManager(context).cancel(1122);

                        }
                    });
                } else {
                    Log.e("SINCRONIZACION SOL", "NADA POR SINCRONIZAr");

                }

                final List<SolicitudCredito> solicitudes_ref = db.getSolicitudDao().getRefNoSincronizadas();

                if (solicitudes_ref.size() > 0) {

                    Gson gson = new Gson();

                    Notification.notify(config);

                    for (SolicitudCredito s : solicitudes_ref) {

                        s.setGarantias(db.getGarantiaDao().getNoSincronizadas(s.getId_solicitud()));
                        s.setFiador(db.getFiadorDao().getNoSincronizado(s.getId_solicitud()));

                        System.out.println(gson.toJson(s));

                        ws.enviar_refinanciamiento(s).enqueue(new Callback<ResponseServer>() {
                            @Override
                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                                if (response.code() == 200) {

                                    Log.e("SINCRONIZACION REF", "SOLICITUD ENVIADA -> " + s.getId_solicitud());

                                    final List<MultipartBody.Part> archivos = new ArrayList<>();

                                    for (Garantia g : s.getGarantias()) {
                                        System.out.println(g.getUrl());
                                        archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), g.getUrl()));
                                    }

                                    if (archivos.size() > 0) {
                                        ApiProvider.getWebService().subir_documentos(archivos).enqueue(new Callback<ResponseServer>() {
                                            @Override
                                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                                                if (response.code() == 200) {
                                                    Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");

                                                    //LOG
                                                    saveSolicitud(db, s, 1);

                                                    if (s.isTiene_fiador()) {
                                                        db.getFiadorDao().delete(s.getFiador());
                                                    }

                                                    db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                                    db.getSolicitudDao().delete(s);
                                                } else {
                                                    Log.e("UPLOAD", "ERROR AL SUBIR LOS ARCHIVOS");
                                                }
                                            }

                                            @Override
                                            public void onFailure(Call<ResponseServer> call, Throwable t) {
                                                Log.e("UPLOAD", t.getMessage());
                                            }
                                        });
                                    } else {

                                        Log.e("SINCRONIZACION REF", "SIN ARCHIVOS");

                                        //LOG
                                        saveSolicitud(db, s, 1);

                                        if (s.isTiene_fiador()) {
                                            db.getFiadorDao().delete(s.getFiador());
                                        }

                                        db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                        db.getSolicitudDao().delete(s);
                                    }

                                    Notification.getManager(context).cancel(1122);

                                } else {
                                    Log.e("SINCRONIZACION REF", "SOLICITUD NO ENVIADA -> " + response.code());
                                    Notification.getManager(context).cancel(1122);
                                }
                            }

                            @Override
                            public void onFailure(Call<ResponseServer> call, Throwable t) {
                                Notification.getManager(context).cancel(1122);
                                Log.e("SINCRONIZACION REF", t.getMessage());

                            }
                        });

                    }

                    Notification.notify(config);

                    ws.obtener_solicitudes().enqueue(new Callback<List<SolicitudCredito>>() {
                        @Override
                        public void onResponse(Call<List<SolicitudCredito>> call, Response<List<SolicitudCredito>> response) {
                            if (response.code() == 200) {

                                db.getSolicitudDao().deleteAllSincronizados();
                                db.getSolicitudDao().insert(response.body());

                                db.getSolicitudDetalleDao().deleteAllSincronizados();
                                db.getGarantiaDao().deleteAllSincronizados();
                                db.getFiadorDao().deleteAllSincronizados();

                                for (SolicitudCredito s : response.body()) {
                                    db.getSolicitudDetalleDao().insert(s.getDetalles());
                                    /*db.getGarantiaDao().insert(s.getGarantias());
                                    db.getFiadorDao().insert(s.getFiador());*/
                                }
                            }

                            Notification.getManager(context).cancel(1122);

                        }

                        @Override
                        public void onFailure(Call<List<SolicitudCredito>> call, Throwable t) {
                            Notification.getManager(context).cancel(1122);
                        }
                    });
                } else {
                    Log.e("SINCRONIZACION REF", "NADA POR SINCRONIZAR");
                }

                final List<Cliente> clientes = db.getClienteDao().getNoSincronizados();

                if (clientes.size() > 0) {

                    Notification.notify(config);

                    for (Cliente c : clientes) {

                        c.setArchivos(db.getClienteDao().getArchivosNoSincronizados(c.getId_cliente()));
                        c.setReferencias(db.getClienteDao().getReferenciasNoSincronizadas(c.getId_cliente()));

                        ws.post_cliente(c).enqueue(new Callback<ResponseServer>() {
                            @Override
                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {

                                if (response.code() == 200) {

                                    Log.e("SYNC CLIENTE", "CLIENTE SUBIDO");
                                    final List<MultipartBody.Part> imagenes = new ArrayList<>();

                                    if (c.getImagen() != null && !c.getImagen().isEmpty()) {
                                        imagenes.add(Functions.prepareFilePart("perfil", c.getImagen()));
                                    }

                                    if (imagenes.size() > 0) {
                                        ApiProvider.getWebService().subir_imagenes(imagenes).enqueue(new Callback<ResponseServer>() {
                                            @Override
                                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {

                                            }

                                            @Override
                                            public void onFailure(Call<ResponseServer> call, Throwable t) {

                                            }
                                        });
                                    }

                                    final List<MultipartBody.Part> archivos = new ArrayList<>();

                                    for (Archivo a : c.getArchivos()) {
                                        archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), a.getUrl()));
                                    }

                                    if (archivos.size() > 0) {
                                        ApiProvider.getWebService().subir_documentos(archivos).enqueue(new Callback<ResponseServer>() {
                                            @Override
                                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                                                if (response.code() == 200) {
                                                    Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");

                                                    //LOG
                                                    saveCliente(db, c);

                                                    db.getClienteDao().deleteArchivosByCliente(c.getId_cliente());
                                                    db.getClienteDao().deleteReferenciaByCliente(c.getId_cliente());
                                                    db.getClienteDao().delete(c);

                                                } else {
                                                    Log.e("UPLOAD", "ERROR AL SUBIR LOS ARCHIVOS");
                                                }
                                            }

                                            @Override
                                            public void onFailure(Call<ResponseServer> call, Throwable t) {
                                                Log.e("UPLOAD", t.getMessage());
                                            }
                                        });
                                    } else {

                                        //LOG
                                        saveCliente(db, c);

                                        db.getClienteDao().deleteArchivosByCliente(c.getId_cliente());
                                        db.getClienteDao().deleteArchivosByCliente(c.getId_cliente());
                                        db.getClienteDao().delete(c);
                                    }

                                } else {
                                    Log.e("SYNC CLIENTE", "ERROR");
                                }

                                Notification.getManager(context).cancel(1122);

                            }

                            @Override
                            public void onFailure(Call<ResponseServer> call, Throwable t) {
                                Notification.getManager(context).cancel(1122);

                                Log.e("SYNC CLIENTE", t.getMessage());
                            }
                        });

                    }

                    Notification.notify(config);
                    ws.get_clientes().enqueue(new Callback<List<Cliente>>() {
                        @Override
                        public void onResponse(Call<List<Cliente>> call, Response<List<Cliente>> response) {
                            if (response.code() == 200) {
                                db.getClienteDao().deleteAllSincronizados();
                                db.getClienteDao().insert(response.body());

                                db.getClienteDao().deleteArchivosSincronizados();
                                db.getClienteDao().deleteReferenciasSincronizadas();

                                for (Cliente cliente : response.body()) {
                                    db.getClienteDao().insertArchivos(cliente.getArchivos());
                                    db.getClienteDao().insertReferencias(cliente.getReferencias());
                                }

                                Notification.getManager(context).cancel(1122);
                            }
                        }

                        @Override
                        public void onFailure(Call<List<Cliente>> call, Throwable t) {
                            Notification.getManager(context).cancel(1122);
                        }
                    });

                    Notification.getManager(context).cancel(1122);

                } else {
                    Log.e("SINCRONIZACION CLIE", "NADA POR SINCRONIZAR");
                }

                return null;
            }

        }.execute();

    }

    public static String getMontoSinIntereses(float saldo, float porcentaje, float proporcion) {

        porcentaje = proporcion * (porcentaje / 100);
        saldo = saldo / (1 + porcentaje);

        return Functions.round2decimals(saldo);
    }

    public static AlertDialog progressDialog(Context context, String text) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setCancelable(false);
        View viewInflated = LayoutInflater.from(context).inflate(R.layout.progress_dialog_layout,
                ((Activity) context).findViewById(android.R.id.content),
                false);

        final TextView descripcion = viewInflated.findViewById(R.id.texto_dialogo);

        descripcion.setText(text);

        builder.setView(viewInflated);
        return builder.create();

    }

    public static PrestamoDetalle tieneMora(PrestamoDetalle detalle, Mora mora_) {

        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


        final int dias_morad = mora_.getDias_mora();
        final double mora = mora_.getMora();/// Double.valueOf(100);

        double dmora = 0;
        double moraap = 0;

        Date inicio = null;
        Date fin = null;

        int dias_mora = 0;
        int nollega = 1;

        try {
            inicio = sdf.parse(detalle.getFecha_vence());
            fin = sdf.parse(sdf.format(new Date()));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Date ftm = inicio;

        Calendar c = Calendar.getInstance();
        c.setTime(ftm);

        Calendar c2 = Calendar.getInstance();
        c2.setTime(fin);

        while (nollega == 1) {
            if (c.after(c2) || c.equals(c2)) {
                nollega = 0;
            }
            if (c.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY && c.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY) {
                dias_mora++;
            }
            c.add(Calendar.DAY_OF_MONTH, 1);
        }

        dias_mora--;

        if (dias_mora > dias_morad) {
            dmora = dias_mora - dias_morad;
            moraap = 1 * mora;//dmora * mora;
        } else {
            moraap = 0;
            dmora = 0;
        }

        if (dmora > 0) {
            detalle.setTiene_mora(true);
            //detalle.setMora(detalle.getMonto() * (1+moraap) - detalle.getMonto());
            detalle.setMora(moraap);
            detalle.setDias_mora((int) dmora);
        }

        return detalle;
    }

    public static PrestamoDetalle tieneMoraNew(PrestamoDetalle detalle, Mora mora_, String ultimaFecha) {

        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


        if (mora_ == null || ultimaFecha.equals("0000-00-00")) {
            System.out.println(detalle.getId_prestamo());
            return detalle;
        }

        final int dias_morad = mora_.getDias_mora();
        final double mora = mora_.getMora();/// Double.valueOf(100);

        double dmora = 0;
        double moraap = 0;

        Date inicio = null;
        Date fin = null;

        int dias_mora = 0;

        try {
            inicio = sdf.parse(ultimaFecha);
            fin = sdf.parse(Functions.getFecha());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Date ftm = inicio;

        Calendar c = Calendar.getInstance();
        c.setTime(ftm);

        Calendar c2 = Calendar.getInstance();
        c2.setTime(fin);

        while (c.before(c2) || c.equals(c2)) {
            if (c.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY && c.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY) {
                dias_mora++;
            }
            c.add(Calendar.DAY_OF_MONTH, 1);
        }

        //dias_mora--;

        if (dias_mora > dias_morad) {
            dmora = dias_mora;//dias_mora - dias_morad;
            moraap = Math.floor((dmora / mora_.getDias_mora())) * mora;//dmora * mora;
        }

        if (dmora > 0) {
            detalle.setTiene_mora(true);
            //detalle.setMora(detalle.getMonto() * (1+moraap) - detalle.getMonto());
            detalle.setMora(moraap);
            detalle.setDias_mora((int) dmora);
        }

        return detalle;
    }

    public static double[] getMora(PrestamoDetalle detalle, int dias_mora_, double mora_) {

        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        final int dias_morad = dias_mora_;
        final double mora = mora_;// / Double.valueOf(100);

        double dmora = 0;
        double moraap = 0;

        Date inicio = null;
        Date fin = null;

        int dias_mora = 0;
        int nollega = 1;

        try {
            inicio = sdf.parse(detalle.getFecha_vence());
            fin = sdf.parse(sdf.format(new Date()));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Date ftm = inicio;

        Calendar c = Calendar.getInstance();
        c.setTime(ftm);

        Calendar c2 = Calendar.getInstance();
        c2.setTime(fin);

        while (nollega == 1) {
            if (c.after(c2) || c.equals(c2)) {
                nollega = 0;
            }
            if (c.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY && c.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY) {
                dias_mora++;
            }
            c.add(Calendar.DAY_OF_MONTH, 1);
        }

        dias_mora--;

        if (dias_mora > dias_morad) {
            dmora = dias_mora - dias_morad;
            moraap = 1 * mora;//dmora * mora;
        } else {
            moraap = 0;
            dmora = 0;
        }

        if (dmora > 0) {
            detalle.setTiene_mora(true);
            //detalle.setMora(detalle.getMonto() * (1+moraap) - detalle.getMonto());
            detalle.setMora(moraap);
            detalle.setDias_mora((int) dmora);
        }

        //final double[] vals = {detalle.getMonto() * (1+moraap) - detalle.getMonto(), dmora};
        final double[] vals = {moraap, dmora};

        return vals;
    }

    public static PrestamoDetalle getMora2(PrestamoDetalle detalle, int dias_mora_, double mora_) {

        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        final int dias_morad = dias_mora_;
        final double mora = mora_;// / Double.valueOf(100);

        double dmora = 0;
        double moraap = 0;

        Date inicio = null;
        Date fin = null;

        int dias_mora = 0;
        int nollega = 1;

        try {
            inicio = sdf.parse(detalle.getFecha_vence());
            fin = sdf.parse(sdf.format(new Date()));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Date ftm = inicio;

        Calendar c = Calendar.getInstance();
        c.setTime(ftm);

        Calendar c2 = Calendar.getInstance();
        c2.setTime(fin);

        while (nollega == 1) {
            if (c.after(c2) || c.equals(c2)) {
                nollega = 0;
            }
            if (c.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY && c.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY) {
                dias_mora++;
            }
            c.add(Calendar.DAY_OF_MONTH, 1);
        }

        dias_mora--;

        if (dias_mora > dias_morad) {
            dmora = dias_mora - dias_morad;
            moraap = 1 * mora;//dmora * mora;
        } else {
            moraap = 0;
            dmora = 0;
        }

        if (dmora > 0) {
            detalle.setTiene_mora(true);
            //detalle.setMora(detalle.getMonto() * (1+moraap) - detalle.getMonto());
            detalle.setMora(moraap);
            detalle.setDias_mora((int) dmora);
        }

        //final double[] vals = {detalle.getMonto() * (1+moraap) - detalle.getMonto(), dmora};

        return detalle;
    }

    public static List<Prestamo> prestamosEnMora(Context context) {

        final AppDatabase db = AppDatabase.getInstance(context);
        List<Prestamo> prestamos = db.prestamoDao().getPrestamosVencidos(getFecha());
        final List<Prestamo> en_mora = new ArrayList<>();

        if (prestamos.size() < 1) {
            return en_mora;
        }

        for (Prestamo p : prestamos) {

            int count_mora = 0;
            final Mora mora = db.prestamoDao().getDatosMoraPrestamo(p.getMonto(), p.getFrecuencia());

            for (PrestamoDetalle pd : db.prestamoDetalleDao().getDetalleAntesHoy(getFecha(), p.getId_prestamo())) {

                pd = tieneMoraNew(pd, mora, p.getProxima_mora());
                if (pd.isTiene_mora()) {
                    count_mora++;
                    p.setMoraTotal(pd.getMora());
                    break;
                }

            }

            if (count_mora > 0) {
                en_mora.add(p);
            }

        }

        return en_mora;
    }

    public static List<Prestamo> prestamosEnMoraPage(Context context, int offset) {

        final AppDatabase db = AppDatabase.getInstance(context);
        List<Prestamo> prestamos = db.prestamoDao().getPrestamosVencidosPaginate(getFecha(), offset);
        final List<Prestamo> en_mora = new ArrayList<>();

        if (prestamos.size() < 1) {
            return en_mora;
        }

        //final Plan plan = db.getPlanesDao().get(prestamos.get(0).getPlaan());

        for (Prestamo p : prestamos) {

            int count_mora = 0;

            for (PrestamoDetalle pd : db.prestamoDetalleDao().getDetalleAntesHoy(getFecha(), p.getId_prestamo())) {

                pd = tieneMora(pd, db.prestamoDao().getDatosMoraPrestamo(p.getMonto(), p.getFrecuencia()));
                if (pd.isTiene_mora()) {
                    count_mora++;
                    p.setMoraTotal(p.getMoraTotal() + pd.getMora());
                }

            }

            if (count_mora > 0) {
                en_mora.add(p);
            }

        }

        return en_mora;
    }

    public static List<Prestamo> prestamosConMora(Context context, List<Prestamo> prestamos) {

        final AppDatabase db = AppDatabase.getInstance(context);
        final List<Prestamo> en_mora = new ArrayList<>();

        final Plan plan = db.getPlanesDao().get(prestamos.get(0).getPlaan());

        for (Prestamo p : prestamos) {

            for (PrestamoDetalle pd : db.prestamoDetalleDao().getDetalleAntesHoy(getFecha(), p.getId_prestamo())) {
                pd = tieneMora(pd, db.prestamoDao().getDatosMoraPrestamo(p.getMonto(), p.getFrecuencia()));
                if (pd.isTiene_mora()) {
                    p.setMoraTotal(p.getMoraTotal() + pd.getMora());
                }
            }
            en_mora.add(p);
        }

        return en_mora;
    }

    public static Prestamo prestamoConMora(Context context, Prestamo prestamo) {

        prestamo.setMoraTotal(0.0);

        final AppDatabase db = AppDatabase.getInstance(context);

        final Plan plan = db.getPlanesDao().get(prestamo.getPlaan());
        final Mora mora = db
                .prestamoDao().getDatosMoraPrestamo(prestamo.getMonto(), prestamo.getFrecuencia());

        for (PrestamoDetalle pd : db.prestamoDetalleDao().getDetalleAntesHoy(getFecha(), prestamo.getId_prestamo())) {
            pd = tieneMoraNew(pd, mora, prestamo.getProxima_mora());
            if (pd.isTiene_mora()) {
                prestamo.setMoraTotal(pd.getMora());
                break;
            }
        }

        return prestamo;
    }

    public static void permisosApp(Activity activity) {


  /*      Dexter.withActivity(activity)
                .withPermissions(
                        Manifest.permission.CAMERA,
                        Manifest.permission.BLUETOOTH,
                        Manifest.permission.BLUETOOTH_ADMIN,
                        Manifest.permission.BLUETOOTH_PRIVILEGED,
                        Manifest.permission.WRITE_EXTERNAL_STORAGE,
                        Manifest.permission.READ_EXTERNAL_STORAGE
                ).withListener(new MultiplePermissionsListener() {
            @Override
            public void onPermissionsChecked(MultiplePermissionsReport report) {

            }

            @Override
            public void onPermissionRationaleShouldBeShown(List<PermissionRequest> permissions, PermissionToken token) {


            }
        }).check();*/

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (activity.getApplicationContext().checkSelfPermission(Manifest.permission.CAMERA)
                    != PackageManager.PERMISSION_GRANTED ||
                    activity.getApplicationContext().checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE)
                            != PackageManager.PERMISSION_GRANTED ||
                    activity.getApplicationContext().checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION)
                            != PackageManager.PERMISSION_GRANTED ||
                    activity.getApplicationContext().checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION)
                            != PackageManager.PERMISSION_GRANTED) {

                ActivityCompat.requestPermissions(activity,
                        new String[]{Manifest.permission.CAMERA, Manifest.permission.READ_EXTERNAL_STORAGE,
                                Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.ACCESS_COARSE_LOCATION,
                                Manifest.permission.ACCESS_FINE_LOCATION},
                        101);

                ActivityCompat.requestPermissions(activity,
                        new String[]{Manifest.permission.READ_EXTERNAL_STORAGE},
                        102);

            }
        }
    }

    public static void getClientes(Context context) {

        final ClienteDao clienteDao = AppDatabase.getInstance(context).getClienteDao();

        ApiProvider.getWebService().get_clientes().enqueue(new retrofit2.Callback<List<Cliente>>() {
            @Override
            public void onResponse(Call<List<Cliente>> call, Response<List<Cliente>> response) {
                if (response.code() == 200) {
                    clienteDao.deleteAllSincronizados();
                    clienteDao.insert(response.body());

                    clienteDao.deleteArchivosSincronizados();
                    clienteDao.deleteReferenciasSincronizadas();

                    for (Cliente cliente : response.body()) {
                        clienteDao.insertArchivos(cliente.getArchivos());
                        clienteDao.insertReferencias(cliente.getReferencias());
                    }
                }
            }

            @Override
            public void onFailure(Call<List<Cliente>> call, Throwable t) {

            }
        });

    }

    public static void getSolicitudes(Context context) {

        final SolicitudDao solicitudDao = AppDatabase.getInstance(context).getSolicitudDao();
        final SolicitudDetalleDao solicitudDetalleDao = AppDatabase.getInstance(context).getSolicitudDetalleDao();

        ApiProvider.getWebService().obtener_solicitudes().enqueue(new retrofit2.Callback<List<SolicitudCredito>>() {
            @Override
            public void onResponse(Call<List<SolicitudCredito>> call, Response<List<SolicitudCredito>> response) {

                if (response.code() == 200) {

                    solicitudDao.deleteAllSincronizados();
                    solicitudDao.insert(response.body());

                    solicitudDetalleDao.deleteAllSincronizados();
                    //garantiaDao.deleteAllSincronizados();
                    //fiadorDao.deleteAllSincronizados();

                    for (SolicitudCredito s : response.body()) {
                        solicitudDetalleDao.insert(s.getDetalles());
                            /*garantiaDao.insert(s.getGarantias());
                            fiadorDao.insert(s.getFiador());*/
                    }
                }

            }

            @Override
            public void onFailure(Call<List<SolicitudCredito>> call, Throwable t) {

            }
        });

    }

    private static void saveSolicitud(AppDatabase db, SolicitudCredito solicitudCredito, int mode) {
        db.getLogDao().insertSolicitud(SolicitudCreditoLog.fromSolicitud(solicitudCredito));

        if (mode == 0) {
            for (SolicitudDetalle s : solicitudCredito.getDetalles()) {
                db.getLogDao().insertSolictudDetalle(SolicitudDetalleLog.fromDetalle(s));
            }
        }

        for (Garantia g : solicitudCredito.getGarantias()) {
            db.getLogDao().insertGarantia(GarantiaLog.fromGarantia(g));
        }

        if (solicitudCredito.isTiene_fiador()) {
            db.getLogDao().insertFiador(FiadorLog.fromFiador(solicitudCredito.getFiador()));
        }
    }

    private static void saveCliente(AppDatabase db, Cliente cliente) {

        db.getLogDao().insertCliente(ClienteLog.fromCliente(cliente));

        for (Referencia r : cliente.getReferencias()) {
            db.getLogDao().insertReferencia(ReferenciaLog.fromReferencia(r));
        }

        for (Archivo a : cliente.getArchivos()) {
            db.getLogDao().insertArchivo(ArchivoLog.fromArchivo(a));
        }

    }

    public static <T> String toCSV(Class clase, List<T> lista, Context context) {
        try {
            final int pos = clase.getName().lastIndexOf(".") + 1;
            final String name_file = clase.getName().substring(pos) + "_" + getFecha().replace("-", "") + "_" + getHora().replace(":", "").toUpperCase() + ".csv";

            if (lista.size() > 0) {
                Writer writer = new FileWriter(context.getExternalFilesDir(Environment.DIRECTORY_DOCUMENTS) + "/" + name_file);
                CSVWriter csv = new CSVWriter(writer);

                final Method[] mts = clase.getDeclaredMethods();
                final List<Method> methods = new ArrayList<>();


                final List<String[]> rows = new ArrayList<>();
                final Field[] fs = clase.getDeclaredFields();
                final List<String> fields = new ArrayList<>();

                for (Method method : mts) {
                    if (Modifier.isPublic(method.getModifiers()) && method.getName().toLowerCase().startsWith("get")
                            || method.getName().toLowerCase().startsWith("is")) {

                        methods.add(method);
                        fields.add(method.getName().toLowerCase().replace("is", "").replace("get", ""));
                    }
                }

               /* for(Field field: fs){
                    if(Modifier.isPrivate(field.getModifiers()) && !Modifier.isStatic(field.getModifiers())){
                        //System.out.println(field.getName().toLowerCase());
                        fields.add(field.getName().toLowerCase());
                    }
                }*/

                rows.add(fields.toArray(new String[fields.size()]));

                for (T object : lista) {
                    final List<String> row = new ArrayList<>();

                    for (Method method : methods) {

                        final String m_name = method.getName().toLowerCase()
                                .replace("get", "")
                                .replace("is", "");

                        row.add(String.valueOf(method.invoke(object)));
                    }

                    rows.add(row.toArray(new String[row.size()]));

                }

                //Email.send(context.getExternalFilesDir(Environment.DIRECTORY_DOCUMENTS)+"/"+name_file);
                csv.writeAll(rows);
                writer.close();

                return context.getExternalFilesDir(Environment.DIRECTORY_DOCUMENTS) + "/" + name_file;
            }


        } catch (IOException | IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }

        return "";
    }

    public static void subirCambiosNoAsync(Context context) {

        Dialog dialog = Functions.progressDialog(context, "Sincronizando con el servidor, por favor espere.");

        new AsyncTask<Void, Void, Void>() {
            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                dialog.show();
            }

            @Override
            protected Void doInBackground(Void... voids) {


                final AppDatabase db = AppDatabase.getInstance(context);
                final WebService ws = ApiProvider.getWebService();

                //cobros
                final List<Prestamo> prestamos = db.prestamoDao().getPrestamosNoSincronizados();
                if (prestamos.size() > 0) {

                    for (Prestamo p : prestamos) {

                        prestamos.get(prestamos.indexOf(p))
                                .setPrestamoDetalle(db.prestamoDetalleDao()
                                        .getPrestamoDetNoSincronizados(p.getId_prestamo()));

                        prestamos.get(prestamos.indexOf(p)).setAbonos(db.getCobrosProcesados()
                                .getAllAbonoByPrestamo(p.getId_prestamo()));

                        prestamos.get(prestamos.indexOf(p)).setPagoMora(db.getPagosMoraDao()
                                .getPagoMoraByPrestamo(p.getId_prestamo()));

                        final Gson gson = new Gson();
                        System.out.println(gson.toJson(p));


                        final Call<Prestamo> enviar_prestamo = ws.enviar_prestamo(p);

                        try {
                            final Response<Prestamo> response_ = enviar_prestamo.execute();
                            if (enviar_prestamo.isExecuted() && response_.isSuccessful() && response_.code() == 200) {


                                db.getLogDao().insertPrestamo(PrestamoLog.fromPrestamo(p));
                                for (PrestamoDetalle pd : p.getPrestamodetalle()) {
                                    db.getLogDao().insertPrestamoDetalle(PrestamoDetalleLog.fromPrestamoDetalle(pd));
                                }

                                String nuevaFecha = getFecha();

                                System.out.println("COBRO SINCRONIZADOS " + response_.body().isSincronizado());
                                db.prestamoDao().updatePrestamo(response_.body());
                                for (PrestamoDetalle detalle : response_.body().getPrestamodetalle()) {
                                    db.prestamoDetalleDao().updatePrestamoDetalle(detalle);

                                    if (detalle.getPagado() == 1) {
                                        nuevaFecha = detalle.getFecha_pago();
                                    }
                                }

                                db.getCobrosProcesados().updateAbonoBy(response_.body().getId_prestamo(), db.getUsuarioDao().getId(), nuevaFecha);
                                db.getCobrosProcesados().updateCobroByDetalle(response_.body().getId_prestamo(), db.getUsuarioDao().getId(), nuevaFecha);
                                db.getPagosMoraDao().setSincronizado(response_.body().getId_prestamo(), db.getUsuarioDao().getId());

                            } else {
                                System.out.println("COBROS NOOO SINCRONIZADOS");

                            }

                        } catch (Exception e) {
                            System.out.println(e.getMessage());
                        }


                    }

                    /*final Call<Prestamo> enviar_prestamos =  ws.enviar_prestamos(prestamos);
                    try {
                        final  Response<Prestamo> response_ = enviar_prestamos.execute();
                        if(enviar_prestamos.isExecuted() && response_.isSuccessful() && response_.code() == 200){

                            final Call<List<Prestamo>> obtener_prestamos =  ws.obtener_prestamos();
                            final Response<List<Prestamo>> response = obtener_prestamos.execute();

                            if(response.isSuccessful() && obtener_prestamos.isExecuted() && response.code() == 200 ){

                                for(Prestamo p: prestamos){

                                    final CobroProcesado cobroProcesado =
                                            new CobroProcesado(p.getPrestamodetalle().size(),
                                                    p.getId_prestamo(),
                                                    db.getUsuarioDao().getId()
                                            );

                                    db.getLogDao().insertPrestamo(PrestamoLog.fromPrestamo(p));

                                    double monto = 0.0;
                                    double mora = 0.0;
                                    for(PrestamoDetalle pd: p.getPrestamodetalle()){
                                        db.getLogDao().insertPrestamoDetalle(PrestamoDetalleLog.fromPrestamoDetalle(pd));

                                        monto += ( pd.getMonto() );
                                        mora += pd.getMora();


                                        if(pd.getAbono() > 0){
                                            monto+= (pd.getMora() - pd.getAbono());
                                            mora = 0.0;
                                        }

                                    }

                                    cobroProcesado.setMora(mora);
                                    cobroProcesado.setMonto(monto);

                                    final long id_cobro = db.getCobrosProcesados().insert(cobroProcesado);
                                    if(id_cobro > 0){
                                        Log.e("COBRO", "SE GUARDÓ EL COBRO");
                                        Log.e("COBRO", String.format("Cantidad -> %d | Mora -> %f | Monto -> %f",
                                                cobroProcesado.getCantidad(), cobroProcesado.getMora(), cobroProcesado.getMonto()));
                                    }
                                }

                                db.prestamoDao().deleteAll();
                                db.prestamoDao().insert(response.body());
                                db.prestamoDetalleDao().deleteAll();

                                for (Prestamo myPrestamo : response.body()) {
                                    if (myPrestamo.getPrestamodetalle() != null) {
                                        db.prestamoDetalleDao().insert(myPrestamo.getPrestamodetalle());
                                    }
                                }

                                //borrar cobros reaizados huerfanos
                                for(CobroProcesado cp: db.getCobrosProcesados().getAll()){
                                    if(db.prestamoDao().getById(cp.getId_prestamo()) == 0 &&
                                        db.getLogDao().getSaldo(cp.getId_prestamo()) >= 0.25){

                                        db.getCobrosProcesados().deleteAllByPrestamo(cp.getId_prestamo());

                                    }
                                }

                            }

                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }*/

                } else {
                    Log.e("SINCRONIZAR", "NO HAY DATOS");
                }

/*
                //abonos
                final List<Prestamo> prestamosAbonados = db.prestamoDao().getPrestamosNoSincronizadosAbonados();

                if(prestamosAbonados.size() > 0) {

                    for (Prestamo p : prestamosAbonados) {
                        prestamosAbonados.get(prestamosAbonados.indexOf(p))
                                .setPrestamoDetalle(db.prestamoDetalleDao()
                                        .getPrestamoDetNoSincronizadosAbonados(p.getId_prestamo()));


                        final Call<Prestamo> enviar_abonos =  ws.enviar_abonos(p);
                        try {
                            final Response<Prestamo> response_ = enviar_abonos.execute();

                            Gson gson = new Gson();
                            System.out.println(gson.toJson(p));

                            if (enviar_abonos.isExecuted() && response_.isSuccessful() && response_.code() == 200) {

                                db.getLogDao().insertPrestamo(PrestamoLog.fromPrestamo(p));
                                for(PrestamoDetalle pd: p.getPrestamodetalle()){
                                    db.getLogDao().insertPrestamoDetalle(PrestamoDetalleLog.fromPrestamoDetalle(pd));
                                }

                                System.out.println("ABONOS SINCRONIZADOS "+String.valueOf(response_.body().isSincronizado()));
                                db.prestamoDao().updatePrestamo(response_.body());
                                for (PrestamoDetalle detalle: response_.body().getPrestamodetalle()){
                                    db.prestamoDetalleDao().updatePrestamoDetalle(detalle);
                                }

                            }else{
                                System.out.println("ABONOS NOOO SINCRONIZADOS");

                            }

                        }catch (Exception e){
                            System.out.println(e.getMessage());
                        }

                    }



                }else{
                    Log.e("ABONOS", "NADA POR SINCRONIZAR");
                }
*/

                //clientes
                final List<Cliente> clientes = db.getClienteDao().getNoSincronizados();
                int id_cliente = 0;

                if (clientes.size() > 0) {

                    for (Cliente c : clientes) {

                        c.setArchivos(db.getClienteDao().getArchivosNoSincronizados(c.getId_cliente()));
                        c.setReferencias(db.getClienteDao().getReferenciasNoSincronizadas(c.getId_cliente()));

                        final Call<ResponseServer> post_cliente = ws.post_cliente(c);
                        try {
                            final Response<ResponseServer> response = post_cliente.execute();

                            if (response.isSuccessful() && response.code() == 200 && post_cliente.isExecuted()) {

                                if (!c.isSincronizado()) {
                                    id_cliente = response.body().getId();
                                    db.getSolicitudDao().actualizarIdCliente(id_cliente, c.getId_cliente());
                                    db.getFiadorDao().actualizarIdFiador(id_cliente, c.getId_cliente());
                                    db.getClienteDao().updateSync(id_cliente, c.getId_cliente());

                                }

                                Log.e("SYNC CLIENTE", "CLIENTE SUBIDO");

                                //LOG
                                saveCliente(db, c);
                                db.getClienteDao().deleteReferenciaByCliente(c.getId_cliente());
                                db.getClienteDao().delete(c);

                                final List<MultipartBody.Part> imagenes = new ArrayList<>();

                                if (c.getImagen() != null && !c.getImagen().isEmpty()) {
                                    imagenes.add(Functions.prepareFilePart("perfil", c.getImagen()));
                                }

                                if (imagenes.size() > 0) {
                                    final Call<ResponseServer> subir_imagenes = ws.subir_imagenes(imagenes);
                                    final Response<ResponseServer> response_ = subir_imagenes.execute();
                                }

                                //se sube uno a uno los archivos
                                subirDocumentos(db, ws, c.getArchivos());

                                /*final List<MultipartBody.Part> archivos = new ArrayList<>();

                                for(Archivo a: c.getArchivos()){
                                    archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), a.getUrl()));
                                }

                                if(archivos.size() > 0){

                                    final Call<ResponseServer> subir_documentos = ws.subir_documentos(archivos);
                                    final Response<ResponseServer> response_docs = subir_documentos.execute();

                                    if(response_docs.code() == 200 && response_docs.isSuccessful() && subir_documentos.isExecuted()){

                                        Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");

                                        db.getClienteDao().deleteArchivosByCliente(c.getId_cliente());
                                        db.getClienteDao().delete(c);

                                    }

                                }else{
                                    db.getClienteDao().deleteArchivosByCliente(c.getId_cliente());
                                    db.getClienteDao().delete(c);
                                }*/
                            }

                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                    }

                    final Call<List<Cliente>> get_clientes = ws.get_clientes();
                    try {
                        final Response<List<Cliente>> response = get_clientes.execute();

                        if (response.isSuccessful() && response.code() == 200 && get_clientes.isExecuted()) {
                            db.getClienteDao().deleteAllSincronizados();
                            db.getClienteDao().insert(response.body());

                            db.getClienteDao().deleteArchivosSincronizados();
                            db.getClienteDao().deleteReferenciasSincronizadas();

                            for (Cliente cliente : response.body()) {
                                db.getClienteDao().insertArchivos(cliente.getArchivos());
                                db.getClienteDao().insertReferencias(cliente.getReferencias());
                            }
                        }

                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } else {
                    Log.e("SINCRONIZACION CLIE", "NADA POR SINCRONIZAR");
                }


                //solicitudes crédito
                final List<SolicitudCredito> solicitudes = db.getSolicitudDao().getNoSincronizadas();
                if (solicitudes.size() > 0) {

                    for (SolicitudCredito s : solicitudes) {

                        s.setDetalles(db.getSolicitudDetalleDao().getNoSincronizadas(s.getId_solicitud()));
                        s.setGarantias(db.getGarantiaDao().getNoSincronizadas(s.getId_solicitud()));
                        s.setFiador(db.getFiadorDao().getNoSincronizado(s.getId_solicitud()));

                        try {
                            final Call<ResponseServer> post_solicitud = ws.post_solicitud(s);
                            final Response<ResponseServer> response = post_solicitud.execute();

                            if (response.isSuccessful() && response.code() == 200 && post_solicitud.isExecuted()) {


                                //Se subió la solicitud exitosamente
                                //LOG
                                saveSolicitud(db, s, 0);

                                if (s.isTiene_fiador()) {
                                    db.getFiadorDao().delete(s.getFiador());
                                }

                                db.getSolicitudDetalleDao().deleteAllBySolicitud(s.getId_solicitud());
                                db.getSolicitudDao().delete(s);

                                //subir garantias
                                subirGarantias(db, ws, s.getGarantias());

                                /*final List<MultipartBody.Part> archivos = new ArrayList<>();

                                System.out.println(s.getGarantias().size());
                                for(Garantia g: s.getGarantias()){
                                    System.out.println(g.getUrl());
                                    archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), g.getUrl()));
                                }

                                if(archivos.size() > 0){

                                    final Call<ResponseServer> subir_documentos = ws.subir_documentos(archivos);
                                    final Response<ResponseServer> response_docs = subir_documentos.execute();

                                    if(response_docs.code() == 200 && response_docs.isSuccessful() && subir_documentos.isExecuted()){

                                        //LOG
                                        saveSolicitud(db, s, 0);

                                        if(s.isTiene_fiador()){
                                            db.getFiadorDao().delete(s.getFiador());
                                        }

                                        db.getSolicitudDetalleDao().deleteAllBySolicitud(s.getId_solicitud());
                                        db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                        db.getSolicitudDao().delete(s);

                                    }

                                }else{
                                    //LOG
                                    saveSolicitud(db, s, 0);

                                    if(s.isTiene_fiador()){
                                        db.getFiadorDao().delete(s.getFiador());
                                    }

                                    db.getSolicitudDetalleDao().deleteAllBySolicitud(s.getId_solicitud());
                                    db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                    db.getSolicitudDao().delete(s);
                                }*/

                            }

                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                    }

                    //obtener solicitudes
                    final Call<List<SolicitudCredito>> obtener_solicitudes = ws.obtener_solicitudes();
                    try {
                        final Response<List<SolicitudCredito>> response = obtener_solicitudes.execute();

                        if (response.isSuccessful() && response.code() == 200 && obtener_solicitudes.isExecuted()) {
                            db.getSolicitudDao().deleteAllSincronizados();
                            db.getSolicitudDao().insert(response.body());

                            db.getSolicitudDetalleDao().deleteAllSincronizados();
                            db.getGarantiaDao().deleteAllSincronizados();
                            db.getFiadorDao().deleteAllSincronizados();

                            for (SolicitudCredito s : response.body()) {
                                db.getSolicitudDetalleDao().insert(s.getDetalles());
                            }
                        }

                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } else {
                    Log.e("SINCRONIZACION SOL", "NADA POR SINCRONIZAR");
                }

                //solicitudes refinanciamiento
                final List<SolicitudCredito> solicitudes_ref = db.getSolicitudDao().getRefNoSincronizadas();

                if (solicitudes_ref.size() > 0) {

                    for (SolicitudCredito s : solicitudes_ref) {

                        s.setGarantias(db.getGarantiaDao().getNoSincronizadas(s.getId_solicitud()));
                        s.setFiador(db.getFiadorDao().getNoSincronizado(s.getId_solicitud()));

                        final Call<ResponseServer> enviar_refinanciamiento = ws.enviar_refinanciamiento(s);
                        try {
                            final Response<ResponseServer> response = enviar_refinanciamiento.execute();

                            if (response.code() == 200 && response.isSuccessful() && enviar_refinanciamiento.isExecuted()) {

                                //LOG
                                saveSolicitud(db, s, 1);

                                if (s.isTiene_fiador()) {
                                    db.getFiadorDao().delete(s.getFiador());
                                }

                                db.getSolicitudDao().delete(s);

                                subirGarantias(db, ws, s.getGarantias());

                                /*final List<MultipartBody.Part> archivos = new ArrayList<>();

                                for(Garantia g: s.getGarantias()){
                                    System.out.println(g.getUrl());
                                    archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), g.getUrl()));
                                }

                                if(archivos.size() > 0){

                                    final Call<ResponseServer> subir_documentos = ws.subir_documentos(archivos);
                                    final Response<ResponseServer> response_docs = subir_documentos.execute();

                                    if(response_docs.code() == 200 && response_docs.isSuccessful() && subir_documentos.isExecuted()){

                                        Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");

                                        //LOG
                                        saveSolicitud(db, s, 1);

                                        if(s.isTiene_fiador()){
                                            db.getFiadorDao().delete(s.getFiador());
                                        }

                                        db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                        db.getSolicitudDao().delete(s);

                                    }

                                }else{
                                    //LOG
                                    saveSolicitud(db, s, 1);

                                    if(s.isTiene_fiador()){
                                        db.getFiadorDao().delete(s.getFiador());
                                    }

                                    db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                    db.getSolicitudDao().delete(s);
                                }*/

                            }

                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                    }

                    final Call<List<SolicitudCredito>> obtener_solicitudes = ws.obtener_solicitudes();
                    try {
                        final Response<List<SolicitudCredito>> response = obtener_solicitudes.execute();

                        if (response.isSuccessful() && response.code() == 200 && obtener_solicitudes.isExecuted()) {
                            db.getSolicitudDao().deleteAllSincronizados();
                            db.getSolicitudDao().insert(response.body());

                            db.getSolicitudDetalleDao().deleteAllSincronizados();
                            db.getGarantiaDao().deleteAllSincronizados();
                            db.getFiadorDao().deleteAllSincronizados();

                            for (SolicitudCredito s : response.body()) {
                                db.getSolicitudDetalleDao().insert(s.getDetalles());
                            }
                        }

                    } catch (IOException e) {
                        e.printStackTrace();
                    }


                    //subir documentos huerfanos
                    subirDocumentos(db, ws);

                    //subir garatias
                    subirGarantias(db, ws);

                } else {
                    Log.e("SINCRONIZACION REF", "NADA POR SINCRONIZAR");
                }

                return null;
            }

            @Override
            protected void onPostExecute(Void aVoid) {
                super.onPostExecute(aVoid);
                dialog.dismiss();
            }
        }.execute();

    }

    public static void subirCambios2(Context context) {


        final NotificationConfig config = new NotificationConfig();
        config.setAuto_cancel(true);
        config.setChannel_id("sincronizacion_servidor");
        config.setChannel_description("Sincroniza en segundo plano los datos de la app");
        config.setSound(false);
        config.setClase(MainActivity.class);
        config.setContext(context);
        config.setContent("Sincronizando datos con el servidor");
        config.setIcon(R.drawable.logo);
        config.setProgress(true);
        config.setName("Credi Master");
        config.setVibration(false);
        config.setLights(true);
        config.setLed_color(context.getResources().getColor(R.color.azul));

        new AsyncTask<Void, Void, Void>() {

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                Notification.notify(config);
            }

            @Override
            protected Void doInBackground(Void... voids) {

                final AppDatabase db = AppDatabase.getInstance(context);
                final WebService ws = ApiProvider.getWebService();

                //cobros
                final List<Prestamo> prestamos = db.prestamoDao().getPrestamosNoSincronizados();
                if (prestamos.size() > 0) {

                    for (Prestamo p : prestamos) {
                        prestamos.get(prestamos.indexOf(p))
                                .setPrestamoDetalle(db.prestamoDetalleDao()
                                        .getPrestamoDetNoSincronizados(p.getId_prestamo()));
                    }

                    final Call<Prestamo> enviar_prestamos = ws.enviar_prestamos(prestamos);
                    try {
                        final Response<Prestamo> response_ = enviar_prestamos.execute();
                        if (enviar_prestamos.isExecuted() && response_.isSuccessful() && response_.code() == 200) {

                            final Call<List<Prestamo>> obtener_prestamos = ws.obtener_prestamos();
                            final Response<List<Prestamo>> response = obtener_prestamos.execute();

                            if (response.isSuccessful() && obtener_prestamos.isExecuted() && response.code() == 200) {

                                for (Prestamo p : prestamos) {

                                    final CobroProcesado cobroProcesado =

                                            new CobroProcesado(p.getPrestamodetalle().size(),
                                                    p.getId_prestamo(),
                                                    db.getUsuarioDao().getId()
                                            );

                                    db.getLogDao().insertPrestamo(PrestamoLog.fromPrestamo(p));

                                    for (PrestamoDetalle pd : p.getPrestamodetalle()) {
                                        db.getLogDao().insertPrestamoDetalle(PrestamoDetalleLog.fromPrestamoDetalle(pd));

                                        cobroProcesado.setMora(cobroProcesado.getMora() + pd.getMora());
                                        cobroProcesado.setMonto(cobroProcesado.getMonto() + pd.getMonto());
                                    }

                                    final long id_cobro = db.getCobrosProcesados().insert(cobroProcesado);
                                    if (id_cobro > 0) {
                                        Log.e("COBRO", "SE GUARDÓ EL COBRO");
                                    }
                                }

                                db.prestamoDao().deleteAll();
                                db.prestamoDao().insert(response.body());
                                db.prestamoDetalleDao().deleteAll();

                                for (Prestamo myPrestamo : response.body()) {
                                    if (myPrestamo.getPrestamodetalle() != null) {
                                        db.prestamoDetalleDao().insert(myPrestamo.getPrestamodetalle());
                                    }
                                }

                                //borrar cobros reaizados huerfanos
                                for (CobroProcesado cp : db.getCobrosProcesados().getAll()) {
                                    if (db.prestamoDao().getById(cp.getId_prestamo()) == 0) {
                                        db.getCobrosProcesados().delete(cp);
                                    }
                                }

                            }

                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } else {
                    Log.e("SINCRONIZAR", "NO HAY DATOS");
                }

                //clientes
                final List<Cliente> clientes = db.getClienteDao().getNoSincronizados();
                int id_cliente = 0;

                if (clientes.size() > 0) {

                    for (Cliente c : clientes) {

                        c.setArchivos(db.getClienteDao().getArchivosNoSincronizados(c.getId_cliente()));
                        c.setReferencias(db.getClienteDao().getReferenciasNoSincronizadas(c.getId_cliente()));

                        final Call<ResponseServer> post_cliente = ws.post_cliente(c);
                        try {
                            final Response<ResponseServer> response = post_cliente.execute();

                            if (response.isSuccessful() && response.code() == 200 && post_cliente.isExecuted()) {

                                if (!c.isSincronizado()) {
                                    id_cliente = response.body().getId();
                                    db.getSolicitudDao().actualizarIdCliente(id_cliente, c.getId_cliente());
                                    db.getFiadorDao().actualizarIdFiador(id_cliente, c.getId_cliente());
                                }

                                Log.e("SYNC CLIENTE", "CLIENTE SUBIDO");
                                final List<MultipartBody.Part> imagenes = new ArrayList<>();

                                if (c.getImagen() != null && !c.getImagen().isEmpty()) {
                                    imagenes.add(Functions.prepareFilePart("perfil", c.getImagen()));
                                }

                                if (imagenes.size() > 0) {
                                    final Call<ResponseServer> subir_imagenes = ws.subir_imagenes(imagenes);
                                    final Response<ResponseServer> response_ = subir_imagenes.execute();
                                }


                                final List<MultipartBody.Part> archivos = new ArrayList<>();

                                for (Archivo a : c.getArchivos()) {
                                    archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), a.getUrl()));
                                }

                                if (archivos.size() > 0) {

                                    final Call<ResponseServer> subir_documentos = ws.subir_documentos(archivos);
                                    final Response<ResponseServer> response_docs = subir_documentos.execute();

                                    if (response_docs.code() == 200 && response_docs.isSuccessful() && subir_documentos.isExecuted()) {

                                        Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");

                                        //LOG
                                        saveCliente(db, c);

                                        db.getClienteDao().deleteReferenciaByCliente(c.getId_cliente());
                                        db.getClienteDao().deleteArchivosByCliente(c.getId_cliente());
                                        db.getClienteDao().delete(c);

                                    }

                                } else {
                                    //LOG
                                    saveCliente(db, c);

                                    db.getClienteDao().deleteReferenciaByCliente(c.getId_cliente());
                                    db.getClienteDao().deleteArchivosByCliente(c.getId_cliente());
                                    db.getClienteDao().delete(c);
                                }
                            }

                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                    }

                    final Call<List<Cliente>> get_clientes = ws.get_clientes();
                    try {
                        final Response<List<Cliente>> response = get_clientes.execute();

                        if (response.isSuccessful() && response.code() == 200 && get_clientes.isExecuted()) {
                            db.getClienteDao().deleteAllSincronizados();
                            db.getClienteDao().insert(response.body());

                            db.getClienteDao().deleteArchivosSincronizados();
                            db.getClienteDao().deleteReferenciasSincronizadas();

                            for (Cliente cliente : response.body()) {
                                db.getClienteDao().insertArchivos(cliente.getArchivos());
                                db.getClienteDao().insertReferencias(cliente.getReferencias());
                            }
                        }

                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } else {
                    Log.e("SINCRONIZACION CLIE", "NADA POR SINCRONIZAR");
                }


                //solicitudes crédito
                final List<SolicitudCredito> solicitudes = db.getSolicitudDao().getNoSincronizadas();
                if (solicitudes.size() > 0) {

                    for (SolicitudCredito s : solicitudes) {

                        s.setDetalles(db.getSolicitudDetalleDao().getNoSincronizadas(s.getId_solicitud()));
                        s.setGarantias(db.getGarantiaDao().getNoSincronizadas(s.getId_solicitud()));
                        s.setFiador(db.getFiadorDao().getNoSincronizado(s.getId_solicitud()));

                        try {
                            final Call<ResponseServer> post_solicitud = ws.post_solicitud(s);
                            final Response<ResponseServer> response = post_solicitud.execute();

                            if (response.isSuccessful() && response.code() == 200 && post_solicitud.isExecuted()) {

                                final List<MultipartBody.Part> archivos = new ArrayList<>();

                                System.out.println(s.getGarantias().size());
                                for (Garantia g : s.getGarantias()) {
                                    System.out.println(g.getUrl());
                                    archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), g.getUrl()));
                                }

                                if (archivos.size() > 0) {

                                    final Call<ResponseServer> subir_documentos = ws.subir_documentos(archivos);
                                    final Response<ResponseServer> response_docs = subir_documentos.execute();

                                    if (response_docs.code() == 200 && response_docs.isSuccessful() && subir_documentos.isExecuted()) {

                                        //LOG
                                        saveSolicitud(db, s, 0);

                                        if (s.isTiene_fiador()) {
                                            db.getFiadorDao().delete(s.getFiador());
                                        }

                                        db.getSolicitudDetalleDao().deleteAllBySolicitud(s.getId_solicitud());
                                        db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                        db.getSolicitudDao().delete(s);

                                    }

                                } else {
                                    //LOG
                                    saveSolicitud(db, s, 0);

                                    if (s.isTiene_fiador()) {
                                        db.getFiadorDao().delete(s.getFiador());
                                    }

                                    db.getSolicitudDetalleDao().deleteAllBySolicitud(s.getId_solicitud());
                                    db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                    db.getSolicitudDao().delete(s);
                                }

                            }

                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                    }


                    final Call<List<SolicitudCredito>> obtener_solicitudes = ws.obtener_solicitudes();
                    try {
                        final Response<List<SolicitudCredito>> response = obtener_solicitudes.execute();

                        if (response.isSuccessful() && response.code() == 200 && obtener_solicitudes.isExecuted()) {
                            db.getSolicitudDao().deleteAllSincronizados();
                            db.getSolicitudDao().insert(response.body());

                            db.getSolicitudDetalleDao().deleteAllSincronizados();
                            db.getGarantiaDao().deleteAllSincronizados();
                            db.getFiadorDao().deleteAllSincronizados();

                            for (SolicitudCredito s : response.body()) {
                                db.getSolicitudDetalleDao().insert(s.getDetalles());
                            }
                        }

                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } else {
                    Log.e("SINCRONIZACION SOL", "NADA POR SINCRONIZAR");
                }

                //solicitudes refinanciamiento
                final List<SolicitudCredito> solicitudes_ref = db.getSolicitudDao().getRefNoSincronizadas();

                if (solicitudes_ref.size() > 0) {

                    for (SolicitudCredito s : solicitudes_ref) {

                        s.setGarantias(db.getGarantiaDao().getNoSincronizadas(s.getId_solicitud()));
                        s.setFiador(db.getFiadorDao().getNoSincronizado(s.getId_solicitud()));

                        final Call<ResponseServer> enviar_refinanciamiento = ws.enviar_refinanciamiento(s);
                        try {
                            final Response<ResponseServer> response = enviar_refinanciamiento.execute();

                            if (response.code() == 200 && response.isSuccessful() && enviar_refinanciamiento.isExecuted()) {

                                final List<MultipartBody.Part> archivos = new ArrayList<>();

                                for (Garantia g : s.getGarantias()) {
                                    System.out.println(g.getUrl());
                                    archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), g.getUrl()));
                                }

                                if (archivos.size() > 0) {

                                    final Call<ResponseServer> subir_documentos = ws.subir_documentos(archivos);
                                    final Response<ResponseServer> response_docs = subir_documentos.execute();

                                    if (response_docs.code() == 200 && response_docs.isSuccessful() && subir_documentos.isExecuted()) {

                                        Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");

                                        //LOG
                                        saveSolicitud(db, s, 1);

                                        if (s.isTiene_fiador()) {
                                            db.getFiadorDao().delete(s.getFiador());
                                        }

                                        db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                        db.getSolicitudDao().delete(s);

                                    }

                                } else {
                                    //LOG
                                    saveSolicitud(db, s, 1);

                                    if (s.isTiene_fiador()) {
                                        db.getFiadorDao().delete(s.getFiador());
                                    }

                                    db.getGarantiaDao().deleteAllBySolicitud(s.getId_solicitud());
                                    db.getSolicitudDao().delete(s);
                                }

                            }

                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                    }

                    final Call<List<SolicitudCredito>> obtener_solicitudes = ws.obtener_solicitudes();
                    try {
                        final Response<List<SolicitudCredito>> response = obtener_solicitudes.execute();

                        if (response.isSuccessful() && response.code() == 200 && obtener_solicitudes.isExecuted()) {
                            db.getSolicitudDao().deleteAllSincronizados();
                            db.getSolicitudDao().insert(response.body());

                            db.getSolicitudDetalleDao().deleteAllSincronizados();
                            db.getGarantiaDao().deleteAllSincronizados();
                            db.getFiadorDao().deleteAllSincronizados();


                            for (SolicitudCredito s : response.body()) {
                                db.getSolicitudDetalleDao().insert(s.getDetalles());
                            }
                        }

                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } else {
                    Log.e("SINCRONIZACION REF", "NADA POR SINCRONIZAR");
                }


                return null;
            }

            @Override
            protected void onPostExecute(Void aVoid) {
                super.onPostExecute(aVoid);
                Notification.getManager(context).cancel(1122);
            }

        }.execute();
    }

    public static float getValueFormat(Object value) {
        final DecimalFormat df = new DecimalFormat("#########.##");
        String value_format = df.format(value);
        value_format = value_format.replace(",", "");
        return Float.valueOf(value_format);
    }

    public static String getRealPathFromURI(Uri contentURI, Context context) {
        String result;
        Cursor cursor = context.getContentResolver().query(contentURI, null, null, null, null);
        if (cursor == null) { // Source is Dropbox or other similar local file path
            result = contentURI.getPath();
        } else {
            cursor.moveToFirst();
            int idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA);
            result = cursor.getString(idx);
            cursor.close();
        }
        return result;
    }

    public static void showPictureDialog(Context context, Option option1, Option option2) {
        AlertDialog.Builder pictureDialog = new AlertDialog.Builder(context);
        pictureDialog.setTitle("Seleccionar");
        String[] pictureDialogItems = {
                "Seleccionar imagen de galería",
                "Tomar fotografía"};

        pictureDialog.setItems(pictureDialogItems,
                (dialog, which) -> {
                    switch (which) {
                        case 0:
                            //choosePhotoFromGallary();
                            option1.OnClick();
                            break;
                        case 1:
                            //takePhotoFromCamera();
                            option2.OnClick();
                            break;
                    }
                });
        pictureDialog.show();
    }

    public static String getRealPathFromURI(Context context, Uri contentUri) {
        Cursor cursor = null;
        try {

            String[] proj = {MediaStore.Images.Media.DATA};
            cursor = context.getContentResolver().query(contentUri, proj, null, null, null);
            int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
            cursor.moveToFirst();
            Log.e("PATH", cursor.getString(column_index));
            return cursor.getString(column_index);

        } catch (Exception e) {
            Log.e("PATH", "getRealPathFromURI Exception : " + e.toString());
            return "";
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
    }

    public static int generateUniqueId() {
        UUID idOne = UUID.randomUUID();
        String str = "" + idOne;
        int uid = str.hashCode();
        String filterStr = "" + uid;
        str = filterStr.replaceAll("-", "");
        return Integer.parseInt(str);
    }

    public static void setLanguage(Activity activity) {

        final Locale localizacion = new Locale("es", "SV");

        Locale.setDefault(localizacion);
        Configuration config = new Configuration();
        config.locale = localizacion;
        activity.getBaseContext().getResources()
                .updateConfiguration(config, activity.getResources().getDisplayMetrics());

    }

    static void subirDocumentos(AppDatabase db, WebService ws) {
        //Archivos Clientes
        final List<Archivo> archivoList = db.getClienteDao().getArchivosNoSync();
        if (archivoList.size() > 0) {

            for (Archivo a : archivoList) {

                final MultipartBody.Part doc = Functions.prepareFilePart("documento", a.getUrl());

                final Call<ResponseServer> subir_documento = ws.subir_documento(doc);
                final Response<ResponseServer> response_doc;
                try {
                    response_doc = subir_documento.execute();
                    if (response_doc.code() == 200 && response_doc.isSuccessful() && subir_documento.isExecuted()) {

                        Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");
                        db.getClienteDao().deleteArchivo(a);

                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }

    static void subirDocumentos(AppDatabase db, WebService ws, List<Archivo> archivos) {
        //Archivos Clientes
        final List<Archivo> archivoList = archivos;
        if (archivoList.size() > 0) {

            for (Archivo a : archivoList) {

                final MultipartBody.Part doc = Functions.prepareFilePart("documento", a.getUrl());

                final Call<ResponseServer> subir_documento = ws.subir_documento(doc);
                final Response<ResponseServer> response_doc;
                try {
                    response_doc = subir_documento.execute();
                    if (response_doc.code() == 200 && response_doc.isSuccessful() && subir_documento.isExecuted()) {

                        Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");
                        db.getClienteDao().deleteArchivo(a);

                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }


    static void subirGarantias(AppDatabase db, WebService ws) {
        //Garantías solicitud
        final List<Garantia> garantias = db.getGarantiaDao().getNoSync();
        if (garantias.size() > 0) {

            for (Garantia a : garantias) {

                final MultipartBody.Part doc = Functions.prepareFilePart("documento", a.getUrl());

                final Call<ResponseServer> subir_documento = ws.subir_documento(doc);
                final Response<ResponseServer> response_doc;
                try {
                    response_doc = subir_documento.execute();
                    if (response_doc.code() == 200 && response_doc.isSuccessful() && subir_documento.isExecuted()) {

                        Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");
                        db.getGarantiaDao().delete(a);

                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }

    static void subirGarantias(AppDatabase db, WebService ws, List<Garantia> garantias_) {
        //Garantías solicitud
        final List<Garantia> garantias = garantias_;
        if (garantias.size() > 0) {

            for (Garantia a : garantias) {

                final MultipartBody.Part doc = Functions.prepareFilePart("documento", a.getUrl());

                final Call<ResponseServer> subir_documento = ws.subir_documento(doc);
                final Response<ResponseServer> response_doc;
                try {
                    response_doc = subir_documento.execute();
                    if (response_doc.code() == 200 && response_doc.isSuccessful() && subir_documento.isExecuted()) {

                        Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");
                        db.getGarantiaDao().delete(a);

                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }

    public static double decimal2Places(double val) {
        BigDecimal bd = new BigDecimal(val).setScale(2, RoundingMode.HALF_UP);
        System.out.println(bd);
        return bd.doubleValue();
    }


    public static boolean runningService(Context context) {
        final ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);

        for (ActivityManager.RunningServiceInfo service : activityManager.getRunningServices(Integer.MAX_VALUE)) {
            if (TrackingService.class.getName().equals(service.service.getClassName())) {
                return true;
            }
        }

        return false;
    }

    public static void startService(Context context) {

        if (EasySharedPreference.Companion.getBoolean("sesion_activa", false)) {
            final Intent intent = new Intent(context, TrackingService.class);

            if (runningService(context)) {
                context.stopService(intent);
            }

            int permission = ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION);

            if (permission == PackageManager.PERMISSION_GRANTED) {

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    System.out.println("START SERVICE");
                    context.startForegroundService(intent);
                } else {
                    System.out.println("START SERVICE 2");
                    context.startService(intent);
                }
            }
        }
    }


    public static boolean canUpdateNow(Context context) {
        String lastUpdate = EasySharedPreference.Companion.getString("last_update", getTimeBefore(16));

        double time = diff(lastUpdate);

        Toast.makeText(context, "Última actualización hace " + time + " minutos", Toast.LENGTH_LONG).show();

        return time > 15;
    }


    public static String getTimeBefore(int time) {
        final Calendar calendar = Calendar.getInstance();
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
        calendar.add(Calendar.MINUTE, time * -1);
        return format.format(calendar.getTime());
    }

    public static double diff(String last) {
        String now = Functions.getHora();

        double difference = 0;

        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
        Date date1 = null;
        Date date2 = null;
        try {
            date1 = format.parse(last);
            date2 = format.parse(now);

            long difference_ = date2.getTime() - date1.getTime();

            if (difference_ < 0) {
                difference_ = date1.getTime() - date2.getTime();
            }

            difference = (difference_ / 1000) / 60;

        } catch (ParseException e) {
            e.printStackTrace();
        }

        return difference;
    }

    public static <T> String format(String suffix, T value, ArgType type) {

        String result = "";

        if (type == string) {
            return String.format("%s %s", suffix, value);
        } else if (type == integer) {
            return String.format("%s %d", suffix, value);
        } else if (type == decimal) {
            return String.format("%s %f", suffix, value);
        }

        return "";
    }


    public static String proximaMora(int id_prestamo, Context context) {

        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        PrestamoDetalleDao dao = AppDatabase.getInstance(context).prestamoDetalleDao();

        final String fecha_vence = dao.getSiguienteCuota(id_prestamo);

        Date vence = null;
        Date hoy = null;

        try {
            vence = sdf.parse(fecha_vence);
            hoy = sdf.parse(getFecha());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Calendar fVence = Calendar.getInstance();
        Calendar fHoy = Calendar.getInstance();

        fVence.setTime(vence);
        fHoy.setTime(hoy);

        if (fHoy.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
            fHoy.add(Calendar.DAY_OF_MONTH, 2);
        }

        String fecha = "";
        if (fVence.before(fHoy)) {
            fHoy.add(Calendar.DAY_OF_MONTH, 7);
            fecha = sdf.format(fHoy.getTime());
        } else {
            //fVence.add(Calendar.DAY_OF_MONTH, -7);
            fecha = sdf.format(fVence.getTime());
        }

        return fecha;
    }

    public static boolean nuevoEstadoAtrasado(int id_prestamo, Context context) {

        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        PrestamoDetalleDao dao = AppDatabase.getInstance(context).prestamoDetalleDao();

        final String fecha_vence = dao.getSiguienteCuota(id_prestamo);

        Date vence = null;
        Date hoy = null;

        try {
            vence = sdf.parse(fecha_vence);
            hoy = sdf.parse(getFecha());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Calendar fVence = Calendar.getInstance();
        Calendar fHoy = Calendar.getInstance();

        fVence.setTime(vence);
        fHoy.setTime(hoy);

        if (fHoy.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
            fHoy.add(Calendar.DAY_OF_MONTH, 2);
        }

        boolean atrasado = false;
        if (fVence.before(fHoy)) {
            atrasado = true;
        }

        return atrasado;
    }

}
