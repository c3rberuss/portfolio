package com.c3rberuss.restaurantapp.fragments;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.restaurantapp.App;
import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.activities.LocationPicker;
import com.c3rberuss.restaurantapp.adapters.DireccionesAdapter;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.entities.Direccion;
import com.c3rberuss.restaurantapp.entities.Usuario;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.textfield.TextInputEditText;
import com.mapbox.api.geocoding.v5.models.CarmenFeature;
import com.mapbox.geojson.Point;
import com.mapbox.mapboxsdk.Mapbox;
import com.mapbox.mapboxsdk.camera.CameraPosition;
import com.mapbox.mapboxsdk.geometry.LatLng;
import com.mapbox.mapboxsdk.plugins.places.picker.PlacePicker;
import com.mapbox.mapboxsdk.plugins.places.picker.model.PlacePickerOptions;

import org.ankit.gpslibrary.ADLocation;
import org.ankit.gpslibrary.MyTracker;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import in.galaxyofandroid.spinerdialog.SpinnerDialog;
import timber.log.Timber;

import static android.app.Activity.RESULT_CANCELED;
import static android.app.Activity.RESULT_OK;

public class DireccionesFrgament extends Fragment implements MyTracker.ADLocationListener{

    @BindView(R.id.lista_direcciones)
    RecyclerView listaDirecciones;
    @BindView(R.id.agregarDireccion)
    FloatingActionButton agregarDireccion;
    @BindView(R.id.btnUsarDireccion)
    Button btnUsarDireccion;
    @BindView(R.id.btnCambiar)
    Button btnCambiar;
    @BindView(R.id.txtDirDefecto)
    TextInputEditText defecto;
    ADLocation location;
    Activity activity;
    Intent intent;
    DireccionesAdapter adapter;
    private SpinnerDialog spinDirecciones;
    private ArrayList<String> Dirs = new ArrayList<>();
    List<Direccion> direccions_ = new ArrayList<>();
    Direccion dir_;


    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.direcciones_fragment_layout, container, false);
        ButterKnife.bind(this, view);
        MyTracker tracker = new MyTracker(activity,this);
        tracker.track();

        adapter = new DireccionesAdapter(direccions_, activity);

        defecto.setKeyListener(null);

        listaDirecciones.setAdapter(adapter);

        final Usuario usuario = AppDatabase.getInstance(activity).getUsuarioDao().getUsuarioActivo();

        AppDatabase.getInstance(activity).getDireccionDAo().getDirecciones(usuario.getId()).observe(this, direccions -> {

            direccions_.clear();
            direccions_.addAll(direccions);

            adapter.swapData(direccions);

            for(Direccion d: direccions){
                Dirs.add(d.getDireccion());
            }

            spinDirecciones = new SpinnerDialog(activity, this.Dirs, "Seleccionar dirección", "Cancelar");

            spinDirecciones.bindOnSpinerListener((item, position) -> {

                dir_ = direccions_.get(position);
                defecto.setText(dir_.getDireccion());
                AppDatabase.getInstance(activity).getDireccionDAo().updateNotDefaultAll();
                AppDatabase.getInstance(activity).getDireccionDAo().updateDefault(dir_.getId());

            });

        });

        return view;
    }

    @OnClick(R.id.agregarDireccion)
    public void onAgregarDireccionClicked() {

        intent = new PlacePicker.IntentBuilder()
                .accessToken(Mapbox.getAccessToken())
                .placeOptions(
                        PlacePickerOptions.builder()
                                .language("es-ES")
                                .statingCameraPosition(
                                        new CameraPosition.Builder()
                                                .target(new LatLng(13.475637, -88.184389))
                                                .zoom(16)
                                                .build())
                                .build())
                .build(activity);

        startActivityForResult(intent, 9999);

    }

    @OnClick(R.id.btnUsarDireccion)
    public void onBtnUsarDireccionClicked() {

        Intent intent = new Intent(activity, LocationPicker.class);
        startActivity(intent);

    }

    @OnClick(R.id.btnCambiar)
    public void onBtnCambiar(){
        spinDirecciones.showSpinerDialog();
    }

    @Override
    public void whereIAM(ADLocation adLocation) {
        location = adLocation;

        Log.e("GEO", String.valueOf(adLocation));
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        activity = (Activity)context;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_CANCELED) {

        } else if (requestCode == 9999 && resultCode == RESULT_OK) {
            CarmenFeature carmenFeature = PlacePicker.getPlace(data);

            if (carmenFeature != null) {
                Log.e("POS", String.format("%s", carmenFeature.address()));
                Log.e("POS", String.format("%s", carmenFeature.placeName()));


                final LatLng latLng =  new LatLng(((Point) carmenFeature.geometry()).latitude(),
                        ((Point) carmenFeature.geometry()).longitude());

                Log.e("LAT", String.valueOf( latLng ));

                final Direccion dir = new Direccion();
                dir.setDefecto(false);
                dir.setDireccion(carmenFeature.placeName());
                dir.setLati(latLng.getLatitude());
                dir.setLongi(latLng.getLongitude());
                dir.setId_usuario(AppDatabase.getInstance(activity).getUsuarioDao().getUsuarioActivo().getId());

                System.out.println(adapter.direccions.size());
                adapter.insertDir(dir);
                System.out.println(adapter.direccions.size());

                AppDatabase.getInstance(activity).getDireccionDAo().insert(dir);
            }
        }
    }
}
