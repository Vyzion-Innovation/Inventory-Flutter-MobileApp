import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';

class InventoryModel {
  final String? id;
  final SupplierModel? seller;
  final String? configuration;
  final CustomerModel? buyer;
  final String? status;
  final String? companyName;
  final int? updatedAt;
  final String? brand;
  final int? purchaseAmountNum;
  final String? modelNumber;
  final int? purchaseTimestamp;
  final String? purchaseAmount;
  final String? paidBy;
  final int? sellAmountNum;
  final int? sellTimestamp;
  final String? purchaseDate;
  final String? sellAmount;
  final String? serialNumber;
  final String? sellDate;
  final int? createdAt;
  final String? itemCode;

  InventoryModel({
    this.id,
    this.seller,
    this.configuration,
    this.buyer,
    this.status,
    this.companyName,
    this.updatedAt,
    this.brand,
    this.purchaseAmountNum,
    this.modelNumber,
    this.purchaseTimestamp,
    this.purchaseAmount,
    this.paidBy,
    this.sellAmountNum,
    this.sellTimestamp,
    this.purchaseDate,
    this.sellAmount,
    this.serialNumber,
    this.sellDate,
    this.createdAt,
    this.itemCode,
  });

  // Factory method to create an InventoryModel instance from Firestore document
  factory InventoryModel.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>? ?? {};
  return InventoryModel(
    id: doc.id,
    seller: data['seller'] != null
        ? SupplierModel.fromMap(data['seller'] as Map<String, dynamic>)
        : null,
    configuration: data['configuration'] as String?,
    buyer: data['buyer'] != null
        ? CustomerModel.fromMap(data['buyer'] as Map<String, dynamic>)
        : null,
    status: data['status'] as String?,
    companyName: data['company_name'] as String?,
    updatedAt: data['updated_at'] != null ? data['updated_at'] as int : null,
    brand: data['brand'] as String?,
    purchaseAmountNum: data['purchase_amount_num'] as int?,
    modelNumber: data['model_number'] as String?,
    purchaseTimestamp: data['purchase_timestamp'] != null ? data['purchase_timestamp'] as int : null,
    purchaseAmount: data['purchase_amount'] as String?,
    paidBy: data['paid_by'] as String?,
    sellAmountNum: data['sell_amount_num'] as int?,
    sellTimestamp: data['sell_timestamp'] != null ? data['sell_timestamp'] as int : null,
    purchaseDate: data['purchase_date'] as String?,
    sellAmount: data['sell_amount'] as String?,
    serialNumber: data['serial_number'] as String?,
    sellDate: data['sell_date'] as String?,
    createdAt: data['created_at'] != null ? data['created_at'] as int : null,
    itemCode: data['item_code'] as String?,
  );
}


  // Method to convert an InventoryModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'seller': seller?.toJson(),
      'configuration': configuration,
      'buyer': buyer?.toJson(),
      'status': status,
      'company_name': companyName,
      'updated_at': updatedAt,
      'brand': brand,
      'purchase_amount_num': purchaseAmountNum,
      'model_number': modelNumber,
      'purchase_timestamp': purchaseTimestamp,
      'purchase_amount': purchaseAmount,
      'paid_by': paidBy,
      'sell_amount_num': sellAmountNum,
      'sell_timestamp': sellTimestamp,
      'purchase_date': purchaseDate,
      'sell_amount': sellAmount,
      'serial_number': serialNumber,
      'sell_date': sellDate,
      'created_at': createdAt,
      'item_code': itemCode,
    };
  }
}
