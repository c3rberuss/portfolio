package com.c3rberuss.crediapp.entities;

import com.google.gson.annotations.SerializedName;

public class ResponseServer {

    @SerializedName("estatus")
    private String status;
    private String message;
    private int id;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
