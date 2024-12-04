import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String? id; // Document ID
  final String? phone;
  final String? billingAddress;
  final String? name;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  CustomerModel({
     this.id,
    required this.phone,
    required this.billingAddress,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
  });

  // Factory method to create a Customer instance from a Firestore document snapshot
  factory CustomerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CustomerModel(
      id: doc.id, // Get the document ID from the snapshot
      phone: data['phone'] as String?,
      billingAddress: data['billing_address'] as String?,
      name: data['name'] as String?,
      updatedAt: data['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['updated_at'] as int)
          : null,
      createdAt: data['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['created_at'] as int)
          : null,
    );
  }

  // Factory method to create a Customer instance from a JSON map
  factory CustomerModel.fromJson(Map<String, dynamic> json, String documentId) {
    return CustomerModel(
      id: documentId, // Pass the document ID from the caller
      phone: json['phone'] as String?,
      billingAddress: json['billing_address'] as String?,
      name: json['name'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updated_at'] as int)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int)
          : null,
    );
  }

  // Method to convert a Customer instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'billing_address': billingAddress,
      'name': name,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'created_at': createdAt?.millisecondsSinceEpoch,
    };
  }
}
