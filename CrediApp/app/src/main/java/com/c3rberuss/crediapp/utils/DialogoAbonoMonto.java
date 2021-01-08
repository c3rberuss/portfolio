package com.c3rberuss.crediapp.utils;

import android.app.Dialog;
import android.content.Context;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;

import java.util.Locale;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class DialogoAbonoMonto {


    double abono = 0.0;
    double saldo = 0.0;
    double mora = 0.0;

    OnAccept accept;
    Dialog dialog;

    @BindView(R.id.lblSaldo)
    TextView lblSaldo;
    @BindView(R.id.txtAbono)
    EditText txtAbono;
    @BindView(R.id.btnCancelar)
    Button btnCancelar;
    @BindView(R.id.btnAbonar)
    Button btnAbonar;

    public DialogoAbonoMonto(Context context, float saldo, float mora, OnAccept onAccept) {

        this.saldo = saldo;
        this.mora = mora;
        this.accept = onAccept;
        this.dialog = new Dialog(context);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.getWindow().getDecorView().setBackgroundResource(android.R.color.transparent);
        dialog.getWindow().setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        dialog.setContentView(R.layout.dialog_abono_monto_layout);
        ButterKnife.bind(this, dialog);

        lblSaldo.setText(String.format("$%s", Functions.round2decimals(saldo)));
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
                String monto = txtAbono.getText().toString();

                if (Double.valueOf(monto) > saldo+mora){
                    monto = String.valueOf(saldo+mora);
                }

                monto = monto.isEmpty() ? "0" : monto;
                monto = monto.startsWith(".") ? "0" + monto : monto;
                monto = monto.endsWith(".") ? monto + "0" : monto;

                if (Double.valueOf(monto) >= 0.01 && Double.valueOf(monto) >= mora) {
                    this.abono = Double.valueOf(txtAbono.getText().toString());
                    dialog.dismiss();
                    this.accept.click(abono);
                    this.txtAbono.setText("");
                } else if (Double.valueOf(monto) < 0.01) {
                    this.txtAbono.setError("El monto debe ser mayor a 0");
                } else {
                    this.txtAbono.setError(String.format(Locale.ENGLISH, "El monto debe ser mayor a la mora ($%s)", Functions.round2decimals(this.mora)));
                }
                break;
        }
    }
}
