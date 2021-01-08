package com.c3rberuss.crediapp.activities;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.view.MenuItem;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.CuotasAdapter;

import java.util.List;
import java.util.Objects;

public class ListaCuotasActivity extends AppCompatActivity {

    private RecyclerView recyclerView;
    private CuotasAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lista_cuotas);

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);


        getSupportActionBar().setTitle("Estructuración de Cuotas");
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        List<String> cuotas = (List<String>) getIntent().getSerializableExtra("cuotas");
        double cuota = getIntent().getExtras().getDouble("cuota");

        recyclerView = findViewById(R.id.lista_cuotas);
        adapter =  new CuotasAdapter(cuotas, this, cuota,
                getIntent().getExtras().getBoolean("solointeres", false),
                getIntent().getExtras().getDouble("monto", 0.0));

        recyclerView.setAdapter(adapter);

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if(item.getItemId() == android.R.id.home){
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }


}
