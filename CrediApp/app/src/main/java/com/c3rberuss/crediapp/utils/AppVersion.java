package com.c3rberuss.crediapp.utils;

import androidx.room.ColumnInfo;

import com.c3rberuss.crediapp.BuildConfig;
import com.google.gson.annotations.SerializedName;

public interface AppVersion {
    @ColumnInfo(name = "app_version")
    @SerializedName("app_version")
    String APP_VERSION = BuildConfig.VERSION_NAME;
}
