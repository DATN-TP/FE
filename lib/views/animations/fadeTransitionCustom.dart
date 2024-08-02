import 'package:flutter/material.dart';
import 'dart:ui';

class BlurTransitionCustom extends StatefulWidget {
  final double durationMs;
  final Widget child;

  const BlurTransitionCustom({
    Key? key,
    required this.durationMs,
    required this.child,
  }) : super(key: key);

  @override
  _BlurTransitionCustomState createState() => _BlurTransitionCustomState();
}

class _BlurTransitionCustomState extends State<BlurTransitionCustom>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.durationMs.toInt()),
      vsync: this,
    );

    _blurAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  void reverseAnimation() {
    if (_controller.isAnimating || _controller.isCompleted) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BlurTransitionCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.durationMs != oldWidget.durationMs) {
      _controller.duration = Duration(milliseconds: widget.durationMs.toInt());
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: _blurAnimation.value,
            sigmaY: _blurAnimation.value,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
