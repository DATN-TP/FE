import 'package:flutter/material.dart';

class SlideBottomToTop extends StatefulWidget {
  final double durationMs;
  final Widget child;

  const SlideBottomToTop({
    super.key,
    required this.durationMs,
    required this.child,
  });

  @override
  _SlideTopToBottomState createState() => _SlideTopToBottomState();
}

class _SlideTopToBottomState extends State<SlideBottomToTop>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.durationMs.toInt()),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), 
      end: Offset.zero,
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
  void didUpdateWidget(covariant SlideBottomToTop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.durationMs != oldWidget.durationMs) {
      _controller.duration = Duration(milliseconds: widget.durationMs.toInt());
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}
