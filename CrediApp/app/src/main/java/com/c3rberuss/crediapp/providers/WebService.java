package com.c3rberuss.crediapp.providers;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.Cobro;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.entities.Departamento;
import com.c3rberuss.crediapp.entities.Frecuencia;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.Parentezco;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.entities.Requisito;
import com.c3rberuss.crediapp.entities.ResponseServer;
import com.c3rberuss.crediapp.entities.SolicitudCredito;
import com.c3rberuss.crediapp.entities.Usuario;
import com.google.gson.JsonObject;

import java.util.List;

import okhttp3.MultipartBody;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.Headers;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.Part;
import retrofit2.http.Query;

public interface WebService {

    public static final String SERVER_URL = "http://192.168.1.18/finanzas/api/";
    public static final String ROOT_URL = "http://192.168.1.18/finanzas/";


    @GET("obtener_frecuencia.php")
    public Call<List<Frecuencia>> get_frecuencias();

    @POST("enviar_solicitud.php")
    @Headers({"Content-Type: application/json"})
    public Call<ResponseServer> post_solicitud(@Body SolicitudCredito solicitud );

    @GET("obtener_planes.php")
    public Call<List<Plan>> get_planes();

    @GET("obtener_clientes.php")
    public Call<List<Cliente>> get_clientes();

    @GET("obtener_departamentos.php")
    public Call<List<Departamento>> get_departamentos();

    @GET("obtener_parentezco.php")
    public Call<List<Parentezco>> get_parentezco();

    @Multipart
    @POST("subir_archivos.php")
    public Call<ResponseServer> post_multifiles(@Part List<MultipartBody.Part> images);

    @POST("registrar_cliente.php")
    @Headers({"Content-Type: application/json"})
    public Call<ResponseServer> post_cliente(@Body Cliente cliente);

    @Multipart
    @POST("subir_documentos.php")
    public Call<ResponseServer> subir_documentos(@Part List<MultipartBody.Part> docs);

    @Multipart
    @POST("subir_documento.php")
    public Call<ResponseServer> subir_documento(@Part MultipartBody.Part docs);

    @Multipart
    @POST("subir_imagen.php")
    public Call<ResponseServer> subir_imagen(@Part MultipartBody.Part imagen);


    @Multipart
    @POST("subir_imagenes.php")
    public Call<ResponseServer> subir_imagenes(@Part List<MultipartBody.Part> images);

    @FormUrlEncoded
    @POST("auth_app.php")
    public Call<Usuario> auth(@Field("usuario") String usuario, @Field("pwd") String pwd);


    @GET("obtener_prestamos.php")
    public Call<List<Prestamo>> obtener_prestamos();

    @GET("obtener_cobros.php")
    public Call<List<Cobro>> obtener_cobros();

    @POST("enviar_prestamos.php")
    public Call<Prestamo> enviar_prestamos(@Body JsonObject obj);

    @POST("enviar_prestamo_det.php")
    public Call<PrestamoDetalle> enviar_prestamo_det(@Body JsonObject obj);


    @POST("enviar_prestamos_2.php")
    public Call<Prestamo> enviar_prestamos(@Body List<Prestamo> prestamos);

    @GET("obtener_solicitudes.php")
    public Call<List<SolicitudCredito>> obtener_solicitudes();

    @GET("obtener_requisitos.php")
    public Call<List<Requisito>> obtener_requisitos();

    @POST("enviar_refinanciamiento.php")
    @Headers({"Content-Type: application/json"})
    public Call<ResponseServer> enviar_refinanciamiento(@Body SolicitudCredito solicitud );

    @GET("obtener_mora.php")
    public Call<List<Mora>> get_mora();

    @GET("validar_version_app.php?app_version="+ BuildConfig.VERSION_NAME)
    public Call<ResponseServer> validar();

    @POST("abonar_cuota.php")
    public Call<Prestamo> enviar_abonos(@Body Prestamo prestamo);

    //@POST("enviar_prestamo_2.php")
    @POST("abonar_cuota_2.php")
    public Call<Prestamo> enviar_prestamo(@Body Prestamo prestamo);

    @GET("obtener_cobros_realizados.php?")
    public Call<List<CobroProcesado>> obtener_cobros_realizados(@Query("id_cobrador") int id_cobrador);

    @FormUrlEncoded
    @POST("actualizar_ubicacion.php")
    public Call<ResponseServer> ubicacion(@Field("lat") double lati, @Field("long") double longi, @Field("id_usuario") int id, @Field("bateria") int bateria);
}
