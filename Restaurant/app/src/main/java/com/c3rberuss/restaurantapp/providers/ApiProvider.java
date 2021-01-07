package com.c3rberuss.restaurantapp.providers;

import com.google.gson.GsonBuilder;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class ApiProvider {

    private static WebService ws;
    private static Retrofit retrofit;

    public static WebService getInstance(){
        if(retrofit == null){
            retrofit = new Retrofit.Builder().baseUrl(WebService.SERVER_URL)
                    .addConverterFactory(GsonConverterFactory.create(new GsonBuilder().serializeNulls().create()))
                    .build();

            ws = retrofit.create(WebService.class);
        }

        return ws;
    }

}
