class ProfileModel {
  final String? phone;
  final String? city;
  final String? gstNumber;
   final String? name;
  final String? pincode;
   final String? role;
   final String? uid;
  final int? updatedAt;
  final int? createdAt;

  ProfileModel({
     this.phone,
     this.city,
     this.name,
      this.pincode,
     this.gstNumber,
     this.uid,
       this.role,
       this.updatedAt,
     this.createdAt,
  });

  // Factory method to create a Customer instance from a JSON map
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      phone: json['phone'] as String?,
      city: json['city'] as String?,
      name: json['name'] as String?,
          pincode: json['pinCode'] as String?,
      gstNumber: json['gstNumber'] as String?,
       role: json['role'] as String?,
      uid: json['uid'] as String?,
       updatedAt: json['updated_at'] != null ? json['updated_at'] as int : null,
     createdAt: json['created_at'] != null ? json['created_at'] as int : null,
    );
  }

  // Method to convert a Customer instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'city': city,
       'name': name,
      'pinCode': pincode,
       'role': role,
      'gstNumber': gstNumber,
      'uid': uid,
       'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
