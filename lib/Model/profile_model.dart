import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String? phone;
  final String? city;
  final String? gstNumber;
   final String? name;
  final String? pincode;
   final String? role;
   final String? id;
    final String? uid;
   final String? address;
  final int? updatedAt;
  final int? createdAt;

  ProfileModel({
     this.phone,
     this.city,
     this.name,
      this.pincode,
       this.address,
     this.gstNumber,
     this.id,
     this.uid,
       this.role,
       this.updatedAt,
     this.createdAt,
  });

  // Factory method to create a Customer instance from a JSON map
    factory ProfileModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProfileModel.fromMap(data, doc.id);
  }

   factory ProfileModel.fromMap(Map<String, dynamic> data, [String? id]) {
    return ProfileModel(
      id: id,
      phone: data['phone'] as String?,
      address: data['address'] as String?,
      name: data['name'] as String?,
       pincode: data['pinCode'] as String?,
      gstNumber: data['gstNumber'] as String?,
      role: data['role'] as String?,
        city: data['city'] as String?,
         uid: data['uid'] as String?,
      updatedAt: data['updated_at'] != null ? data['updated_at'] as int : null,
    createdAt: data['created_at'] != null ? data['created_at'] as int : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'city': city,
       'name': name,
      'pinCode': pincode,
       'role': role,
      'gstNumber': gstNumber,
      'uid': uid,
      'address': address,
       'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
