import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class SendNotification {
  Future<void> sendNotification(String deviceToken, String title, String body);
}

class SendNotificationImpl extends SendNotification {

  @override
  Future<void> sendNotification(String deviceToken, String title, String body) async {
    const String serverKey = 'AAAAXbTykJY:APA91bFT_x0BlSuya46wUg7wgBD6c0RMjMO2TEhzLh9gFHctUalnYYRBzSR-HhrctXN2OZnCHYQHVw9bMFNY1WCkNdVvDDfACMLa9oQXYpfm5wyA9rm-R6tJX5pLHf4rMHiwq8HjGmyK';
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final Map<String, dynamic> data = {
      'to': deviceToken,
      'notification': {
        'title': title,
        'body': body,
        'sound': 'default', // You can customize the notification sound here
      },
    };

    final String jsonData = json.encode(data);

    try {
      final response = await http.post(Uri.parse(fcmUrl), headers: headers, body: jsonData);

      if (response.statusCode == 200) {
        print(deviceToken);
        print('Notification sent successfully');
      } else {
        print('Failed to send notification. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

}