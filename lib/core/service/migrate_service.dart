import 'dart:async';

import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/core/library/extensions.dart' show ParsingStringList;
import 'package:noctus_mobile/domain/entities/logged/user_logged.dart';
import 'package:sqflite/sqflite.dart';

export 'package:sqflite/sqflite.dart' show Database, ConflictAlgorithm, Batch;

const String _kDatabaseName = 'app.db';

final String kTypeInteger = TypeColumn.integer.name;
final String kTypeText = TypeColumn.text.name;
final String kTypeReal = TypeColumn.real.name;

enum TypeColumn {
  integer,
  text,
  real,
}

final class ColumnTableEntity {
  final String name;
  final TypeColumn type;

  const ColumnTableEntity({
    required this.name,
    required this.type,
  });
}

abstract interface class IMigrateService {
  Future<Database?> getDb();
  Future<void> onCreate(Database db, int version);
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion);
  Future<bool> deleteTables({bool deleteAll = false});
  Future<void> closeDataBase();
}

final class MigrateService implements IMigrateService {
  String? _databasesPath;
  Database? _database;

  MigrateService({
    Database? databaseTest,
    String? databasesPathTest,
  }) {
    _database = databaseTest;
    _databasesPath = databasesPathTest;
  }

  @override
  Future<Database?> getDb() async {
    if (_database != null) return _database;
    return _database = await _createDatabase();
  }

  Future<Database> _createDatabase() async {
    _databasesPath = _databasesPath ?? await getDatabasesPath();
    final String path = [_databasesPath!, _kDatabaseName].joinPath;
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  @override
  Future<void> onCreate(Database db, int _) async {
    await _createTableUser(db);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {}
  }

  Future<void> _createTableUser(Database db) async {
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS ${DataBaseSchemaHelper.kUser} (
      ${UserLoggedEntity.kKeyId} $kTypeInteger PRIMARY KEY,
      ${UserLoggedEntity.kKeyName} $kTypeText,
      ${UserLoggedEntity.kKeyImage} $kTypeText,
      ${UserLoggedEntity.kKeyRole} $kTypeText,
      ${UserLoggedEntity.kKeyActive} $kTypeInteger
      )
       ''',
    );
  }

  @override
  Future<void> closeDataBase() async {
    try {
      await _database?.close();
    } catch (_) {}
  }

  @override
  Future<bool> deleteTables({bool deleteAll = false}) {
    return Future.value(true);
  }
}