package com.c3rberuss.crediapp.utils;

import java.io.IOException;

import okhttp3.Interceptor;
import okhttp3.Request;
import okhttp3.Response;

class InterceptorRequest implements Interceptor {

    @Override
    public Response intercept(Chain chain) throws IOException {

        final Request request = chain.request();

        System.out.println(request.body());

        return chain.proceed(request);
    }
}