import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/services/api_service.dart';


class MessageController extends GetxController {
  var responseText = "".obs;
  var messages = <Map<String, dynamic>>[].obs;
  var isTypeing = false.obs;

  Future<void> sendMessage(String message) async {
    // Add user message
    messages.add({
      'text': message,
      'isUser': true,
      'time': DateFormat('hh:mm a').format(DateTime.now()),
    });

    // Show typing indicator
    responseText.value = "Thinking...";
    isTypeing.value = true;

    try {
      // Call FastApiService to get response
      String reply = await FastApiService.askQuestion(message);

      // Add bot response
      messages.add({
        'text': reply,
        'isUser': false,
        'time': DateFormat('hh:mm a').format(DateTime.now()),
      });
    } catch (e) {
      // Add error message if API call fails
      messages.add({
        'text': 'Error: $e',
        'isUser': false,
        'time': DateFormat('hh:mm a').format(DateTime.now()),
      });
    } finally {
      // Hide typing indicator
      isTypeing.value = false;
      responseText.value = "";
    }
  }
}