import 'package:ResiEasy/data/config/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateNewRequest extends StatefulWidget {
  const CreateNewRequest({super.key});

  @override
  State<CreateNewRequest> createState() => _CreateNewRequestState();
}

class _CreateNewRequestState extends State<CreateNewRequest> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<XFile>? _images;

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedImages = await picker.pickMultiImage();
    setState(() {
      _images = pickedImages;
    });
  }

  void _submitRequest() {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    // Handle the submission logic here
    print('Title: $title');
    print('Description: $description');
    if (_images != null) {
      for (var image in _images!) {
        print('Image path: ${image.path}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('txt_createNewRequest'.tr(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: ColorApp().cl1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      children: _images!.map((image) {
                        return Image.file(
                          File(image.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _submitRequest,
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
      ),
    );
  }
}