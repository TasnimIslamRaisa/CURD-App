class productModal{

  String? img;
  String? productCode;
  String? productName;
  String? qty;
  String? totalPrice;
  String? unitPrice;
  String? productId;

  productModal(
      {required productName,
        required productCode,
        required img,
        required unitPrice,
        required qty,
        required totalPrice,
        required  productId
      }
      );

  factory  productModal.fromJson(Map<String, dynamic> json) {
    return productModal(
      productId: json['_id'],
      productName: json['ProductName'],
      productCode: json['ProductCode'],
      img: json['Img'],
      unitPrice: json['UnitPrice'],
      qty: json['Qty'],
      totalPrice: json['TotalPrice'],
      );
  }


  // Map<String, dynamic> toJson() {
  //   return {
  //     'ProductName': productName,
  //     'ProductCode': productCode,
  //     'Img': img,
  //     'UnitPrice': unitPrice,
  //     'Qty': qty,
  //     'TotalPrice': totalPrice,
  //   };
  // }

}