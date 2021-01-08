package com.c3rberuss.crediapp.utils;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.location.Location;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiManager;
import android.os.BatteryManager;
import android.os.Build;
import android.os.IBinder;
import android.os.Looper;
import android.os.SystemClock;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;
import androidx.core.content.ContextCompat;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.ResponseServer;
import com.c3rberuss.crediapp.providers.ApiProvider;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.LocationSettingsRequest;


import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import static androidx.core.app.NotificationCompat.PRIORITY_LOW;

public class TrackingService extends Service {

    private static final String TAG = TrackingService.class.getSimpleName();
    double latitude;
    double longitude;
    BatteryManager bm;
    NotificationCompat.Builder mBuilder;
    Notification notification;
    LocationRequest request;

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();

        String channel;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
            channel = createChannel();
        else {
            channel = "";
        }

        mBuilder = new NotificationCompat.Builder(getApplicationContext(), channel).setSmallIcon(R.drawable.logo).setContentTitle("RUNNING APP");
        notification = mBuilder
                .setPriority(PRIORITY_LOW)
                .setCategory(Notification.CATEGORY_SERVICE)
                .build();

        startForeground(9999, notification);

        request = new LocationRequest();
        bm = (BatteryManager)getSystemService(BATTERY_SERVICE);
        request.setInterval(60000);
        request.setFastestInterval(60000);
        request.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);

        final LocationSettingsRequest.Builder builder = new LocationSettingsRequest.Builder();
        builder.addLocationRequest(request);
        final LocationSettingsRequest locationSettingsRequest = builder.build();


        //Save the location data to the database//
       final LocationCallback locationCallback = new LocationCallback() {
            @Override
            public void onLocationResult(LocationResult locationResult) {
                super.onLocationResult(locationResult);
                Location location = locationResult.getLastLocation();
                if (location != null) {
                    //Save the location data to the database//
                    latitude = location.getLatitude();
                    longitude = location.getLongitude();
                    Log.e("BATTERY", String.valueOf(bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)));
                    subirCoordenadas(latitude, longitude);
                }

            }
        };

       final FusedLocationProviderClient mFusedLocationClient = LocationServices.getFusedLocationProviderClient(getApplicationContext());
        mFusedLocationClient.requestLocationUpdates(request, locationCallback, Looper.myLooper());

    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        return START_STICKY;
    }

    @Override
    public void onTaskRemoved(Intent rootIntent) {

        Intent restartService = new Intent(getApplicationContext(),
                this.getClass());

        restartService.setPackage(getPackageName());
        PendingIntent restartServicePI = PendingIntent.getService(
                getApplicationContext(), 1, restartService,
                PendingIntent.FLAG_ONE_SHOT);

        //Restart the service once it has been killed android
        AlarmManager alarmService = (AlarmManager) getApplicationContext().getSystemService(Context.ALARM_SERVICE);
        alarmService.set(AlarmManager.ELAPSED_REALTIME_WAKEUP, SystemClock.elapsedRealtime() + (60 * 1000), restartServicePI);
    }

    protected BroadcastReceiver stopReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            unregisterReceiver(stopReceiver);
            stopSelf();
        }
    };

    public void subirCoordenadas(double lattitude, double longitude){

        int id_usuario = AppDatabase.getInstance(getBaseContext()).getUsuarioDao().getId();
        int bateria = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        //TODO: upload coords to server

        ApiProvider.getWebService().ubicacion(lattitude, longitude, id_usuario, bateria).enqueue(new Callback<ResponseServer>() {
            @Override
            public void onResponse(Call<ResponseServer> call, Response<ResponseServer> response) {
                //System.out.println(response.body().getMessage());
                System.out.println(response.code());
            }

            @Override
            public void onFailure(Call<ResponseServer> call, Throwable t) {
                System.out.println(t.toString());
            }
        });

        Log.e("COORDS", "LAT="+ lattitude + " : LON="+ longitude);
    }

    @NonNull
    @TargetApi(26)
    private synchronized String createChannel() {
        NotificationManager mNotificationManager = (NotificationManager) this.getSystemService(Context.NOTIFICATION_SERVICE);
        String name = "CREDI MASTER";
        int importance = NotificationManager.IMPORTANCE_LOW;
        NotificationChannel mChannel = new NotificationChannel("crediapp-channel", name, importance);
        mChannel.enableLights(true);
        mChannel.setLightColor(Color.BLUE);

        if (mNotificationManager != null) {
            mNotificationManager.createNotificationChannel(mChannel);
        } else {
            stopSelf();
        }
        return "crediapp-channel";
    }
}