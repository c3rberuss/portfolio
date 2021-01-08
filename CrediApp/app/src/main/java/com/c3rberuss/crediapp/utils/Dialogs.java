package com.c3rberuss.crediapp.utils;

import android.content.Context;

import com.developer.kalert.KAlertDialog;

public class Dialogs {


    public static KAlertDialog success(Context context, String title, String message,
                                       KAlertDialog.KAlertClickListener confirmListener){

        KAlertDialog dialog = new KAlertDialog(context, KAlertDialog.SUCCESS_TYPE);
        dialog.setTitleText(title);
        dialog.setContentText(message);

        dialog.setConfirmText("Aceptar");

        dialog.setConfirmClickListener(confirmListener);

        return dialog;
    }

    public static KAlertDialog printer(Context context, String title, String message,
                                       KAlertDialog.KAlertClickListener confirmListener,
                                       KAlertDialog.KAlertClickListener cancel){

        KAlertDialog dialog = new KAlertDialog(context, KAlertDialog.SUCCESS_TYPE);
        dialog.setTitleText(title);
        dialog.setContentText(message);

        dialog.setCancelText("Aceptar");

        dialog.setConfirmText("Imprimir ticket");

        dialog.setConfirmClickListener(confirmListener);
        dialog.setCancelClickListener(cancel);

        return dialog;
    }

    public static KAlertDialog error(Context context, String title, String message,
                                     KAlertDialog.KAlertClickListener confirmListener){

        KAlertDialog dialog = new KAlertDialog(context, KAlertDialog.ERROR_TYPE);
        dialog.setTitleText(title);
        dialog.setContentText(message);

        dialog.setConfirmText("Aceptar");

        dialog.setConfirmClickListener(confirmListener);

        return dialog;

    }


    public static KAlertDialog appVersionAntigua(Context context, String title, String content,
                                       KAlertDialog.KAlertClickListener confirmListener){

        final KAlertDialog dialog = new KAlertDialog(context, KAlertDialog.WARNING_TYPE);
        dialog.setTitleText(title);
        dialog.setContentText(content);

        dialog.setConfirmText("Aceptar");
        dialog.setCancelable(false);

        dialog.setConfirmClickListener(confirmListener);
        return dialog;
    }

}
