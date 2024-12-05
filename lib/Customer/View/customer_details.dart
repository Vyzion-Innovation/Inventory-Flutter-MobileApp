import 'package:flutter/material.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDetailsScreen({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Customer Name: ${customer.name ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Phone: ${customer.phone ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Billing Address: ${customer.billingAddress ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
           const SizedBox(height: 8),
            Text("Created At: ${customer.createdAt}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
        
          ],
        ),
      ),
    );
  }
}
