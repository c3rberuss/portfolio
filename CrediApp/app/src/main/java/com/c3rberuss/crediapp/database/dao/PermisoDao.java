package com.c3rberuss.crediapp.database.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Permiso;

import java.util.List;

@Dao
public interface PermisoDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(List<Permiso> permisos);

    @Query("DELETE FROM "+Permiso.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT COUNT(*) FROM "+Permiso.TABLE_NAME+" WHERE nombre=:nombre AND id_usuario=:id_usuario")
    public int getPermiso(String nombre, int id_usuario);
}
