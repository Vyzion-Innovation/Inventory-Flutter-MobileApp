import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Model/customer_model.dart';
import 'package:inventoryappflutter/Model/supplier_model.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_text.dart';

class SupplierDetails extends StatelessWidget {
  final SupplierModel supplier;

  const SupplierDetails({Key? key, required this.supplier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const AppText(
          Strings.supplier,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        isCenter: true,
      ),
      body: Column(
        children: [
          // Gradient header

          const SizedBox(height: 16),
          // Customer details card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        icon: Icons.person,
                        label: "Supplier Name",
                        value: supplier.name ?? 'N/A',
                      ),
                      const Divider(),
                      _buildDetailRowWithCopy(
                        context: context,
                        icon: Icons.phone,
                        label: "Phone",
                        value: '+91-${supplier.phone ?? ''}',
                      ),
                      const Divider(),
                      _buildDetailRow(
                        icon: Icons.location_on,
                        label: "Address",
                        value: supplier.supplierAddress ?? 'N/A',
                      ),
                      const Divider(),
                      _buildDetailRow(
                        icon: Icons.calendar_today,
                        label: "Created At",
                        value: formatTimestamp(supplier.createdAt),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  
                ),
                const SizedBox(height: 4),
                AppText(
                  value,
                  
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
String formatTimestamp(int? timestamp) {
  if (timestamp == null) {
    return "N/A"; // Handle null timestamp
  }
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime); // Customize the format
}

  Widget _buildDetailRowWithCopy({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  
                ),
                const SizedBox(height: 4),
                AppText(
                  value,
                  
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  
                ),
              ],
            ),
          ),
          if (value != 'N/A')
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Phone number copied to clipboard!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.copy, color: Colors.blue),
            ),
        ],
      ),
    );
  }
}
