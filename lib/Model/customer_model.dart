import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String? id; // Document ID
  final String? phone;
  final String? billingAddress;
  final String? name;
  final int? updatedAt;
  final int? createdAt;

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
      return CustomerModel.fromMap(data, doc.id);
  }
  factory CustomerModel.fromMap(Map<String, dynamic> data, [String? id]) {
    return CustomerModel(
      id: id, // Get the document ID from the snapshot
      phone: data['phone'] as String?,
      billingAddress: data['billing_address'] as String?,
      name: data['name'] as String?,
       updatedAt: data['updated_at'] != null ? data['updated_at'] as int : null,
     createdAt: data['created_at'] != null ? data['created_at'] as int : null,
    );
  }


  // Method to convert a Customer instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'billing_address': billingAddress,
      'name': name,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
