import 'dart:convert';
import 'package:curd_app/screens/product_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../modal/productModal.dart';
import '../style/style.dart';

class updateProductDetails extends StatefulWidget {
  const updateProductDetails({super.key, required this.product});
  final ProductModal product;

  @override
  State<updateProductDetails> createState() => _updateProductDetailsState();
}

class _updateProductDetailsState extends State<updateProductDetails> {
  TextEditingController productNamecontroller = TextEditingController();
  TextEditingController productCodecontroller = TextEditingController();
  TextEditingController unitPricecontroller = TextEditingController();
  TextEditingController qtycontroller = TextEditingController();
  TextEditingController totalPicecontroller = TextEditingController();
  TextEditingController imageurlcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool updateproductIndicator = false;

  @override
  void initState() {
    productNamecontroller.text = widget.product.productName ?? "";
    productCodecontroller.text = widget.product.productCode ?? "";
    unitPricecontroller.text = widget.product.unitPrice ?? "";
    qtycontroller.text = widget.product.quantity ?? "";
    totalPicecontroller.text = widget.product.totalPrice ?? "";
    imageurlcontroller.text = widget.product.image ?? "";
    super.initState();
  }

  @override
  void dispose() {
    productCodecontroller.dispose();
    productNamecontroller.dispose();
    unitPricecontroller.dispose();
    qtycontroller.dispose();
    totalPicecontroller.dispose();
    imageurlcontroller.dispose();
    super.dispose();
  }

  Future<void> updateProduct() async {
    updateproductIndicator = true;
    setState(() {});
    String updateProductUrl =
        "https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}";
    Uri updateProductUri = Uri.parse(updateProductUrl);

    //prepare data
    Map<String, dynamic> inputData = {
      "Img": imageurlcontroller.text.trim(),
      "ProductCode": productCodecontroller.text,
      "ProductName": productNamecontroller.text,
      "Qty": qtycontroller.text,
      "TotalPrice": totalPicecontroller.text,
      "UnitPrice": unitPricecontroller.text
    };

    var encodeData = jsonEncode(inputData);

    Response response = await post(
      updateProductUri,
      body: encodeData,
      headers: {'content-type': 'application/json'},
    );
    var code = response.statusCode;
    var body = response.body;
    print(code);
    print(body);

    if (code == 200) {
      clearForm();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProductListView(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New product added!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add new product failed! Try again.')),
      );
    }

    updateproductIndicator = false;
    setState(() {});
  }

  void clearForm() {
    productNamecontroller.clear();
    productCodecontroller.clear();
    unitPricecontroller.clear();
    qtycontroller.clear();
    totalPicecontroller.clear();
    imageurlcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit A product Details"),
        centerTitle: true,
        backgroundColor: tealColor,
        foregroundColor: whiteColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: productNamecontroller,
                decoration: formStyle("Product Name"),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please write Your Product name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: productCodecontroller,
                decoration: formStyle("Product Code"),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please write Your Product name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: unitPricecontroller,
                decoration: formStyle("Unit Price"),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please write Your Product name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: qtycontroller,
                decoration: formStyle("Quantity"),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please write Your Product name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: totalPicecontroller,
                decoration: formStyle("Total Price"),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please write Your Product name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: imageurlcontroller,
                decoration: formStyle("Image Url"),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please write Your Product name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: updateproductIndicator == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateProduct();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tealColor,
                      foregroundColor: whiteColor,
                      fixedSize: const Size.fromWidth(double.maxFinite),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: const Text("Done"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
