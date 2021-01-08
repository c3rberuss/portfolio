package com.c3rberuss.crediapp.forms;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.core.content.FileProvider;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.GarantiasAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Departamento;
import com.c3rberuss.crediapp.entities.DepartamentoMunicipio;
import com.c3rberuss.crediapp.entities.Garantia;
import com.c3rberuss.crediapp.entities.Municipio;
import com.c3rberuss.crediapp.utils.Functions;
import com.google.android.material.textfield.TextInputEditText;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import ernestoyaquello.com.verticalstepperform.Step;
import in.galaxyofandroid.spinerdialog.SpinnerDialog;

public class GarantiasStep extends Step<List<Garantia>> {

    private Context context;
    private ImageButton btnAgregarGarantia;
    private List<Garantia> garantias = new ArrayList<>();
    public ImageView foto;
    private TextInputEditText nombre, descripcion;
    private boolean editando_garantia = false;
    public static String pathFoto;
    public static int IMAGE_CAPTURE_GARANTIA = 500;
    public static final int REQUEST_PICK_IMAGE_GAR = 201;
    private GarantiasAdapter adapter = new GarantiasAdapter(0);
    private RecyclerView lista_gar;
    private ArrayList<String> Departamentos = new ArrayList<>();
    private ArrayList<String> Municipios = new ArrayList<>();
    private List<Departamento> departamentosList = new ArrayList<>();
    private List<DepartamentoMunicipio> dep_munis = new ArrayList<>();
    private TextInputEditText departamento;
    private TextInputEditText municipio;
    private TextInputEditText direccion;
    private SpinnerDialog spinDepas, spinMuni;
    int id_departamento = 11;
    int id_municipio = 64;
    int pos_dep = 10;

    private View.OnClickListener onClickListener = v -> {

        editando_garantia = true;
        int position = lista_gar.indexOfChild(v);
        final Garantia tmp = adapter.garantias.get(position);

        agregarGarantiaDialogo(position, tmp.getUrl(), tmp.getDireccion(), tmp.getDescripcion());

    };


    protected GarantiasStep(String title, String subtitle, String nextButtonText, Context context) {
        super(title, subtitle, nextButtonText);
        this.context = context;
    }

    public GarantiasStep(String title, Activity context) {
        super(title);
        this.context = context;
    }

    @Override
    public List<Garantia> getStepData() {
        return this.adapter.garantias;
    }

    @Override
    public String getStepDataAsHumanReadableString() {
        return null;
    }

    @Override
    public void restoreStepData(List<Garantia> data) {

    }

    @Override
    protected IsDataValid isStepDataValid(List<Garantia> stepData) {

        if(stepData == null){
            return new IsDataValid(false);
        }

        if(stepData.size() < 1){
            return new IsDataValid(false);
        }

        return new IsDataValid(true);
    }

    @Override
    protected View createStepContentLayout() {
        LayoutInflater inflater = LayoutInflater.from(this.context);

        View view = inflater.inflate(R.layout.garantias_step_layout, null, false);

        lista_gar = view.findViewById(R.id.lista_garantias);
        lista_gar.setAdapter(adapter);
        adapter.setOnClickListener(onClickListener);

        view.findViewById(R.id.btnAgregarGarantia).setOnClickListener(v->{
            agregarGarantiaDialogo(-1, "", "", "");
        });


        Departamentos.clear();
        dep_munis.addAll(AppDatabase.getInstance(context).getDepartamentoDao().getAllDep_());

        for (DepartamentoMunicipio d: dep_munis) {
            Departamentos.add(d.getDepartamento().getNombre_departamento());
        }

        this.Municipios.clear();

        for (Municipio m : this.dep_munis.get(10).getMunicipios()) {
            this.Municipios.add(m.getNombre_municipio());
        }

        return view;
    }

    @Override
    protected void onStepOpened(boolean animated) {

    }

    @Override
    protected void onStepClosed(boolean animated) {

    }

    @Override
    protected void onStepMarkedAsCompleted(boolean animated) {

    }

    @Override
    protected void onStepMarkedAsUncompleted(boolean animated) {

    }

    private void agregarGarantiaDialogo(int pos_gar, String urlImage, String nom, String desc){

        final Dialog dialog = new Dialog(context);

        dialog.setContentView(R.layout.agregar_garantia_layout);
        Window window = dialog.getWindow();
        window.setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);

        ((TextView)dialog.findViewById(R.id.textView13)).setText("Agregar garantía");

        //this.nombre = dialog.findViewById(R.id.txtNombreDocumento);
        //this.descripcion = dialog.findViewById(R.id.txtDescripcionDocumento);

        //this.nombre.setText(nom);
        //this.descripcion.setText(desc);

        this.descripcion = dialog.findViewById(R.id.txtDescripcionDocumento);
        this.direccion = dialog.findViewById(R.id.txtDireccionCliente);

        foto = dialog.findViewById(R.id.imagen_documento);
        //this.direccion = dialog.findViewById(R.id.txtDireccionCliente);

        this.direccion.setText(nom);
        this.descripcion.setText(desc);

        spinDepas = new SpinnerDialog((Activity) context, this.Departamentos, "Seleccionar Departamento", "Cancelar");
        spinMuni = new SpinnerDialog((Activity) context, this.Municipios, "Seleccionar Municipio", "Cancelar");

