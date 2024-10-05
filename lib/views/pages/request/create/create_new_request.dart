import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/views/pages/request/request_view_model.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class CreateNewRequest extends StatefulWidget {
  const CreateNewRequest({super.key});

  @override
  State<CreateNewRequest> createState() => _CreateNewRequestState();
}

class _CreateNewRequestState extends State<CreateNewRequest> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<XFile>? _images = [];
  
  // Biến lưu trữ giá trị type đã chọn
  String _selectedType = 'phanAnh';
  
  // Danh sách loại yêu cầu
  final List<DropdownMenuItem<String>> _dropdownItems = [
    DropdownMenuItem(
      value: 'request',
      child: Text('txt_request'.tr()), // Phản ánh
    ),
    DropdownMenuItem(
      value: 'feedback',
      child: Text('txt_feedback'.tr()), // Góp ý
    ),
    DropdownMenuItem(
      value: 'camplaint',
      child: Text('txt_feedback'.tr()), // Khiếu nại
    ),
  ];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedImages = await picker.pickMultiImage();
    
    if (pickedImages != null && (_images!.length + pickedImages.length <= 2)) {
      setState(() {
        _images!.addAll(pickedImages.take(2 - _images!.length)); // Chỉ thêm đủ số hình tối đa 2
      });
    } else {
      // Hiển thị thông báo nếu quá 2 hình
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('txt_selectImageError'.tr())),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images!.removeAt(index);
    });
  }

  void _submitRequest(RequestViewModel viewModel) {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final List<File> images = _images!.map((image) => File(image.path)).toList();

    if (images.isNotEmpty) {
      viewModel.uploadMultipleImage(images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('txt_createNewRequest'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: ColorApp().cl1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => RequestViewModel(),
        child: Consumer<RequestViewModel>(
          builder: (BuildContext context, RequestViewModel viewModel, Widget? child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('txt_type'.tr(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      items: _dropdownItems,
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorApp().cl1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('txt_title'.tr(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'txt_title'.tr(),
                        border: const OutlineInputBorder(),
                        labelStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorApp().cl1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('txt_description'.tr(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'txt_description'.tr(),
                        border: const OutlineInputBorder(),
                        labelStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorApp().cl1),
                        ),
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),
                    _images == null || _images!.isEmpty
                        ? TextButton.icon(
                            onPressed: _pickImages,
                            icon: Icon(Icons.image, color: ColorApp().cl1,),
                            label: Text('txt_selectImage'.tr(), style: const TextStyle(fontSize: 16, color: Colors.blue)),
                          )
                        : Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: _images!.asMap().entries.map((entry) {
                              int index = entry.key;
                              XFile image = entry.value;
                              return Stack(
                                children: [
                                  Image.file(
                                    File(image.path),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(index),
                                      child: Container(
                                        color: Colors.black54,
                                        child: Icon(Icons.close, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => _submitRequest(viewModel),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: ColorApp().cl1,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'txt_submit'.tr(),
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

