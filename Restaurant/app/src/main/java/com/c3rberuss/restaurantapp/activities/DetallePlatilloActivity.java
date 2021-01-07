package com.c3rberuss.restaurantapp.activities;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.c3rberuss.restaurantapp.MainActivity;
import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.db.dao.PedidoDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDetalleDao;
import com.c3rberuss.restaurantapp.db.dao.PlatilloDao;
import com.c3rberuss.restaurantapp.db.dao.UsuarioDao;
import com.c3rberuss.restaurantapp.entities.DetallePlatillo;
import com.c3rberuss.restaurantapp.entities.Pedido;
import com.c3rberuss.restaurantapp.entities.PedidoDetalle;
import com.c3rberuss.restaurantapp.entities.Platillo;
import com.c3rberuss.restaurantapp.entities.Usuario;
import com.c3rberuss.restaurantapp.providers.WebService;
import com.c3rberuss.restaurantapp.utils.Dialogs;
import com.c3rberuss.restaurantapp.utils.Functions;
import com.developer.kalert.KAlertDialog;
import com.squareup.picasso.Picasso;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.Date;

public class DetallePlatilloActivity extends AppCompatActivity {

    private TextView descripcion, nombre, precio,cantidad;
    private ImageView imagen;
    private EditText notas;
    private ImageButton mas, menos;
    private Button agregar_pedido;
    private PlatilloDao platilloDao;
    private PedidoDao pedidoDao;
    private PedidoDetalleDao pedidoDetalleDao;
    private UsuarioDao usuarioDao;
    private int id_platillo = -1;
    private int qty = 1;
    private DecimalFormat df = new DecimalFormat("######.##");
    private Platillo platillo;
    private Usuario usuario;
    private Pedido pedido;
    private boolean editando = false;
    private PedidoDetalle detallePlatillo;
    private int id_detalle = 0;
    private int qty_2 = 0;
    KAlertDialog dialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detalle_platillo);

        dialog = Dialogs.success(this, "Éxito", "Se agregó a su pedido exitosamente.", null, kAlertDialog -> {
            this.finish();
        });

        df.setRoundingMode(RoundingMode.CEILING);

        id_platillo = getIntent().getExtras().getInt("id_platillo");
        editando = getIntent().getExtras().getBoolean("editando");
        id_detalle = getIntent().getExtras().getInt("id_detalle");

        imagen = findViewById(R.id.imagen_platillo);
        nombre = findViewById(R.id.lblNombrePlatillo);
        precio = findViewById(R.id.lblPrecioPlatillo);
        descripcion = findViewById(R.id.lblDescripcionPlatillo);

        notas = findViewById(R.id.txtNotaPlatillo);
        mas = findViewById(R.id.btnPlusQty);
        menos = findViewById(R.id.btnMinusQty);
        cantidad = findViewById(R.id.lblCantidadDetalle);

        agregar_pedido = findViewById(R.id.btnAgregarAorden);

        platilloDao = MainActivity.database.getPlatilloDao();
        usuarioDao = MainActivity.database.getUsuarioDao();

        pedidoDao = MainActivity.database.getPedidoDao();
        pedidoDetalleDao = MainActivity.database.getPedidoDetalleDao();

        pedido = pedidoDao.obtenerPedidoActivo();

        usuario = usuarioDao.getUsuarioActivo();



        platilloDao.get(id_platillo).observe(this, plat -> {

            platillo = plat;

            if(editando){
                detallePlatillo = pedidoDetalleDao.getDetalle(id_detalle);
                cantidad.setText(Functions.intToString2Digits(detallePlatillo.getCantidad()));
                qty = detallePlatillo.getCantidad();
                qty_2 = detallePlatillo.getCantidad();
            }

            Picasso.get().load(WebService.SERVER_URL + platillo.getImagen())
                    .error(R.drawable.food)
                    .centerCrop()
                    .fit()
                    .into(imagen);

            nombre.setText(platillo.getNombre());
            descripcion.setText(platillo.getDescripcion());
            precio.setText(String.format("$%s", df.format(platillo.getPrecio())));
            cantidad.setText(Functions.intToString2Digits(qty));

            updateSubTotal();

        });


        menos.setOnClickListener(v->{
            if(qty > 1){
                qty--;
                cantidad.setText(Functions.intToString2Digits(qty));
                updateSubTotal();
            }
        });

        mas.setOnClickListener(v->{
            if (qty<51){
                qty++;
                cantidad.setText(Functions.intToString2Digits(qty));
                updateSubTotal();
            }
        });

        agregar_pedido.setOnClickListener(v->{

            CrearOactualizarPedido();

            PedidoDetalle pedidoDetalle = pedidoDetalleDao.getDetalle(platillo.getId_platillo(), pedido.getId());

            if(pedidoDetalle == null){

                pedidoDetalle = new PedidoDetalle();
                pedidoDetalle.setCantidad(qty);
                pedidoDetalle.setId_pedido(pedido.getId());
                pedidoDetalle.setSubtotal(qty*platillo.getPrecio());
                pedidoDetalle.setId_platillo_detalle(platillo.getId_platillo());
                pedidoDetalle.setNota(notas.getText().toString());

                pedidoDetalleDao.insert(pedidoDetalle);

                System.out.println("CREADO EXITOSAMENTE");
                //Log.d("DETALLE", )

                Log.d("COUNT->", String.valueOf(pedidoDetalleDao.getCount(pedido.getId())));
                MainActivity.updateHotCount(true);

            }else{

                if (editando){

                    pedidoDetalle.setSubtotal(qty * platillo.getPrecio());
                    pedidoDetalle.setCantidad(qty);

                }else{
                    //                pedidoDetalle.setNota(notas.getText().toString());
                    pedidoDetalle.setSubtotal( pedidoDetalle.getSubtotal() + (qty * platillo.getPrecio()) );
                    pedidoDetalle.setCantidad(qty + pedidoDetalle.getCantidad());
                }

                pedidoDetalleDao.update(pedidoDetalle);

                System.out.println("Actualizando detalle");

                Log.d("COUNT->", String.valueOf(pedidoDetalleDao.getCount(pedido.getId())));

            }



            System.out.println("Insertado Correctamente");

            dialog.show();

        });

    }

    private void updateSubTotal(){

        final double subtotal = qty * platillo.getPrecio();
        final String text = "AGREGAR "+Functions.intToString2Digits(qty)+" A LA ORDEN - $"+ df.format(subtotal);
        agregar_pedido.setText(text);

    }

    private void CrearOactualizarPedido(){

        if(pedido == null){

            pedido = new Pedido();
            pedido.setFecha_(new Date());
            pedido.setTotal(qty * platillo.getPrecio());
            pedido.setId_usuario(usuario.getId());
            pedido.setProcesada(false);

            int id_pedido = (int) pedidoDao.insert(pedido);
            pedido = pedidoDao.obtenerPedidoActivo();

        }else{

            pedido.setTotal(pedido.getTotal() + (qty*platillo.getPrecio()));
            pedido.setTotal(pedido.getTotal() - (qty_2 * platillo.getPrecio()));
            pedidoDao.update(pedido);

        }
    }

}
