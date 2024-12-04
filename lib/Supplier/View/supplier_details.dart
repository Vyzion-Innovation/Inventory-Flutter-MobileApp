import 'package:flutter/material.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';

class SupplierDetails extends StatelessWidget {
  final SupplierModel supplier;

  const SupplierDetails({Key? key, required this.supplier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("inventory Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Customer Name: ${supplier.name ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Phone: ${supplier.phone ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Billing Address: ${supplier.supplierAddress ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
           const SizedBox(height: 8),
            Text("Created At: ${supplier.createdAt}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
        
          ],
        ),
      ),
    );
  }
}
