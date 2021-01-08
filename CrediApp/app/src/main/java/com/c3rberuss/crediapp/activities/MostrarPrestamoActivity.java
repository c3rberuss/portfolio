package com.c3rberuss.crediapp.activities;

import android.os.AsyncTask;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.PrestamoAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.PrestamoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDetalleDao;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.providers.ApiProvider;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import retrofit2.Call;
import retrofit2.Response;

public class MostrarPrestamoActivity extends AppCompatActivity {
    RecyclerView recycler;
    PrestamoAdapter adapter;
    List<Prestamo> clientes = new ArrayList<>();
    SearchView searchView;
    SwipeRefreshLayout pullToRefresh;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_prestamos);

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);


        recycler = findViewById(R.id.lista_clientes);

        pullToRefresh = findViewById(R.id.pull_to_refresh);

        getTasks();
        adapter = new PrestamoAdapter(getApplicationContext(),clientes);
        searchView = (SearchView) findViewById(R.id.busqueda_cliente);
        int id = searchView.getContext()
                .getResources()
                .getIdentifier("android:id/search_src_text", null, null);
        TextView textView = (TextView) searchView.findViewById(id);
        textView.setTextColor(getResources().getColor(R.color.colorPrimary));

        final PrestamoDao prestamoDao = AppDatabase.getInstance(this).prestamoDao();
        final PrestamoDetalleDao prestamoDetalleDao = AppDatabase.getInstance(this).prestamoDetalleDao();

        pullToRefresh.setOnRefreshListener(() -> {

            ApiProvider.getWebService().obtener_prestamos().enqueue(new retrofit2.Callback<List<Prestamo>>() {
                @Override
                public void onResponse(Call<List<Prestamo>> call, Response<List<Prestamo>> response) {
                    if(response.code() == 200){

                        prestamoDao.delete();
                        prestamoDao.insert(response.body());

                        for (Prestamo myPrestamo: response.body()){
                            prestamoDetalleDao.insert(myPrestamo.getPrestamodetalle());
                        }

                    }

                    pullToRefresh.setRefreshing(false);
                }
                @Override
                public void onFailure(Call<List<Prestamo>> call, Throwable t) {

                    Toast.makeText(MostrarPrestamoActivity.this, "No es posible actualizar en este momento.", Toast.LENGTH_LONG).show();
                    pullToRefresh.setRefreshing(false);
                }
            });

        });


    }


    private void getTasks() {
        class GetTasks extends AsyncTask<Void, Void, List<Prestamo>> {

            @Override
            protected List<Prestamo> doInBackground(Void... voids) {
                List<Prestamo> taskList = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDao()
                        .getAllPrestamo();
                return taskList;
            }

            @Override
            protected void onPostExecute(List<Prestamo> clientes) {
                super.onPostExecute(clientes);

                PrestamoAdapter adapter = new PrestamoAdapter(getApplicationContext(),clientes);
              //  adapter = new PrestamoAdapter(clientes);
                recycler.setAdapter(adapter);
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
        }

        GetTasks gt = new GetTasks();
        gt.execute();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }
}
