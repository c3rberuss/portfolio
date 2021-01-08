package com.c3rberuss.crediapp.activities;

import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.widget.FrameLayout;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.fragments.CobrosHoyFragment;
import com.c3rberuss.crediapp.fragments.EnMoraFragment;
import com.c3rberuss.crediapp.fragments.TodosFragment;
import com.c3rberuss.crediapp.providers.ApiProvider;
import com.google.android.material.tabs.TabLayout;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

import butterknife.BindView;
import butterknife.ButterKnife;
import retrofit2.Call;
import retrofit2.Response;

public class PrestamosActivity extends AppCompatActivity {


    @BindView(R.id.tabs)
    TabLayout tabs;
    private static FragmentManager manager;
    @BindView(R.id.main_content)
    FrameLayout mainContent;

    private EnMoraFragment enMoraFragment;
    private CobrosHoyFragment cobrosHoyFragment;
    private TodosFragment todosFragment;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_prestamos2);
        ButterKnife.bind(this);

        setTitle("Prestamos - Cobros");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);

        //new GetPrestamos().execute();

        enMoraFragment = new EnMoraFragment();
        cobrosHoyFragment = new CobrosHoyFragment();
        todosFragment = new TodosFragment();

        manager = getSupportFragmentManager();

        tabs.getTabAt(1).select();
        setFragment(cobrosHoyFragment);

        tabs.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                switch (tab.getPosition()) {
                    case 0:
                        setFragment(new EnMoraFragment());
                        break;
                    case 1:
                        setFragment(new CobrosHoyFragment());
                        break;
                    case 2:
                        setFragment(new TodosFragment());
                        break;
                }
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });
    }

    public static void setFragment(Fragment fragment) {
        final FragmentTransaction fragmentTransaction = manager.beginTransaction();
        fragmentTransaction.replace(R.id.main_content, fragment);
        fragmentTransaction.commit();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }

    class GetPrestamos extends AsyncTask<Void, Void, Void> {

        final AppDatabase db = AppDatabase.getInstance(PrestamosActivity.this);

        @Override
        protected Void doInBackground(Void... voids) {


            final Call<List<Prestamo>> obtener_prestamos =  ApiProvider.getWebService().obtener_prestamos();
            try {

                final Response<List<Prestamo>> response = obtener_prestamos.execute();

                if(response.isSuccessful() && obtener_prestamos.isExecuted() && response.code() == 200 ){

                    db.prestamoDao().delete();
                    db.prestamoDao().insert(response.body());
                    db.prestamoDetalleDao().delete();

                    for (Prestamo myPrestamo : response.body()) {
                        if (myPrestamo.getPrestamodetalle() != null) {
                            db.prestamoDetalleDao().insert(myPrestamo.getPrestamodetalle());
                        }
                    }

                    Log.e("DESCARGA", "TRUE");

                }else{
                    Log.e("DESCARGA", "FALSE");
                }
            } catch (IOException e) {
                e.printStackTrace();
                Log.e("DESCARGA", e.getMessage());
            }
            return null;
        }
    }

}
