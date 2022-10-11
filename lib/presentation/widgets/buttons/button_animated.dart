import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ButtonAnimated extends StatefulWidget {
  const ButtonAnimated({
    Key? key,
    required this.child,
    this.pressedScale,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final double? pressedScale;
  final void Function()? onTap;

  @override
  State<ButtonAnimated> createState() => _ButtonAnimatedState();
}

class _ButtonAnimatedState extends State<ButtonAnimated>
    with SingleTickerProviderStateMixin {
  static const Duration kScaleDownDuration = Duration(milliseconds: 75);
  static const Duration kScaleUpDuration = Duration(milliseconds: 100);
  Tween<double>? _scaleTween;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleTween = Tween<double>(begin: 1.0, end: widget.pressedScale);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _scaleAnimation = _animationController
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(_scaleTween!);
    _updateTweenEnd();
  }

  @override
  void didUpdateWidget(ButtonAnimated old) {
    super.didUpdateWidget(old);
    _updateTweenEnd();
  }

  void _updateTweenEnd() {
    _scaleTween?.end = widget.pressedScale ?? 0.9;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      HapticFeedback.selectionClick();
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating == true) return;
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController.animateTo(1.0, duration: kScaleDownDuration)
        : _animationController.animateTo(0.0, duration: kScaleUpDuration);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.onTap != null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: enabled ? widget.onTap : null,
      child: Semantics(
        button: true,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
