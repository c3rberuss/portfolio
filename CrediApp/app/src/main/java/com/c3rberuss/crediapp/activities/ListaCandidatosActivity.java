package com.c3rberuss.crediapp.activities;

import android.os.Bundle;
import android.view.MenuItem;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.CandidatosAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.SolicitudDao;
import com.c3rberuss.crediapp.database.dao.SolicitudDetalleDao;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.SolicitudCredito;
import com.c3rberuss.crediapp.providers.ApiProvider;
import com.c3rberuss.crediapp.utils.Functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import butterknife.BindView;
import butterknife.ButterKnife;
import retrofit2.Call;
import retrofit2.Response;

public class ListaCandidatosActivity extends AppCompatActivity {

    @BindView(R.id.busqueda_cliente)
    SearchView busquedaCliente;
    @BindView(R.id.lista_clientes)
    RecyclerView listaCandidatos;
    @BindView(R.id.pull_to_refresh)
    SwipeRefreshLayout pullToRefresh;

    private CandidatosAdapter adapter;
    private List<Prestamo> prestamos = new ArrayList<>();
    private SolicitudDao solicitudDao;
    private SolicitudDetalleDao solicitudDetalleDao;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_prestamos);
        ButterKnife.bind(this);

        setTitle("Clientes aptos para refinanciamiento");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);

        Functions.permisosApp(this);

        adapter = new CandidatosAdapter(this, prestamos);
        listaCandidatos.setAdapter(adapter);

        solicitudDao = AppDatabase.getInstance(this).getSolicitudDao();
        solicitudDetalleDao = AppDatabase.getInstance(this).getSolicitudDetalleDao();


        AppDatabase.getInstance(this).prestamoDao().getCandidatosRefinanciamiento().observe(this, candidatos -> {
            adapter.swapData(candidatos);
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

            ApiProvider.getWebService().obtener_solicitudes().enqueue(new retrofit2.Callback<List<SolicitudCredito>>() {
                @Override
                public void onResponse(Call<List<SolicitudCredito>> call, Response<List<SolicitudCredito>> response) {

                    if(response.code() == 200){

                        solicitudDao.deleteAllSincronizados();
                        solicitudDao.insert(response.body());

                        solicitudDetalleDao.deleteAllSincronizados();
                        //garantiaDao.deleteAllSincronizados();
                        //fiadorDao.deleteAllSincronizados();

                        for(SolicitudCredito s: response.body()){
                            solicitudDetalleDao.insert(s.getDetalles());
                            /*garantiaDao.insert(s.getGarantias());
                            fiadorDao.insert(s.getFiador());*/
                        }
                    }

                    pullToRefresh.setRefreshing(false);

                }

                @Override
                public void onFailure(Call<List<SolicitudCredito>> call, Throwable t) {
                    Toast.makeText(ListaCandidatosActivity.this, "No es posible actualizar en este momento.", Toast.LENGTH_LONG).show();
                    pullToRefresh.setRefreshing(false);
                }
            });


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
