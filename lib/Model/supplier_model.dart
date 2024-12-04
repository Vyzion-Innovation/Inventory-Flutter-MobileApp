import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierModel {
  final String? id; // Document ID
  final String? phone;
  final String? supplierAddress;
  final String? name;
  final DateTime? updatedAt;
  final DateTime? createdAt;

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
    return SupplierModel(
      id: doc.id, // Get the document ID from the snapshot
      phone: data['phone'] as String?,
      supplierAddress: data['address'] as String?,
      name: data['name'] as String?,
      updatedAt: data['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['updated_at'] as int)
          : null,
      createdAt: data['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['created_at'] as int)
          : null,
    );
  }

  // Factory method to create a SupplierModel instance from a JSON map
  factory SupplierModel.fromJson(Map<String, dynamic> json, String documentId) {
    return SupplierModel(
      id: documentId, // Pass the document ID from the caller
      phone: json['phone'] as String?,
      supplierAddress: json['address'] as String?,
      name: json['name'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updated_at'] as int)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int)
          : null,
    );
  }

  // Method to convert a SupplierModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'address': supplierAddress,
      'name': name,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'created_at': createdAt?.millisecondsSinceEpoch,
    };
  }
}
