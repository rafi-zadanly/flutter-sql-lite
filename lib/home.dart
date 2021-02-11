import 'package:flutter/material.dart';
import 'dart:async';
import 'crud.dart';
import 'model.dart';
import 'enter.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CRUD dbHelper = CRUD();
  Future<List<Model>> future;

  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    setState(() {
      future = dbHelper.getAll();
    });
  }

  Future<Model> navigateToEntryForm(BuildContext context, Model client) async {
    var result = await Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return EntryForm(client);
      }
    ));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu List'),
      ),
      body: FutureBuilder<List<Model>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data.map((todo) => cardo(todo)).toList()
            );
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          if (contact != null) {
            int result = await dbHelper.insert(contact);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  Card cardo(Model menu) {
    final currency = new NumberFormat("#,##0", "en_US");
    return Card(
      color: Colors.white,
      elevation: 5.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.food_bank),
        ),
        title: Text(
          menu.name,
        ),
        subtitle: Text('Rp ' + currency.format(menu.price)),
        trailing: GestureDetector(
          child: Icon(Icons.delete),
          onTap: () async {
            int result = await dbHelper.delete(menu);
            if (result > 0) {
              updateListView();
            }
          },
        ),
        onTap: () async {
          var menu2 = await navigateToEntryForm(context, menu);
          if (menu2 != null) {
            int result = await dbHelper.update(menu2);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }
}