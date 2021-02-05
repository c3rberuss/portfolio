package com.c3rberuss.services

import android.annotation.TargetApi
import android.app.NotificationChannel
import android.app.NotificationManager
import android.net.Uri
import android.os.Build
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        this.registerChannel()
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    override fun registerWith(registry: PluginRegistry?) {
        registry?.let { FirebaseCloudMessagingPluginRegistrant.registerWith(it) };
    }

    @TargetApi(Build.VERSION_CODES.O)
    private fun registerChannel(){
        val channel: NotificationChannel = NotificationChannel(
                getString(R.string.default_notification_channel_id),
                "Tire Services",
                NotificationManager.IMPORTANCE_HIGH
        ).also {

            it.setSound(Uri.parse("android.resource://${packageName}/${R.raw.car}"), it.audioAttributes)
        }
        val manager:NotificationManager = getSystemService(NotificationManager::class.java) as NotificationManager
        manager.createNotificationChannel(channel)
    }
}