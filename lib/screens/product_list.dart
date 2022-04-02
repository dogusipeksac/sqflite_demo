import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  DBHelper dbHelper = DBHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    var productsFuture=dbHelper.getProducts();
    productsFuture.then((data) => products=data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
    itemCount: productCount,
    itemBuilder: (BuildContext context,int position){
      return Card(
        color: Colors.cyan,
        elevation: 2.0,
        child: ListTile(
          leading: const CircleAvatar(backgroundColor: Colors.black12,child: Text("P"),),
          title: Text(products[position].name),
          subtitle: Text(products[position].description),
          onTap: (){},
        ),
      );
    });
  }
}
