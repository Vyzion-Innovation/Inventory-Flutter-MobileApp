import 'package:flutter/material.dart';
import 'package:inventoryappflutter/Model/repair_model.dart';

class RepairDetailsScreen extends StatelessWidget {
  final RepairModel repair;

  const RepairDetailsScreen({Key? key, required this.repair}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repair Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Customer Name: ${repair.customerName ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Phone: ${repair.phone ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Model: ${repair.model ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Job Number: ${repair.jobNumber ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Issue: ${repair.issue ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Description: ${repair.description ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Estimated Cost: ${repair.estimatedCostNum ?? 0}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Final Cost: ${repair.finalCostNum ?? 0}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Status: ${repair.status ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Complete Date: ${repair.completeDate ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Created At: ${DateTime.fromMillisecondsSinceEpoch(repair.createdAt ?? 0)}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Updated At: ${DateTime.fromMillisecondsSinceEpoch(repair.updatedAt ?? 0)}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
