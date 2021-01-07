package com.c3rberuss.restaurantapp.repository;

import android.app.Application;
import android.os.AsyncTask;

import androidx.lifecycle.LiveData;

import com.c3rberuss.restaurantapp.MainActivity;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.db.dao.CategoriaDao;
import com.c3rberuss.restaurantapp.db.dao.CategoriaPlatillosDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDetalleDao;
import com.c3rberuss.restaurantapp.db.dao.PlatilloDao;
import com.c3rberuss.restaurantapp.db.dao.UsuarioDao;
import com.c3rberuss.restaurantapp.entities.Categoria;
import com.c3rberuss.restaurantapp.entities.CategoriaPlatillos;
import com.c3rberuss.restaurantapp.entities.Platillo;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class AppRepository {

    private CategoriaDao categoriaDao;
    private PlatilloDao platilloDao;
    private PedidoDao pedidoDao;
    private PedidoDetalleDao pedidoDetalleDao;
    private UsuarioDao usuarioDao;
    private CategoriaPlatillosDao categoriaPlatillosDao;

    private LiveData<List<Categoria>> allCategories;

    public AppRepository(Application application) {

        AppDatabase db = AppDatabase.getInstance(application);
        categoriaDao = db.getCategoriaDao();
        platilloDao = db.getPlatilloDao();
        pedidoDao = db.getPedidoDao();
        pedidoDetalleDao = db.getPedidoDetalleDao();
        usuarioDao = db.getUsuarioDao();
        categoriaPlatillosDao = db.getCategoriaPlatillosDao();

        allCategories = categoriaDao.get_all();

    }

    public LiveData<List<Categoria>> getAllCategories() {
        return allCategories;
    }

    public LiveData<List<CategoriaPlatillos>> getAllCategoria(){
        return categoriaPlatillosDao.getAllCategorias();
    }

    public void setAllCategories(LiveData<List<Categoria>> allCategories) {
        this.allCategories = allCategories;
    }


}
