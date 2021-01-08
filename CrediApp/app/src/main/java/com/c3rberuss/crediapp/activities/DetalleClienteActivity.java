package com.c3rberuss.crediapp.activities;

import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Switch;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.DocumentosAdapter;
import com.c3rberuss.crediapp.adapters.ReferenciasAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Archivo;
import com.c3rberuss.crediapp.entities.Referencia;
import com.c3rberuss.crediapp.providers.WebService;
import com.c3rberuss.crediapp.utils.Functions;
import com.google.android.material.textfield.TextInputEditText;
import com.google.android.material.textfield.TextInputLayout;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import br.com.sapereaude.maskedEditText.MaskedEditText;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class DetalleClienteActivity extends AppCompatActivity {

    @BindView(R.id.foto_cliente)
    ImageView fotoCliente;
    @BindView(R.id.btnCapturarImagenCliente)
    ImageButton btnCapturarImagenCliente;
    @BindView(R.id.textView16)
    TextView textView16;
    @BindView(R.id.txtNombreCliente)
    TextInputEditText txtNombreCliente;
    @BindView(R.id.txtProfesion)
    TextInputEditText txtProfesion;
    @BindView(R.id.txtFechaNacimiento)
    TextInputEditText txtFechaNacimiento;
    @BindView(R.id.txtDepartamentoCliente)
    TextInputEditText txtDepartamentoCliente;
    @BindView(R.id.txtMunicipioCliente)
    TextInputEditText txtMunicipioCliente;
    @BindView(R.id.txtDireccionCliente)
    TextInputEditText txtDireccionCliente;
    @BindView(R.id.txtDuiCliente)
    MaskedEditText txtDuiCliente;
    @BindView(R.id.txtNitCliente)
    MaskedEditText txtNitCliente;
    @BindView(R.id.txtTelefonoCliente1)
    MaskedEditText txtTelefonoCliente1;
    @BindView(R.id.txtTelefonoCliente2)
    MaskedEditText txtTelefonoCliente2;
    @BindView(R.id.txtCorreoCliente)
    TextInputEditText txtCorreoCliente;
    @BindView(R.id.switchNegocio)
    Switch switchNegocio;
    @BindView(R.id.txtNombreNegocio)
    TextInputEditText txtNombreNegocio;
    @BindView(R.id.l_n)
    TextInputLayout lN;
    @BindView(R.id.txtActividadNegocio)
    TextInputEditText txtActividadNegocio;
    @BindView(R.id.l_a)
    TextInputLayout lA;
    @BindView(R.id.txtDireccionNegocio)
    TextInputEditText txtDireccionNegocio;
    @BindView(R.id.l_d)
    TextInputLayout lD;
    @BindView(R.id.inputs)
    LinearLayout inputs;
    @BindView(R.id.card_fiador)
    CardView cardFiador;
    @BindView(R.id.textView9)
    TextView textView9;
    @BindView(R.id.btnAgregarReferencia)
    ImageButton btnAgregarReferencia;
    @BindView(R.id.divider)
    View divider;
    @BindView(R.id.lista_referencias)
    RecyclerView listaReferencias;
    @BindView(R.id.textView10)
    TextView textView10;
    @BindView(R.id.btnAgregarDocumento)
    ImageButton btnAgregarDocumento;
    @BindView(R.id.divider2)
    View divider2;
    @BindView(R.id.lista_documentos)
    RecyclerView listaDocumentos;
    @BindView(R.id.btnRegistrarCliente)
    Button btnRegistrarCliente;
    @BindView(R.id.cardReferencias)
    CardView cardReferencias;
    @BindView(R.id.cardDocumentos)
    CardView cardDocumentos;


    private List<Referencia> referencias = new ArrayList<>();
    private List<Archivo> documentos = new ArrayList<>();

    private ReferenciasAdapter ref_adapter = new ReferenciasAdapter(1);
    private DocumentosAdapter doc_adapter = new DocumentosAdapter(1);

    private boolean editando_referencia = false;
    private boolean editando_documento = false;

    private View.OnClickListener onClickListenerRef = view -> {

        editando_referencia = true;
        int position = listaReferencias.indexOfChild(view);
        final Referencia tmp = ref_adapter.referencias.get(position);

        mostrarReferenciaDialogo(tmp);

    };

    private View.OnClickListener onClickListenerDoc = view -> {
        editando_documento = true;
        int position = listaDocumentos.indexOfChild(view);
        final Archivo tmp = doc_adapter.documentos.get(position);

        mostrarDocumentoDialogo(tmp);
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detalle_cliente);
        ButterKnife.bind(this);
        setTitle("Expediente del cliente");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);


        final Intent intent = getIntent();
        final int id_cliente = intent.getIntExtra("id_cliente", -1);

        btnRegistrarCliente.setVisibility(View.GONE);
        btnCapturarImagenCliente.setVisibility(View.GONE);
        btnAgregarDocumento.setVisibility(View.GONE);
        btnAgregarReferencia.setVisibility(View.GONE);

        switchNegocio.setVisibility(View.GONE);

        txtMunicipioCliente.setEnabled(true);

        txtNombreCliente.setKeyListener(null);
        txtProfesion.setKeyListener(null);
        txtFechaNacimiento.setKeyListener(null);
        txtDepartamentoCliente.setKeyListener(null);
        txtMunicipioCliente.setKeyListener(null);
        txtDireccionCliente.setKeyListener(null);
        txtDuiCliente.setKeyListener(null);
        txtNitCliente.setKeyListener(null);
        txtTelefonoCliente1.setKeyListener(null);
        txtTelefonoCliente2.setKeyListener(null);
        txtCorreoCliente.setKeyListener(null);

        txtNombreNegocio.setKeyListener(null);
        txtActividadNegocio.setKeyListener(null);
        txtDireccionNegocio.setKeyListener(null);

        AppDatabase.getInstance(this).getClienteDao().getClienteLive(id_cliente).observe(this, cliente -> {

            if (cliente.getImagen() != null && !cliente.getImagen().isEmpty()) {

                if(cliente.isSincronizado()){
                    Picasso.get().load(WebService.ROOT_URL + cliente.getImagen())
                            .placeholder(R.drawable.nodisp)
                            .error(R.drawable.nodisp)
                            .into(fotoCliente);
                }else{
                    Picasso.get().load(new File(cliente.getImagen()))
                            .placeholder(R.drawable.nodisp)
                            .error(R.drawable.nodisp)
                            .into(fotoCliente);
                }

            }

            txtNombreCliente.setText(cliente.getNombre());
            txtProfesion.setText(cliente.getProfesion());
            txtFechaNacimiento.setText(Functions.fechaDMY(cliente.getFecha_nacimiento()));
            txtDepartamentoCliente.setText(AppDatabase.getInstance(this).getDepartamentoDao().getDepa(cliente.getDepartamento()));
            txtMunicipioCliente.setText(AppDatabase.getInstance(this).getMunicipioDao().getMuni(cliente.getMunicipio()));
            txtDireccionCliente.setText(cliente.getDireccion());
            txtDuiCliente.setText(cliente.getDui());
            txtNitCliente.setText(cliente.getNit());
            txtTelefonoCliente1.setText(cliente.getTelefono());
            txtTelefonoCliente2.setText(cliente.getTelefono2());
            txtCorreoCliente.setText(cliente.getCorreo());

            if (cliente.getNegocio() != null && !cliente.getNegocio().isEmpty() &&
                    cliente.getActividad_negocio() != null && !cliente.getActividad_negocio().isEmpty() &&
                    cliente.getDireccion_negocio() != null && !cliente.getDireccion_negocio().isEmpty()) {

                txtNombreNegocio.setText(cliente.getNegocio());
                txtActividadNegocio.setText(cliente.getActividad_negocio());
                txtDireccionNegocio.setText(cliente.getDireccion_negocio());

            } else {
                cardFiador.setVisibility(View.GONE);
            }

            ref_adapter.swapData(AppDatabase.getInstance(this).getClienteDao().getReferenciasByCliente(id_cliente));

            listaReferencias.setAdapter(ref_adapter);
            ref_adapter.setOnClickListener(onClickListenerRef);

            if (ref_adapter.referencias.size() < 1) {
                cardReferencias.setVisibility(View.GONE);
            }

            doc_adapter.swapData(AppDatabase.getInstance(this).getClienteDao().getArchivosByCliente(id_cliente));
            listaDocumentos.setAdapter(doc_adapter);
            doc_adapter.setOnClickListener(onClickListenerDoc);

            if (doc_adapter.documentos.size() < 1) {
                cardDocumentos.setVisibility(View.GONE);
            }
        });
    }

    private void mostrarReferenciaDialogo(Referencia ref) {

        final Dialog dialog = new Dialog(this);
        dialog.setContentView(R.layout.ver_referencia_layout);
        Window window = dialog.getWindow();
        window.setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);

        final ViewHolderRef holder = new ViewHolderRef(dialog);

        holder.txtNombreReferencia.setKeyListener(null);
        holder.txtTelefonoReferencia.setKeyListener(null);
        holder.txtParentezcoReferencia.setKeyListener(null);

        holder.txtNombreReferencia.setText(ref.getNombre());
        holder.txtTelefonoReferencia.setText(ref.getTelefono());
        holder.txtParentezcoReferencia.setText(ref.getParentezco());

        dialog.show();

    }

    private void mostrarDocumentoDialogo(Archivo archivo) {

        final Dialog dialog = new Dialog(this);

        dialog.setContentView(R.layout.ver_documento_layout);
        Window window = dialog.getWindow();
        window.setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);

        final ViewHolderDoc holder = new ViewHolderDoc(dialog);

        holder.txtNombreDocumento.setKeyListener(null);
        holder.txtDescripcionDocumento.setKeyListener(null);

        holder.txtNombreDocumento.setText(archivo.getNombre());
        holder.txtDescripcionDocumento.setText(archivo.getDescripcion());

        if(archivo.isSincronizado()){
            Picasso.get().load(WebService.ROOT_URL+archivo.getUrl())
                    .error(R.drawable.nodisp)
                    .into(holder.imagenDocumento);
        }else{
            Picasso.get().load(new File(archivo.getUrl()))
                    .error(R.drawable.nodisp)
                    .into(holder.imagenDocumento);
        }


        dialog.show();

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }

    class ViewHolderRef {
        @BindView(R.id.txtNombreReferencia)
        TextInputEditText txtNombreReferencia;
        @BindView(R.id.txtTelefonoReferencia)
        MaskedEditText txtTelefonoReferencia;
        @BindView(R.id.txtParentezcoReferencia)
        TextInputEditText txtParentezcoReferencia;
        @BindView(R.id.btnGuardarReferencia)
        Button btnGuardarReferencia;

        Dialog dialog;

        ViewHolderRef(Dialog dialog) {
            ButterKnife.bind(this, dialog);
            this.dialog = dialog;
        }

        @OnClick(R.id.btnGuardarReferencia)
        void cerrar() {
            dialog.dismiss();
        }
    }

    class ViewHolderDoc {
        @BindView(R.id.imagen_documento)
        ImageView imagenDocumento;
        @BindView(R.id.txtNombreDocumento)
        TextInputEditText txtNombreDocumento;
        @BindView(R.id.txtDescripcionDocumento)
        TextInputEditText txtDescripcionDocumento;
        @BindView(R.id.btnCerrar)
        Button btnCerrar;

        Dialog dialog;

        ViewHolderDoc(Dialog dialog) {
            ButterKnife.bind(this, dialog);
            this.dialog = dialog;
        }

        @OnClick(R.id.btnCerrar)
        void cerrar() {
            dialog.dismiss();
        }
    }
}
