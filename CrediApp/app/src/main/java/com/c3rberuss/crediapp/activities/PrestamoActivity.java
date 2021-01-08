package com.c3rberuss.crediapp.activities;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.MainActivity;
import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.PrestamoAdapter;

import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class PrestamoActivity extends AppCompatActivity {
    RecyclerView recycler;
    PrestamoAdapter adapter;
    List<Prestamo> clientes = new ArrayList<>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_prestamos);

        setTitle("Préstamos");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);

/*        MainActivity.ws.obtener_prestamos().enqueue(new Callback<List<Prestamo>>() {
            @Override
            public void onResponse(Call<List<Prestamo>> call, Response<List<Prestamo>> response) {
                if(response.code() == 200){
                    clientes.clear();
                    clientes.addAll(response.body());
                    List<Prestamo> myPrestamoList= response.body();
                    saveTask(myPrestamoList);
                }
            }
            @Override
            public void onFailure(Call<List<Prestamo>> call, Throwable t) {

            }
        });*/
    }
    private void saveTask(List<Prestamo> myPrestamoList) {
        class SaveTask extends AsyncTask<Void, Void, Void> {
            @Override
            protected Void doInBackground(Void... voids) {
                for (int i=0; i<myPrestamoList.size(); i++){
                    Prestamo myPrestamo = myPrestamoList.get(i);
                    String nombre = myPrestamo.getNombre();
                    double monto= myPrestamo.getMonto();
                    int id_prestamo=myPrestamo.getId_prestamo();
                    List<PrestamoDetalle> miPrestamoDetList = myPrestamo.getPrestamodetalle();
                   if(!AppDatabase.getInstance(getApplicationContext()).prestamoDao().getExisteIdPrestamo(id_prestamo)){
                        AppDatabase.getInstance(getApplicationContext()).prestamoDao().insertPrestamo(myPrestamo);
                       for (int j=0; j<miPrestamoDetList.size(); j++) {
                           PrestamoDetalle miPrestamoDetalle = miPrestamoDetList.get(j);
                           int id_detalle=miPrestamoDetalle.getId_detalle();
                           AppDatabase.getInstance(getApplicationContext()).prestamoDetalleDao().insertPrestamo((PrestamoDetalle) miPrestamoDetalle);
                       }
                   }
                }
                return null;
            }

            @Override
            protected void onPostExecute(Void aVoid) {
                super.onPostExecute(aVoid);

                finish();
                startActivity(new Intent(getApplicationContext(), MainActivity.class));

                Toast.makeText(getApplicationContext(), "Prestamos Descargados", Toast.LENGTH_LONG).show();
            }
        }
        SaveTask st = new SaveTask();
        st.execute();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }
}
