package com.c3rberuss.crediapp.database;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.room.migration.Migration;
import androidx.sqlite.db.SupportSQLiteDatabase;

import com.c3rberuss.crediapp.database.dao.AbonoDao;
import com.c3rberuss.crediapp.database.dao.ClienteDao;
import com.c3rberuss.crediapp.database.dao.CobroProcesadoDao;
import com.c3rberuss.crediapp.database.dao.DepartamentoDao;
import com.c3rberuss.crediapp.database.dao.FiadorDao;
import com.c3rberuss.crediapp.database.dao.FrecuenciaDao;
import com.c3rberuss.crediapp.database.dao.GarantiaDao;
import com.c3rberuss.crediapp.database.dao.LogDao;
import com.c3rberuss.crediapp.database.dao.MunicipioDao;
import com.c3rberuss.crediapp.database.dao.PagosMoraDao;
import com.c3rberuss.crediapp.database.dao.ParentezcoDao;
import com.c3rberuss.crediapp.database.dao.PermisoDao;
import com.c3rberuss.crediapp.database.dao.PlanDao;
import com.c3rberuss.crediapp.database.dao.PlanRequisitoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDetalleDao;
import com.c3rberuss.crediapp.database.dao.RequisitoDao;
import com.c3rberuss.crediapp.database.dao.SolicitudDao;
import com.c3rberuss.crediapp.database.dao.SolicitudDetalleDao;
import com.c3rberuss.crediapp.database.dao.UsuarioDao;
import com.c3rberuss.crediapp.entities.Abono;
import com.c3rberuss.crediapp.entities.Archivo;
import com.c3rberuss.crediapp.entities.ArchivoLog;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.ClienteLog;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.entities.Departamento;
import com.c3rberuss.crediapp.entities.Fiador;
import com.c3rberuss.crediapp.entities.FiadorLog;
import com.c3rberuss.crediapp.entities.Frecuencia;
import com.c3rberuss.crediapp.entities.Garantia;
import com.c3rberuss.crediapp.entities.GarantiaLog;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.Municipio;
import com.c3rberuss.crediapp.entities.PagosMora;
import com.c3rberuss.crediapp.entities.Parentezco;
import com.c3rberuss.crediapp.entities.Permiso;
import com.c3rberuss.crediapp.entities.Persona;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.PlanRequisito2;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.entities.PrestamoDetalleLog;
import com.c3rberuss.crediapp.entities.PrestamoLog;
import com.c3rberuss.crediapp.entities.Referencia;
import com.c3rberuss.crediapp.entities.ReferenciaLog;
import com.c3rberuss.crediapp.entities.Requisito;
import com.c3rberuss.crediapp.entities.SolicitudCredito;
import com.c3rberuss.crediapp.entities.SolicitudCreditoLog;
import com.c3rberuss.crediapp.entities.SolicitudDetalle;
import com.c3rberuss.crediapp.entities.SolicitudDetalleLog;
import com.c3rberuss.crediapp.entities.Usuario;
import com.c3rberuss.crediapp.utils.insertAsyncTask;

@Database(entities = {
        Usuario.class, Permiso.class, Frecuencia.class, Parentezco.class, Departamento.class, Municipio.class,
        Cliente.class, Prestamo.class, PrestamoDetalle.class, Plan.class, PlanRequisito2.class, Requisito.class, Archivo.class,
        Referencia.class, SolicitudCredito.class, SolicitudDetalle.class, Fiador.class, Garantia.class, CobroProcesado.class,
        SolicitudCreditoLog.class, SolicitudDetalleLog.class, GarantiaLog.class, FiadorLog.class, ArchivoLog.class, ClienteLog.class,
        ReferenciaLog.class, PrestamoLog.class, PrestamoDetalleLog.class, Mora.class, Abono.class, PagosMora.class
}, version = 20)
public abstract class AppDatabase extends RoomDatabase {

    private static final String DB_NAME = "crediapp_db";
    private static AppDatabase instance;

    public static synchronized AppDatabase getInstance(Context context) {
        if (instance == null) {
            instance = Room.databaseBuilder(context.getApplicationContext(), AppDatabase.class, DB_NAME)
                    .fallbackToDestructiveMigration()
                    .allowMainThreadQueries()
                    .addMigrations(MIGRATION_1_2, MIGRATION_2_3, MIGRATION_3_4, MIGRATION_4_5,
                            MIGRATION_5_6, MIGRATION_6_7, MIGRATION_7_8, MIGRATION_8_9, MIGRATION_9_10,
                            MIGRATION_10_11, MIGRATION_11_12, MIGRATION_12_13, MIGRATION_13_14,
                            MIGRATION_14_15, MIGRATION_15_16, MIGRATION_16_17, MIGRATION_18_19,
                            MIGRATION_19_20)
                    //.addCallback(sRoomDatabaseCallback)
                    .build();
        }

        return instance;
    }

