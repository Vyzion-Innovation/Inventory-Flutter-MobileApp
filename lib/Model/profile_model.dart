class ProfileModel {
  final String? phone;
  final String? city;
  final String? gstNumber;
   final String? name;
  final String? pincode;
   final String? role;
   final String? uid;
  final DateTime updatedAt;
  final DateTime createdAt;

  ProfileModel({
    required this.phone,
    required this.city,
    required this.name,
     required this.pincode,
    required this.gstNumber,
    required this.uid,
      required this.role,
      required this.updatedAt,
    required this.createdAt,
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
        updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updated_at'] as int),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
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
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }
}
