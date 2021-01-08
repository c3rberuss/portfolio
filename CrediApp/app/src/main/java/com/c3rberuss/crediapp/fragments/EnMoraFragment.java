package com.c3rberuss.crediapp.fragments;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.activities.PrestamoDetalleActivity;
import com.c3rberuss.crediapp.adapters.PrestamoAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.PrestamoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDetalleDao;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.providers.ApiProvider;
import com.c3rberuss.crediapp.utils.Functions;
import com.c3rberuss.crediapp.utils.InfiniteScroll;
import com.c3rberuss.crediapp.utils.Permisos;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class EnMoraFragment extends Fragment {


    @BindView(R.id.busqueda_cliente)
    SearchView busquedaCliente;
    @BindView(R.id.lista_clientes)
    RecyclerView listaPrestamos;
    @BindView(R.id.pull_to_refresh)
    SwipeRefreshLayout pullToRefresh;
    PrestamoAdapter adapter;
    List<Prestamo> prestamos = new ArrayList<>();
    Activity activity;
    InfiniteScroll infiniteScroll;

    private final int COBROS = 555;

    View.OnClickListener onClickListener = v -> {

        if (Permisos.tiene_("realizar_cobro", activity)) {
            Prestamo prestamo = adapter.clientes.get(listaPrestamos.getChildAdapterPosition(v));
            String nombrecliente = prestamo.getNombre();
            String cliente_monto = " * Monto:  $" + Functions.round2decimals(prestamo.getFinaal()) + " - Saldo:  $" + Functions.round2decimals(prestamo.getSaldo());
            int id_prestamo = prestamo.getId_prestamo();
            //  Toast.makeText(mCtx, "Prestamo Seleccionado"+nombrecliente, Toast.LENGTH_LONG).show();
            Intent intent = new Intent(activity, PrestamoDetalleActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
            intent.putExtra("id_prestamo", id_prestamo);
            intent.putExtra("nombre", nombrecliente);
            intent.putExtra("cliente_monto", cliente_monto);

            intent.putExtra("monto", Functions.round2decimals(prestamo.getFinaal()));
            intent.putExtra("saldo", Functions.round2decimals(prestamo.getSaldo()));
            intent.putExtra("ultimo_pago", Functions.fechaDMY(prestamo.getProxima_mora()));

            final List<PrestamoDetalle> prestamoDetalles = AppDatabase.getInstance(activity).
                    prestamoDetalleDao()
                    .getByIdPrestamoDetalle(id_prestamo);

            intent.putExtra("cuotas", (Serializable) prestamoDetalles);

            Log.e("SIZE PD", String.valueOf(prestamoDetalles.size()));

            startActivityForResult(intent, COBROS);
        }

    };
    @BindView(R.id.texto2)
    TextView texto2;


    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.activity_prestamos, container, false);
        ButterKnife.bind(this, view);

        adapter = new PrestamoAdapter(activity, prestamos);
        listaPrestamos.setAdapter(adapter);

        final PrestamoDao prestamoDao = AppDatabase.getInstance(activity).prestamoDao();
        final PrestamoDetalleDao prestamoDetalleDao = AppDatabase.getInstance(activity).prestamoDetalleDao();

        //adapter.insertNews(Functions.prestamosEnMoraPage(activity, 1));

        adapter.swapData(Functions.prestamosEnMora(activity));

/*
        infiniteScroll = new InfiniteScroll((LinearLayoutManager) listaPrestamos.getLayoutManager()) {
            @Override
            public void onLoadMore(int page, int totalItemsCount, RecyclerView view) {
                final int curSize = adapter.clientes.size();
                final List<Prestamo> newPres = Functions.prestamosEnMoraPage(activity, page);
                adapter.insertNews(newPres);
                view.post(() -> {
                    // Notify adapter with appropriate notify methods
                    adapter.notifyItemRangeInserted(curSize, newPres.size());
                });
            }
        };
*/

        //listaPrestamos.addOnScrollListener(infiniteScroll);

        adapter.setOnClickListener(onClickListener);

        update();

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

        /*pullToRefresh.setOnRefreshListener(() -> {

            ApiProvider.getWebService().obtener_prestamos().enqueue(new Callback<List<Prestamo>>() {
                @Override
                public void onResponse(Call<List<Prestamo>> call, Response<List<Prestamo>> response) {
                    if (response.code() == 200) {

                        prestamoDao.delete();
                        prestamoDao.insert(response.body());

                        for (Prestamo myPrestamo : response.body()) {
                            prestamoDetalleDao.insert(myPrestamo.getPrestamodetalle());
                        }

                        adapter.swapData(Functions.prestamosEnMora(activity));

                    }

                    pullToRefresh.setRefreshing(false);
                    busquedaCliente.setQuery("", true);
                    busquedaCliente.clearFocus();
                    update();
                }

                @Override
                public void onFailure(Call<List<Prestamo>> call, Throwable t) {

                    Toast.makeText(activity, "No es posible actualizar en este momento.", Toast.LENGTH_LONG).show();
                    pullToRefresh.setRefreshing(false);
                }
            });

        });*/

        return view;
    }

    private void update(){

        if (adapter.clientes.size() > 0) {
            busquedaCliente.setVisibility(View.VISIBLE);
            listaPrestamos.setVisibility(View.VISIBLE);
            texto2.setVisibility(View.GONE);
        } else {
            texto2.setText("No hay cobros disponibles");
            busquedaCliente.setVisibility(View.GONE);
            listaPrestamos.setVisibility(View.GONE);
            texto2.setVisibility(View.VISIBLE);
        }

    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        this.activity = (Activity) context;
    }

    class GetPrestamos extends AsyncTask<Void, Void, Void>{

        @Override
        protected Void doInBackground(Void... voids) {


            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);
            update();
        }
    }
}
