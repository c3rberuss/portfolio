package com.c3rberuss.restaurantapp.activities;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.c3rberuss.restaurantapp.MainActivity;
import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.entities.Usuario;
import com.c3rberuss.restaurantapp.providers.ApiProvider;
import com.c3rberuss.restaurantapp.utils.Functions;
import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.GraphRequest;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
import com.google.gson.Gson;
import com.himanshurawat.hasher.HashType;
import com.himanshurawat.hasher.Hasher;

import org.json.JSONException;

import java.util.Arrays;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class LoginActivity extends AppCompatActivity {

    @BindView(R.id.email)
    EditText email;
    @BindView(R.id.password)
    EditText password;
    @BindView(R.id.login)
    Button login;
    @BindView(R.id.btnFacebook)
    Button btnFacebook;
    @BindView(R.id.txtRegistrar)
    TextView txtRegistrar;

    private CallbackManager callbackManager;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        ButterKnife.bind(this);

        callbackManager = CallbackManager.Factory.create();

        LoginManager.getInstance().registerCallback(callbackManager,
                new FacebookCallback<LoginResult>() {
                    @Override
                    public void onSuccess(LoginResult loginResult) {


                        GraphRequest request = GraphRequest.newMeRequest(
                                loginResult.getAccessToken(),
                                (object, response) -> {

                                    final Usuario usuario = new Usuario();
                                    try {
                                        usuario.setNombre(object.getString("name"));
                                        usuario.setCorreo(object.getString("email"));
                                        usuario.setPwd(Hasher.Companion.hash(object.getString("id"), HashType.MD5));
                                    } catch (JSONException e) {
                                        e.printStackTrace();
                                    }
                                    usuario.setFb(true);

                                    loginFunc(usuario);

                                    //goToMain();

                                });
                        Bundle parameters = new Bundle();
                        parameters.putString("fields", "id, name, email");
                        request.setParameters(parameters);
                        request.executeAsync();
                    }

                    @Override
                    public void onCancel() {
                        // App code
                    }

                    @Override
                    public void onError(FacebookException exception) {
                        // App code
                    }
                });

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        callbackManager.onActivityResult(requestCode, resultCode, data);

        if(requestCode == 666 && resultCode == RESULT_OK){

            goToMain();

        }

    }

    @OnClick(R.id.login)
    public void onViewClicked() {

        final Usuario usuario = new Usuario();
        usuario.setCorreo(email.getText().toString());
        usuario.setPwd(Hasher.Companion.hash(password.getText().toString(), HashType.MD5));
        usuario.setFb(false);

        loginFunc(usuario);

    }

    public void goToMain() {
        final Intent intent = new Intent(this, MainActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
        startActivity(intent);
        this.finish();
    }

    @OnClick(R.id.btnFacebook)
    public void Login() {

        LoginManager.getInstance().logInWithReadPermissions(this, Arrays.asList("public_profile"));

    }

    private void loginFunc(Usuario usuario) {

        Gson gson = new Gson();

        System.out.println(gson.toJson(usuario));

        ApiProvider.getInstance().login(usuario).enqueue(new Callback<Usuario>() {
            @Override
            public void onResponse(Call<Usuario> call, Response<Usuario> response) {
                if (response.code() == 200) {
                    Functions.iniciarSesion();

                    final Usuario u = response.body();
                    u.setActivo(true);

                    AppDatabase.getInstance(LoginActivity.this)
                            .getUsuarioDao()
                            .insert(u);

                    Log.e("LOGIN", "EXITO");
                    goToMain();
                } else {
                    Log.e("LOGIN", "ERROR " + String.valueOf(response.code()));
                }
            }

            @Override
            public void onFailure(Call<Usuario> call, Throwable t) {
                Log.e("LOGIN", t.getMessage());
            }
        });
    }

    @OnClick(R.id.txtRegistrar)
    public void Registrar() {

        final Intent intent = new Intent(this, RegistroActivity.class);
        startActivityForResult(intent, 666);

    }
}
