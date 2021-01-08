package com.c3rberuss.crediapp.providers;

import com.google.gson.GsonBuilder;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class ApiProvider {

    private static WebService webService;
    private static Retrofit retrofit;
    private static OkHttpClient okHttpClient;

    public static synchronized WebService getWebService(){
        if(webService == null){

/*            okHttpClient = new OkHttpClient.Builder()
                    .connectTimeout(5, TimeUnit.MINUTES)
                    .readTimeout(3, TimeUnit.MINUTES)
                    .writeTimeout(3, TimeUnit.MINUTES)
                    .build();*/

            retrofit = new Retrofit.Builder().baseUrl(WebService.SERVER_URL)
                    .client(createRequestInterceptorClient())
                    .addConverterFactory(GsonConverterFactory.create(new GsonBuilder().serializeNulls().create()))
                    .build();

            webService = retrofit.create(WebService.class);
        }

        return webService;
    }

    private static OkHttpClient createRequestInterceptorClient(){
        final Interceptor interceptor = new Interceptor() {
            @Override
            public Response intercept(Chain chain) throws IOException {
                final Response response = chain.proceed(chain.request());

                //System.out.println(response.body().string());

                return response;
            }
        };

        return new OkHttpClient.Builder()
                .connectTimeout(5, TimeUnit.MINUTES)
                .readTimeout(3, TimeUnit.MINUTES)
                .writeTimeout(3, TimeUnit.MINUTES)
                .addInterceptor(interceptor)
                .addInterceptor(new HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY))
                .build();
    }

}
