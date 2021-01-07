package com.c3rberuss.restaurantapp.db.dao;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.restaurantapp.entities.Usuario;

@Dao
public interface UsuarioDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(Usuario usuario);

    @Update
    public void update(Usuario usuario);

    @Delete
    public void delete(Usuario usuario);

    @Query("DELETE FROM "+Usuario.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT * FROM "+Usuario.TABLE_NAME+" WHERE activo=1 LIMIT 1")
    public Usuario getUsuarioActivo();

    @Query("SELECT COUNT(*) FROM "+Usuario.TABLE_NAME + " WHERE correo = :email")
    public int existeUsuario(String email);

    @Query("UPDATE "+Usuario.TABLE_NAME+" SET activo=0 WHERE activo=1")
    void logout();

}
