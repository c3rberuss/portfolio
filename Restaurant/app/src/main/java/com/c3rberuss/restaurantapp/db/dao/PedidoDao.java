package com.c3rberuss.restaurantapp.db.dao;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.restaurantapp.entities.Pedido;

@Dao
public interface PedidoDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public long insert(Pedido  pedido);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(Pedido... pedido);

    @Update
    public void update(Pedido pedido);

    @Delete
    public void delete(Pedido pedido);

    @Query("DELETE FROM "+Pedido.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT * FROM "+Pedido.TABLE_NAME+" WHERE procesada = 0 LIMIT 1")
    public Pedido obtenerPedidoActivo();


}
