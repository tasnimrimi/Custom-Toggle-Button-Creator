import 'package:flutter/material.dart';
import '../models/switch_config.dart';

class CustomToggleWidget extends StatefulWidget {
  final SwitchConfig config;
  final bool? forceValue;
  final double scale;
  final VoidCallback? onTap;

  const CustomToggleWidget({
    super.key,
    required this.config,
    this.forceValue,
    this.scale = 1.0,
    this.onTap,
  });

  @override
  State<CustomToggleWidget> createState() => _CustomToggleWidgetState();
}

class _CustomToggleWidgetState extends State<CustomToggleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnim;
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.forceValue ?? widget.config.isOn;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      value: _isOn ? 1.0 : 0.0,
    );
    _slideAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(CustomToggleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newVal = widget.forceValue ?? widget.config.isOn;
    if (newVal != _isOn) {
      _isOn = newVal;
      if (_isOn) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOn = !_isOn;
      if (_isOn) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    widget.onTap?.call();
  }

  IconData? _getIcon(IconType type) {
    switch (type) {
      case IconType.sun:
        return Icons.wb_sunny_rounded;
      case IconType.morning:
        return Icons.wb_twilight_rounded;
      case IconType.bulb:
        return Icons.lightbulb_rounded;
      case IconType.moon:
        return Icons.nightlight_round;
      case IconType.night:
        return Icons.nights_stay_rounded;
      case IconType.star:
        return Icons.star_rounded;
      case IconType.none:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cfg = widget.config;
    final scale = widget.scale;
    final double w = cfg.width * scale;
    final double h = cfg.height * scale;
    final double pad = cfg.innerPadding * scale;
    final double thumbSize = h - pad * 2;
    final double travelDist = w - thumbSize - pad * 2;

    final lightIcon = _getIcon(cfg.lightIcon);
    final darkIcon = _getIcon(cfg.darkIcon);

    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _slideAnim,
        builder: (context, _) {
          final bgColor = Color.lerp(
            cfg.borderColor.withOpacity(0.5),
            cfg.accentColor,
            _slideAnim.value,
          )!;

          return Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(cfg.borderRadius * scale),
              border: Border.all(
                color: cfg.borderColor.withOpacity(0.4),
                width: 1,
              ),
              boxShadow: cfg.transitionGlow && _isOn
                  ? [
                      BoxShadow(
                        color: cfg.accentColor.withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 2,
                      )
                    ]
                  : cfg.innerShadow
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : [],
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Thumb
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  left: pad + _slideAnim.value * travelDist,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      color: cfg.thumbColor,
                      borderRadius:
                          BorderRadius.circular(cfg.borderRadius * scale * 0.8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: _isOn && darkIcon != null
                        ? Icon(darkIcon,
                            size: thumbSize * 0.55, color: cfg.accentColor)
                        : !_isOn && lightIcon != null
                            ? Icon(lightIcon,
                                size: thumbSize * 0.55,
                                color: cfg.accentColor.withOpacity(0.7))
                            : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
