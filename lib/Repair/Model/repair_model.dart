class RepairModel {
  String? description;
  String? issue;
  String? phone;
  int? completeTimestamp;
  int? createdAt;
  int? estimatedCostNum;
  int? finalCostNum;
  String? completeDate;
  int? updatedAt;
  String? jobNumber;
  String? model;
  String? customerName;
  String? status;

  // Constructor
  RepairModel({
    this.description,
    this.issue,
    this.phone,
    this.completeTimestamp,
    this.createdAt,
    this.estimatedCostNum,
    this.finalCostNum,
    this.completeDate,
    this.updatedAt,
    this.jobNumber,
    this.model,
    this.customerName,
    this.status,
  });

  // Factory method to create an instance from JSON
  factory RepairModel.fromJson(Map<String, dynamic> json) {
    return RepairModel(
      description: json['description'] as String?,
      issue: json['issue'] as String?,
      phone: json['phone'] as String?,
      completeTimestamp: json['complete_timestamp'] as int?,
      createdAt: json['created_at'] as int?,
      estimatedCostNum: json['estimated_cost_num'] as int?,
      finalCostNum: json['final_cost_num'] as int?,
      completeDate: json['complete_date'] as String?,
      updatedAt: json['updated_at'] as int?,
      jobNumber: json['job_number'] as String?,
      model: json['model'] as String?,
      customerName: json['customer_name'] as String?,
      status: json['status'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'issue': issue,
      'phone': phone,
      'complete_timestamp': completeTimestamp,
      'created_at': createdAt,
      'estimated_cost_num': estimatedCostNum,
      'final_cost_num': finalCostNum,
      'complete_date': completeDate,
      'updated_at': updatedAt,
      'job_number': jobNumber,
      'model': model,
      'customer_name': customerName,
      'status': status,
    };
  }
}
