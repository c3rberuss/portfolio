package com.c3rberuss.radiostream1;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.content.Intent;
import android.view.View.OnClickListener;
import android.support.v7.app.AppCompatActivity;

import android.support.v7.widget.CardView;
import android.view.View;
import android.widget.Toast;

import com.c3rberuss.radiostream1.R;


public class MenuActivity extends AppCompatActivity {

    CardView radioCard, programacionCard, visitarsitioCard,salirCard;
    private String RADIO_CRISTIANA1="http://radioabbaid.com/";
    private String url =RADIO_CRISTIANA1;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu_2);

        radioCard = (CardView) findViewById(R.id.radioCard);
        programacionCard = (CardView) findViewById(R.id.programacionCard);
        visitarsitioCard = (CardView) findViewById(R.id.visitarsitioCard );
        salirCard = (CardView) findViewById(R.id.salirCard );
        radioCard.setCardBackgroundColor(Color.parseColor("#607D8B"));
        programacionCard.setCardBackgroundColor(Color.parseColor("#FFC107"));
        visitarsitioCard.setCardBackgroundColor(Color.parseColor("#689F38"));
        salirCard.setCardBackgroundColor(Color.parseColor("#0097A7"));


        radioCard.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View v) {
                //Log.d("x","x");
                //Toast.makeText(getApplicationContext(), "Ir a Radio  ....", Toast.LENGTH_LONG).show();
                  Intent ven=new Intent(getApplicationContext(), MainActivity.class);
                  startActivity(ven);
                finish();

            }
        });

        programacionCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(getApplicationContext(), "Pendiente...", Toast.LENGTH_LONG).show();
            }
        });

        visitarsitioCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
       // String url = "http://www.stackoverflow.com";
        Intent i = new Intent(Intent.ACTION_VIEW);
        i.setData(Uri.parse(url));
        startActivity(i);
            }
        });
        salirCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(getApplicationContext(), "Saliendo...", Toast.LENGTH_LONG).show();
                android.os.Process.killProcess(android.os.Process.myPid());
            }
        });
    }

    }




