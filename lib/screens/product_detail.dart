import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;

  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  Product product;

  _ProductDetailState(this.product);

  var dbHelper = DBHelper();
  var textName = TextEditingController();
  var textDescription = TextEditingController();
  var textUnitPrice = TextEditingController();

  @override
  void initState() {
    textName.text=product.name;
    textDescription.text=product.description;
    textUnitPrice.text=product.unitPrice.toString();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün detayı: ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              const PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              const PopupMenuItem<Options>(
                value: Options.update,
                child: Text("güncelle"),
              ),
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField()
        ],
      ),
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün adı"),
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

  void selectProcess(Options value) async {
    switch (value) {
      case Options.delete:
        await dbHelper.deleteProduct(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.updateProduct(Product.withId(
            id: product.id,
            name: textName.text,
            description: textDescription.text,
            unitPrice: double.tryParse(textUnitPrice.text)!));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
