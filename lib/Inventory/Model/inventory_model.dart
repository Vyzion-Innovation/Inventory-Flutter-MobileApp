class InventoryModel {
  Seller? seller;
  String? configuration;
  Buyer? buyer;
  String? status;
  String? companyName;
  int? updatedAt;
  String? brand;
  int? purchaseAmountNum;
  String? modelNumber;
  int? purchaseTimestamp;
  int? purchaseAmount;
  String? paidBy;
  int? sellAmountNum;
  int? sellTimestamp;
  String? purchaseDate;
  int? sellAmount;
  String? serialNumber;
  String? sellDate;
  int? createdAt;
  String? itemCode;

  InventoryModel(
      {this.seller,
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
      this.itemCode});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    seller =
        json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    configuration = json['configuration'];
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
    status = json['status'];
    companyName = json['company_name'];
    updatedAt = json['updated_at'];
    brand = json['brand'];
    purchaseAmountNum = json['purchase_amount_num'];
    modelNumber = json['model_number'];
    purchaseTimestamp = json['purchase_timestamp'];
    purchaseAmount = json['purchase_amount'];
    paidBy = json['paid_by'];
    sellAmountNum = json['sell_amount_num'];
    sellTimestamp = json['sell_timestamp'];
    purchaseDate = json['purchase_date'];
    sellAmount = json['sell_amount'];
    serialNumber = json['serial_number'];
    sellDate = json['sell_date'];
    createdAt = json['created_at'];
    itemCode = json['item_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    data['configuration'] = this.configuration;
    if (this.buyer != null) {
      data['buyer'] = this.buyer!.toJson();
    }
    data['status'] = this.status;
    data['company_name'] = this.companyName;
    data['updated_at'] = this.updatedAt;
    data['brand'] = this.brand;
    data['purchase_amount_num'] = this.purchaseAmountNum;
    data['model_number'] = this.modelNumber;
    data['purchase_timestamp'] = this.purchaseTimestamp;
    data['purchase_amount'] = this.purchaseAmount;
    data['paid_by'] = this.paidBy;
    data['sell_amount_num'] = this.sellAmountNum;
    data['sell_timestamp'] = this.sellTimestamp;
    data['purchase_date'] = this.purchaseDate;
    data['sell_amount'] = this.sellAmount;
    data['serial_number'] = this.serialNumber;
    data['sell_date'] = this.sellDate;
    data['created_at'] = this.createdAt;
    data['item_code'] = this.itemCode;
    return data;
  }
}

class Seller {
  int? createdAt;
  String? id;
  String? phone;
  int? updatedAt;
  String? name;
  String? address;

  Seller(
      {this.createdAt,
      this.id,
      this.phone,
      this.updatedAt,
      this.name,
      this.address});

  Seller.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    phone = json['phone'];
    updatedAt = json['updated_at'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class Buyer {
  String? id;
  String? phone;
  String? billingAddress;
  String? name;
  int? updatedAt;
  int? createdAt;

  Buyer(
      {this.id,
      this.phone,
      this.billingAddress,
      this.name,
      this.updatedAt,
      this.createdAt});

  Buyer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    billingAddress = json['billing_address'];
    name = json['name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['billing_address'] = this.billingAddress;
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}