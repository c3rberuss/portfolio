package com.c3rberuss.restaurantapp.db;

import android.content.Context;
import android.os.AsyncTask;

import androidx.annotation.NonNull;
import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.sqlite.db.SupportSQLiteDatabase;

import com.c3rberuss.restaurantapp.MainActivity;
import com.c3rberuss.restaurantapp.db.dao.CategoriaPlatillosDao;
import com.c3rberuss.restaurantapp.db.dao.DetallePlatilloDao;
import com.c3rberuss.restaurantapp.db.dao.DireccionDao;
import com.c3rberuss.restaurantapp.db.dao.FavoritosDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDetalleDao;
import com.c3rberuss.restaurantapp.db.dao.PlatilloDao;
import com.c3rberuss.restaurantapp.db.dao.UsuarioDao;
import com.c3rberuss.restaurantapp.entities.Categoria;
import com.c3rberuss.restaurantapp.entities.Direccion;
import com.c3rberuss.restaurantapp.entities.Pedido;
import com.c3rberuss.restaurantapp.entities.PedidoDetalle;
import com.c3rberuss.restaurantapp.entities.Platillo;
import com.c3rberuss.restaurantapp.db.dao.CategoriaDao;
import com.c3rberuss.restaurantapp.entities.PlatilloFavorito;
import com.c3rberuss.restaurantapp.entities.Usuario;

import java.util.List;

import retrofit2.Call;
import retrofit2.Response;

@Database(entities = {
        Platillo.class, Categoria.class, Pedido.class,
        PedidoDetalle.class, Usuario.class, PlatilloFavorito.class, Direccion.class
}, version = 1)
public abstract class AppDatabase extends RoomDatabase {

    private static final String DB_NAME = "restaurant_db";
    private static AppDatabase instance;

    public static synchronized AppDatabase getInstance(Context context){
        if(instance == null){
            instance = Room.databaseBuilder(context.getApplicationContext(), AppDatabase.class, DB_NAME)
                    .fallbackToDestructiveMigration()
                    .allowMainThreadQueries()
                    .addCallback(sRoomDatabaseCallback)
                    .build();
        }

        return instance;
    }

    //DAOS
    public abstract CategoriaDao getCategoriaDao();
    public abstract PlatilloDao getPlatilloDao();
    public abstract PedidoDao getPedidoDao();
    public abstract PedidoDetalleDao getPedidoDetalleDao();
    public abstract UsuarioDao getUsuarioDao();
    public abstract CategoriaPlatillosDao getCategoriaPlatillosDao();
    public abstract FavoritosDao getPlatilloFavorito();
    public abstract DetallePlatilloDao getDetallePlatilloDao();
    public abstract DireccionDao getDireccionDAo();

    private static RoomDatabase.Callback sRoomDatabaseCallback = new RoomDatabase.Callback() {

        @Override
        public void onOpen(@NonNull SupportSQLiteDatabase db) {
            super.onOpen(db);
            insertCategoriasPlatillos();
        }
    };


    private static void insertCategoriasPlatillos(){
        MainActivity.ws.get_categorias().enqueue(new retrofit2.Callback<List<Categoria>>() {
            @Override
            public void onResponse(Call<List<Categoria>> call, Response<List<Categoria>> response) {

                if(response.code() == 200){
                    System.out.println("PETICION REALIZADA");
                    new insertAsyncTask(instance).execute(response.body());
                }else{
                    System.out.println("ERROR PETICION");
                }

            }

            @Override
            public void onFailure(Call<List<Categoria>> call, Throwable t) {
                System.out.println("ERROR: "+t.getMessage());
            }
        });
    }


    private static class insertAsyncTask extends AsyncTask<List<Categoria>, Void, Void>{

        private CategoriaDao categoriaDao;
        private PlatilloDao platilloDao;

        insertAsyncTask(AppDatabase db){
            categoriaDao = db.getCategoriaDao();
            platilloDao = db.getPlatilloDao();
        }

        @SafeVarargs
        @Override
        protected final Void doInBackground(List<Categoria>... lists) {


            categoriaDao.deleteAll();
            categoriaDao.insert(lists[0]);

            //System.out.println("CATEGORIAS N: "+String.valueOf(categoriaDao.getAll().size()));

            platilloDao.deleteAll();

            for(Categoria c: lists[0]){
                if(c.getProductos() != null && c.getProductos().size() > 0){
                    platilloDao.insert(c.getProductos());
                }
            }

            return null;
        }
    }
}
