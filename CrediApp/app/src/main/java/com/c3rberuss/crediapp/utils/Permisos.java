package com.c3rberuss.crediapp.utils;

import android.content.Context;
import android.view.View;

import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.PermisoDao;
import com.c3rberuss.crediapp.database.dao.UsuarioDao;

public class Permisos {

    public static int tiene(String modulo, Context context){

        final AppDatabase db = AppDatabase.getInstance(context);
        final UsuarioDao usuarioDao = db.getUsuarioDao();
        final PermisoDao permisoDao = db.getPermisoDao();

        final int id_usuario = usuarioDao.getId();

        if(permisoDao.getPermiso(modulo.toLowerCase(), id_usuario) > 0 || usuarioDao.isAdmin() == 1){
            return View.VISIBLE;
        }

        return View.GONE;
    }

    public static boolean tiene_(String modulo, Context context){

        final AppDatabase db = AppDatabase.getInstance(context);
        final UsuarioDao usuarioDao = db.getUsuarioDao();
        final PermisoDao permisoDao = db.getPermisoDao();

        final int id_usuario = usuarioDao.getId();

        return permisoDao.getPermiso(modulo.toLowerCase(), id_usuario) > 0 || usuarioDao.isAdmin() == 1;
    }

}
