import 'package:ResiEasy/views/animations/slideBottomToTop.dart';
import 'package:flutter/material.dart';

class Loginbutton extends StatelessWidget {
  const Loginbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideBottomToTop(
      durationMs: 1500,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
        },
        child: const Text('Have an account? Login',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            )),
      ),
    );
  }
}
