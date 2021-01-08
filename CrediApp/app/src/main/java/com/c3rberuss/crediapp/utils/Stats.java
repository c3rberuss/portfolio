package com.c3rberuss.crediapp.utils;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.ArchivoLog;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.entities.FiadorLog;
import com.c3rberuss.crediapp.entities.GarantiaLog;
import com.c3rberuss.crediapp.entities.PrestamoDetalleLog;
import com.c3rberuss.crediapp.entities.PrestamoLog;
import com.c3rberuss.crediapp.entities.ReferenciaLog;
import com.c3rberuss.crediapp.entities.SolicitudCreditoLog;
import com.c3rberuss.crediapp.entities.SolicitudDetalleLog;

import java.util.ArrayList;
import java.util.List;

public class Stats extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {

        final AppDatabase db = AppDatabase.getInstance(context);

        if(EasySharedPreference.Companion.getBoolean("sesion_activa", false)){

            final List<String> urls = new ArrayList<>();

            String url_tmp;

            final List<PrestamoDetalleLog> prestamosDetalle = db.getLogDao().getPrestamosDetalle();
            url_tmp = Functions.toCSV(PrestamoDetalleLog.class, prestamosDetalle, context);

            if (!url_tmp.isEmpty()) {
                urls.add(url_tmp);
            }

            final List<PrestamoLog> prestamoLogs = db.getLogDao().getPrestamos();
            url_tmp = Functions.toCSV(PrestamoLog.class, prestamoLogs, context);

            if (!url_tmp.isEmpty()) {
                urls.add(url_tmp);
            }

            final List<ArchivoLog> archivoLogs = db.getLogDao().getArchivos();
            url_tmp = Functions.toCSV(ArchivoLog.class, archivoLogs, context);

            if (!url_tmp.isEmpty()) {
                urls.add(url_tmp);
            }

            final List<GarantiaLog> garantiaLogs = db.getLogDao().getGarantias();
            url_tmp = Functions.toCSV(GarantiaLog.class, garantiaLogs, context);

            if (!url_tmp.isEmpty()) {
                urls.add(url_tmp);
            }

            final List<ReferenciaLog> referenciaLogs = db.getLogDao().getReferencias();
            url_tmp = Functions.toCSV(ReferenciaLog.class, referenciaLogs, context);

            if (!url_tmp.isEmpty()) {
                urls.add(url_tmp);
            }

            final List<FiadorLog> fiadorLogs = db.getLogDao().getFiadores();
            url_tmp = Functions.toCSV(FiadorLog.class, fiadorLogs, context);

            if (!url_tmp.isEmpty()) {
                urls.add(url_tmp);
            }

            final List<SolicitudCreditoLog> solicitudCreditoLogs = db.getLogDao().getSolicitudes();
            url_tmp = Functions.toCSV(SolicitudCreditoLog.class, solicitudCreditoLogs, context);

            if (!url_tmp.isEmpty()) {
                urls.add(url_tmp);
            }

            final List<SolicitudDetalleLog> solicitudDetalleLogs = db.getLogDao().getSolicitudesDetalle();
            url_tmp = Functions.toCSV(SolicitudDetalleLog.class, solicitudDetalleLogs, context);

            if (!url_tmp.isEmpty()) {
                urls.add(url_tmp);
            }

            final List<CobroProcesado> cobroProcesados = db.getCobrosProcesados().getAll();
            url_tmp = Functions.toCSV(CobroProcesado.class, cobroProcesados, context);

            if (!url_tmp.isEmpty()) {
                urls.add(url_tmp);
            }

            if (urls.size() > 0) {
                Email.sendMultiFiles(urls,
                        "Resumen Diario de transacciones. - "+db.getUsuarioDao().getNombre(),
                        "Backup Automático - "+db.getUsuarioDao().getNombre());

                Log.e("BACKUP", "EJECUTANDO");
            }
        }
    }
}
