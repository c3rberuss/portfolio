package com.c3rberuss.crediapp.utils;

import android.app.Dialog;
import android.os.AsyncTask;
import android.util.Log;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.AbonoDao;
import com.c3rberuss.crediapp.database.dao.ClienteDao;
import com.c3rberuss.crediapp.database.dao.CobroProcesadoDao;
import com.c3rberuss.crediapp.database.dao.DepartamentoDao;
import com.c3rberuss.crediapp.database.dao.FiadorDao;
import com.c3rberuss.crediapp.database.dao.FrecuenciaDao;
import com.c3rberuss.crediapp.database.dao.GarantiaDao;
import com.c3rberuss.crediapp.database.dao.MunicipioDao;
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
import com.c3rberuss.crediapp.entities.Abono;
import com.c3rberuss.crediapp.entities.Archivo;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.entities.Departamento;
import com.c3rberuss.crediapp.entities.Frecuencia;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.Municipio;
import com.c3rberuss.crediapp.entities.Parentezco;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.PlanRequisito2;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.entities.Referencia;
import com.c3rberuss.crediapp.entities.Requisito;
import com.c3rberuss.crediapp.entities.SolicitudCredito;
import com.c3rberuss.crediapp.entities.SolicitudDetalle;
import com.c3rberuss.crediapp.providers.ApiProvider;
import com.c3rberuss.crediapp.providers.WebService;

