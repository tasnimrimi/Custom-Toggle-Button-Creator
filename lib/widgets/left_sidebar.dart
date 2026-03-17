import 'package:flutter/material.dart';
import '../models/switch_config.dart';
import '../widgets/custom_toggle_widget.dart';

class LeftSidebar extends StatelessWidget {
  final SwitchConfig config;
  final List<({String name, SwitchConfig config})> savedItems;
  final ValueChanged<SwitchConfig> onConfigChanged;
  final VoidCallback onNewProject;

  const LeftSidebar({
    super.key,
    required this.config,
    required this.savedItems,
    required this.onConfigChanged,
    required this.onNewProject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: const Color(0xFF12121A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel('TOGGLE STYLES'),
                  const SizedBox(height: 12),
                  _styleGrid(),
                  const SizedBox(height: 24),
                  _sectionLabel('ICONS'),
                  const SizedBox(height: 12),
                  _iconSection(),
                  const SizedBox(height: 24),
                  _sectionLabel('SAVED ITEMS'),
                  const SizedBox(height: 12),
                  _savedItemsList(),
                ],
              ),
            ),
          ),

          // New Project button
          Padding(
            padding: const EdgeInsets.all(14),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onNewProject,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('New Project',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C6FF7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          color: Color(0xFF6B6B8A),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      );

  SwitchConfig _presetFor(ToggleStyle style) {
    switch (style) {
      case ToggleStyle.rounded:
        return config.copyWith(
          style: style,
          borderRadius: 24,
          accentColor: const Color(0xFF7C3AED),
          thumbColor: const Color(0xFFFFFFFF),
          borderColor: const Color(0xFF4C1D95),
          innerShadow: false,
          transitionGlow: true,
          width: 64,
          height: 32,
        );
      case ToggleStyle.square:
        return config.copyWith(
          style: style,
          borderRadius: 0,
          accentColor: const Color(0xFF18181B),
          thumbColor: const Color(0xFFFAFAFA),
          borderColor: const Color(0xFFFAFAFA),
          innerShadow: false,
          transitionGlow: false,
          width: 64,
          height: 32,
        );
      case ToggleStyle.minimal:
        return config.copyWith(
          style: style,
          borderRadius: 20,
          accentColor: const Color(0xFFFDA4AF),
          thumbColor: const Color(0xFFFFFFFF),
          borderColor: const Color(0xFFFBCFD4),
          innerShadow: true,
          transitionGlow: false,
          width: 64,
          height: 32,
        );
      case ToggleStyle.flat:
        return config.copyWith(
          style: style,
          borderRadius: 24,
          accentColor: const Color(0xFF0D3D40),
          thumbColor: const Color(0xFF2DD4BF),
          borderColor: const Color(0xFF2DD4BF),
          innerShadow: false,
          transitionGlow: true,
          width: 64,
          height: 32,
        );
      case ToggleStyle.labeled:
        return config.copyWith(
          style: style,
          borderRadius: 8,
          accentColor: const Color(0xFF92400E),
          thumbColor: const Color(0xFFFBBF24),
          borderColor: const Color(0xFFB45309),
          innerShadow: true,
          transitionGlow: false,
          width: 64,
          height: 32,
        );
      case ToggleStyle.loading:
        return config.copyWith(
          style: style,
          borderRadius: 24,
          accentColor: const Color(0xFF0F172A),
          thumbColor: const Color(0xFF3B82F6),
          borderColor: const Color(0xFF1E3A5F),
          innerShadow: true,
          transitionGlow: true,
          width: 64,
          height: 32,
        );
    }
  }

  Widget _styleGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.3,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _styleCell(ToggleStyle.rounded,
            label: 'Neon', child: const _NeonToggle()),
        _styleCell(ToggleStyle.square,
            label: 'Brutal', child: const _BrutalistToggle()),
        _styleCell(ToggleStyle.minimal,
            label: 'Pastel', child: const _PastelToggle()),
        _styleCell(ToggleStyle.flat,
            label: 'Glass', child: const _GlassToggle()),
        _styleCell(ToggleStyle.labeled,
            label: 'Warm', child: const _WarmToggle()),
        _styleCell(ToggleStyle.loading,
            label: 'Midnight', child: const _MidnightToggle()),
      ],
    );
  }

  Widget _styleCell(ToggleStyle style,
      {required Widget child, required String label}) {
    final isSelected = config.style == style;
    return GestureDetector(
      onTap: () => onConfigChanged(_presetFor(style)),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF7C6FF7).withOpacity(0.12)
              : const Color(0xFF1A1A24),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF7C6FF7) : const Color(0xFF252535),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(scale: 0.8, child: child),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF7C6FF7)
                    : const Color(0xFF6B6B8A),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Light State',
            style: TextStyle(color: Color(0xFF8888AA), fontSize: 11)),
        const SizedBox(height: 10),
        // Changed to a grid or wrapped rows to accommodate 4 items (None + 3 icons)
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _iconOption(IconType.none, Icons.not_interested_rounded, 'None',
                isLight: true),
            _iconOption(IconType.sun, Icons.wb_sunny_rounded, 'Sun',
                isLight: true),
            _iconOption(IconType.morning, Icons.wb_twilight_rounded, 'Morning',
                isLight: true),
            _iconOption(IconType.bulb, Icons.lightbulb_rounded, 'Bulb',
                isLight: true),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Dark State',
            style: TextStyle(color: Color(0xFF8888AA), fontSize: 11)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _iconOption(IconType.none, Icons.not_interested_rounded, 'None',
                isLight: false),
            _iconOption(IconType.moon, Icons.nightlight_round, 'Moon',
                isLight: false),
            _iconOption(IconType.night, Icons.nights_stay_rounded, 'Night',
                isLight: false),
            _iconOption(IconType.star, Icons.star_rounded, 'Star',
                isLight: false),
          ],
        ),
      ],
    );
  }

  Widget _iconOption(IconType type, IconData icon, String label,
      {required bool isLight}) {
    final selected =
        isLight ? config.lightIcon == type : config.darkIcon == type;
    return GestureDetector(
      onTap: () {
        onConfigChanged(isLight
            ? config.copyWith(lightIcon: type)
            : config.copyWith(darkIcon: type));
      },
      child: Container(
        width: 44, // Fixed width for wrap consistency
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF7C6FF7).withOpacity(0.15)
              : const Color(0xFF1A1A24),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? const Color(0xFF7C6FF7) : const Color(0xFF252535),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 14,
                color: selected
                    ? const Color(0xFF7C6FF7)
                    : const Color(0xFF6B6B8A)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? const Color(0xFF7C6FF7)
                    : const Color(0xFF6B6B8A),
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _savedItemsList() {
    if (savedItems.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A24),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('No saved switches yet',
            style: TextStyle(color: Color(0xFF6B6B8A), fontSize: 11)),
      );
    }
    return Column(
      children: savedItems.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A24),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF252535)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: item.config.accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomToggleWidget(
                    config: item.config,
                    forceValue: true,
                    scale: 0.35,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    const Text('Edited just now',
                        style:
                            TextStyle(color: Color(0xFF6B6B8A), fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Preset Toggles (Clean, no icons)
class _NeonToggle extends StatelessWidget {
  const _NeonToggle();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFF7C3AED),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.all(2.5),
          width: 17,
          height: 17,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class _BrutalistToggle extends StatelessWidget {
  const _BrutalistToggle();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        border: Border.all(color: const Color(0xFFFAFAFA), width: 2),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 14,
          height: 14,
          decoration: const BoxDecoration(color: Color(0xFFFAFAFA)),
        ),
      ),
    );
  }
}

class _PastelToggle extends StatelessWidget {
  const _PastelToggle();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFFFDA4AF),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.all(2.5),
          width: 17,
          height: 17,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class _GlassToggle extends StatelessWidget {
  const _GlassToggle();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFF0D3D40),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFF2DD4BF), width: 1.5),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.all(2.5),
          width: 17,
          height: 17,
          decoration: const BoxDecoration(
              color: Color(0xFF2DD4BF), shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class _WarmToggle extends StatelessWidget {
  const _WarmToggle();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFF92400E),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.all(2.5),
          width: 17,
          height: 17,
          decoration: BoxDecoration(
              color: const Color(0xFFFBBF24),
              borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}

class _MidnightToggle extends StatelessWidget {
  const _MidnightToggle();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFF1E3A5F)),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.all(2.5),
          width: 17,
          height: 17,
          decoration: const BoxDecoration(
              color: Color(0xFF3B82F6), shape: BoxShape.circle),
        ),
      ),
    );
  }
}
