import 'package:cloud_firestore/cloud_firestore.dart';

class RepairModel {
  final String? id;
  String? description;
  String? issue;
  String? phone;
  int? completeTimestamp;
  int? createdAt;
  int? estimatedCostNum;
  String? estimatedCost;
  int? finalCostNum;
  String? finalCost;
  String? completeDate;
  int? updatedAt;
  String? jobNumber;
  String? model;
  String? customerName;
  String? status;

  // Constructor
  RepairModel({
     this.id,
    this.description,
    this.issue,
    this.phone,
    this.completeTimestamp,
    this.createdAt,
    this.estimatedCostNum,
    this.finalCostNum,
     this.estimatedCost,
    this.finalCost,
    this.completeDate,
    this.updatedAt,
    this.jobNumber,
    this.model,
    this.customerName,
    this.status,
  });

  // Factory method to create an instance from JSON
  factory RepairModel.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>? ?? {};
  return RepairModel(
    id: doc.id,
      description: data['description'] as String?,
      issue: data['issue'] as String?,
      phone: data['phone'] as String?,
      completeTimestamp: data['complete_timestamp'] as int?,
      createdAt: data['created_at'] as int?,
      estimatedCostNum: data['estimated_cost_num'] as int?,
       jobNumber: data['job_number'] as String?,
        estimatedCost: data['estimated_cost'] as String?,
      finalCostNum: data['final_cost_num'] as int?,
      completeDate: data['complete_date'] as String?,
      updatedAt: data['updated_at'] as int?,
      finalCost: data['final_cost'] as String?,
      model: data['model'] as String?,
      customerName: data['customer_name'] as String?,
      status: data['status'] as String?,
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
      'estimated_cost': estimatedCost,
      'final_cost': finalCost
    };
  }
}
