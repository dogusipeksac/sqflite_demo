import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var dbHelper = DBHelper();
  var textName = TextEditingController();
  var textDescription = TextEditingController();
  var textUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni ürün ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün adı"),
      controller: textName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün açıklaması"),
      controller: textDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Birim fiyatı"),
      controller: textUnitPrice,
    );
  }

  buildSaveButton() {
    return FlatButton(
      onPressed: () {
        addProduct();
      },
      child: const Text("Ekle"),
    );
  }

  void addProduct() async {
    var result=await dbHelper.insertProduct(Product(name:textName.text, description:textDescription.text,
        unitPrice: double.tryParse(textUnitPrice.text)!));
    Navigator.pop(context,true);
  }
}
