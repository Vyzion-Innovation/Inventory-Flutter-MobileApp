class SupplierModel {
  final String? phone;
  final String? supplierAddress;
  final String? name;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  SupplierModel({
    required this.phone,
    required this.supplierAddress,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
  });

  // Factory method to create a SupplierModel instance from a JSON map
  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      phone: json['phone'] as String?, // Handle nullable phone
      supplierAddress: json['address'] as String?, // Handle nullable address
      name: json['name'] as String?, // Handle nullable name
      updatedAt: json['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updated_at'] as int)
          : null, // Handle nullable updatedAt
      createdAt: json['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int)
          : null, // Handle nullable createdAt
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
