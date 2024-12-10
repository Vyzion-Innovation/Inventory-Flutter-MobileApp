import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:inventoryappflutter/Constant/appStrings.dart';
import 'package:inventoryappflutter/Model/repair_model.dart';
import 'package:inventoryappflutter/common/app_common_appbar.dart';
import 'package:inventoryappflutter/common/app_text.dart';

class RepairDetailsScreen extends StatelessWidget {
  final RepairModel repair;

  const RepairDetailsScreen({Key? key, required this.repair}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const AppText(
          Strings.repair,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        isCenter: true,
      ),
      body: ListView(
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
                        label: "Customer Name",
                        value: repair.customerName ?? 'N/A',
                      ),
                      const Divider(),
                      _buildDetailRowWithCopy(
                        context: context,
                        icon: Icons.phone,
                        label: "Phone",
                        value: repair.phone ?? 'N/A',
                      ),
                      const Divider(),
                      _buildDetailRow(
                        icon: Icons.model_training,
                        label: "Model Number",
                        value: repair.model ?? 'N/A',
                      ),
                       const Divider(),
                       _buildDetailRowWithCopy(
                        context: context,
                        icon: Icons.work_outline,
                        label: "Job Number",
                        value: repair.jobNumber ?? 'N/A',
                      ),
                       const Divider(),
                      _buildDetailRow(
                        icon: Icons.sync_problem_outlined,
                        label: "Issue",
                        value: repair.issue ?? 'N/A',
                      ),
                       const Divider(),
                      _buildDetailRow(
                        icon: Icons.description,
                        label: "Description",
                        value: repair.description ?? 'N/A',
                      ),
                       const Divider(),
                      _buildDetailRow(
                        icon: Icons.monetization_on,
                        label: "Estimated Cost",
                        value: repair.estimatedCost ?? 'N/A',
                      ),

                       const Divider(),
                      _buildDetailRow(
                        icon: Icons.monetization_on,
                        label: "final Cost",
                        value: repair.finalCost ?? 'N/A',
                      ),
                       const Divider(),
                      _buildDetailRow(
                        icon: Icons.signal_wifi_statusbar_null_sharp,
                        label: "Status",
                        value: repair.status ?? 'N/A',
                      ),
                       const Divider(),
                      _buildDetailRow(
                        icon: Icons.calendar_today,
                        label: "Complete Date",
                        value: repair.completeDate ?? 'N/A',
                      ),
                      const Divider(),
                      _buildDetailRow(
                        icon: Icons.calendar_today,
                        label: "Created At",
                        value: formatTimestamp(repair.createdAt),
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

  Widget _buildDetailRow({required IconData icon, required String label, required String value}) {
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
                    content: Text("Number copied to clipboard!"),
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
