import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sous_chef_app/services/server.dart';
import 'dart:convert';

List<List<dynamic>> inventory = [];
List<List<dynamic>> entireInventory = [];

class foodDB {
  Future<List<List<dynamic>>> fetchInventoryData() async {
    try {
      final response = await http.get(Uri.parse('http://${Server.address}/inventory/'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<List<dynamic>> fetchedInventory = [];

        jsonData.forEach((key, value) {
          int id = value['id'];
          String name = value['name'];
          int? quantity = value['quantity'];
          String? expirationDate = value['expiration_date'];
          String location = value['food_type'];
          String? imageUrl = value['image_url'];
          int daysLeft = -1;

          if (expirationDate != null){
            // Calculate days left from today to expiration date
            DateTime today = DateTime.now();
            DateTime expiryDate = DateTime.parse(expirationDate);
            daysLeft = expiryDate.difference(today).inDays;
          }
          
          // Create list of food details
          List<dynamic> foodDetails = [
            id,
            name,
            quantity,
            daysLeft,
            location,
            imageUrl,
          ];
          
          fetchedInventory.add(foodDetails);
        });

        // Check if fetched inventory is different from existing inventory
        if (!listEquals(inventory, fetchedInventory)) {
          // Update inventory and entireInventory
          inventory = fetchedInventory;
          entireInventory = fetchedInventory;
        }

        fetchedInventory.sort((a, b) => a[3].compareTo(b[3]));

        return fetchedInventory;
      } else {
        throw Exception('Failed to load inventory');
      }
    } catch (e) {
      print('Error fetching inventory: $e');
      return [];
    }
  }
}
