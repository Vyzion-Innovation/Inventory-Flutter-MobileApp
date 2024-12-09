import 'package:flutter/material.dart';
import 'package:inventoryappflutter/Model/inventory_model.dart';

class InventoryDetailsScreen extends StatelessWidget {
  final InventoryModel inventory;

  const InventoryDetailsScreen({Key? key, required this.inventory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supplier Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Customer Name: ${inventory.itemCode ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Phone: ${inventory.companyName ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Model: ${inventory.modelNumber ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Job Number: ${inventory.configuration ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Issue: ${inventory.modelNumber ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Description: ${inventory.status ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Estimated Cost: ${inventory.purchaseAmount ?? 0}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Final Cost: ${inventory.sellAmount ?? 0}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Status: ${inventory.status ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Complete Date: ${inventory.serialNumber ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Created At: ${inventory.createdAt ?? 0}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Updated At: ${inventory.updatedAt ?? 0}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
