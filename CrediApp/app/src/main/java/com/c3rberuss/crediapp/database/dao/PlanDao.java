package com.c3rberuss.crediapp.database.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Frecuencia;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.PlanRequisito;
import com.c3rberuss.crediapp.entities.PlanRequisito2;

import java.util.List;

@Dao
public interface PlanDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(List<Plan> plans);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(Plan plan);

    @Query("DELETE FROM "+Plan.TABLE_NAME)
    void deleteAll();

    @Query("SELECT * FROM "+Plan.TABLE_NAME+" WHERE id LIKE :id")
    boolean getExisteIdPlan(int id);

    String sql5="SELECT * FROM planes WHERE id LIKE :id";
    @Query(sql5)
    List<Plan> getListByIdPlan(int id);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertPlan(Plan plan);


    @Query("SELECT * FROM "+Plan.TABLE_NAME+" AS p INNER JOIN "+ Frecuencia.TABLE_NAME +" AS f ON p.frecuencia=f.id")
    LiveData<List<PlanRequisito>> getAll();

    @Query("SELECT * FROM "+Plan.TABLE_NAME+" AS p WHERE :monto BETWEEN p.desde AND p.hasta OR p.frecuencia = :id")
    List<PlanRequisito> getAllByRange(int id, double monto);

    @Query("SELECT * FROM "+Plan.TABLE_NAME)
    List<Plan> getAllPlan();

    @Query("SELECT COUNT(*) FROM "+ PlanRequisito2.TABLE_NAME+" WHERE id_plan=:id_plan AND id_requisito=6")
    int fiadorRequerido(int id_plan);

    @Query("SELECT * FROM "+Plan.TABLE_NAME+" WHERE id = :id")
    Plan get(int id);

}
