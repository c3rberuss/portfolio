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

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class DialogoEfectivo {

    @BindView(R.id.lblCambio)
    TextView lblCambio;
    @BindView(R.id.textView6)
    TextView textView6;
    @BindView(R.id.txtEfectivo)
    EditText txtEfectivo;
    @BindView(R.id.btnCancelar)
    Button btnCancelar;
    @BindView(R.id.btnProcesar)
    Button btnProcesar;

    double efectivo_recibido = 0;
    double monto = 0.0;
    OnAccept accept;
    Dialog dialog;

    public DialogoEfectivo(Context context, double monto, OnAccept onAccept) {

        this.monto = monto;
        this.accept = onAccept;

        this.dialog = new Dialog(context);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.getWindow().getDecorView().setBackgroundResource(android.R.color.transparent);
        dialog.setContentView(R.layout.efectivo_layout);
        ButterKnife.bind(this, dialog);


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

                if (Double.valueOf(val) < Double.valueOf(Functions.round2decimals(monto))) {
                    txtEfectivo.setError("Falta dinero");
                    btnProcesar.setEnabled(false);
                    lblCambio.setText("$0.0");
                } else {
                    final double cambio = Double.valueOf(val) - DialogoEfectivo.this.getMonto();
                    lblCambio.setText("$" + Functions.round2decimals(cambio < 0 ? 0.0 : cambio));
                    btnProcesar.setEnabled(true);
                }
            }
        };

        txtEfectivo.addTextChangedListener(textWatcher);
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public void show(){
        dialog.show();
    }

    @OnClick({R.id.btnCancelar, R.id.btnProcesar})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.btnCancelar:
                dialog.cancel();
                break;
            case R.id.btnProcesar:
                if (!txtEfectivo.getText().toString().isEmpty()) {
                    efectivo_recibido = Double.valueOf(txtEfectivo.getText().toString());
                    dialog.dismiss();

                    this.accept.click(efectivo_recibido);

                   /* proceso = "UPD";
                    getTasks(id_prestamo, proceso);
                    setResult(RESULT_OK);*/
                }
                break;
        }
    }

    public double getEfectivo_recibido() {
        return efectivo_recibido;
    }

    public void setEfectivo_recibido(double efectivo_recibido) {
        this.efectivo_recibido = efectivo_recibido;
    }
}
