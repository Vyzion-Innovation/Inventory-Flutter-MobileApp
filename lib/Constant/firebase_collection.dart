import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  // Collection references
  static final CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  static final CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');
      static final CollectionReference inventory =
      FirebaseFirestore.instance.collection('inventories');
  static final CollectionReference repairs =
      FirebaseFirestore.instance.collection('repairs');

  // Add other collection references here
}
