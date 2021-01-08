package com.c3rberuss.crediapp.activities;

import android.app.Dialog;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Switch;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.core.content.FileProvider;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.GarantiasAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.Departamento;
import com.c3rberuss.crediapp.entities.DepartamentoMunicipio;
import com.c3rberuss.crediapp.entities.Fiador;
import com.c3rberuss.crediapp.entities.Frecuencia;
import com.c3rberuss.crediapp.entities.Garantia;
import com.c3rberuss.crediapp.entities.Municipio;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.SolicitudCredito;
import com.c3rberuss.crediapp.utils.Dialogs;
import com.c3rberuss.crediapp.utils.Functions;
import com.developer.kalert.KAlertDialog;
import com.google.android.material.textfield.TextInputEditText;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import in.galaxyofandroid.spinerdialog.SpinnerDialog;
import jrizani.jrspinner.JRSpinner;
import okhttp3.MultipartBody;

public class RefinanciarActivity extends AppCompatActivity {

    @BindView(R.id.txtNombreCliente)
    TextInputEditText txtNombreCliente;
    @BindView(R.id.txtCuotasPendientes)
    TextInputEditText txtCuotasPendientes;
    @BindView(R.id.txtMontoPendiente)
    TextInputEditText txtMontoPendiente;
    @BindView(R.id.txtMontoRecibir)
    TextInputEditText txtMontoRecibir;
    @BindView(R.id.txtNuevoMonto)
    TextInputEditText txtNuevoMonto;
    @BindView(R.id.btnAgregarGarantia)
    ImageButton btnAgregarGarantia;
    @BindView(R.id.lista_garantias)
    RecyclerView listaGarantias;
    @BindView(R.id.btnRefinanciar)
    Button btnRefinanciar;
    @BindView(R.id.spinner_fiadores)
    JRSpinner spinnerFiadores;
    @BindView(R.id.switchNegocio)
    Switch switchNegocio;
    @BindView(R.id.txtNombreNegocio)
    TextInputEditText txtNombreNegocio;
    @BindView(R.id.txtActividadNegocio)
    TextInputEditText txtActividadNegocio;
    @BindView(R.id.txtDireccionNegocio)
    TextInputEditText txtDireccionNegocio;
    @BindView(R.id.inputs)
    LinearLayout inputs;
    @BindView(R.id.card_fiador)
    CardView cardFiador;

    private String[]  fiadores;
    private List<Cliente> fiadoresList = new ArrayList<>();
    private Cliente fiador_seleccionado;

    private List<Garantia> garantias = new ArrayList<>();
    public ImageView foto;
    private TextInputEditText nombre, descripcion;
    private boolean editando_garantia = false;
    public static String pathFoto;
    public static int IMAGE_CAPTURE_GARANTIA = 500;
    private static final int REQUEST_PICK_IMAGE_GAR = 201;
    private GarantiasAdapter adapter = new GarantiasAdapter(1);

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
        int position = listaGarantias.indexOfChild(v);
        final Garantia tmp = adapter.garantias.get(position);

