package com.c3rberuss.crediapp.activities;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.ClientesAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.ClienteDao;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.providers.ApiProvider;
import com.c3rberuss.crediapp.utils.Permisos;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import retrofit2.Call;
import retrofit2.Response;

public class ClientesActivity extends AppCompatActivity {

    ClientesAdapter adapter;
    List<Cliente> clientes = new ArrayList<>();
    @BindView(R.id.busqueda_cliente)
    SearchView busquedaCliente;
    @BindView(R.id.lista_clientes)
    RecyclerView recycler;
    @BindView(R.id.pull_to_refresh)
    SwipeRefreshLayout pullToRefresh;
    @BindView(R.id.btnAgregarCliente)
    FloatingActionButton btnAgregarCliente;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_clientes);
        ButterKnife.bind(this);

        setTitle("Clientes");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);


        final ClienteDao clienteDao = AppDatabase.getInstance(this).getClienteDao();

        adapter = new ClientesAdapter(clientes, this);
        recycler.setAdapter(adapter);

        AppDatabase.getInstance(this).getClienteDao().getAll().observe(this, clientes1 -> {

            clientes.clear();
            clientes.addAll(clientes1);
            adapter = new ClientesAdapter(clientes1, ClientesActivity.this);
            recycler.setAdapter(adapter);

        });


        int id = busquedaCliente.getContext()
                .getResources()
                .getIdentifier("android:id/search_src_text", null, null);
        TextView textView = (TextView) busquedaCliente.findViewById(id);

        textView.setTextColor(getResources().getColor(R.color.colorPrimary));

        busquedaCliente.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
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

        pullToRefresh.setOnRefreshListener(() -> {

           ApiProvider.getWebService().get_clientes().enqueue(new retrofit2.Callback<List<Cliente>>() {
                @Override
                public void onResponse(Call<List<Cliente>> call, Response<List<Cliente>> response) {
                    if(response.code() == 200){
                        clienteDao.deleteAllSincronizados();
                        clienteDao.insert(response.body());

                        clienteDao.deleteArchivosSincronizados();
                        clienteDao.deleteReferenciasSincronizadas();

                        for(Cliente cliente: response.body()){
                            clienteDao.insertArchivos(cliente.getArchivos());
                            clienteDao.insertReferencias(cliente.getReferencias());
                        }

                        pullToRefresh.setRefreshing(false);
                    }
                }

                @Override
                public void onFailure(Call<List<Cliente>> call, Throwable t) {
                    Toast.makeText(ClientesActivity.this, "No es posible actualizar en este momento.", Toast.LENGTH_LONG).show();
                    pullToRefresh.setRefreshing(false);
                }
            });

        });

        btnAgregarCliente.setVisibility(Permisos.tiene("agregar_cliente", this));
    }

    @OnClick(R.id.btnAgregarCliente)
    public void onViewClicked() {

        Intent intent = new Intent(this, AgregarCliente.class);
        startActivity(intent);

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }
}
