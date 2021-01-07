package com.c3rberuss.restaurantapp.utils;

import android.content.Context;
import android.content.DialogInterface;

import com.developer.kalert.KAlertDialog;

public class Dialogs {

    private static KAlertDialog dialog;

    public static KAlertDialog success(Context context, String title, String message,
                                       DialogInterface.OnCancelListener cancelListener,
                                       KAlertDialog.KAlertClickListener confirmListener){

        dialog = new KAlertDialog(context, KAlertDialog.SUCCESS_TYPE);
        dialog.setTitleText(title);
        dialog.setContentText(message);

        dialog.setConfirmText("Aceptar");
        dialog.setCancelText("Cancelar");

        dialog.setOnCancelListener(cancelListener);
        dialog.setConfirmClickListener(confirmListener);

        return dialog;
    }

    public static KAlertDialog error(Context context, String title, String message,
                                     DialogInterface.OnCancelListener cancelListener,
                                     KAlertDialog.KAlertClickListener confirmListener){

        dialog = new KAlertDialog(context, KAlertDialog.ERROR_TYPE);
        dialog.setTitleText(title);
        dialog.setContentText(message);

        dialog.setConfirmText("Aceptar");
        dialog.setCancelText("Cancelar");

        dialog.setOnCancelListener(cancelListener);
        dialog.setConfirmClickListener(confirmListener);

        return dialog;

    }

}
