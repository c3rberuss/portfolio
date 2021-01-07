package com.c3rberuss.restaurantapp.activities;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.SearchView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.adapters.FavoritosAdapter;
import com.c3rberuss.restaurantapp.adapters.PlatillosAdapter;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.db.dao.PlatilloDao;
import com.c3rberuss.restaurantapp.entities.Platillo;
import com.c3rberuss.restaurantapp.entities.PlatilloFavorito;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ListaPlatillosActivity extends AppCompatActivity {

    @BindView(R.id.lista_favoritos)
    RecyclerView listaFavoritos;
    @BindView(R.id.favs)
    LinearLayout favs;
    private List<Platillo> productos = new ArrayList<>();
    private List<PlatilloFavorito> favoritos = new ArrayList<>();
    private RecyclerView lista_platillos;
    private PlatillosAdapter adapter;
    private FavoritosAdapter favoritosAdapter;
    private View.OnClickListener onClickListener = v -> {

        final int pos = lista_platillos.getChildAdapterPosition(v);
        final Platillo tmp = adapter.platillos.get(pos);

        Intent intent = new Intent(ListaPlatillosActivity.this, DetallePlatilloActivity.class);
        Bundle bundle = new Bundle();
        bundle.putInt("id_platillo", tmp.getId_platillo());
        bundle.putBoolean("editando", false);

        intent.putExtras(bundle);
        startActivity(intent);

    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lista_platillos);
        ButterKnife.bind(this);

        final int id_categoria = getIntent().getExtras().getInt("id_categoria");
        final PlatilloDao platilloDao = AppDatabase.getInstance(this).getPlatilloDao();

        lista_platillos = findViewById(R.id.lista_platillos);
        adapter = new PlatillosAdapter(productos, this);
        lista_platillos.setAdapter(adapter);

        adapter.setOnClickListener(onClickListener);

        favoritosAdapter = new FavoritosAdapter(favoritos, this, adapter);
        listaFavoritos.setAdapter(favoritosAdapter);

        SearchView searchView = (SearchView) findViewById(R.id.busqueda_platillos);

        int id = searchView.getContext()
                .getResources()
                .getIdentifier("android:id/search_src_text", null, null);
        TextView textView = (TextView) searchView.findViewById(id);

        textView.setTextColor(getResources().getColor(R.color.colorPrimary));

        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String s) {
                return false;
            }

            @Override
            public boolean onQueryTextChange(String s) {
                adapter.getFilter().filter(s);
                return false;
            }
        });

        platilloDao.getAllPlatillos(id_categoria).observe(this, platillos -> {
            adapter.swapData(platillos);
        });

        AppDatabase.getInstance(this).getPlatilloFavorito().getFavoritos(id_categoria).observe(this, platilloFavoritos -> {

            favoritosAdapter.swapData(platilloFavoritos);
            if (platilloFavoritos.size() > 0){
                favs.setVisibility(View.VISIBLE);
            }else{
                favs.setVisibility(View.GONE);
            }

        });

    }

}
