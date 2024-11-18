import 'package:flutter/material.dart';
import 'database_helper.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init(); // initialize the database
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _insert,
              child: const Text('Insert'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _query,
              child: const Text('Query All Rows'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _queryById,
              child: const Text('Query by ID'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _update,
              child: const Text('Update'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _delete,
              child: const Text('Delete by ID'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteAll,
              child: const Text('Delete All Records'),
            ),
          ],
        ),
      ),
    );
  }

  // Insert a record
  void _insert() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: 'Bob',
      DatabaseHelper.columnAge: 23,
    };
    final id = await dbHelper.insert(row);
    debugPrint('Inserted row id: $id');
  }

  // Query all records
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    debugPrint('Query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  // New: Query by ID
  void _queryById() async {
    const int idToQuery = 1; // Specify the ID to query
    final row = await dbHelper.queryById(idToQuery);
    if (row != null) {
      debugPrint('Query by ID $idToQuery: $row');
    } else {
      debugPrint('No record found with ID $idToQuery');
    }
  }

  // Update a record
  void _update() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1, // Specify the ID to update
      DatabaseHelper.columnName: 'Mary',
      DatabaseHelper.columnAge: 32,
    };
    final rowsAffected = await dbHelper.update(row);
    debugPrint('Updated $rowsAffected row(s)');
  }

  // Delete a record by ID
  void _delete() async {
    const int idToDelete = 1; // Specify the ID to delete
    final rowsDeleted = await dbHelper.delete(idToDelete);
    debugPrint('Deleted $rowsDeleted row(s) with ID $idToDelete');
  }

  // New: Delete all records
  void _deleteAll() async {
    final rowsDeleted = await dbHelper.deleteAll();
    debugPrint('Deleted all records: $rowsDeleted rows deleted');
  }
}