    //DAOS
    public abstract UsuarioDao getUsuarioDao();

    public abstract PermisoDao getPermisoDao();

    public abstract FrecuenciaDao getFrecuenciaDao();

    public abstract ParentezcoDao getPatentezcoDao();

    public abstract DepartamentoDao getDepartamentoDao();

    public abstract MunicipioDao getMunicipioDao();

    public abstract ClienteDao getClienteDao();

    public abstract PlanDao getPlanesDao();

    public abstract RequisitoDao getRequisitoDao();

    public abstract SolicitudDao getSolicitudDao();

    public abstract GarantiaDao getGarantiaDao();

    public abstract FiadorDao getFiadorDao();

    public abstract SolicitudDetalleDao getSolicitudDetalleDao();

    public abstract CobroProcesadoDao getCobrosProcesados();

    public abstract PlanRequisitoDao getPlanRequisitoDao();

    public abstract LogDao getLogDao();

    public abstract AbonoDao getAbonoDao();

    //NUEVO
    public abstract PrestamoDao prestamoDao();

    public abstract PrestamoDetalleDao prestamoDetalleDao();

    public abstract PagosMoraDao getPagosMoraDao();

    private static Callback sRoomDatabaseCallback = new Callback() {

        @Override
        public void onOpen(@NonNull SupportSQLiteDatabase db) {
            super.onOpen(db);
            //new insertAsyncTask(instance).execute();
        }
    };

    static final Migration MIGRATION_1_2 = new Migration(1, 2) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE solicitud ADD COLUMN mora REAL NOT NULL DEFAULT 0.0");
            database.execSQL("ALTER TABLE solicitud ADD COLUMN dias_mora INTEGER NOT NULL DEFAULT 0");

