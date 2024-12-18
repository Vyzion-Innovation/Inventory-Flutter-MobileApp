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
  var repairCount = 0.obs;
  var isVisible = false.obs; // Tracks visibility of the side panel
  var totalPurchaseAmount = 0.0.obs;
  var sellCount = 0.obs;
  var totalSelleAmount = 0.0.obs;
  var currentMonthRepairAmount = 0.0.obs;
   final RxList<InventoryModel> inventoryList = <InventoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
     fetchRepairList();
    fetchStockCountAndSum(); // Fetch inventory count on initialization
    fetchSellCountAndSum();
   fetchRepairListCount();
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
      List<InventoryModel> inventories = snapshot.docs
    .map((doc) => InventoryModel.fromFirestore(doc))
    .toList();

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
    DateTime sevenDaysBack = now.subtract(Duration(days: 7));

    int startTimestamp = startOfMonth.millisecondsSinceEpoch;
     int sevenDaysBackTimeStamp = sevenDaysBack.millisecondsSinceEpoch;
    
   try {
  // Fetch all sell records to calculate the total sell amount
  QuerySnapshot allRecordsSnapshot = await FirebaseFirestore.instance
      .collection('inventories')
      .where('status', isEqualTo: 'sell')
      .where('sell_timestamp', isGreaterThanOrEqualTo: startTimestamp)
      .get();

  // Calculate the total sell amount for all records
  List<InventoryModel> allInventories = allRecordsSnapshot.docs
      .map((doc) => InventoryModel.fromFirestore(doc))
      .toList();

  totalSelleAmount.value = allInventories.fold(
    0.0,
    (sum, inventory) => sum + (inventory.sellAmountNum ?? 0.0),
  );

  // Fetch only the 5 most recent sell records for display
  QuerySnapshot recentRecordsSnapshot = await FirebaseFirestore.instance
      .collection('inventories')
      .where('status', isEqualTo: 'sell')
      .orderBy('sell_timestamp', descending: true) // Order by most recent
      .where('sell_timestamp', isGreaterThanOrEqualTo: sevenDaysBackTimeStamp)
      .limit(5) // Limit to the most recent 5 records
      .get();

  // Map the recent records to InventoryModel instances
  List<InventoryModel> recentInventories = recentRecordsSnapshot.docs
      .map((doc) => InventoryModel.fromFirestore(doc))
      .toList();

  inventoryList.assignAll(recentInventories);
    } catch (e) {
      print("Error fetching inventory: $e");
    }
  }

  void fetchRepairList() async {
   DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month -1, 1);
   

    int startTimestamp = startOfMonth.millisecondsSinceEpoch;
       try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('repairs')
          .where('status', isEqualTo: 'complete')
           .where('complete_timestamp', isGreaterThanOrEqualTo: startTimestamp)
          .get();
      // Map the documents to InventoryModel instances
      List<RepairModel> repairs = snapshot.docs
    .map((doc) => RepairModel.fromFirestore(doc))
    .toList();
      currentMonthRepairAmount.value = repairs.fold(
        0.0,
        (sum, repair) => sum + (repair.finalCostNum ?? 0.0),
      );
    } catch (e) {
      print("Error fetching repair: $e");
    }
  }
  void fetchRepairListCount() async {
   DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month -1, 1);
            try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('repairs')
          .where('status', isEqualTo: 'receive')
          .get();
      // Map the documents to InventoryModel instances
      List<RepairModel> repairs = snapshot.docs
    .map((doc) => RepairModel.fromFirestore(doc))
    .toList();
      repairCount.value = repairs.length;
    } catch (e) {
      print("Error fetching repair: $e");
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
