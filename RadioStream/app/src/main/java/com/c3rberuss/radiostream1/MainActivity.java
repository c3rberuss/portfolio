package com.c3rberuss.radiostream1;

//import android.support.v7.app.AppCompatActivity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;

import java.io.IOException;
import android.content.Context;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnBufferingUpdateListener;
import android.media.MediaPlayer.OnPreparedListener;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.SeekBar.OnSeekBarChangeListener;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import com.c3rberuss.radiostream1.R;

import java.util.Calendar;
import java.util.TimeZone;


public class MainActivity extends AppCompatActivity {

    private MediaPlayer player;

    
    private String RADIO_CRISTIANA1="http://streamserverperu.com:7040"; //Radio ABBA 900 AM EL SALVADOR
    //private String RADIO_CRISTIANA1="http://streamserverperu.com:7020";  //Radio Adoracion FM
    //private String RADIO_CRISTIANA1="http://158.69.200.1:8022/stream/"; //Radio ABBA 900 AM EL SALVADOR
    private String url =RADIO_CRISTIANA1;
    protected boolean isPlay = false, isSound=false;
    private ToggleButton buttonStreaming,btnSound;
    ImageView imageSplash,imgplay,imgpause,volumeImageView;
    ToggleButton tgBtn;
    private boolean init = false;


    //ventana de progreso
    private AlertDialog dialog;
    private AlertDialog.Builder no_transmision;

