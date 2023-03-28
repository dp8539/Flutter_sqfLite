import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

List data = [];

class SqliteDb {
  Database? db;
  String path = '';

  createDb() async {
    print('++++');
    String val = await getDatabasesPath();
    path = join(val, 'data.db');
    openDb();
  }

  openDb() async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Data (id INTEGER PRIMARY KEY, name TEXT, email TEXT);',
        );
      },
    );
  }

  addData({required String name, required String email}) async {
    print('-*--**-*-*');
    db!.insert(
      'Data',
      {
        'name': name,
        'email': email,
      },
    );
  }

  updateData(
      {required String name, required String email, required String id}) {
    db!.update(
      'Data',
      {
        'name': name,
        'email': email,
      },
      where: 'id=$id',
    );
  }

  deleteData({required int id}) async {
    await db?.delete(
      'Data',
      where: 'id=$id',
    );
  }

//2022-10-14 10:19:01.708394
  selectData() async {
    List<Map> result = [];
    data.clear();
    print('-------------- $db');
    if (db == null) {
      openDb();
    } else {
      result = await db!.rawQuery('SELECT * FROM Data');
    }

    for (var value in result) {
      data.add(value);
    }

    print(result);
    print("dgdfhgfdhugufdyufgdygvfydvgfydgvydfvygfduyvf $data");
  }
}
