package com.c3rberuss.restaurantapp;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProviders;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.amn.easysharedpreferences.EasySharedPreferenceConfig;
import com.c3rberuss.restaurantapp.activities.AppIntroActivity;
import com.c3rberuss.restaurantapp.activities.DetallePedidoActivity;
import com.c3rberuss.restaurantapp.activities.ListaPlatillosActivity;
import com.c3rberuss.restaurantapp.activities.LoginActivity;
import com.c3rberuss.restaurantapp.activities.PerfilActivity;
import com.c3rberuss.restaurantapp.adapters.CategoriasAdapter;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.db.dao.CategoriaPlatillosDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDetalleDao;
import com.c3rberuss.restaurantapp.db.dao.PlatilloDao;
import com.c3rberuss.restaurantapp.db.dao.CategoriaDao;
import com.c3rberuss.restaurantapp.entities.CategoriaPlatillos;
import com.c3rberuss.restaurantapp.providers.WebService;
import com.c3rberuss.restaurantapp.utils.Functions;
import com.c3rberuss.restaurantapp.viewmodels.CategoriasViewModel;
import com.google.gson.GsonBuilder;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {

    public static WebService ws;
    private Retrofit retrofit;
    public static AppDatabase database;
    private static TextView txtViewCount;
    private static int count = 0;
    private List<CategoriaPlatillos> categorias_ = new ArrayList<>();
    private RecyclerView lista_categorias;
    private CategoriasAdapter adapter;
    private CategoriasViewModel model;
    private static PedidoDao pedidoDao;
    private static PedidoDetalleDao pedidoDetalleDao;

    private View.OnClickListener onClickListener = v->{

        int pos = lista_categorias.getChildAdapterPosition(v);

        final CategoriaPlatillos tmp = adapter.getCategorias().get(pos);

        if(tmp.getPlatillos() != null && tmp.getPlatillos().size() > 0){
            Intent intent = new Intent(MainActivity.this, ListaPlatillosActivity.class);
            Bundle bundle = new Bundle();

            bundle.putInt("id_categoria", tmp.getCategoria().getId());
            intent.putExtras(bundle);

            startActivity(intent);
        }

    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EasySharedPreferenceConfig.Companion
                .initDefault(new EasySharedPreferenceConfig.Builder()
                        .inputFileName("credimaster_preferences").inputMode(Context.MODE_PRIVATE).build());

        this.retrofit = new Retrofit.Builder().baseUrl(WebService.SERVER_URL)
                .addConverterFactory(GsonConverterFactory.create(new GsonBuilder().serializeNulls().create()))
                .build();

        ws = retrofit.create(WebService.class);

        database = AppDatabase.getInstance(this);

        CategoriaDao categoria_db = database.getCategoriaDao();
        final PlatilloDao platillo_db = database.getPlatilloDao();
        final CategoriaPlatillosDao categoriaPlatillosDao = database.getCategoriaPlatillosDao();

        pedidoDao = database.getPedidoDao();
        pedidoDetalleDao = database.getPedidoDetalleDao();

        lista_categorias = findViewById(R.id.lista_categorias);
        adapter = new CategoriasAdapter(categorias_, this);
        lista_categorias.setAdapter(adapter);
        adapter.setOnClickListener(onClickListener);


        model = ViewModelProviders.of(this).get(CategoriasViewModel.class);

        model.getAllCategories().observe(this, categorias -> {
            if(categorias != null &&categorias.size() > 0){
                adapter.swapData(categorias);
            }
        });

        if(pedidoDao.obtenerPedidoActivo() != null){
            //contador
            count = pedidoDetalleDao.getCount(pedidoDao.obtenerPedidoActivo().getId());
        }


        if(EasySharedPreference.Companion.getBoolean("init", true)){
            final Intent intent = new Intent(this, AppIntroActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
            startActivity(intent);
            this.finish();
        }else{
            if(!Functions.sesionIniciada()){
                final Intent intent = new Intent(this, LoginActivity.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
                startActivity(intent);
                this.finish();
            }
        }

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);

        final View notificaitons = menu.findItem(R.id.actionNotifications).getActionView();

        txtViewCount = (TextView) notificaitons.findViewById(R.id.txtCount);
        updateHotCount(false);

        notificaitons.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, DetallePedidoActivity.class);
            intent.putExtra("vacio", count <= 0);
            startActivity(intent);
        });

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()){
            case R.id.usuario:
                final Intent perfil = new Intent(this, PerfilActivity.class);
                startActivityForResult(perfil, 777);
                break;
        }

        return true;

    }

    public static void updateHotCount(boolean increment){

        if(increment){
            count++;
        }else{
            if(pedidoDao.obtenerPedidoActivo() != null){
                count = pedidoDetalleDao.getCount(pedidoDao.obtenerPedidoActivo().getId());
            }else{
                count = 0;
            }
        }

        txtViewCount.setText(String.valueOf(count));
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(requestCode == 777 && resultCode == RESULT_OK){
            final Intent intent = new Intent(this, LoginActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
            startActivity(intent);
            this.finish();
        }
    }
}
