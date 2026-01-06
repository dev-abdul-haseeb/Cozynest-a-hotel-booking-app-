import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:intl/intl.dart';

class DBManager {
  //Singleton
  DBManager._();
  static DBManager getInstance() {
    return DBManager._();
  }

  Database? myDB;

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }

  // db open (path-> if exists else create)

  Future<Database> openDB() async {
    Directory appdir = await getApplicationDocumentsDirectory();

    String dbPath = join(
      appdir.path,
      "cozynest.db",
    ); //Path where to create db, Name of db

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Users (
            username TEXT PRIMARY KEY,
            password TEXT NOT NULL,
            name TEXT NOT NULL,
            city TEXT NOT NULL,
            country TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE Bookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            hotelName TEXT NOT NULL,
            hotelDescription TEXT NOT NULL,
            address1 TEXT NOT NULL,
            username TEXT NOT NULL,
            checkInDate TEXT NOT NULL,
            checkInTime TEXT NOT NULL,
            checkOutDate TEXT NOT NULL,
            checkOutTime TEXT NOT NULL,
            totalPrice REAL NOT NULL,
            numberOfGuests INTEGER NOT NULL,
            status TEXT NOT NULL,
            FOREIGN KEY (username) REFERENCES Users(username)
          )
        ''');
      },
    );
  }

  Future<bool> insertUser({
    required String username,
    required String password,
    required String name,
    required String city,
    required String country,
  }) async {
    final db = await getDB();
    final existing = await db.query(
      'Users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (existing.isNotEmpty) {
      return false;
    }
    await db.insert(
      'Users',
      {
        'username': username,
        'password': password,
        'name': name,
        'city': city,
        'country': country,
      },
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
    return true;
  }

  Future<void> insertBooking({
    required String hotelName,
    required String hotelDescription,
    required String address1,
    required String username,
    required String checkInDate,
    required String checkInTime,
    required String checkOutDate,
    required String checkOutTime,
    required double totalPrice,
    required int numberOfGuests,
    required String status,
  }) async {
    final db = await getDB();

    await db.insert(
      'Bookings',
      {
        'hotelName': hotelName,
        'hotelDescription': hotelDescription,
        'address1': address1,
        'username': username,
        'checkInDate': checkInDate,
        'checkInTime': checkInTime,
        'checkOutDate': checkOutDate,
        'checkOutTime': checkOutTime,
        'totalPrice': totalPrice,
        'numberOfGuests': numberOfGuests,
        'status': status,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }



  Future<Map<String, dynamic>?> getUser({
    required String username,
    required String password,
  }) async {
    final db = await getDB();
    final result = await db.query(
      'Users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }

  }

  Future<List<Map<String, dynamic>>> getBookingsByUsername(String username) async {
    final db = await getDB();
    return await db.query(
      'Bookings',
      where: 'username = ?',
      whereArgs: [username],
      orderBy: 'checkInDate DESC',
    );
  }

  Future<void> expirePastPendingBookings() async {
    final db = await getDB();
    final now = DateTime.now();

    final bookings = await db.query(
      'Bookings',
      where: 'status = ?',
      whereArgs: ['paid'],
    );

    for (var booking in bookings) {
      try {
        final checkOutDateStr = booking['checkOutDate'] as String;
        final checkOutTimeStr = booking['checkOutTime'] as String;

        // Combine and parse using intl
        final fullDateStr = '$checkOutDateStr $checkOutTimeStr';
        final formatter = DateFormat('yyyy-MM-dd h:mm a');
        final checkOutDateTime = formatter.parse(fullDateStr);

        if (checkOutDateTime.isBefore(now)) {
          await db.update(
            'Bookings',
            {'status': 'Expired'},
            where: 'id = ?',
            whereArgs: [booking['id']],
          );
        }
      } catch (e) {
        print("Failed to parse date for booking ID ${booking['id']}: $e");
      }
    }
  }


}