            database.execSQL("ALTER TABLE solicitud_log ADD COLUMN mora REAL NOT NULL DEFAULT 0.0");
            database.execSQL("ALTER TABLE solicitud_log ADD COLUMN dias_mora INTEGER NOT NULL DEFAULT 0");

        }
    };

    static final Migration MIGRATION_2_3 = new Migration(2, 3) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN hora TEXT");
        }
    };

    static final Migration MIGRATION_3_4 = new Migration(3, 4) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE prestamo ADD COLUMN mora REAL NOT NULL DEFAULT 0.0");
            database.execSQL("ALTER TABLE prestamo ADD COLUMN dias_mora INTEGER NOT NULL DEFAULT 0");

            database.execSQL("ALTER TABLE prestamo_log ADD COLUMN mora REAL NOT NULL DEFAULT 0.0");
            database.execSQL("ALTER TABLE prestamo_log ADD COLUMN dias_mora INTEGER NOT NULL DEFAULT 0");

        }
    };

    static final Migration MIGRATION_4_5 = new Migration(4, 5) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {

            database.execSQL("CREATE TABLE mora (\n" +
                    "    id_mora INTEGER PRIMARY KEY NOT NULL,\n" +
                    "    desde REAL NOT NULL,\n" +
                    "    hasta REAL NOT NULL,\n" +
                    "    frecuencia INTEGER NOT NULL,\n" +
                    "    dias_mora INTEGER NOT NULL,\n" +
                    "    mora REAL NOT NULL" +
                    ");");
        }
    };

    static final Migration MIGRATION_5_6 = new Migration(5, 6) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {

            database.execSQL("ALTER TABLE " + Cliente.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + ClienteLog.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + CobroProcesado.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + Prestamo.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + PrestamoLog.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + PrestamoDetalle.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + PrestamoDetalleLog.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + SolicitudCredito.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + SolicitudCreditoLog.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + SolicitudDetalle.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");
            database.execSQL("ALTER TABLE " + SolicitudDetalleLog.TABLE_NAME + " ADD COLUMN app_version TEXT DEFAULT '1.5.6'");

        }
    };

    static final Migration MIGRATION_6_7 = new Migration(6, 7) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE prestamo_detalle ADD COLUMN abono REAL NOT NULL DEFAULT 0.0");
            database.execSQL("ALTER TABLE prestamo_detalle_log ADD COLUMN abono REAL NOT NULL DEFAULT 0.0");
        }
    };

    static final Migration MIGRATION_7_8 = new Migration(7, 8) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {

            database.execSQL("CREATE TABLE abonos (\n" +
                    "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,\n" +
                    "id_detalle INTEGER NOT NULL DEFAULT 0,\n" +
                    "fecha TEXT DEFAULT '0000-00-00',\n" +
                    "hora TEXT DEFAULT '00:00:00',\n" +
                    "valor REAL NOT NULL DEFAULT 0.0,\n" +
                    "sincronizado INTEGER NOT NULL DEFAULT 0,\n" +
                    "referencia TEXT\n" +
                    ");");

        }
    };

    static final Migration MIGRATION_8_9 = new Migration(8, 9) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE prestamo ADD COLUMN abonado INTEGER NOT NULL DEFAULT 0");
            database.execSQL("ALTER TABLE prestamo_log ADD COLUMN abonado INTEGER NOT NULL DEFAULT 0");

            database.execSQL("ALTER TABLE prestamo_detalle ADD COLUMN abonado INTEGER NOT NULL DEFAULT 0");
            database.execSQL("ALTER TABLE prestamo_detalle_log ADD COLUMN abonado INTEGER NOT NULL DEFAULT 0");
        }
    };


    static final Migration MIGRATION_9_10 = new Migration(9, 10) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE prestamo_detalle ADD COLUMN monto_abono REAL NOT NULL DEFAULT 0.0");
            database.execSQL("ALTER TABLE prestamo_detalle_log ADD COLUMN monto_abono REAL NOT NULL DEFAULT 0.0");
        }
    };

    static final Migration MIGRATION_10_11 = new Migration(10, 11) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE prestamo_detalle ADD COLUMN fecha_abono TEXT DEFAULT '0000-00-00'");
            database.execSQL("ALTER TABLE prestamo_detalle_log ADD COLUMN fecha_abono TEXT  DEFAULT '0000-00-00'");

            database.execSQL("ALTER TABLE prestamo_detalle ADD COLUMN hora_abono TEXT DEFAULT '0000-00-00'");
            database.execSQL("ALTER TABLE prestamo_detalle_log ADD COLUMN hora_abono TEXT DEFAULT '0000-00-00'");

            //campos nuevos abonos
            database.execSQL("ALTER TABLE abonos ADD COLUMN usuario_abono INTEGER NOT NULL DEFAULT 0");
            database.execSQL("ALTER TABLE abonos ADD COLUMN caja INTEGER NOT NULL DEFAULT 0");
            database.execSQL("ALTER TABLE abonos ADD COLUMN id_prestamo INTEGER NOT NULL DEFAULT 0");

            //campos nuevos cobros procesados
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN sincronizado INTEGER NOT NULL DEFAULT 0");
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN id_detalle INTEGER NOT NULL DEFAULT 0");
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN abono INTEGER NOT NULL DEFAULT 0");

            database.execSQL("ALTER TABLE cliente ADD COLUMN vetado INTEGER NOT NULL DEFAULT 0");
        }
    };


    static final Migration MIGRATION_11_12 = new Migration(11, 12) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN cliente TEXT DEFAULT '--'");
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN cuota TEXT  DEFAULT '--'");
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN recuperacion INTEGER NOT NULL DEFAULT 0");
        }
    };

    static final Migration MIGRATION_12_13 = new Migration(12, 13) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN referencia TEXT");
        }
    };

    static final Migration MIGRATION_13_14 = new Migration(13, 14) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE prestamo ADD COLUMN estado INTEGER NOT NULL DEFAULT 0");
        }
    };

    static final Migration MIGRATION_14_15 = new Migration(14, 15) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE prestamo ADD COLUMN atrasado INTEGER NOT NULL DEFAULT 0");
            database.execSQL("ALTER TABLE prestamo ADD COLUMN proxima_mora TEXT DEFAULT '0000-00-00'");
        }
    };

    static final Migration MIGRATION_15_16 = new Migration(15, 16) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN soloMora INTEGER NOT NULL DEFAULT 0");
        }
    };

    static final Migration MIGRATION_16_17 = new Migration(16, 17) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {
            database.execSQL("CREATE TABLE " + PagosMora.TABLE_NAME + " (\n" +
                    "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,\n" +
                    "id_prestamo INTEGER NOT NULL DEFAULT -1,\n" +
                    "dias_mora INTEGER NOT NULL DEFAULT 0,\n" +
                    "valor REAL NOT NULL DEFAULT 0.0,\n" +
                    "fecha TEXT DEFAULT '0000-00-00',\n" +
                    "hora TEXT DEFAULT '00:00:00',\n" +
                    "corresponde INTEGER NOT NULL DEFAULT -1,\n" +
                    "sincronizado INTEGER NOT NULL DEFAULT 0\n" +
                    ");");
        }
    };

    static final Migration MIGRATION_18_19 = new Migration(18, 19) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE cobros_procesado ADD COLUMN pago_mora INTEGER NOT NULL DEFAULT 0");
        }
    };

    static final Migration MIGRATION_19_20 = new Migration(19, 20) {
        @Override
        public void migrate(@NonNull SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE " + PagosMora.TABLE_NAME + " ADD COLUMN id_usuario INTEGER NOT NULL DEFAULT 0");
        }
    };
}
