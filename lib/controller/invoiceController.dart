
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class InvoiceController extends GetxController {
//   var items = <InvoiceItem>[].obs;
//   TextEditingController customerNameController = TextEditingController();
//   TextEditingController customerNumberController = TextEditingController();
//   TextEditingController customerAddrController = TextEditingController();
//   TextEditingController itemNameController = TextEditingController();
//   TextEditingController itemPriceController = TextEditingController();
//   TextEditingController itemQuantityController = TextEditingController();
//   void addItem() {
//     final itemName = itemNameController.text;
//     final itemPrice = double.tryParse(itemPriceController.text) ?? 0.0;
//
//     if (itemName.isNotEmpty && itemPrice > 0) {
//       items.add(InvoiceItem(name: itemName, price: itemPrice));
//
//       itemNameController.clear();
//       itemPriceController.clear();
//     }
//   }
//
//   double calculateTotal() {
//     return items.fold(0, (total, item) => total + item.price);
//   }
// }
//
// class InvoiceItem {
//   final String name;
//   final double price;
//
//   InvoiceItem({required this.name, required this.price});
// }


class InvoiceController extends GetxController {
  var items = <InvoiceItem>[].obs;
  
  TextEditingController customerNameController = TextEditingController();
   TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerNumberController = TextEditingController();
  TextEditingController customerAddrController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();

  void addItem() {
    final itemName = itemNameController.text;
    final itemPrice = double.tryParse(itemPriceController.text) ?? 0.0;
    final itemQuantity = int.tryParse(itemQuantityController.text) ?? 1;

    if (itemName.isNotEmpty && itemPrice > 0 && itemQuantity > 0) {
      items.add(InvoiceItem(name: itemName, price: itemPrice, quantity: itemQuantity));

      itemNameController.clear();
      itemPriceController.clear();
      itemQuantityController.clear();
    }
  }

  double calculateTotal() {
    return items.fold(0, (total, item) => total + (item.price * item.quantity));
  }
}

class InvoiceItem {
  final String name;
  final double price;
  final int quantity;

  InvoiceItem({required this.name, required this.price, required this.quantity});
}
