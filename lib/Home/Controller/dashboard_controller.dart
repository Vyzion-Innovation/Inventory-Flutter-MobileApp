import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:inventoryappflutter/Add_Customer/View/add_customer_screen.dart';
import 'package:inventoryappflutter/Add_Inventory/View/add_inventory.dart';
import 'package:inventoryappflutter/Add_Repair/View/repair_screen.dart';
import 'package:inventoryappflutter/Add_Supplier/View/add_supplier_screen.dart';
import 'package:inventoryappflutter/Model/inventory_model.dart';
import 'package:inventoryappflutter/Model/repair_model.dart';

class DashboardController extends GetxController {
  var count = 0.obs; // Observable count variable
  var isVisible = false.obs; // Tracks visibility of the side panel
  var totalPurchaseAmount = 0.0.obs;
  var sellCount = 0.obs;
  var totalSelleAmount = 0.0.obs;
  var currentMonthRepairAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStockCountAndSum(); // Fetch inventory count on initialization
    fetchSellCountAndSum();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchStockCountAndSum() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('inventories')
          .where('status', isEqualTo: 'stock')
          .get();
      // Map the documents to InventoryModel instances
      List<InventoryModel> inventories = snapshot.docs.map((doc) {
        return InventoryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      count.value = inventories.length;
      totalPurchaseAmount.value = inventories.fold(
        0.0,
        (sum, inventory) => sum + (inventory.purchaseAmountNum ?? 0.0),
      );
    } catch (e) {
      print("Error fetching inventory: $e");
    }
  }

   Future<void> fetchSellCountAndSum() async {
     DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month -1, 1);
    DateTime startOfNextMonth = DateTime(now.year, now.month + 1, 1);

    int startTimestamp = startOfMonth.millisecondsSinceEpoch;
    int endTimestamp = startOfNextMonth.millisecondsSinceEpoch;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('inventories')
          .where('status', isEqualTo: 'sell')
           .where('sell_timestamp', isGreaterThanOrEqualTo: startTimestamp)
          .where('createdAt', isLessThan: endTimestamp)
          .get();
      // Map the documents to InventoryModel instances
      List<InventoryModel> inventories = snapshot.docs.map((doc) {
        return InventoryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      totalSelleAmount.value = inventories.fold(
        0.0,
        (sum, inventory) => sum + (inventory.sellAmountNum ?? 0.0),
      );
    } catch (e) {
      print("Error fetching inventory: $e");
    }
  }

  void fetchRepairList(String status) async {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime startOfNextMonth = DateTime(now.year, now.month + 1, 1);

    int startTimestamp = startOfMonth.millisecondsSinceEpoch;
    int endTimestamp = startOfNextMonth.millisecondsSinceEpoch;

    try {
      Query query = FirebaseFirestore.instance
          .collection('repairs')
          .where('createdAt', isGreaterThanOrEqualTo: startTimestamp)
          .where('createdAt', isLessThan: endTimestamp);

      // Apply a filter based on the selected button

      if (status.toLowerCase() == 'Complete'.toLowerCase()) {
        query = query.where('status', isEqualTo: 'Complete'.toLowerCase());
      }

      QuerySnapshot snapshot = query.get() as QuerySnapshot<Object?>;

      // Map Firestore documents to `RepairModel` list
      List<RepairModel> repairs = snapshot.docs.map((doc) {
        return RepairModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      currentMonthRepairAmount.value = repairs.fold(
        0.0,
        (sum, repairs) => sum + (repairs.finalCostNum ?? 0.0),
      );

      // Update the repair list and apply filters
    } catch (e) {
      print("Error fetching repair list: $e");
    }
  }

  void aboutScreenRoute(String button) {
    switch (button) {
      case 'inventory':
        Get.to(() => InventoryFormScreen());
        break;
      case 'supplier':
        Get.to(() => AddSupplierScreen());
        break;
      case 'repair':
        Get.to(() => RepairFormScreen());
        break;
      case 'customer':
        Get.to(() => AddCustomerScreen());
        break;
      default:
        print('Invalid button type: $button');
        break;
    }
  }
}
