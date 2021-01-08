package com.c3rberuss.crediapp.utils;

import android.app.Dialog;
import android.os.AsyncTask;

import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.AbonoDao;
import com.c3rberuss.crediapp.database.dao.ClienteDao;
import com.c3rberuss.crediapp.database.dao.CobroProcesadoDao;
import com.c3rberuss.crediapp.database.dao.DepartamentoDao;
import com.c3rberuss.crediapp.database.dao.FiadorDao;
import com.c3rberuss.crediapp.database.dao.FrecuenciaDao;
import com.c3rberuss.crediapp.database.dao.GarantiaDao;
import com.c3rberuss.crediapp.database.dao.MunicipioDao;
import com.c3rberuss.crediapp.database.dao.PagosMoraDao;
import com.c3rberuss.crediapp.database.dao.ParentezcoDao;
import com.c3rberuss.crediapp.database.dao.PermisoDao;
import com.c3rberuss.crediapp.database.dao.PlanDao;
import com.c3rberuss.crediapp.database.dao.PlanRequisitoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDetalleDao;
import com.c3rberuss.crediapp.database.dao.RequisitoDao;
import com.c3rberuss.crediapp.database.dao.SolicitudDao;
import com.c3rberuss.crediapp.database.dao.SolicitudDetalleDao;
import com.c3rberuss.crediapp.database.dao.UsuarioDao;

public class deleteAsyncTask extends AsyncTask<Void, Void, Void> {

    private FrecuenciaDao frecuenciaDao;
    private ParentezcoDao parentezcoDao;
    private DepartamentoDao departamentoDao;
    private MunicipioDao municipioDao;
    private PrestamoDao prestamoDao;
    private PrestamoDetalleDao prestamoDetalleDao;
    private PlanDao planDao;
    private RequisitoDao requisitoDao;
    private PlanRequisitoDao planRequisito2;
    private ClienteDao clienteDao;
    private SolicitudDetalleDao solicitudDetalleDao;
    private SolicitudDao solicitudDao;
    private FiadorDao fiadorDao;
    private GarantiaDao garantiaDao;
    private PagosMoraDao pagosMoraDao;
    private UsuarioDao usuarioDao;
    private PermisoDao permisoDao;
    private CobroProcesadoDao cobroProcesadoDao;
    private AbonoDao abonoDao;
    private AppDatabase db;
    private Dialog dialog;

    public deleteAsyncTask(AppDatabase db, Dialog dialog){
        frecuenciaDao = db.getFrecuenciaDao();
        parentezcoDao = db.getPatentezcoDao();
        departamentoDao = db.getDepartamentoDao();
        municipioDao = db.getMunicipioDao();
        prestamoDao = db.prestamoDao();
        prestamoDetalleDao = db.prestamoDetalleDao();
        planDao = db.getPlanesDao();
        requisitoDao = db.getRequisitoDao();
        clienteDao = db.getClienteDao();
        solicitudDao = db.getSolicitudDao();
        solicitudDetalleDao = db.getSolicitudDetalleDao();
        fiadorDao = db.getFiadorDao();
        garantiaDao = db.getGarantiaDao();
        planRequisito2 = db.getPlanRequisitoDao();
        usuarioDao = db.getUsuarioDao();
        permisoDao = db.getPermisoDao();
        cobroProcesadoDao = db.getCobrosProcesados();
        abonoDao = db.getAbonoDao();
        pagosMoraDao = db.getPagosMoraDao();
        this.db = db;
        this.dialog = dialog;

    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
        dialog.show();
    }

    @Override
    protected Void doInBackground(Void... voids) {

        frecuenciaDao.deleteAll();
        parentezcoDao.deleteAll();
        departamentoDao.deleteAll();
        municipioDao.deleteAll();
        prestamoDao.deleteAll2();
        prestamoDetalleDao.deleteAll2();
        planDao.deleteAll();
        requisitoDao.deleteAll();
        clienteDao.deleteAll();
        solicitudDao.deleteAll();
        solicitudDetalleDao.deleteAll();
        fiadorDao.deleteAll();
        garantiaDao.deleteAll();
        planRequisito2.deleteAll();
        cobroProcesadoDao.deleteAll();
        abonoDao.deleteAll();
        pagosMoraDao.deleteAll();

        return null;
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        super.onPostExecute(aVoid);
        dialog.dismiss();
    }
}
