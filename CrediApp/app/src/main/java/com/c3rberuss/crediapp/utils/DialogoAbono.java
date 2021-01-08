package com.c3rberuss.crediapp.utils;

import android.app.Dialog;
import android.content.Context;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class DialogoAbono {


    double abono = 0.0;
    PrestamoDetalle cuota;
    double saldo = 0.0;

    OnAccept accept;
    Dialog dialog;
    @BindView(R.id.lblNCuota)
    TextView lblNCuota;
    @BindView(R.id.lblMonto)
    TextView lblMonto;
    @BindView(R.id.lblMora)
    TextView lblMora;
    @BindView(R.id.lblSaldo)
    TextView lblSaldo;
    @BindView(R.id.txtAbono)
    EditText txtAbono;
    @BindView(R.id.btnCancelar)
    Button btnCancelar;
    @BindView(R.id.btnAbonar)
    Button btnAbonar;

    public DialogoAbono(Context context, PrestamoDetalle cuota, OnAccept onAccept) {

        this.accept = onAccept;

        this.cuota = cuota;

        this.saldo = this.cuota.getMora() + this.cuota.getMonto() - this.cuota.getAbono();


        this.dialog = new Dialog(context);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.getWindow().getDecorView().setBackgroundResource(android.R.color.transparent);
        dialog.setContentView(R.layout.dialog_abono_layout);
        ButterKnife.bind(this, dialog);


        lblNCuota.setText(String.format("CUOTA %s", this.cuota.getCorrelativo()));
        lblMonto.setText(String.format("$%s", Functions.round2decimals(this.cuota.getMonto())));
        lblMora.setText(String.format("$%s", Functions.round2decimals(this.cuota.getMora())));
        lblSaldo.setText(String.format("$%s", Functions.round2decimals(saldo)));

        final TextWatcher textWatcher = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                String val = s.toString().isEmpty() ? "0.0" : s.toString();
                val = val.startsWith(".") ? "0"+val : val;

                final String s_ = Functions.round2decimals(saldo - Double.valueOf(val));

                if (Double.valueOf(Functions.round2decimals(Double.valueOf(val))) > Double.valueOf(Functions.round2decimals(saldo))) {
                    txtAbono.setText(Functions.round2decimals(saldo));
                    lblSaldo.setText(String.format("$%s", Functions.round2decimals(0.0)));
                }else if(Double.valueOf(val) < 0.01){
                    //txtAbono.setError("No puede ser menor a 1 centavo");

                    lblSaldo.setText(String.format("$%s",  s_.startsWith("-") ? "0.0" : s_));
                }else{
                    lblSaldo.setText(String.format("$%s",  s_.startsWith("-") ? "0.0" : s_));
                }



            }
        };

        txtAbono.addTextChangedListener(textWatcher);

    }

    public DialogoAbono(Context context, PrestamoDetalle cuota, double monto, int frecuencia, OnAccept onAccept) {

        this.accept = onAccept;

        final Mora mora = AppDatabase.getInstance(context)
                .prestamoDao().getDatosMoraPrestamo(monto, frecuencia);

        this.cuota = Functions.tieneMora(cuota, mora);

        this.saldo = this.cuota.getMora() + this.cuota.getMonto() - this.cuota.getAbono();


        this.dialog = new Dialog(context);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.getWindow().getDecorView().setBackgroundResource(android.R.color.transparent);
        dialog.setContentView(R.layout.dialog_abono_layout);
        ButterKnife.bind(this, dialog);


        lblNCuota.setText(String.format("CUOTA %s", this.cuota.getCorrelativo()));
        lblMonto.setText(String.format("$%s", Functions.round2decimals(this.cuota.getMonto())));
        lblMora.setText(String.format("$%s", Functions.round2decimals(this.cuota.getMora())));
        lblSaldo.setText(String.format("$%s", Functions.round2decimals(saldo)));

        final TextWatcher textWatcher = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                String val = s.toString().isEmpty() ? "0.0" : s.toString();

                if (Double.valueOf(val) > saldo) {
                    txtAbono.setText(Functions.round2decimals(saldo));
                    lblSaldo.setText(String.format("$%s", Functions.round2decimals(0.0)));
                }else{
                    lblSaldo.setText(String.format("$%s", Functions.round2decimals(saldo - Double.valueOf(val))));
                }

            }
        };

        txtAbono.addTextChangedListener(textWatcher);

    }

    public void show() {
        dialog.show();
    }

    @OnClick({R.id.btnCancelar, R.id.btnAbonar})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.btnCancelar:
                dialog.dismiss();
                break;
            case R.id.btnAbonar:
                this.abono = Double.valueOf(txtAbono.getText().toString());
                /*if(abono > 0){

                }*/

                dialog.dismiss();
                this.accept.click(abono);
                break;
        }
    }
}
