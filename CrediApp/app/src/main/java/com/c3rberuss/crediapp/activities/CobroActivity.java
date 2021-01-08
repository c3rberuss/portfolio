package com.c3rberuss.crediapp.activities;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.SearchView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.MainActivity;
import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.CobroAdapter;
import com.c3rberuss.crediapp.entities.Cobro;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class CobroActivity extends AppCompatActivity {

    RecyclerView recycler;
    CobroAdapter adapter;
    List<Cobro> clientes = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_clientes);

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);


        recycler = findViewById(R.id.lista_clientes);
        adapter = new CobroAdapter(clientes);

        recycler.setAdapter(adapter);


        MainActivity.ws.obtener_cobros().enqueue(new Callback<List<Cobro>>() {
            @Override
            public void onResponse(Call<List<Cobro>> call, Response<List<Cobro>> response) {
                if(response.code() == 200){
                    clientes.clear();
                    clientes.addAll(response.body());
                    adapter = new CobroAdapter(response.body());
                    recycler.setAdapter(adapter);
                }
            }

            @Override
            public void onFailure(Call<List<Cobro>> call, Throwable t) {

            }
        });


        findViewById(R.id.btnAgregarCliente).setOnClickListener(v->{

            Intent intent = new Intent(this, AgregarCliente.class);
            startActivity(intent);

        });

        SearchView searchView = (SearchView) findViewById(R.id.busqueda_cliente);

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
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }
}
