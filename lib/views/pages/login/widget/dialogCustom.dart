import 'package:flutter/material.dart';

class Dialogcustom extends StatelessWidget {
  const Dialogcustom({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Xác nhận thoát'),
      content: const Text('Bạn có chắc muốn thoát không?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Không'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Có'),
        ),
      ],
    );
  }
}
