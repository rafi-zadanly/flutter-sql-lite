class Model {
  int _id;
  String _name;
  int _price;
  String _description;

  Model(
    this._name,
    this._price,
    this._description
  );

  Model.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._price = map['price'];
    this._description = map['description'];
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get price => _price;

  set price(int value) {
    _price = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['description'] = description;
    
    return map;
  }
}