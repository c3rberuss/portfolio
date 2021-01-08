package com.c3rberuss.crediapp.database.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.PlanRequisito2;
import com.c3rberuss.crediapp.entities.Requisito;

import java.util.List;

@Dao
public interface PlanRequisitoDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(List<PlanRequisito2> planRequisito2s);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(PlanRequisito2 planRequisito);

    @Query("DELETE FROM "+ PlanRequisito2.TABLE_NAME)
    void deleteAll();

    @Query("SELECT plan_requisito.id_plan, plan_requisito.cantidad,\n" +
            " requisito.nombre, requisito.descripcion,\n" +
            " requisito.id from "+PlanRequisito2.TABLE_NAME+" INNER JOIN "+Requisito.TABLE_NAME+" ON\n" +
            " requisito.id = plan_requisito.id_requisito where plan_requisito.id_plan =:id")
    List<Requisito> getRequisitos(int id);
}