        this.departamento = dialog.findViewById(R.id.txtDepartamentoCliente);
        this.departamento.setOnFocusChangeListener((v, hasFocus) -> {
            if (hasFocus) {
                spinDepas.showSpinerDialog();
            }
        });
        this.departamento.setOnClickListener(v -> spinDepas.showSpinerDialog());
        this.departamento.setText("Usulután".toUpperCase());

        this.municipio = dialog.findViewById(R.id.txtMunicipioCliente);
        this.municipio.setOnFocusChangeListener((v, hasFocus) -> {
            if (hasFocus) {
                spinMuni.showSpinerDialog();
            }
        });
        this.municipio.setOnClickListener(v -> spinMuni.showSpinerDialog());

        this.municipio.setText("Usulután".toUpperCase());

        this.Municipios.clear();
        for (Municipio m : this.dep_munis.get(10).getMunicipios()) {
            this.Municipios.add(m.getNombre_municipio());
        }

        spinDepas.bindOnSpinerListener((item, position) -> {
            this.pos_dep = position;
            this.departamento.setText(item);
            this.municipio.setText("");

            this.Municipios.clear();

            //this.municipio.setEnabled(true);
            Log.e("POS", "POSICION DEPARTA "+String.valueOf(position));

            id_departamento = this.dep_munis.get(position).getDepartamento().getId_departamento();

            for (Municipio m : this.dep_munis.get(position).getMunicipios()) {
                this.Municipios.add(m.getNombre_municipio());
            }

        });
        spinMuni.bindOnSpinerListener((item, position) -> {
            this.municipio.setText(item);
            //this.id_municipio = departamentosList.get(pos_dep).getMunicipios().get(position).getId_municipio();
            this.id_municipio = dep_munis.get(pos_dep).getMunicipios().get(position).getId_municipio();
        });


        if(pos_gar > -1){
            Picasso.get().load(new File(urlImage)).centerCrop().fit().into(foto);
            pathFoto = urlImage;
        }

        dialog.findViewById(R.id.btnCapturarImagen).setOnClickListener(v->{
            Functions.showPictureDialog(context, this::dispatchPickImage, this::takePicture);
        });

        final Button btnGuardar = dialog.findViewById(R.id.btnGuardarDocumento);

        if(editando_garantia){
            btnGuardar.setText("Guardar");
        }

        btnGuardar.setOnClickListener(v->{


            final Garantia gar = new Garantia();

            gar.setDescripcion(descripcion.getText().toString());
            gar.setUrl(pathFoto);
            gar.setDepartamento(id_departamento);
            gar.setMunicipio(id_municipio);
            gar.setDireccion(direccion.getText().toString());
            gar.setFecha(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
            gar.setSincronizada(false);


            if( gar.getDescripcion().length() > 0 && gar.getUrl().length() > 0 &&
                gar.getDepartamento() > 0 && gar.getMunicipio() > 0 && gar.getDireccion().length() > 0){

                if(editando_garantia){
                    adapter.garantias.remove(pos_gar);
                    adapter.garantias.add(pos_gar, gar);
                    adapter.notifyItemChanged(pos_gar);
                    dialog.dismiss();
                }else{
                    final File tmp = new File(pathFoto);

                    if(tmp.length() > 0) {
                        adapter.addDocumento(gar);
                        dialog.dismiss();
                    }
                }

                editando_garantia = false;
                pathFoto = "";

                isStepDataValid(getStepData());
                markAsCompletedOrUncompleted(true);

            }

        });

        dialog.findViewById(R.id.btnCancelar).setOnClickListener(v->{
            dialog.dismiss();

            pathFoto = "";
            editando_garantia = false;
        });

        dialog.show();

    }

    private File createImageFile() throws IOException {
        // Create an image file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "JPEG_" + timeStamp + "_";
        File storageDir = this.context.getExternalFilesDir(Environment.DIRECTORY_PICTURES);

        File image = File.createTempFile(
                imageFileName,  /* prefix */
                ".jpg",         /* suffix */
                storageDir      /* directory */
        );


        // Save a file: path for use with ACTION_VIEW intents
        pathFoto = image.getAbsolutePath();

//        final HashMap<String, Object> result = new HashMap<>();
//
//        result.put("file", image);
//        result.put("path", image.getAbsolutePath());

        return image;
    }

    private void dispatchPickImage(){
        final Intent galleryIntent = new Intent(Intent.ACTION_PICK,
                android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

        ((Activity)this.context).startActivityForResult(galleryIntent, REQUEST_PICK_IMAGE_GAR);

    }

    private void takePicture(){
        final Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);

        File photoFile = null;
        try {

            photoFile = createImageFile();

            if(photoFile.getAbsolutePath() != null && !photoFile.getAbsolutePath().isEmpty()){

                System.out.println(photoFile.getAbsolutePath());

            }

        } catch (IOException ex) {
            // Error occurred while creating the File
            System.out.println(ex.getMessage());
        }
        // Continue only if the File was successfully created
        if (photoFile != null) {
            Uri photoURI = FileProvider.getUriForFile(context,
                    "com.c3rberuss.crediapp.provider",
                    photoFile);
            takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI);

            ((Activity)this.context).startActivityForResult(takePictureIntent, IMAGE_CAPTURE_GARANTIA);
        }
    }

}
