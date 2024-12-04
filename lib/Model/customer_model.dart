class CustomerModel {
  final String? phone;
  final String? billingAddress;
  final String? name;
  final DateTime? updatedAt;
  final DateTime ?createdAt;

  CustomerModel({
    required this.phone,
    required this.billingAddress,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
  });

  // Factory method to create a Customer instance from a JSON map
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      phone: json['phone'] as String?,
      billingAddress: json['billing_address'] as String?,
      name: json['name'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updated_at'] as int)
          : null, // Handle nullable updatedAt
      createdAt: json['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int)
          : null, // Handle nullable crea
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