        agregarGarantiaDialogo(position, tmp.getUrl(), tmp.getDireccion(), tmp.getDescripcion());

    };

    private AppDatabase db;
    private Prestamo prestamo;
    private Plan plan;
    private Frecuencia frecuencia;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_refinanciar);
        ButterKnife.bind(this);

        setTitle("Refinanciamiento");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);


        db = AppDatabase.getInstance(this);

        final int id_prestamo = getIntent().getExtras().getInt("id_prestamo");

        listaGarantias.setAdapter(adapter);
        adapter.setOnClickListener(onClickListener);


        db.prestamoDao().getPrestamo(id_prestamo).observe(this, prestamo1 -> {
            prestamo = prestamo1;

            frecuencia = db.getFrecuenciaDao().getById(prestamo1.getFrecuencia());
            plan = db.getPlanesDao().get(prestamo1.getPlaan());

            txtCuotasPendientes.setText(Functions.intToString2Digits(db.prestamoDetalleDao().getCuotasPendientesByPrestamo(id_prestamo)));
            txtNombreCliente.setText(prestamo.getNombre());

            final int proporcion = (int) Math.ceil(Float.valueOf(prestamo1.getCuotas()) / Float.valueOf(frecuencia.getProporcion()));
            final String monto = Functions.getMontoSinIntereses((float) prestamo1.getSaldo(), (float) prestamo1.getPorcentaje(), proporcion);

            txtMontoPendiente.setText("$" + monto);

            txtNuevoMonto.setText(String.valueOf(prestamo1.getMonto()));

            if(AppDatabase.getInstance(this).getPlanesDao().fiadorRequerido(plan.getId())  < 1){
                cardFiador.setVisibility(View.GONE);
            }else{
                cardFiador.setVisibility(View.VISIBLE);
            }

        });

        final TextWatcher watcher = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                String monto = s.toString();

                monto = monto.isEmpty() ? "0" : monto;
                monto = monto.startsWith(".") ? "0" + monto : monto;
                monto = monto.equals(".") ? "0" : monto;

                txtMontoRecibir.setText(
                        Functions.round2decimals(
                                Double.valueOf(monto) - Double.valueOf(txtMontoPendiente.getText().toString().replace("$", ""))
                        )
                );

            }
        };

        txtNuevoMonto.addTextChangedListener(watcher);

        inputs.setVisibility(View.GONE);

        switchNegocio.setOnCheckedChangeListener((buttonView, isChecked) -> {

            if(isChecked){
                inputs.setVisibility(View.VISIBLE);
            }else{
                inputs.setVisibility(View.GONE);
            }

        });

        spinnerFiadores.setOnItemClickListener(position -> {
            fiador_seleccionado = fiadoresList.get(position);
        });

        fiadoresList = AppDatabase.getInstance(this).getClienteDao().getAll_();


        fiadores = new String[fiadoresList.size()];

        for(Cliente c: fiadoresList){
            fiadores[fiadoresList.indexOf(c)] = c.getNombre();
        }

        spinnerFiadores.setItems(fiadores);

        db.getDepartamentoDao().getAllDep().observe(this, departamentos -> {

            Departamentos.clear();
            dep_munis.addAll(departamentos);

            for (DepartamentoMunicipio d: dep_munis) {
                Departamentos.add(d.getDepartamento().getNombre_departamento());
            }

        });

    }

    private void agregarGarantiaDialogo(int pos_gar, String urlImage, String nom, String desc) {

        final Dialog dialog = new Dialog(this);

        dialog.setContentView(R.layout.agregar_garantia_layout);
        Window window = dialog.getWindow();
        window.setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);

        ((TextView) dialog.findViewById(R.id.textView13)).setText("Agregar garantía");

        this.nombre = dialog.findViewById(R.id.txtNombreDocumento);
        this.descripcion = dialog.findViewById(R.id.txtDescripcionDocumento);
        this.direccion = dialog.findViewById(R.id.txtDireccionCliente);

        this.direccion.setText(nom);
        this.descripcion.setText(desc);

        foto = dialog.findViewById(R.id.imagen_documento);



        spinDepas = new SpinnerDialog(this, this.Departamentos, "Seleccionar Departamento", "Cancelar");
        spinMuni = new SpinnerDialog(this, this.Municipios, "Seleccionar Municipio", "Cancelar");

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

            this.municipio.setEnabled(true);

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


        if (pos_gar > -1) {
            Picasso.get().load(new File(urlImage)).centerCrop().fit().into(foto);
            pathFoto = urlImage;
        }

        dialog.findViewById(R.id.btnCapturarImagen).setOnClickListener(v -> {
            Functions.showPictureDialog(this, this::dispatchPickImage, this::takePicture);
        });

        final Button btnGuardar = dialog.findViewById(R.id.btnGuardarDocumento);

        if (editando_garantia) {
            btnGuardar.setText("Guardar");
        }

        btnGuardar.setOnClickListener(v -> {
            final Garantia gar = new Garantia();

            gar.setDescripcion(descripcion.getText().toString());
            gar.setUrl(pathFoto);
            gar.setDepartamento(id_departamento);
            gar.setMunicipio(id_municipio);
            gar.setDireccion(direccion.getText().toString());
            gar.setSincronizada(false);

            gar.setFecha(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));

            if( gar.getDescripcion().length() > 0 && gar.getUrl().length() > 0 &&
                    gar.getDepartamento() > 0 && gar.getMunicipio() > 0 && gar.getDireccion().length() > 0){

                if (editando_garantia) {

                    adapter.garantias.remove(pos_gar);
                    adapter.garantias.add(pos_gar, gar);
                    adapter.notifyItemChanged(pos_gar);
                    dialog.dismiss();
                } else {
                    final File tmp = new File(pathFoto);

                    if (tmp.length() > 0) {
                        adapter.addDocumento(gar);
                        dialog.dismiss();
                    }
                }

                editando_garantia = false;
                pathFoto = "";

            }

        });

        dialog.findViewById(R.id.btnCancelar).setOnClickListener(v -> {
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
        File storageDir = this.getExternalFilesDir(Environment.DIRECTORY_PICTURES);

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

        startActivityForResult(galleryIntent, REQUEST_PICK_IMAGE_GAR);

    }

    private void takePicture() {
        final Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);

        File photoFile = null;
        try {

            photoFile = createImageFile();

            if (photoFile.getAbsolutePath() != null && !photoFile.getAbsolutePath().isEmpty()) {

                System.out.println(photoFile.getAbsolutePath());

            }

        } catch (IOException ex) {
            // Error occurred while creating the File
            System.out.println(ex.getMessage());
        }
        // Continue only if the File was successfully created
        if (photoFile != null) {
            Uri photoURI = FileProvider.getUriForFile(this,
                    "com.c3rberuss.crediapp.provider",
                    photoFile);
            takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI);

            startActivityForResult(takePictureIntent, IMAGE_CAPTURE_GARANTIA);
        }
    }

    @OnClick(R.id.btnAgregarGarantia)
    public void onBtnAgregarGarantiaClicked() {

        agregarGarantiaDialogo(-1, "", "", "");
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == IMAGE_CAPTURE_GARANTIA && resultCode == RESULT_OK) {
            //System.out.println("FUNCIONÓ");

            pathFoto = Functions.comprimirImagen(pathFoto, this);

            if (!pathFoto.isEmpty()) {
                Picasso.get().load(new File(pathFoto))
                        .centerCrop()
                        .fit()
                        .into(foto);
            }

        } else if (requestCode == IMAGE_CAPTURE_GARANTIA && resultCode == RESULT_CANCELED) {
            Functions.borrarArchivo(pathFoto);
        }else if (requestCode == REQUEST_PICK_IMAGE_GAR && resultCode == RESULT_OK) {

            final Uri imageUri = data.getData();

            pathFoto = Functions.getRealPathFromURI(this, imageUri);
            pathFoto = Functions.comprimirImagen2(pathFoto, this);

            Picasso.get().load(new File(pathFoto))
                    .centerCrop()
                    .fit()
                    .into(foto);


        }

    }

    @OnClick(R.id.btnRefinanciar)
    public void onBtnRefinanciarClicked() {

        Log.e("GARANTIAS", String.valueOf(adapter.garantias.size()));
        Log.e("Monto", txtMontoRecibir.getText().toString());
        Log.e("Pendiente", String.valueOf(db.getSolicitudDao().tieneSolicitudPendiente(prestamo.getId_cliente())));


        if(adapter.garantias.size()  == 0){
            final KAlertDialog alert = Dialogs.success(RefinanciarActivity.this,
                    "Error", "Las garantías son requeridas", null);
            alert.changeAlertType(KAlertDialog.WARNING_TYPE);

            alert.show();

            return;
        }

        if (Double.valueOf(txtMontoRecibir.getText().toString()) < 1){
            final KAlertDialog alert = Dialogs.success(RefinanciarActivity.this,
                    "Error", "El monto a recibir debe ser mayor a 0", null);
            alert.changeAlertType(KAlertDialog.WARNING_TYPE);

            alert.show();

            return;
        }

        if(db.getPlanesDao().fiadorRequerido(prestamo.getPlaan()) > 0){


            if(fiador_seleccionado == null && !switchNegocio.isChecked()){
                final KAlertDialog alert = Dialogs.success(RefinanciarActivity.this,
                        "Error", "El fiador es requerido", null);
                alert.changeAlertType(KAlertDialog.WARNING_TYPE);

                alert.show();

                return;

            } else if(fiador_seleccionado == null && !txtActividadNegocio.getText().toString().isEmpty() &&
                !txtNombreNegocio.getText().toString().isEmpty() && !txtDireccionNegocio.getText().toString().isEmpty()){

                final KAlertDialog alert = Dialogs.success(RefinanciarActivity.this,
                        "Error", "El fiador es requerido", null);
                alert.changeAlertType(KAlertDialog.WARNING_TYPE);

                alert.show();

                return;

            }
        }


        if(db.getSolicitudDao().tieneSolicitudRefPendiente(prestamo.getId_cliente()) > 0){
            final KAlertDialog alert = Dialogs.success(RefinanciarActivity.this,
                    "Error", "El cliente ya posee una solicitud.", null);
            alert.changeAlertType(KAlertDialog.WARNING_TYPE);

            alert.show();

            return;
        }

        if(adapter.garantias.size() > 0 && Double.valueOf(txtMontoRecibir.getText().toString()) > 0 &&
            db.getSolicitudDao().tieneSolicitudRefPendiente(prestamo.getId_cliente()) < 1) {

            final int id_usuario = db.getUsuarioDao().getId();

            final SolicitudCredito solicitud = new SolicitudCredito();
            solicitud.setId_cliente(prestamo.getId_cliente());
            solicitud.setFecha(Functions.getFecha());
            solicitud.setHora(Functions.getHora());
            solicitud.setMonto(Float.valueOf(txtNuevoMonto.getText().toString()));
            solicitud.setFrecuencia(frecuencia.getId());
            solicitud.setPorcentaje((float) prestamo.getPorcentaje());
            solicitud.setPlan(plan.getId());
            solicitud.setId_vendedor(id_usuario);
            solicitud.setId_refinanciado(prestamo.getId_prestamo());
            solicitud.setCuotas(prestamo.getCuotas());

            final Fiador fiador = new Fiador();

            if(AppDatabase.getInstance(this).getPlanesDao().fiadorRequerido(plan.getId()) > 0 ){

                solicitud.setTiene_fiador(true);

                fiador.setIdFiador(fiador_seleccionado.getId_cliente());
                fiador.setFecha(Functions.getFecha());

                if(switchNegocio.isChecked()){
                    fiador.setNegocio(txtNombreNegocio.getText().toString());
                    fiador.setActividad(txtActividadNegocio.getText().toString());
                    fiador.setDireccion(txtDireccionNegocio.getText().toString());
                }else{
                    fiador.setNegocio("");
                    fiador.setActividad("");
                    fiador.setDireccion("");
                }

                fiador.setTieneNegocio(switchNegocio.isChecked());

                solicitud.setFiador(fiador);

            }

            solicitud.setGarantias(adapter.garantias);

            final List<MultipartBody.Part> archivos = new ArrayList<>();

            for(Garantia g: solicitud.getGarantias()){
                archivos.add(Functions.prepareFilePart(UUID.randomUUID().toString(), g.getUrl()));
            }


            //NUEVO

            final Dialog dialog = Functions.progressDialog(this, "Enviando solicitud... Espere un momento.");
            dialog.show();

            solicitud.setSincronizada(false);
            solicitud.setRefinanciamiento(1);

            long id_solicitud = db.getSolicitudDao().insert(solicitud);

            for(Garantia g: solicitud.getGarantias()){
                solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setSincronizada(false);
                solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setId_prestamo((int) id_solicitud);
                solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setFecha(Functions.getFecha());
            }

            if(solicitud.isTiene_fiador()){
                solicitud.getFiador().setSincronizado(false);
                solicitud.getFiador().setIdPrestamo((int)id_solicitud);

                db.getFiadorDao().insert(solicitud.getFiador());
            }

            db.getGarantiaDao().insert(solicitud.getGarantias());

            dialog.dismiss();

            final KAlertDialog alert = Dialogs.success(RefinanciarActivity.this,
                    "Exito", "Solicitud guardada exitosamente. ¡Recuede Sincronizar los datos!", v->{

                        v.dismiss();
                        finish();

                    });

            alert.show();


            //FIN NUEVO


            /*ApiProvider.getWebService().enviar_refinanciamiento(solicitud).enqueue(new Callback<ResponseServer>() {
                @Override
                public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                    if(response.code() == 200){

                        ApiProvider.getWebService().subir_documentos(archivos).enqueue(new Callback<ResponseServer>() {
                            @Override
                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                                if(response.code() == 200){
                                    Log.e("UPLOAD", "ARCHIVOS SUBIDOS EXITOSAMENTE");
                                    Dialogs.success(RefinanciarActivity.this, "Exito", "Solicitud de refinanciamiento enviada exitosamente", v->{
                                        v.dismiss();
                                        finish();
                                    }).show();
                                }else{
                                    Log.e("UPLOAD", "ERROR AL SUBIR LOS ARCHIVOS");
                                }
                            }

                            @Override
                            public void onFailure(Call<ResponseServer> call, Throwable t) {
                                Log.e("UPLOAD", t.getMessage());
                            }
                        });


                    }else{
                        //Toast.makeText(RefinanciarActivity.this, String.valueOf(response.code()), Toast.LENGTH_LONG).show();
                    }
                }

                @Override
                public void onFailure(Call<ResponseServer> call, Throwable t) {

                    //Toast.makeText(RefinanciarActivity.this, t.getMessage(), Toast.LENGTH_LONG).show();

                    solicitud.setSincronizada(false);
                    solicitud.setRefinanciamiento(1);

                    long id_solicitud = db.getSolicitudDao().insert(solicitud);

                    for(Garantia g: solicitud.getGarantias()){
                        solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setSincronizada(false);
                        solicitud.getGarantias().get( solicitud.getGarantias().indexOf(g)).setId_prestamo((int) id_solicitud);
                    }

                    if(solicitud.isTiene_fiador()){
                        solicitud.getFiador().setSincronizado(false);
                        solicitud.getFiador().setIdPrestamo((int)id_solicitud);

                        db.getFiadorDao().insert(solicitud.getFiador());
                    }

                    db.getGarantiaDao().insert(solicitud.getGarantias());

                    final KAlertDialog alert = Dialogs.success(RefinanciarActivity.this,
                            "Error", "Solicitud no pudo ser enviada. Se guardará localmente y luego se envirá.", v->{

                                v.dismiss();
                                finish();

                            });
                    alert.changeAlertType(KAlertDialog.WARNING_TYPE);

                    alert.show();

                }
            });*/

        }else{

            final KAlertDialog alert = Dialogs.success(RefinanciarActivity.this,
                    "Error", "Solicitud no pudo ser enviada.", null);
            alert.changeAlertType(KAlertDialog.WARNING_TYPE);

            alert.show();
        }

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }
}
