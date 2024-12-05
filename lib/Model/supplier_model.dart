import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierModel {
  final String? id; // Document ID
  final String? phone;
  final String? supplierAddress;
  final String? name;
  final int? updatedAt;
  final int? createdAt;

  SupplierModel({
     this.id, // Include the document ID in the constructor
    required this.phone,
    required this.supplierAddress,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
  });

  // Factory method to create a SupplierModel instance from a Firestore document snapshot
  factory SupplierModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SupplierModel.fromMap(data, doc.id);
  }

  // Factory method to create a SupplierModel instance from a Map<String, dynamic>
  factory SupplierModel.fromMap(Map<String, dynamic> data, [String? id]) {
    return SupplierModel(
      id: id,
      phone: data['phone'] as String?,
      supplierAddress: data['address'] as String?,
      name: data['name'] as String?,
      updatedAt: data['updated_at'] != null ? data['updated_at'] as int : null,
    createdAt: data['created_at'] != null ? data['created_at'] as int : null,
    );
  }


  // Method to convert a SupplierModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'address': supplierAddress,
      'name': name,
     'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
