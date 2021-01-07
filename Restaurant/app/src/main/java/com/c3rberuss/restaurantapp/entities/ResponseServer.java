package com.c3rberuss.restaurantapp.entities;

public class ResponseServer {

    private String estatus;
    private String message;

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
