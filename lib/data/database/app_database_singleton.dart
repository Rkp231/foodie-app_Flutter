import 'dart:async';

import 'package:floor/floor.dart';
import 'package:foodie/data/database/app_database.dart';

class AppDatabaseSingleton {
  static AppDatabase database;

  Future<AppDatabase> prepareDatabase() async {
    if (database != null) return database;
    database = await $FloorAppDatabase
        .databaseBuilder('foodie.db')
        .addMigrations([migration1to2]).build();
    return database;
  }

  // create migration
  final migration1to2 = Migration(1, 2, (database) async {
    await database
        .execute('ALTER TABLE products ADD COLUMN discountPrice REAL');
  });
}
