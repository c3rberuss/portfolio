package com.c3rberuss.restaurantapp;

import android.app.Application;

import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.mapbox.mapboxsdk.Mapbox;
import com.mapbox.mapboxsdk.plugins.places.picker.PlacePicker;

public class App extends Application {

    private AppDatabase database;

    @Override
    public void onCreate() {
        super.onCreate();
        Mapbox.getInstance(getApplicationContext(), "pk.eyJ1IjoiYzNyYmVydXNzIiwiYSI6ImNqeGJmdzN3aDA0dnMzem1tOTQzd20yZGEifQ.LKXwC9gJiLNCvBMR7Su4Jg");
    }

    public AppDatabase getDatabase() {
        return database;
    }

    public void setDatabase(AppDatabase database) {
        this.database = database;
    }
}
