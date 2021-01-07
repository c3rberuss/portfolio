package com.c3rberuss.restaurantapp.db.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.restaurantapp.entities.PlatilloFavorito;

import java.util.List;

@Dao
public interface FavoritosDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void addFavorite(PlatilloFavorito favorito);

    @Delete
    public void quitFavorite(PlatilloFavorito favorito);

    @Query("DELETE FROM "+PlatilloFavorito.TABLE_NAME+" WHERE id_platillo=:id_platillo AND id_usuario=:id_usuario")
    public void quitFavorite(int id_platillo, int id_usuario);

    @Query("SELECT * FROM "+PlatilloFavorito.TABLE_NAME+" WHERE id_platillo=:id_platillo AND id_usuario = :id_usuario ")
    public PlatilloFavorito get(int id_usuario, int id_platillo);

    @Query("SELECT * FROM "+PlatilloFavorito.TABLE_NAME+" WHERE id_platillo=:id_platillo AND id_usuario = :id_usuario ")
    LiveData<PlatilloFavorito> get_(int id_usuario, int id_platillo);

    @Query("SELECT * FROM "+PlatilloFavorito.TABLE_NAME+" WHERE id_categoria=:id_cat AND fav=1")
    LiveData<List<PlatilloFavorito>> getFavoritos(int id_cat);

    @Query("UPDATE "+PlatilloFavorito.TABLE_NAME+" SET fav=:checked WHERE id=:id")
    void update(boolean checked, int id);

}
