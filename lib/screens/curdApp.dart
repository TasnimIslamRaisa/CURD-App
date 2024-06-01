import 'package:curd_app/screens/product_list_view.dart';
import 'package:flutter/material.dart';

class curdApp extends StatefulWidget {
  const curdApp({super.key});

  @override
  State<curdApp> createState() => _curdAppState();
}

class _curdAppState extends State<curdApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Curd App Practice",
      debugShowCheckedModeBanner: false,
      home: ProductListView() ,
    );
  }
}
