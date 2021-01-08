package com.c3rberuss.crediapp.activities;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Switch;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.MainActivity;
import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.DocumentosAdapter;
import com.c3rberuss.crediapp.adapters.HintParentezcoAdapter;
import com.c3rberuss.crediapp.adapters.ReferenciasAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Archivo;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.Departamento;
import com.c3rberuss.crediapp.entities.DepartamentoMunicipio;
import com.c3rberuss.crediapp.entities.Municipio;
import com.c3rberuss.crediapp.entities.Parentezco;
import com.c3rberuss.crediapp.entities.Referencia;
import com.c3rberuss.crediapp.entities.ResponseServer;
import com.c3rberuss.crediapp.utils.Dialogs;
import com.c3rberuss.crediapp.utils.Functions;
import com.google.android.material.textfield.TextInputEditText;
import com.google.gson.Gson;
import com.jaiselrahman.hintspinner.HintSpinner;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import br.com.sapereaude.maskedEditText.MaskedEditText;
import butterknife.BindView;
import butterknife.ButterKnife;
import in.galaxyofandroid.spinerdialog.SpinnerDialog;
import okhttp3.MultipartBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class AgregarCliente extends AppCompatActivity {

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
    private ArrayList<String> Departamentos = new ArrayList<>();
    private ArrayList<String> Municipios = new ArrayList<>();
    private List<MultipartBody.Part> imagenes = new ArrayList<>();
    private List<MultipartBody.Part> documents = new ArrayList<>();
    private List<Departamento> departamentosList = new ArrayList<>();
    private ReferenciasAdapter adapter;
    private RecyclerView lista_ref, lista_docs;
    private String pathClienteImagen, pathFotoDocumento;
    private static final int REQUEST_CAPTURE_IMAGE = 100, REQUEST_CAPTURE_IMAGE_DOC = 101;
    private static final int REQUEST_PICK_IMAGE = 200,  REQUEST_PICK_IMAGE_DOC = 201;
    private int OPEN_MEDIA_PICKER = 1;
    private DocumentosAdapter documentosAdapter = new DocumentosAdapter(0);
    private HintParentezcoAdapter parentezcoAdapter;
    private ImageView fotoDoc;
    private float rotation = 90;
    private HintSpinner spinnerParentezco;
    private TextInputEditText nombreRef;
    private MaskedEditText telefonoRef;
    private List<Parentezco> parentezcos = new ArrayList<>();
    private TextInputEditText nombreDoc, descripcionDoc;
    private boolean editando_referencia = false, editando_documento = false;
    List<String> paths = new ArrayList<>();

    private List<DepartamentoMunicipio> dep_munis = new ArrayList<>();

    private static final String CERO = "0";
    private static final String BARRA = "/";

    //Calendario para obtener fecha & hora
    public final Calendar c = Calendar.getInstance();

    //Variables para obtener la fecha
    int mes = c.get(Calendar.MONTH);
    int dia = c.get(Calendar.DAY_OF_MONTH);
    int anio = c.get(Calendar.YEAR);

    int pos_dep = 10;
    int id_departamento = 11;
    int id_municipio = 64;


    //datos generales del cliente
    private SpinnerDialog spinDepas, spinMuni;
    private ImageView perfil;
    private TextInputEditText fecha_nacimiento;
    private TextInputEditText profesion;
    private TextInputEditText departamento;
    private TextInputEditText municipio;
    private TextInputEditText direccionCliente;
    private TextInputEditText nombreCliente;
    private MaskedEditText duiCliente, nitCliente;
    private MaskedEditText telCliente1, telCliente2;
    private TextInputEditText correo;

    private AppDatabase db;


    private View.OnClickListener onClickListenerRef = view -> {

        editando_referencia = true;
        int position = lista_ref.indexOfChild(view);
        final Referencia tmp = adapter.referencias.get(position);

        int index = getIndexOfArray(tmp.getParentezco(), parentezcos);
        agregarReferenciaDialogo(index + 1, position, tmp.getNombre(), tmp.getTelefono());

    };

    private View.OnClickListener onClickListenerDoc = view -> {
        editando_documento = true;
        int position = lista_docs.indexOfChild(view);
        final Archivo tmp = documentosAdapter.documentos.get(position);

        agregarDocumentoDialogo(position, tmp.getUrl(), tmp.getNombre(), tmp.getDescripcion());
    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_agregar_cliente);
        ButterKnife.bind(this);

        setTitle("Agregar Cliente");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);

        Functions.permisosApp(this);


        perfil = findViewById(R.id.foto_cliente);

        parentezcoAdapter = new HintParentezcoAdapter(this, parentezcos, "Parentezco");
        obtener_parentezcos();

        this.documentosAdapter.setOnClickListener(this.onClickListenerDoc);

        db = AppDatabase.getInstance(this);

        //verificar permisos
        Functions.permisosApp(this);

        this.nombreCliente = findViewById(R.id.txtNombreCliente);
        this.duiCliente = findViewById(R.id.txtDuiCliente);
        this.nitCliente = findViewById(R.id.txtNitCliente);
        this.telCliente1 = findViewById(R.id.txtTelefonoCliente1);
        this.telCliente2 = findViewById(R.id.txtTelefonoCliente2);
        this.correo = findViewById(R.id.txtCorreoCliente);
        this.profesion = findViewById(R.id.txtProfesion);
        this.fecha_nacimiento = findViewById(R.id.txtFechaNacimiento);
        this.direccionCliente = findViewById(R.id.txtDireccionCliente);

        spinDepas = new SpinnerDialog(this, this.Departamentos, "Seleccionar Departamento", "Cancelar");
        spinMuni = new SpinnerDialog(this, this.Municipios, "Seleccionar Municipio", "Cancelar");

        this.departamento = findViewById(R.id.txtDepartamentoCliente);
        this.departamento.setOnFocusChangeListener((v, hasFocus) -> {
            if (hasFocus) {
                spinDepas.showSpinerDialog();
            }
        });
        this.departamento.setOnClickListener(v -> spinDepas.showSpinerDialog());
        this.departamento.setText("Usulután".toUpperCase());

        this.municipio = findViewById(R.id.txtMunicipioCliente);
        this.municipio.setOnFocusChangeListener((v, hasFocus) -> {
            if (hasFocus) {
                spinMuni.showSpinerDialog();
            }
        });
        this.municipio.setOnClickListener(v -> spinMuni.showSpinerDialog());

        this.municipio.setText("Usulután".toUpperCase());

        spinDepas.bindOnSpinerListener((item, position) -> {
            this.pos_dep = position;
            this.departamento.setText(item);
            this.municipio.setText("");

            this.Municipios.clear();

            this.municipio.setEnabled(true);

//            id_departamento = this.departamentosList.get(position).getId_departamento();
//
//            for (Municipio m : this.departamentosList.get(position).getMunicipios()) {
//                this.Municipios.add(m.getNombre_municipio());
//            }

            Log.e("POS", "POSICION DEPARTA "+String.valueOf(position));
            id_departamento = this.dep_munis.get(position).getDepartamento().getId_departamento();

            for (Municipio m : this.dep_munis.get(position).getMunicipios()) {
                this.Municipios.add(m.getNombre_municipio());
            }

        });

        adapter = new ReferenciasAdapter(0);
        lista_docs = findViewById(R.id.lista_documentos);
        lista_docs.setAdapter(documentosAdapter);

        adapter.setOnClickListener(onClickListenerRef);

        db.getDepartamentoDao().getAllDep().observe(this, departamentos -> {

            Departamentos.clear();
            dep_munis.addAll(departamentos);

            for (DepartamentoMunicipio d : dep_munis) {
                Departamentos.add(d.getDepartamento().getNombre_departamento());
            }

            this.Municipios.clear();

            for (Municipio m : this.dep_munis.get(10).getMunicipios()) {
                this.Municipios.add(m.getNombre_municipio());
            }

        });

        spinMuni.bindOnSpinerListener((item, position) -> {
            this.municipio.setText(item);
            //this.id_municipio = departamentosList.get(pos_dep).getMunicipios().get(position).getId_municipio();
            this.id_municipio = dep_munis.get(pos_dep).getMunicipios().get(position).getId_municipio();
        });

        findViewById(R.id.btnAgregarReferencia).setOnClickListener(v -> {
            agregarReferenciaDialogo(-1, 0, "", "");
        });

        lista_ref = findViewById(R.id.lista_referencias);

        lista_ref.setAdapter(adapter);

        findViewById(R.id.btnCapturarImagenCliente).setOnClickListener(v -> {

            Functions.showPictureDialog(this, ()->dispatchPickImage("perfil"),
                    () -> dispatchTakePictureIntent("perfil"));


        });

        findViewById(R.id.btnAgregarDocumento).setOnClickListener(v -> {
            agregarDocumentoDialogo(-1, "", "", "");
        });

        findViewById(R.id.btnRegistrarCliente).setOnClickListener(v -> {
            registrarCliente();
        });

        this.fecha_nacimiento.setOnFocusChangeListener((v, hasFocus) -> {
            if (hasFocus) {
                obtenerFecha();
            }
        });

        this.fecha_nacimiento.setOnClickListener((v) -> obtenerFecha());

        inputs.setVisibility(View.GONE);

        switchNegocio.setOnCheckedChangeListener((buttonView, isChecked) -> {

            if (isChecked) {
                inputs.setVisibility(View.VISIBLE);
            } else {
                inputs.setVisibility(View.GONE);
            }

        });

    }


    private Uri getCaptureImageOutputUri() {
        Uri outputFileUri = null;
        File getImage = getExternalCacheDir();
        if (getImage != null) {
            outputFileUri = Uri.fromFile(new File(getImage.getPath(), "profile.png"));
        }
        return outputFileUri;
    }

    private void obtenerFecha() {

        DatePickerDialog recogerFecha = new DatePickerDialog(this, (view, year, month, dayOfMonth) -> {

            final int mesActual = month + 1;

            String diaFormateado = (dayOfMonth < 10) ? CERO + String.valueOf(dayOfMonth) : String.valueOf(dayOfMonth);

            String mesFormateado = (mesActual < 10) ? CERO + String.valueOf(mesActual) : String.valueOf(mesActual);

            this.dia = dayOfMonth;
            this.mes = month;
            this.anio = year;

            final String fecha = year + "-" + mesFormateado + "-" + diaFormateado;
            this.fecha_nacimiento.setText(Functions.fechaDMY(fecha));


        }, anio, mes, dia);

        recogerFecha.show();

    }

    private void agregarReferenciaDialogo(int pos_spi, int pos_ref, String nom, String tel) {

        final Dialog dialog = new Dialog(this);

        dialog.setContentView(R.layout.agregar_referencia_layout);
        Window window = dialog.getWindow();
        window.setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);

        this.spinnerParentezco = dialog.findViewById(R.id.spinner_parentezco);
        this.nombreRef = dialog.findViewById(R.id.txtNombreReferencia);
        this.telefonoRef = dialog.findViewById(R.id.txtTelefonoReferencia);

        this.spinnerParentezco.setAdapter(parentezcoAdapter);

        this.nombreRef.setText(nom);
        this.telefonoRef.setText(tel);

        final Referencia ref = new Referencia();
        final Button btnGuardar = dialog.findViewById(R.id.btnGuardarReferencia);

        spinnerParentezco.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                ref.setParentezco(parentezcos.get(position).getNombre());
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        if (pos_spi > -1) {
            spinnerParentezco.setSelection(pos_spi, true);
            spinnerParentezco.setSelected(true);
        }

        if (editando_referencia) {
            btnGuardar.setText("Guardar");
        }

        btnGuardar.setOnClickListener(v -> {

            ref.setNombre(nombreRef.getText().toString());
            ref.setTelefono(telefonoRef.getText().toString());

            if (ref.getNombre().length() > 0 && ref.getTelefono().length() > 0 && ref.getParentezco() != null) {

                if (editando_referencia) {
                    adapter.referencias.remove(pos_ref);
                    adapter.referencias.add(pos_ref, ref);
                    adapter.notifyItemChanged(pos_ref);
                } else {
                    adapter.addReferencia(ref);
                }

                dialog.dismiss();
                editando_referencia = false;
                pathClienteImagen = "";
            }
        });

        dialog.findViewById(R.id.btnCancelar).setOnClickListener(v -> {
            dialog.dismiss();
            pathClienteImagen = "";
            editando_referencia = false;
        });

        dialog.show();

    }

    private void agregarDocumentoDialogo(int pos_doc, String urlImage, String nom, String desc) {

        final Dialog dialog = new Dialog(this);
        rotation = 90.0f;

        dialog.setContentView(R.layout.agregar_documento_layout);
        Window window = dialog.getWindow();
        window.setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);

        this.nombreDoc = dialog.findViewById(R.id.txtNombreDocumento);
        this.descripcionDoc = dialog.findViewById(R.id.txtDescripcionDocumento);

        this.nombreDoc.setText(nom);
        this.descripcionDoc.setText(desc);

        fotoDoc = dialog.findViewById(R.id.imagen_documento);

        if (pos_doc > -1) {
            Picasso.get().load(new File(urlImage)).centerCrop().fit().into(fotoDoc);
            pathFotoDocumento = urlImage;
        }

        dialog.findViewById(R.id.btnCapturarImagen).setOnClickListener(v -> {
            Functions.showPictureDialog(this, ()->dispatchPickImage("documento"),
                    () -> dispatchTakePictureIntent("documento"));
            //dispatchTakePictureIntent("documento");
        });

        dialog.findViewById(R.id.btnRotar).setOnClickListener(v -> {
            fotoDoc.setRotation(rotation);
            rotation += 90.0;
        });


        final Button btnGuardar = dialog.findViewById(R.id.btnGuardarDocumento);

        if (editando_documento) {
            btnGuardar.setText("Guardar");
        }

        btnGuardar.setOnClickListener(v -> {
            final Archivo doc = new Archivo();

            doc.setNombre(nombreDoc.getText().toString());
            doc.setDescripcion(descripcionDoc.getText().toString());
            doc.setUrl(pathFotoDocumento);
            doc.setSincronizado(false);

            if (doc.getNombre().length() > 0 && doc.getDescripcion().length() > 0 && doc.getUrl().length() > 0) {
                if (editando_documento) {

                    documentosAdapter.documentos.remove(pos_doc);
                    documentosAdapter.documentos.add(pos_doc, doc);
                    documentosAdapter.notifyItemChanged(pos_doc);
                    dialog.dismiss();

                } else {
                    final File tmp = new File(pathFotoDocumento);

                    if (tmp.length() > 0) {
                        documentosAdapter.addDocumento(doc);
                        dialog.dismiss();
                    }
                }

                pathFotoDocumento = "";
                editando_documento = false;
            }

        });

        dialog.findViewById(R.id.btnCancelar).setOnClickListener(v -> {
            dialog.dismiss();

            pathFotoDocumento = "";
            editando_documento = false;
        });

        dialog.show();

    }

    private File createImageFile() throws IOException {
        // Create an image file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "JPEG_" + timeStamp + "_";
        File storageDir = getExternalFilesDir(Environment.DIRECTORY_PICTURES);

        File image = File.createTempFile(
                imageFileName,  /* prefix */
                ".jpg",         /* suffix */
                storageDir      /* directory */
        );


        // Save a file: path for use with ACTION_VIEW intents
        //currentPhotoPath = image.getAbsolutePath();

//        final HashMap<String, Object> result = new HashMap<>();
//
//        result.put("file", image);
//        result.put("path", image.getAbsolutePath());

        return image;
    }

    private void dispatchPickImage(String mode){
        final Intent galleryIntent = new Intent(Intent.ACTION_PICK,
                android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

        switch(mode){
            case "perfil":
                startActivityForResult(galleryIntent, REQUEST_PICK_IMAGE);
                break;
            case "documento":
                startActivityForResult(galleryIntent, REQUEST_PICK_IMAGE_DOC);
                break;
        }

    }

    private void dispatchTakePictureIntent(String tipo) {
        final Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        // Ensure that there's a camera activity to handle the intent
        if (takePictureIntent.resolveActivity(getPackageManager()) != null) {
            // Create the File where the photo should go
            File photoFile = null;
            try {

                photoFile = createImageFile();

                if (photoFile.getAbsolutePath() != null && !photoFile.getAbsolutePath().isEmpty()) {

                    switch (tipo) {
                        case "perfil":
                            pathClienteImagen = photoFile.getAbsolutePath();
                            break;
                        case "documento":
                            pathFotoDocumento = photoFile.getAbsolutePath();
                            break;

                    }

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

                switch (tipo) {
                    case "perfil":
                        startActivityForResult(takePictureIntent, REQUEST_CAPTURE_IMAGE);
                        break;
                    case "documento":
                        startActivityForResult(takePictureIntent, REQUEST_CAPTURE_IMAGE_DOC);
                        break;

                }
            }
        }
    }

    private int getIndexOfArray(String val, List<Parentezco> array) {
        int pos = -1;

        for (final Parentezco val_ : array) {
            if (val_.getNombre().equals(val)) {
                pos = array.indexOf(val_);
                break;
            }
        }

        return pos;
    }

    private String getRealPathFromURI(Uri contentURI) {
        String result;
        Cursor cursor = getContentResolver().query(contentURI, null, null, null, null);
        if (cursor == null) { // Source is Dropbox or other similar local file path
            result = contentURI.getPath();
        } else {
            cursor.moveToFirst();
            int idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA);
            result = cursor.getString(idx);
            cursor.close();
        }
        return result;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == REQUEST_CAPTURE_IMAGE && resultCode == RESULT_OK) {


            pathClienteImagen = Functions.comprimirImagen(pathClienteImagen, this);
            paths.add(pathClienteImagen);

            if (!pathClienteImagen.isEmpty()) {
                Picasso.get().load(new File(pathClienteImagen))
                        .centerCrop()
                        .fit()
                        .into(perfil);
            }

        } else if (requestCode == REQUEST_CAPTURE_IMAGE_DOC && resultCode == RESULT_OK) {

            pathFotoDocumento = Functions.comprimirImagen(pathFotoDocumento, this);

            if (!pathFotoDocumento.isEmpty()) {
                Picasso.get().load(new File(pathFotoDocumento))
                        .centerCrop()
                        .fit()
                        .into(fotoDoc);
            }

        } else if (requestCode == REQUEST_CAPTURE_IMAGE && resultCode == RESULT_CANCELED) {
            System.out.println("CANCELADO");
            Functions.borrarArchivo(pathClienteImagen);
        } else if (requestCode == REQUEST_CAPTURE_IMAGE_DOC && resultCode == RESULT_CANCELED) {

            System.out.println("CANCELADO");
            Functions.borrarArchivo(pathFotoDocumento);

        }else if (requestCode == REQUEST_PICK_IMAGE && resultCode == RESULT_OK) {

            final Uri imageUri = data.getData();

            pathClienteImagen = Functions.getRealPathFromURI(this, imageUri);
            pathClienteImagen = Functions.comprimirImagen2(pathClienteImagen, this);

            paths.add(pathClienteImagen);

            Picasso.get().load(new File(pathClienteImagen))
                    .centerCrop()
                    .fit()
                    .into(perfil);

            Log.e("PERFIL IMAGE", pathClienteImagen);


        }else if (requestCode == REQUEST_PICK_IMAGE_DOC && resultCode == RESULT_OK) {

            final Uri imageUri = data.getData();

            pathFotoDocumento = Functions.getRealPathFromURI(this, imageUri);
            pathFotoDocumento = Functions.comprimirImagen2(pathFotoDocumento, this);

            Log.e("DOC IMAGE", pathFotoDocumento);

            Picasso.get().load(new File(pathFotoDocumento))
                    .centerCrop()
                    .fit()
                    .into(fotoDoc);


        }
    }


    private void obtener_parentezcos() {
        /*MainActivity.ws.get_parentezco().enqueue(new Callback<List<Parentezco>>() {
            @Override
            public void onResponse(Call<List<Parentezco>> call, Response<List<Parentezco>> response) {
                if(response.code() == 200){
                    parentezcos.clear();
                    parentezcos.addAll(response.body());
                    adapter.notifyDataSetChanged();
                }
            }

            @Override
            public void onFailure(Call<List<Parentezco>> call, Throwable t) {

            }
        });*/

        AppDatabase.getInstance(this).getPatentezcoDao().getAll().observe(this, parentezcos1 -> {
            parentezcos.clear();
            parentezcos.addAll(parentezcos1);
            adapter.notifyDataSetChanged();
        });

    }

    private int indexOfItemDep(String val) {

        for (Departamento d : departamentosList) {

            if (d.getNombre_departamento().toUpperCase().equals(val.toUpperCase())) {
                return departamentosList.indexOf(d);
            }

        }

        return -1;
    }

    private int indexOfMuni(int pos_dep, String val) {

        for (Municipio m : departamentosList.get(pos_dep).getMunicipios()) {
            if (m.getNombre_municipio().toUpperCase().equals(val.toUpperCase())) {
                return departamentosList.get(pos_dep).getMunicipios().indexOf(m);
            }
        }
        return 0;
    }

    private void registrarCliente() {

        final String required = "Este campo es requerido";
        final String invalid = "Datos inválidos";

        if (this.nombreCliente.getText().toString().isEmpty()) {
            this.nombreCliente.setError(required);
            return;
        }

        if (this.profesion.getText().toString().isEmpty()) {
            this.profesion.setError(required);
            return;
        }

        if (this.fecha_nacimiento.getText().toString().isEmpty()) {
            this.fecha_nacimiento.setError(required);
            return;
        }

        if (this.departamento.getText().toString().isEmpty()) {
            this.departamento.setError(required);
            return;
        }

        if (this.municipio.getText().toString().isEmpty()) {
            this.municipio.setError(required);
            return;
        }

        if (this.direccionCliente.getText().toString().isEmpty()) {
            this.direccionCliente.setError(required);
            return;
        }

        if (this.duiCliente.getText().toString().isEmpty()) {
            this.duiCliente.setError(required);
            return;
        } else if (this.duiCliente.getText().toString().length() < 10) {
            this.duiCliente.setError(invalid);
            return;
        }

        if (this.nitCliente.getText().toString().isEmpty()) {
            this.nitCliente.setError(required);
            return;
        } else if (this.nitCliente.getText().toString().length() < 17) {
            this.nitCliente.setError(invalid);
            return;
        }

        if (this.telCliente1.getText().toString().isEmpty()) {
            this.telCliente1.setError(required);
            return;
        } else if (this.telCliente1.getText().toString().length() < 9) {
            this.telCliente1.setError(invalid);
            return;
        }

        if (!this.telCliente2.getText().toString().isEmpty() && this.telCliente2.getText().toString().length() < 9) {
            this.telCliente2.setError(invalid);
            return;
        }

        if (!this.correo.getText().toString().isEmpty() && !this.correo.getText().toString().contains("@") &&
                !this.correo.getText().toString().contains(".")) {
            this.correo.setError(invalid);
            return;
        }

        if(switchNegocio.isChecked() && txtNombreNegocio.getText().toString().isEmpty()){
            txtNombreNegocio.setError(required);
            return;
        }

        if(switchNegocio.isChecked() && txtActividadNegocio.getText().toString().isEmpty()){
            txtActividadNegocio.setError(required);
            return;
        }

        if(switchNegocio.isChecked() && txtDireccionNegocio.getText().toString().isEmpty()){
            txtDireccionNegocio.setError(required);
            return;
        }

        final String nombre_cliente = this.nombreCliente.getText().toString();

        final int index_dep = indexOfItemDep(this.departamento.getText().toString());

        final String profesion = this.profesion.getText().toString();
        final String fecha = this.fecha_nacimiento.getText().toString();

        final int departamento_cliente = id_departamento;
        final int municipio_cliente = id_municipio;
        final String direccion_cliente = this.direccionCliente.getText().toString();
        final String dui_cliente = this.duiCliente.getText().toString();
        final String nit_cliente = this.nitCliente.getText().toString();
        final String tel1 = this.telCliente1.getText().toString();
        final String tel2 = this.telCliente2.getText().toString();
        final String correo_ = this.correo.getText().toString();

        final String nombre_negocio = txtNombreNegocio.getText().toString();
        final String actividad_negocio = txtActividadNegocio.getText().toString();
        final String direccion_negocio = txtDireccionNegocio.getText().toString();


        final Cliente cliente = new Cliente();

        cliente.setNombre(nombre_cliente.toUpperCase());
        cliente.setFecha_nacimiento(Functions.fechaDMY(fecha));
        cliente.setProfesion(profesion.toUpperCase());
        cliente.setDepartamento(departamento_cliente);
        cliente.setMunicipio(municipio_cliente);
        cliente.setDireccion(direccion_cliente.toUpperCase());
        cliente.setDui(dui_cliente);
        cliente.setNit(nit_cliente);
        cliente.setTelefono(tel1);
        cliente.setTelefono2(tel2);
        cliente.setCorreo(correo_);
        cliente.setId_usuario(db.getUsuarioDao().getId());

        cliente.setNegocio(nombre_negocio.toUpperCase());
        cliente.setActividad_negocio(actividad_negocio.toUpperCase());
        cliente.setDireccion_negocio(direccion_negocio.toUpperCase());
        cliente.setFecha_registro(Functions.getFecha());

        if (AppDatabase.getInstance(this).getClienteDao().existeCliente(dui_cliente, nit_cliente) > 0) {

            Dialogs.error(AgregarCliente.this, "Error", "El cliente ya existe.", Dialog::dismiss).show();
            return;
        }


        cliente.setImagen(pathClienteImagen);


        if (paths.size() > 0) {
            for (String path: paths){
                if(!path.isEmpty()){
                    cliente.setImagen(path);
                    break;
                }
            }
        }

        imagenes.clear();
        documents.clear();

        cliente.setReferencias(adapter.referencias);

        cliente.setArchivos(documentosAdapter.documentos);

        if (cliente.getImagen() != null && !cliente.getImagen().isEmpty()) {
            imagenes.add(Functions.prepareFilePart("perfil", cliente.getImagen()));
        }

        for (Archivo a : cliente.getArchivos()) {
            documents.add(Functions.prepareFilePart(UUID.randomUUID().toString(), a.getUrl()));
        }

        Gson json = new Gson();

        System.out.println(json.toJson(cliente));

        final Dialog dialog = Functions.progressDialog(this, "Enviando solicitud... Espere un momento.");
        dialog.show();


        ///NUEVO
        //Toast.makeText(AgregarCliente.this, t.getMessage(), Toast.LENGTH_LONG).show();

        cliente.setSincronizado(false);
        cliente.setId_cliente(Functions.generateUniqueId());

        final int id_cliente = (int) db.getClienteDao().insert(cliente);

        Log.e("CLIENTE LOCAL", String.valueOf(id_cliente));
        Log.e("CANTIDAD REF CLI", String.valueOf(cliente.getReferencias().size()));
        Log.e("CANTIDAD REF ADAP", String.valueOf(adapter.referencias.size()));

        for (Referencia r : cliente.getReferencias()) {
            final int pos = cliente.getReferencias().indexOf(r);
            cliente.getReferencias().get(pos).setId(Functions.generateUniqueId());
            cliente.getReferencias().get(pos).setId_cliente(id_cliente);
            cliente.getReferencias().get(pos).setSincronizada(false);
            cliente.getReferencias().get(pos).setFecha_registro(Functions.getFecha());
            Log.e("REF ID", String.valueOf( cliente.getReferencias().get(pos).getId()));
        }

        for (Archivo a : cliente.getArchivos()) {
            final int pos = cliente.getArchivos().indexOf(a);
            cliente.getArchivos().get(pos).setId_archivo(Functions.generateUniqueId());
            cliente.getArchivos().get(pos).setId_cliente(id_cliente);
            cliente.getArchivos().get(pos).setSincronizado(false);
            cliente.getArchivos().get(pos).setFecha(Functions.getFecha());
            Log.e("DOC ID", String.valueOf(cliente.getArchivos().get(pos).getId_archivo()));
        }

        if (cliente.getArchivos() != null && cliente.getArchivos().size() > 0) {
            db.getClienteDao().insertArchivos(cliente.getArchivos());
        }

        if (cliente.getReferencias() != null && cliente.getReferencias().size() > 0) {
            db.getClienteDao().insertReferencias(cliente.getReferencias());
        }

        dialog.cancel();

        Dialogs.success(AgregarCliente.this, "Exito",
                "El cliente fue guardado exitosamente, ¡Recuerde sincronizar los datos!", kAlertDialog -> {

            kAlertDialog.dismiss();
            AgregarCliente.this.finish();

        }).show();

        //FIN NUEVO

       /* MainActivity.ws.post_cliente(cliente).enqueue(new Callback<ResponseServer>() {
            @Override
            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {

                if (response.code() == 200) {

                    //Dialogs.success(AgregarCliente.this, "Exito", "Cliente registrado exitosamente", null, null).show();
                    if (imagenes.size() > 0) {
                        MainActivity.ws.subir_imagenes(imagenes).enqueue(new Callback<ResponseServer>() {
                            @Override
                            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                                if (response.code() == 200) {
                                    dialog.cancel();
                                    //Dialogs.success(AgregarCliente.this, "Exito", "Imágenes subidas exitosamente", null, null).show();
                                    subirArchivos();
                                } else {
                                    //Dialogs.error(AgregarCliente.this, "Error", "Error al subir las imagenes", null, null).show();
                                }
                            }

                            @Override
                            public void onFailure(Call<ResponseServer> call, Throwable t) {
                                dialog.cancel();
                                Toast.makeText(AgregarCliente.this, t.getMessage(), Toast.LENGTH_LONG).show();
                                Dialogs.error(AgregarCliente.this, "Error", "Error al subir las imagenes", kAlertDialog -> {
                                    finish();
                                    AgregarCliente.this.finish();
                                }).show();
                            }
                        });
                    } else {
                        dialog.cancel();
                        subirArchivos();
                    }

                } else {
                    dialog.cancel();
                    Log.d("ERROR", "ERROR AL AGREGAR CLIENTE " + String.valueOf(response.code()));
                    Dialogs.error(AgregarCliente.this, "Error", "Error al registrar cliente", kAlertDialog -> {
                        finish();
                        AgregarCliente.this.finish();
                    }).show();
                }

            }

            @Override
            public void onFailure(Call<ResponseServer> call, Throwable t) {
                dialog.cancel();
                Toast.makeText(AgregarCliente.this, t.getMessage(), Toast.LENGTH_LONG).show();

                cliente.setSincronizado(false);
                cliente.setId_cliente((int) new Date().getTime());

                final int id_cliente = (int) db.getClienteDao().insert(cliente);

                Log.e("CLIENTE LOCAL", String.valueOf(id_cliente));

                for (Referencia r : cliente.getReferencias()) {
                    final int pos = cliente.getReferencias().indexOf(r);
                    cliente.getReferencias().get(pos).setId((int) new Date().getTime());
                    cliente.getReferencias().get(pos).setId_cliente(id_cliente);
                    cliente.getReferencias().get(pos).setSincronizada(false);
                }

                for (Archivo a : cliente.getArchivos()) {
                    final int pos = cliente.getArchivos().indexOf(a);
                    cliente.getArchivos().get(pos).setId_archivo((int) new Date().getTime());
                    cliente.getArchivos().get(pos).setId_cliente(id_cliente);
                    cliente.getArchivos().get(pos).setSincronizado(false);
                }

                if (cliente.getArchivos() != null && cliente.getArchivos().size() > 0) {
                    db.getClienteDao().insertArchivos(cliente.getArchivos());
                }

                if (cliente.getReferencias() != null && cliente.getReferencias().size() > 0) {
                    db.getClienteDao().insertReferencias(cliente.getReferencias());
                }

                Dialogs.error(AgregarCliente.this, "Error", "Error al registrar cliente. Se guardará localmente.", kAlertDialog -> {

                    kAlertDialog.dismiss();
                    AgregarCliente.this.finish();

                }).show();

            }
        });*/

    }

    private String getPathFile(String prefix, String original) {

        if (!original.isEmpty()) {
            final String name = original.substring(original.lastIndexOf("/"));
            return prefix + name;
        }

        return "";

    }

    private Cliente updateRoutesDocuments(Cliente cliente) {
        for (Archivo a : cliente.getArchivos()) {
            documents.add(Functions.prepareFilePart(UUID.randomUUID().toString(), a.getUrl()));
        }
        return cliente;
    }

    private void subirArchivos() {

        final Dialog dialog = Functions.progressDialog(this, "Subiendo Archivos...");
        dialog.show();

        if (documents.size() > 0) {
            MainActivity.ws.subir_documentos(documents).enqueue(new Callback<ResponseServer>() {
                @Override
                public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                    Toast.makeText(AgregarCliente.this, response.body().getStatus(), Toast.LENGTH_LONG).show();
                    if (response.code() == 200) {
                        Functions.getClientes(AgregarCliente.this);
                        dialog.cancel();
                        Dialogs.success(AgregarCliente.this, "Exito", "Cliente registrado exitosamente", kAlertDialog -> {
                            kAlertDialog.dismiss();
                            AgregarCliente.this.finish();
                        }).show();
                    } else {
                        dialog.cancel();
                        Dialogs.error(AgregarCliente.this, "Error", "Error al registrar cliente", kAlertDialog -> {
                            kAlertDialog.dismiss();
                            AgregarCliente.this.finish();
                        }).show();
                    }
                }

                @Override
                public void onFailure(Call<ResponseServer> call, Throwable t) {
                    dialog.cancel();
                    Toast.makeText(AgregarCliente.this, t.getMessage(), Toast.LENGTH_LONG).show();
                    Dialogs.error(AgregarCliente.this, "Error", "Error al subir los Archivos", kAlertDialog -> {
                        kAlertDialog.dismiss();
                        AgregarCliente.this.finish();
                    }).show();
                }
            });
        } else {
            dialog.cancel();
            Functions.getClientes(AgregarCliente.this);
            Dialogs.success(AgregarCliente.this, "Exito", "Cliente registrado exitosamente", kAlertDialog -> {
                kAlertDialog.dismiss();
                AgregarCliente.this.finish();
            }).show();
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
