import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierModel {
  String? documentId;
  late String content;
  late Timestamp createdOn;
  late bool isDone;

  SupplierModel({
    required this.content,
    required this.isDone,
//     required this.createdOn,
  });

  SupplierModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    content = documentSnapshot["content"];
    createdOn = documentSnapshot["createdOn"];
    isDone = documentSnapshot["isDone"];
  }
}