import java.io.IOException;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class insertAsyncTask extends AsyncTask<Void, Void, Void> {

    //private CategoriaDao categoriaDao;
    //private PlatilloDao platilloDao;

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
    private UsuarioDao usuarioDao;
    private PermisoDao permisoDao;
    private CobroProcesadoDao cobroProcesadoDao;
    private AbonoDao abonoDao;
    private AppDatabase db;
    private Dialog dialog;

    public insertAsyncTask(AppDatabase db, Dialog dialog){
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

        final WebService ws = ApiProvider.getWebService();
        cobroProcesadoDao.deleteAllAnteriores();



        try {
            Response<List<Prestamo>> response = ws.obtener_prestamos().execute();
            if(response.isSuccessful() && response.code() == 200){

                prestamoDao.delete();
                prestamoDetalleDao.delete();

                for (Prestamo myPrestamo: response.body()){
                    prestamoDao.insert(myPrestamo);
                    if(myPrestamo.getPrestamodetalle() != null) {
                        for (PrestamoDetalle pd: myPrestamo.getPrestamodetalle()){
                            prestamoDetalleDao.insert(pd);
                        }
                    }
                }

                //borrar cobros realizados huerfanos
                for(CobroProcesado cp: db.getCobrosProcesados().getAll()){
                    if(db.prestamoDao().getById(cp.getId_prestamo()) == 0){
                        db.getCobrosProcesados().delete(cp);
                    }
                }

            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            Response<List<CobroProcesado>> response = ws.obtener_cobros_realizados(usuarioDao.getId()).execute();

            if(response.isSuccessful() && response.code() == 200){
                cobroProcesadoDao.deleteAllSync();
                abonoDao.deleteAllSync();

                //cobroProcesadoDao.insert(response.body());

                for (CobroProcesado cp: response.body()){

                    cobroProcesadoDao.insert(cp);

                    if(cp.isAbono()){
                        final Abono tmp = new Abono();
                        tmp.setId_prestamo(cp.getId_prestamo());
                        tmp.setHora(cp.getHora());
                        tmp.setFecha(cp.getFecha());
                        tmp.setUsuario_abono(cp.getId_usuario());
                        tmp.setValor(cp.getMonto());
                        tmp.setSincronizado(true);
                        tmp.setCaja(0);
                        tmp.setId_detalle(cp.getId_detalle());

                        abonoDao.insert(tmp);
                    }
                }


                System.out.println("SI SE DESCARGARON LOS COBROS");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }


        try {
            Response<List<Mora>> response = ws.get_mora().execute();

            if(response.isSuccessful() && response.code() == 200){
                prestamoDao.deleteAllMora();

                for (Mora mora: response.body()){
                    //prestamoDao.insertMoras(response.body());
                    prestamoDao.insertMora(mora);
                }

                System.out.println("SE OBTUVIERON MORAS");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            Response<List<Frecuencia>> response =  ws.get_frecuencias().execute();


            if(response.isSuccessful() && response.code() == 200){
                frecuenciaDao.deleteAll();
                //frecuenciaDao.insert(response.body());
                for (Frecuencia frecuencia: response.body()){
                    frecuenciaDao.insert(frecuencia);
                }

                System.out.println("SE OBTUVIERON FRECUENCIAS");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            Response<List<Parentezco>> response = ws.get_parentezco().execute();
            if(response.isSuccessful() && response.code() == 200){
                parentezcoDao.deleteAll();
                //parentezcoDao.insert(response.body());

                for (Parentezco parentezco: response.body()){
                    parentezcoDao.insert(parentezco);
                }

                System.out.println("SE OBTUVIERON PARENTEZCOS");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            Response<List<Departamento>> response =  ws.get_departamentos().execute();
            if(response.isSuccessful() && response.code() == 200){
                departamentoDao.deleteAll();
                //departamentoDao.insert(response.body());

                municipioDao.deleteAll();
                for(Departamento d: response.body()){
                    departamentoDao.insert(d);
                    for (Municipio m: d.getMunicipios()){
                        municipioDao.insert(m);
                    }
                    //municipioDao.insert(d.getMunicipios());
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            Response<List<Plan>> response = ws.get_planes().execute();
            if(response.isSuccessful() && response.code() == 200){

                planDao.deleteAll();
                //planDao.insert(response.body());
                planRequisito2.deleteAll();


                for (Plan plan: response.body()){
                    planDao.insert(plan);
                    for (PlanRequisito2 pr: plan.getPlanes_requisitos()){
                        planRequisito2.insert(pr);
                    }
                    //planRequisito2.insert(plan.getPlanes_requisitos());
                }

                Log.e("DESCARGA", "TRUE");
            }else{
                Log.e("DESCARGA", "FALSE");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }


        try {
            Response<List<Cliente>> response =  ws.get_clientes().execute();

            if(response.isSuccessful() && response.code() == 200){
                clienteDao.deleteAllSincronizados();
                //clienteDao.insert(response.body());

                clienteDao.deleteArchivosSincronizados();
                clienteDao.deleteReferenciasSincronizadas();

                for(Cliente cliente: response.body()){

                    clienteDao.insert(cliente);

                    for (Archivo archivo: cliente.getArchivos()){
                        clienteDao.insertArchivo(archivo);
                    }

                    for (Referencia referencia: cliente.getReferencias()){
                        clienteDao.insertReferencia(referencia);
                    }

                    /*clienteDao.insertArchivos(cliente.getArchivos());
                    clienteDao.insertReferencias(cliente.getReferencias());*/
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }


        try {
            Response<List<SolicitudCredito>> response = ws.obtener_solicitudes().execute();

            if(response.isSuccessful() && response.code() == 200){

                solicitudDao.deleteAllSincronizados();
                //solicitudDao.insert(response.body());

                solicitudDetalleDao.deleteAllSincronizados();
                //garantiaDao.deleteAllSincronizados();
                //fiadorDao.deleteAllSincronizados();

                for(SolicitudCredito s: response.body()){
                    solicitudDao.insert(s);
                    for (SolicitudDetalle sd: s.getDetalles()){
                        solicitudDetalleDao.insert(sd);
                    }
                    //solicitudDetalleDao.insert(s.getDetalles());
                            /*garantiaDao.insert(s.getGarantias());
                            fiadorDao.insert(s.getFiador());*/
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }


        try {
            Response<List<Requisito>> response = ws.obtener_requisitos().execute();

            if(response.isSuccessful() && response.code()==200){

                requisitoDao.deleteAll();
                //requisitoDao.insert(response.body());

                for (Requisito requisito: response.body()){
                    requisitoDao.insert(requisito);
                }

            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        super.onPostExecute(aVoid);
        EasySharedPreference.Companion.putString("last_update", Functions.getHora());
        dialog.dismiss();
    }
}
