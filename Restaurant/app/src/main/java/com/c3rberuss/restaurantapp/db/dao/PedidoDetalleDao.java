package com.c3rberuss.restaurantapp.db.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.restaurantapp.entities.PedidoDetalle;

import java.util.List;

@Dao
public interface PedidoDetalleDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public long insert(PedidoDetalle detalle);

    @Update
    public void update(PedidoDetalle detalle);

    @Delete
    public void delete(PedidoDetalle detalle);

    @Query("SELECT * FROM "+PedidoDetalle.TABLE_NAME+" WHERE id_platillo_detalle=:id_platillo AND id_pedido=:id_pedido LIMIT 1")
    public PedidoDetalle getDetalle(int id_platillo, int id_pedido);

    @Query("SELECT COUNT(*) FROM "+PedidoDetalle.TABLE_NAME+" WHERE id_pedido=:id_pedido")
    public int getCount(int id_pedido);

    @Query("SELECT COUNT(*) FROM "+PedidoDetalle.TABLE_NAME)
    public int getCount();

    @Query("SELECT * FROM "+ PedidoDetalle.TABLE_NAME)
    public LiveData<List<PedidoDetalle>> getAll();

    @Query("SELECT * FROM "+ PedidoDetalle.TABLE_NAME + " WHERE id_pedido=:id_pedido")
    public LiveData<List<PedidoDetalle>> getAll(int id_pedido);

    @Query("SELECT * FROM "+PedidoDetalle.TABLE_NAME+" WHERE id = :id  LIMIT 1")
    public PedidoDetalle getDetalle(int id);

}
