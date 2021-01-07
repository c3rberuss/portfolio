package com.c3rberuss.restaurantapp.providers;

import com.c3rberuss.restaurantapp.entities.Categoria;
import com.c3rberuss.restaurantapp.entities.Pedido;
import com.c3rberuss.restaurantapp.entities.ResponseServer;
import com.c3rberuss.restaurantapp.entities.Usuario;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;

public interface WebService {

    public static String SERVER_URL = "http://pedidos.apps-oss.com/";

    @GET("obtener_categorias.php")
    public Call<List<Categoria>> get_categorias();

    @POST("procesar_pedido.php")
    public Call<ResponseServer> post_pedido(@Body Pedido pedido);

    @POST("login_app.php")
    public Call<Usuario> login(@Body Usuario usuario);

    @POST("procesar_usuario.php")
    public Call<Usuario> registrar(@Body Usuario usuario);
}
