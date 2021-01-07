package com.c3rberuss.restaurantapp.db.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Query;

import com.c3rberuss.restaurantapp.entities.DetallePlatillo;
import com.c3rberuss.restaurantapp.entities.PedidoDetalle;
import com.c3rberuss.restaurantapp.entities.Platillo;

import java.util.List;

@Dao
public interface DetallePlatilloDao {

    @Query("SELECT p.nombre, p.imagen, d.cantidad, d.subtotal, d.id_platillo_detalle AS id_platillo, d.id AS id_detalle FROM "+ Platillo.TABLE_NAME +
            " AS p INNER JOIN "+ PedidoDetalle.TABLE_NAME + " AS d ON p.id_platillo=d.id_platillo_detalle WHERE d.id_pedido=:id")

    public LiveData<List<DetallePlatillo>> getDetallePedido(int id);

}