    //Timezone de El Salvador
    private TimeZone Sv_timeZone;
    private Calendar Sv_calendar;
    private Calendar Device_Calendar;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_2);

        no_transmision = new AlertDialog.Builder(this);
        no_transmision.setCancelable(false);
        no_transmision.setTitle("Radio ABBA 900 AM");
        no_transmision.setMessage("La radio no se encuentra transmitiendo actualmente. Revise la programación.");
        no_transmision.setPositiveButton("Volver al inicio", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Intent ven=new Intent(getApplicationContext(),MenuActivity.class);
                startActivity(ven);
                finish();
            }
        });

        Sv_timeZone = TimeZone.getTimeZone("America/El_Salvador");
        Sv_calendar = Calendar.getInstance(Sv_timeZone);

        if(Sv_calendar.get(Calendar.HOUR_OF_DAY) == 6 && Sv_calendar.get(Calendar.MINUTE) < 45){
            no_transmision.show();
        }
        if(Sv_calendar.get(Calendar.HOUR_OF_DAY) == 21 && Sv_calendar.get(Calendar.MINUTE) > 30){
            no_transmision.show();
        }

        dialog = progressDialog(this, (ViewGroup) findViewById(android.R.id.content),
                "Espere un momento ...\nConectando con la radio.");

         imageSplash=(ImageView) findViewById(R.id.imageSplash);
        //volumeImageView=(ImageView) findViewById(R.id.volumeImageView);


        // Inicializo el objeto MediaPlayer
        initializeMediaPlayer();

        // Inicializando el volumen
        initializeVolume();

        buttonStreaming = (ToggleButton) findViewById(R.id.playPauseButton);
        btnSound= (ToggleButton) findViewById(R.id.btnSound);

        buttonStreaming.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                buttonStreaming.setEnabled(false);

                if (!isPlay && !init) {
                    dialog.show();
                    startPlaying();

                    init = true;
                    isPlay = true;

                }else if(init && !isPlay) {

                    player.start();
                    imageSplash.setImageResource(R.drawable.romanos10_17);
                    Log.d("INIT && ISPLAY", "TRUE FALSE");
                    isPlay = true;
                    buttonStreaming.setEnabled(true);

                }else if(init && isPlay) {
                    stopPlaying();
                    isPlay = false;
                }

                Log.d("isPlay", String.valueOf(isPlay));
                Log.d("init", String.valueOf(init));


            }
        });
        btnSound.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View arg0) {
                btnSound.setEnabled(false);
                isSound = !isSound;
                if (isSound) {
                    startAudio();

                } else {
                    stopAudio();
                }
            }
        });

        // Agregar un floating action click handler para iniciar una nueva Activity
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (player.isPlaying()){
                    player.stop();
                    //player.pause();
                     player.release();
                    }
                Intent ven=new Intent(getApplicationContext(),MenuActivity.class);
                startActivity(ven);
                finish();

            }
        });
    }

    public void startAudio() {
        final AudioManager audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
        audioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_MUTE, /* flags= */ 0);
        btnSound.setEnabled(true);
    }

    public void stopAudio() {
        final AudioManager audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
        audioManager.adjustStreamVolume(
                AudioManager.STREAM_MUSIC, AudioManager.ADJUST_UNMUTE, /* flags= */ 0);
        btnSound.setEnabled(true);
    }

    public void stopPlaying() {
        if (player.isPlaying()){
            //player.stop();
            player.pause();
           // player.release();
            //initializeMediaPlayer();
            buttonStreaming.setEnabled(true);
            imageSplash.setImageResource(R.drawable.microfono);
        }
    }

    private void initializeVolume() {
        try {
            final SeekBar volumeBar = (SeekBar) findViewById(R.id.volumeSeekBar);
            final AudioManager audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
            final int musicVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
            volumeBar.setMax(audioManager
                    .getStreamMaxVolume(AudioManager.STREAM_MUSIC));
                       final OnSeekBarChangeListener eventListener = new OnSeekBarChangeListener() {
                @Override
                public void onStopTrackingTouch(SeekBar seekBar) {
                }

                @Override
                public void onStartTrackingTouch(SeekBar seekBar) {
                }

                @Override
                public void onProgressChanged(SeekBar seekBar, int progress,
                                              boolean fromUser) {
                    audioManager.setStreamVolume(AudioManager.STREAM_MUSIC,
                            progress, 0);
                }
            };

            volumeBar.setOnSeekBarChangeListener(eventListener);
        } catch (Exception e) {
            Log.e("MainActivity", e.getMessage());
        }
    }

    private void initializeMediaPlayer() {
        player = new MediaPlayer();

        player.setOnBufferingUpdateListener(new OnBufferingUpdateListener() {

            public void onBufferingUpdate(MediaPlayer mp, int percent) {
                Log.i("Buffering", "" + percent);
            }
        });

        player.setOnErrorListener(new MediaPlayer.OnErrorListener() {
            @Override
            public boolean onError(MediaPlayer mp, int what, int extra) {

                Log.d("ERROR", String.valueOf(what));
                dialog.cancel();
                no_transmision.setMessage("Ha ocurrido un error al intentar conectar con la radio.");
                no_transmision.show();

                return false;
            }
        });
    }

    public void startPlaying() {

        try {
//            Toast.makeText(getApplicationContext(),
//                    "Conectando con la radio, espere unos segundos...",
//                    Toast.LENGTH_LONG).show();
            //player.reset();
            player.setDataSource(url);
            //player.setAudioStreamType(AudioManager.STREAM_MUSIC);

            player.setOnPreparedListener(new OnPreparedListener() {

                public void onPrepared(MediaPlayer mp) {

                    if(dialog.isShowing()){
                        dialog.cancel();
                    }

                    player.start();
                    imageSplash.setImageResource(R.drawable.romanos10_17);
                    buttonStreaming.setEnabled(true);
                }
            });

            player.prepareAsync();

        } catch (IllegalArgumentException | SecurityException
                | IllegalStateException | IOException e) {
            Toast.makeText(getApplicationContext(),
                    "Error al conectar con la radio", Toast.LENGTH_LONG).show();
        }
    }


    //mostrar dialogo mientras carga en buffer la transmisión
    public AlertDialog progressDialog(Context context, ViewGroup group_, String text){
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setCancelable(false);
        View viewInflated = LayoutInflater.from(context).inflate(R.layout.progress_dialog_layout, group_, false);

        final TextView descripcion = viewInflated.findViewById(R.id.texto_dialogo);

        descripcion.setText(text);

        builder.setView(viewInflated);
        return builder.create();

    }

}