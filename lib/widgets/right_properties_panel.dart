import 'package:flutter/material.dart';
import '../models/switch_config.dart';

class RightPropertiesPanel extends StatelessWidget {
  final SwitchConfig config;
  final ValueChanged<SwitchConfig> onConfigChanged;
  final VoidCallback onCopyCode;

  const RightPropertiesPanel({
    super.key,
    required this.config,
    required this.onConfigChanged,
    required this.onCopyCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: const Color(0xFF12121A),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF1E1E2E), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Properties',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C6FF7).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: const Color(0xFF7C6FF7).withOpacity(0.3)),
                  ),
                  child: const Text(
                    'v1.2.0',
                    style: TextStyle(
                        color: Color(0xFF7C6FF7),
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader('LAYOUT & SIZE'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _numberField(
                          label: 'Width',
                          suffix: 'W',
                          value: config.width,
                          min: 32,
                          max: 120,
                          onChanged: (v) =>
                              onConfigChanged(config.copyWith(width: v)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _numberField(
                          label: 'Height',
                          suffix: 'H',
                          value: config.height,
                          min: 20,
                          max: 60,
                          onChanged: (v) =>
                              onConfigChanged(config.copyWith(height: v)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _sliderField(
                    label: 'Inner Padding',
                    value: config.innerPadding,
                    min: 1,
                    max: 8,
                    onChanged: (v) =>
                        onConfigChanged(config.copyWith(innerPadding: v)),
                  ),
                  const SizedBox(height: 18),
                  _sectionHeader('APPEARANCE'),
                  const SizedBox(height: 10),
                  _colorField(
                    label: 'Accent Color',
                    color: config.accentColor,
                    hexLabel: _colorToHex(config.accentColor),
                    onTap: () => _showColorPicker(
                        context,
                        config.accentColor,
                        (c) =>
                            onConfigChanged(config.copyWith(accentColor: c))),
                  ),
                  const SizedBox(height: 8),
                  _colorField(
                    label: 'Thumb Color',
                    color: config.thumbColor,
                    hexLabel: _colorToHex(config.thumbColor),
                    onTap: () => _showColorPicker(context, config.thumbColor,
                        (c) => onConfigChanged(config.copyWith(thumbColor: c))),
                  ),
                  const SizedBox(height: 8),
                  _colorField(
                    label: 'Border Color',
                    color: config.borderColor,
                    hexLabel: _colorToHex(config.borderColor),
                    onTap: () => _showColorPicker(
                        context,
                        config.borderColor,
                        (c) =>
                            onConfigChanged(config.copyWith(borderColor: c))),
                  ),
                  const SizedBox(height: 18),
                  _sectionHeader('EFFECTS'),
                  const SizedBox(height: 10),
                  _toggleRow(
                    label: 'Inner Shadow',
                    value: config.innerShadow,
                    onChanged: (v) =>
                        onConfigChanged(config.copyWith(innerShadow: v)),
                  ),
                  const SizedBox(height: 8),
                  _toggleRow(
                    label: 'Transition Glow',
                    value: config.transitionGlow,
                    onChanged: (v) =>
                        onConfigChanged(config.copyWith(transitionGlow: v)),
                  ),
                  const SizedBox(height: 8),
                  _toggleRow(
                    label: 'Click Sound',
                    value: config.clickSound,
                    onChanged: (v) =>
                        onConfigChanged(config.copyWith(clickSound: v)),
                  ),
                  const SizedBox(height: 12),
                  _sliderField(
                    label: 'Border Radius',
                    value: config.borderRadius,
                    min: 0,
                    max: 32,
                    suffixText: '${config.borderRadius.toInt()}px',
                    onChanged: (v) =>
                        onConfigChanged(config.copyWith(borderRadius: v)),
                  ),
                  const SizedBox(height: 18),
                  _sectionHeader('ANIMATION'),
                  const SizedBox(height: 10),
                  _dropdownField(
                    value: config.animation,
                    onChanged: (v) =>
                        onConfigChanged(config.copyWith(animation: v)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) => Text(
        text,
        style: const TextStyle(
          color: Color(0xFF6B6B8A),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      );

  Widget _numberField({
    required String label,
    required String suffix,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Color(0xFF8888AA), fontSize: 11)),
        const SizedBox(height: 4),
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A24),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF252535)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (value > min) onChanged(value - 1);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.remove,
                      size: 12, color: Color(0xFF6B6B8A)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (value < max) onChanged(value + 1);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child:
                      const Icon(Icons.add, size: 12, color: Color(0xFF6B6B8A)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  color: Color(0xFF252535),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                ),
                child: Text(suffix,
                    style: const TextStyle(
                        color: Color(0xFF6B6B8A), fontSize: 10)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sliderField({
    required String label,
    required double value,
    required double min,
    required double max,
    String? suffixText,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(color: Color(0xFF8888AA), fontSize: 11)),
            if (suffixText != null)
              Text(suffixText,
                  style:
                      const TextStyle(color: Color(0xFF6B6B8A), fontSize: 10)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 3,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
            activeTrackColor: const Color(0xFF7C6FF7),
            inactiveTrackColor: const Color(0xFF252535),
            thumbColor: const Color(0xFF7C6FF7),
            overlayColor: const Color(0xFF7C6FF7).withOpacity(0.2),
          ),
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _colorField({
    required String label,
    required Color color,
    required String hexLabel,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A24),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF252535)),
        ),
        child: Row(
          children: [
            Text(label,
                style: const TextStyle(color: Color(0xFF8888AA), fontSize: 12)),
            const Spacer(),
            Text(hexLabel,
                style: const TextStyle(color: Color(0xFF6B6B8A), fontSize: 11)),
            const SizedBox(width: 8),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(color: Color(0xFF8888AA), fontSize: 12)),
        _MiniToggle(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _dropdownField({
    required AnimationType value,
    required ValueChanged<AnimationType> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF252535)),
      ),
      child: DropdownButton<AnimationType>(
        value: value,
        isExpanded: true,
        dropdownColor: const Color(0xFF1A1A24),
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF6B6B8A), size: 18),
        style: const TextStyle(color: Colors.white, fontSize: 13),
        items: AnimationType.values.map((a) {
          return DropdownMenuItem(
            value: a,
            child: Text(_animLabel(a)),
          );
        }).toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  String _animLabel(AnimationType a) {
    switch (a) {
      case AnimationType.slide:
        return 'Slide (Standard)';
      case AnimationType.fade:
        return 'Fade';
      case AnimationType.bounce:
        return 'Bounce';
      case AnimationType.spring:
        return 'Spring';
    }
  }

  String _colorToHex(Color c) =>
      '#${c.value.toRadixString(16).substring(2).toUpperCase()}';

  void _showColorPicker(
      BuildContext context, Color current, ValueChanged<Color> onPick) {
    final colors = [
      const Color(0xFF4F46E5),
      const Color(0xFF7C6FF7),
      const Color(0xFF06B6D4),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEF4444),
      const Color(0xFFEC4899),
      const Color(0xFF8B5CF6),
      const Color(0xFFFFFFFF),
      const Color(0xFF334155),
      const Color(0xFF1E293B),
      const Color(0xFF0F172A),
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A24),
        title: const Text('Pick a Color',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        content: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: colors.map((c) {
            return GestureDetector(
              onTap: () {
                onPick(c);
                Navigator.pop(ctx);
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: c == current
                        ? Colors.white
                        : Colors.white.withOpacity(0.15),
                    width: c == current ? 2.5 : 1,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A24),
        title: const Text('Export Options',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _exportOption(ctx, Icons.code_rounded, 'Copy CSS Code', 'css'),
            const SizedBox(height: 8),
            _exportOption(ctx, Icons.flutter_dash_rounded, 'Copy Flutter Code',
                'flutter'),
          ],
        ),
      ),
    );
  }

  Widget _exportOption(
      BuildContext ctx, IconData icon, String label, String type) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(ctx);
        onCopyCode();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF252535),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF7C6FF7), size: 20),
            const SizedBox(width: 10),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _MiniToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _MiniToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 38,
        height: 22,
        decoration: BoxDecoration(
          color: value ? const Color(0xFF7C6FF7) : const Color(0xFF252535),
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(2),
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
