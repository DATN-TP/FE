import 'package:datn/views/animations/slideBottomToTop.dart';
import 'package:flutter/material.dart';

class SignupButton extends StatefulWidget {
  const SignupButton({super.key});

  @override
  _SignupButtonState createState() => _SignupButtonState();
}

class _SignupButtonState extends State<SignupButton>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SlideBottomToTop(
      durationMs: 1500,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 7,
              offset: const Offset(5, 10),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(
          size.width * 0.05,
          size.height * 0.25,
          size.width * 0.05,
          size.height * 0.02,
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6f24fd),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
