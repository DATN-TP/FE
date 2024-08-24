import 'package:ResiEasy/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Vnpayservice {
  final ApiService apiService;

  Vnpayservice(this.apiService);

  Future<void> createPaymentUrl() async {
    final response = await apiService.post('/vnpay/create_payment_url', {
      "amount": 20000,
      "bankCode": "",
      "language": "vn"
    });

    if (response != null) {
      final url = Uri.parse(response); // Assuming the response contains a 'url' field
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
        print("hihi có quay lại nè");
      } else {
        throw Exception('Could not launch $url');
      }
    } else {
      throw Exception('Failed to create payment url');
    }
  }
}