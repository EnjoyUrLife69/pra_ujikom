import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:praujikom/app/data/event_response.dart';
import 'package:praujikom/app/modules/dashboard/views/index_view.dart';
import 'package:praujikom/app/modules/dashboard/views/profile_view.dart';
import 'package:praujikom/app/modules/dashboard/views/your_event_view.dart';
import 'package:praujikom/app/utils/api.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  final _getConnect = GetConnect();

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(),
    YourEventView(),
    ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
    getEvent();
    getYourEvent();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final token = GetStorage().read('token');

  Future<EventResponse> getEvent() async {
    final response = await _getConnect.get(
      BaseUrl.events,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return EventResponse.fromJson(response.body);
  }

  var yourEvents = <Events>[].obs;

  Future<void> getYourEvent() async {
    final response = await _getConnect.get(
      BaseUrl.yourEvent,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    final eventResponse = EventResponse.fromJson(response.body);
    yourEvents.value = eventResponse.events ?? [];
  }


  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void addEvent() async {
    final response = await _getConnect.post(
      BaseUrl.events, // URL buat API tambah event
      {
        'name': nameController.text, 
        'description': descriptionController.text, 
        'event_date': eventDateController.text,
        'location': locationController.text, 
      },
      headers: {
        'Authorization': "Bearer $token"
      },
      contentType: "application/json",
    );

   
    if (response.statusCode == 201) {
      Get.snackbar(
        'Success', 
        'Event Added', 
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.green, 
        colorText: Colors.white, 
      );
      nameController.clear();
      descriptionController.clear();
      eventDateController.clear();
      locationController.clear();
      update(); 
      getEvent(); 
      getYourEvent();
      Get.close(1); 
    } else {
      Get.snackbar(
        'Failed', 
        'Event Failed to Add', 
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.red, 
        colorText: Colors.white,
      );
    }
  }
}
