import 'package:flutter/material.dart';
import 'model.dart';

class EntryForm extends StatefulWidget {
  final Model menu;

  EntryForm(this.menu);

  @override
  EntryFormState createState() => EntryFormState(this.menu);
}

class EntryFormState extends State<EntryForm> {
  Model menu;

  EntryFormState(this.menu);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (menu != null) {
      nameController.text = menu.name;
      priceController.text = menu.price.toString();
      descriptionController.text = menu.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: menu == null ? Text('Tambah') : Text('Ubah'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left:10.0, right:10.0),
        child: ListView(
          children: <Widget> [
            Padding (
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding (
              padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding (
              padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding (
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: <Widget> [
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.1,
                      ),
                      onPressed: () {
                        if (menu == null) {
                          menu = Model(
                            nameController.text, 
                            int.parse(priceController.text), 
                            descriptionController.text
                          );
                        } else {
                          menu.name = nameController.text;
                          menu.price = int.parse(priceController.text);
                          menu.description = descriptionController.text;
                        }
                        Navigator.pop(context, menu);
                      },
                    ),
                  ),
                  Container(width: 5.0,),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.1,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}