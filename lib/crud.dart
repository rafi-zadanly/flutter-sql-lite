import 'package:sqflite/sqlite_api.dart';
import 'model.dart';
import 'accessDatabase.dart';

class CRUD {
  static const menuTable = 'menus';
  static const id = 'id';
  static const name = 'name';
  static const price = 'price';
  static const description = 'description';
  AccessDatabase dbHelper = new AccessDatabase();

  Future<int> insert(Model menu) async {
    Database db = await dbHelper.initDb();
    
    final sql = 'INSERT INTO ${CRUD.menuTable} (${CRUD.name}, ${CRUD.price}, ${CRUD.description}) VALUES (?, ?, ?)';
    List<dynamic> params = [menu.name, menu.price, menu.description];
    final result = await db.rawInsert(sql, params);

    return result;
  }

  Future<int> update(Model menu) async {
    Database db = await dbHelper.initDb();

    final sql = 'UPDATE ${CRUD.menuTable} SET ${CRUD.name} = ?, ${CRUD.price} = ?, ${CRUD.description} = ? WHERE ${CRUD.id} = ?';
    List<dynamic> params = [menu.name, menu.price, menu.description, menu.id];
    final result = await db.rawUpdate(sql, params);
    
    return result;
  }

  Future<int> delete(Model menu) async {
    Database db = await dbHelper.initDb();

    final sql = 'DELETE FROM ${CRUD.menuTable} WHERE ${CRUD.id} = ?';
    List<dynamic> params = [menu.id];
    final result = await db.rawDelete(sql, params);
    
    return result;
  }

  Future<List<Model>> getAll() async {
    Database db = await dbHelper.initDb();

    final sql = 'SELECT * FROM ${CRUD.menuTable} ORDER BY ${CRUD.id} DESC';
    final data = await db.rawQuery(sql);

    List<Model> menus = List();
    for (final node in data) {
      final menu = Model.fromMap(node);
      menus.add(menu);
    }

    return menus;
  }
}