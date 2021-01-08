package com.c3rberuss.crediapp.utils;

import com.c3rberuss.crediapp.entities.Usuario;

public interface OnVerify {
    void verify(boolean successful, Usuario usuario);
    void ondefault();
}
