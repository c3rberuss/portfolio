import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'database.g.dart';

//TODO: Fix tables gen

const tableUser = SqfEntityTable(
  tableName: "user",
  primaryKeyName: "id",
  primaryKeyType: PrimaryKeyType.integer_unique,
  useSoftDeleting: false,
  modelName: "UserEntity",
  fields: [
    SqfEntityField("email", DbType.text),
    SqfEntityField("name", DbType.text),
    SqfEntityField("phone", DbType.text, defaultValue: ""),
    SqfEntityField("image", DbType.text),
  ],
);

const tableOrder = SqfEntityTable(
  tableName: "order",
  primaryKeyName: "id",
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  modelName: "OrderEntity",
  fields: [
    SqfEntityFieldRelationship(
      parentTable: tableUser,
      deleteRule: DeleteRule.CASCADE,
    ),
  ],
);

const tableProduct = SqfEntityTable(
  tableName: "product",
  primaryKeyName: "id",
  primaryKeyType: PrimaryKeyType.integer_unique,
  useSoftDeleting: false,
  modelName: "ProductEntity",
  fields: [
    SqfEntityField("name", DbType.text),
    SqfEntityField("description", DbType.text),
    SqfEntityField("price", DbType.real),
    SqfEntityField("image", DbType.text),
  ],
);

const tableOrderItem = SqfEntityTable(
  tableName: "order_item",
  primaryKeyName: "id",
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  modelName: "OrderItemEntity",
  fields: [
    SqfEntityField("qty", DbType.integer),
    SqfEntityField("indications", DbType.text),
    SqfEntityFieldRelationship(
      parentTable: tableProduct,
      deleteRule: DeleteRule.CASCADE,
    ),
    SqfEntityFieldRelationship(
      parentTable: tableOrder,
      deleteRule: DeleteRule.CASCADE,
    ),
  ],
);

//Database
@SqfEntityBuilder(appDatabase)
const appDatabase = SqfEntityModel(
  modelName: 'AppDatabase', // optional
  databaseName: 'database.db',
  databaseTables: [
    tableUser,
    tableOrder,
    tableProduct,
    tableOrderItem,
  ],
  bundledDatabasePath: null,
);
