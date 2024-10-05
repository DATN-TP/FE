import 'dart:io';
import 'dart:typed_data';
import 'package:ResiEasy/extension.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:dio/dio.dart';

class UploadService {
  final ApiService apiService;

  UploadService(this.apiService);

  Future<String> uploadImage(File file) async {
    Uint8List? f = await file.compressFile();
    if (f == null) {
      throw Exception('Failed to compress file');
    }

    FormData formData = FormData.fromMap({
      "image": MultipartFile.fromBytes(f, filename: file.path.split("/").last),
    });

    try {
      final response = await apiService.post('/upload/upload-image', formData, headers: {
        'Content-Type': 'multipart/form-data',
      });
      if (response != null && response['url'] != null) {
        return response['url'];
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  //upload nhiều image
  Future<List<String>> uploadMultipleImage(List<File> files) async {
    List<Uint8List?> compressedFiles = [];
    for (var file in files) {
      Uint8List? f = await file.compressFile();
      if (f == null) {
        throw Exception('Failed to compress file');
      }
      compressedFiles.add(f);
    }

    List<MultipartFile> multipartFiles = [];
    for (var i = 0; i < files.length; i++) {
      multipartFiles.add(MultipartFile.fromBytes(compressedFiles[i]!, filename: files[i].path.split("/").last));
    }

    FormData formData = FormData.fromMap({
      "images": multipartFiles,
    });

    try {
      final response = await apiService.post('/upload/upload-multiple-image', formData, headers: {
        'Content-Type': 'multipart/form-data',
      });
      if (response != null && response['urls'] != null) {
        return List<String>.from(response['urls']);
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}