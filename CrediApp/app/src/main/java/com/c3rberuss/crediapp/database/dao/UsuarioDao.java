package com.c3rberuss.crediapp.database.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Usuario;

@Dao
public interface UsuarioDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(Usuario usuario);

    @Query("SELECT * FROM "+Usuario.TABLE_NAME+" WHERE id=0")
    public LiveData<Usuario> usuarioActivoLive();

    @Query("SELECT * FROM "+Usuario.TABLE_NAME+" WHERE id=0")
    public Usuario usuarioActivo();

    @Delete
    public void delete(Usuario usuario);

    @Query("DELETE FROM "+Usuario.TABLE_NAME+" WHERE id_usuario=0")
    public void delete();

    @Query("DELETE FROM "+Usuario.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT id_usuario FROM "+Usuario.TABLE_NAME+" WHERE id=0")
    public int getId();

    @Query("SELECT admin FROM "+Usuario.TABLE_NAME+" WHERE id=0")
    public int isAdmin();

    @Query("SELECT COUNT(*) FROM "+Usuario.TABLE_NAME+" WHERE usuario=:usuario AND password=:pwd")
    public int auth(String usuario, String pwd);


    @Query("SELECT nombre FROM "+Usuario.TABLE_NAME+" WHERE id=0")
    public String getNombre();

}

