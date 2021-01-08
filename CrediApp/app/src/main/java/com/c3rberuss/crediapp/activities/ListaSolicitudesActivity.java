package com.c3rberuss.crediapp.activities;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.SolicitudAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.SolicitudDao;
import com.c3rberuss.crediapp.database.dao.SolicitudDetalleDao;
import com.c3rberuss.crediapp.entities.SolicitudCredito;
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

public class ListaSolicitudesActivity extends AppCompatActivity {

    @BindView(R.id.busqueda_solicitud)
    SearchView busquedaSolicitud;
    @BindView(R.id.lista_solicitudes)
    RecyclerView listaSolicitudes;
    @BindView(R.id.btnAgregarSolicitud)
    FloatingActionButton btnAgregarSolicitud;
    @BindView(R.id.texto)
    TextView texto;
    @BindView(R.id.swipe_refresh)
    SwipeRefreshLayout swipeRefresh;

    private List<SolicitudCredito> solicitudCreditos = new ArrayList<>();
    private SolicitudAdapter adapter;
    private int id_usuario;
    private SolicitudDetalleDao solicitudDetalleDao;
    private SolicitudDao solicitudDao;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lista_solicitudes);
        ButterKnife.bind(this);

        setTitle("Solicitudes de crédito");

        solicitudDao = AppDatabase.getInstance(this).getSolicitudDao();
        solicitudDetalleDao = AppDatabase.getInstance(this).getSolicitudDetalleDao();

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);

        id_usuario = AppDatabase.getInstance(this).getUsuarioDao().getId();

        adapter = new SolicitudAdapter(this, solicitudCreditos);
        listaSolicitudes.setAdapter(adapter);


        AppDatabase.getInstance(this).getSolicitudDao().getAll(id_usuario).observe(this, solicitudCreditos1 -> {

            if (solicitudCreditos1.size() > 0) {
                busquedaSolicitud.setVisibility(View.VISIBLE);
                listaSolicitudes.setVisibility(View.VISIBLE);
                texto.setVisibility(View.GONE);
            } else {
                busquedaSolicitud.setVisibility(View.GONE);
                listaSolicitudes.setVisibility(View.GONE);
                texto.setVisibility(View.VISIBLE);
            }

            adapter.swapData(solicitudCreditos1);
        });

        int id = busquedaSolicitud.getContext()
                .getResources()
                .getIdentifier("android:id/search_src_text", null, null);
        TextView textView = (TextView) busquedaSolicitud.findViewById(id);

        textView.setTextColor(getResources().getColor(R.color.colorPrimary));

        busquedaSolicitud.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
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

        btnAgregarSolicitud.setVisibility(Permisos.tiene("agregar_solicitud", this));

        swipeRefresh.setOnRefreshListener(() -> {

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
                    }else{
                        solicitudDao.deleteAllSincronizados();
                        solicitudDetalleDao.deleteAllSincronizados();
                    }

                    swipeRefresh.setRefreshing(false);

                }

                @Override
                public void onFailure(Call<List<SolicitudCredito>> call, Throwable t) {
                    swipeRefresh.setRefreshing(false);
                    Toast.makeText(ListaSolicitudesActivity.this, "No es posible actualizar en este momento", Toast.LENGTH_LONG).show();
                }
            });

        });

    }

    @OnClick(R.id.btnAgregarSolicitud)
    public void onViewClicked() {

        Intent intent = new Intent(this, SolicitudCreditoActivity.class);
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
