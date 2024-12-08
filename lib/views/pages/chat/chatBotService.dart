import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatBotService {

  final String apiKey =  dotenv.env['API_KEY']??''; 

  final String apiUrl = 'https://api.openai.com/v1/chat/completions'; // Endpoint của OpenAI

  final Dio _dio = Dio();

  // Hàm gửi yêu cầu và xử lý stream
  Future<String> getResponse(String prompt) async {
    try {
      String responseContent = ''; // Chuỗi kết quả hoàn chỉnh

      final response = await _dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          responseType: ResponseType.stream, // Đọc dữ liệu dạng stream
        ),
        data: json.encode({
          // "model": "gpt-3.5-turbo", // Chọn mô hình GPT-3.5 Turbo
          "model": "ft:gpt-4o-2024-08-06:personal::AXrd12XF", // Chọn mô hình GPT-3.5 Turbo
          "messages": [
            {"role": "user", "content": prompt} // Tin nhắn đầu vào
          ],
          "max_tokens": 200, // Giới hạn số token phản hồi
          "stream": true, // Bật chế độ stream
        }),
      );

      // Đọc dữ liệu từ stream và xử lý từng dòng
      await response.data!.stream
          .cast<List<int>>() // Chuyển stream thành List<int>
          .transform(utf8.decoder) // Giải mã từ byte sang chuỗi
          .transform(const LineSplitter()) // Chia thành các dòng
          .forEach((line) {
        if (line.trim().isEmpty) return; // Bỏ qua dòng rỗng

        // Loại bỏ "data: " nếu có
        line = line.replaceFirst('data: ', '');

        try {
          // Parse JSON từ dòng dữ liệu
          final jsonChunk = jsonDecode(line);
          final delta = jsonChunk['choices']?[0]?['delta'];

          if (delta != null && delta['content'] != null) {
            responseContent += delta['content']; // Ghép nội dung từ `content`
            print('Streaming: $responseContent'); // In ra chuỗi đã ghép
          }
        } catch (e) {
          print('Error parsing chunk: $e'); // Bỏ qua nếu không thể parse chunk
        }
      });

      // Trả về chuỗi hoàn chỉnh sau khi kết thúc stream
      return responseContent.trim();
    } catch (e) {
      print('Error occurred: $e');
      return 'An error occurred. Please try again.';
    }
  }
}