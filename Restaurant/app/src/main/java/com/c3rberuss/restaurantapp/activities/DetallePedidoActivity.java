package com.c3rberuss.restaurantapp.activities;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.c3rberuss.restaurantapp.MainActivity;
import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.adapters.DetalleAdapter;
import com.c3rberuss.restaurantapp.db.dao.DetallePlatilloDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDetalleDao;
import com.c3rberuss.restaurantapp.entities.DetallePlatillo;
import com.c3rberuss.restaurantapp.entities.Pedido;
import com.c3rberuss.restaurantapp.entities.ResponseServer;
import com.c3rberuss.restaurantapp.utils.Dialogs;
import com.google.gson.Gson;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class DetallePedidoActivity extends AppCompatActivity {

    private RecyclerView lista_detalles;
    private DetalleAdapter adapter;
    private List<DetallePlatillo> detallePlatillos = new ArrayList<>();
    private DetallePlatilloDao detallePlatilloDao;
    private PedidoDao pedidoDao;
    private PedidoDetalleDao detalleDao;
    private Pedido pedido;
    private Button enviar;
    private TextView total;

    private View.OnClickListener onClickListener = v -> {

        final int pos = lista_detalles.getChildAdapterPosition(v);
        final DetallePlatillo tmp = adapter.detalles.get(pos);

        Intent intent = new Intent(DetallePedidoActivity.this, DetallePlatilloActivity.class);

        Bundle bundle = new Bundle();
        bundle.putInt("id_platillo", tmp.getId_platillo());
        bundle.putInt("id_detalle", tmp.getId_detalle());
        bundle.putBoolean("editando", true);

        intent.putExtras(bundle);
        startActivity(intent);

    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detalle_pedido);

        enviar = findViewById(R.id.btnEnviarPedido);
        total = findViewById(R.id.lblTotal);

        detallePlatilloDao = MainActivity.database.getDetallePlatilloDao();
        pedidoDao = MainActivity.database.getPedidoDao();
        detalleDao = MainActivity.database.getPedidoDetalleDao();

        lista_detalles = findViewById(R.id.lista_detalle);
        adapter = new DetalleAdapter(detallePlatillos);
        adapter.setOnClickListener(onClickListener);

        lista_detalles.setAdapter(adapter);

        pedido = pedidoDao.obtenerPedidoActivo();

        if(pedido != null){

            detallePlatilloDao.getDetallePedido(pedido.getId()).observe(this, detallePlatillos-> {
                adapter.swapData(detallePlatillos);

                pedido = pedidoDao.obtenerPedidoActivo();

                if(pedido != null){
                    final String tot = "$"+String.valueOf(pedido.getTotal());
                    total.setText(tot);
                }

                if(detallePlatillos.size() < 1){
                    lista_detalles.setVisibility(View.GONE);
                    findViewById(R.id.lblNoItems).setVisibility(View.VISIBLE);
                    findViewById(R.id.subTotal).setVisibility(View.GONE);
                    findViewById(R.id.linearLayout2).setVisibility(View.GONE);
                    enviar.setVisibility(View.GONE);
                }
            });

        }else{
            lista_detalles.setVisibility(View.GONE);
            findViewById(R.id.lblNoItems).setVisibility(View.VISIBLE);
            enviar.setVisibility(View.GONE);
            findViewById(R.id.subTotal).setVisibility(View.GONE);
            findViewById(R.id.linearLayout2).setVisibility(View.GONE);
            findViewById(R.id.linearLayout2).setVisibility(View.GONE);
        }

        enviar.setOnClickListener(v->{

            Pedido pedido = pedidoDao.obtenerPedidoActivo();

            if(pedido != null){
                detalleDao.getAll(pedido.getId()).observe(DetallePedidoActivity.this, pedidoDetalles -> {
                    pedido.setDetalle(pedidoDetalles);
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    pedido.setFecha(df.format(pedido.getFecha_()));
                    new sendAsync().execute(pedido);
                });
            }

        });

    }

    class sendAsync extends AsyncTask<Pedido, Void, Void>{

        @Override
        protected Void doInBackground(Pedido... pedidos) {

            Gson gson = new Gson();

            System.out.println("JSON : " + gson.toJson(pedidos[0]));

            MainActivity.ws.post_pedido(pedidos[0]).enqueue(new Callback<ResponseServer>() {
                @Override
                public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {


                    if(response.code() == 200){

                        Pedido p = pedidos[0];
                        p.setProcesada(true);
                        pedidoDao.update(p);
                        MainActivity.updateHotCount(false);

                        Dialogs.success(DetallePedidoActivity.this, "Éxito",
                                "Se agregó a su pedido exitosamente.", null, kAlertDialog -> {
                            finish();
                        }).show();
                    }else{

                        Dialogs.error(DetallePedidoActivity.this, "Error",
                                "Ha ocurrido un error. Intente nuevamente más tarde", null, null).show();

                    }
                }

                @Override
                public void onFailure(Call<ResponseServer> call, Throwable t) {
                    System.out.println("ERROE: " + t.getMessage());
                }
            });

            return null;
        }
    }
}
