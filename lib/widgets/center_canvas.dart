// import 'package:flutter/material.dart';
// import '../models/switch_config.dart';
// import '../widgets/custom_toggle_widget.dart';
//
// enum PreviewMode { splitView, single, preview }
//
// class CenterCanvas extends StatefulWidget {
//   final SwitchConfig config;
//   final ValueChanged<SwitchConfig> onConfigChanged;
//
//   const CenterCanvas({
//     super.key,
//     required this.config,
//     required this.onConfigChanged,
//   });
//
//   @override
//   State<CenterCanvas> createState() => _CenterCanvasState();
// }
//
// class _CenterCanvasState extends State<CenterCanvas> {
//   PreviewMode _mode = PreviewMode.splitView;
//   double _zoom = 100;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildToolbar(),
//         Expanded(
//           child: _buildCanvas(),
//         ),
//         _buildBottomUpload(),
//       ],
//     );
//   }
//
//   Widget _buildToolbar() {
//     return Container(
//       height: 48,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: const BoxDecoration(
//         color: Color(0xFF12121A),
//         border: Border(
//           bottom: BorderSide(color: Color(0xFF1E1E2E), width: 1),
//         ),
//       ),
//       child: Row(
//         children: [
//           _modeButton(
//               Icons.desktop_windows_outlined, 'Desktop', PreviewMode.splitView),
//           const SizedBox(width: 4),
//           _modeButton(
//               Icons.phone_android_outlined, 'Mobile', PreviewMode.single),
//           const SizedBox(width: 12),
//           Container(width: 1, height: 20, color: const Color(0xFF252535)),
//           const SizedBox(width: 12),
//           const Text('Preview\nMode:',
//               style: TextStyle(
//                   color: Color(0xFF6B6B8A), fontSize: 9, height: 1.3)),
//           const SizedBox(width: 12),
//           _tabButton('Split\nView', PreviewMode.splitView),
//           const SizedBox(width: 4),
//           _tabButton('Single', PreviewMode.single),
//           const Spacer(),
//           GestureDetector(
//             onTap: () => setState(() => _zoom = (_zoom - 10).clamp(50, 200)),
//             child: const Icon(Icons.remove, size: 16, color: Color(0xFF6B6B8A)),
//           ),
//           const SizedBox(width: 8),
//           Text('${_zoom.toInt()}%',
//               style: const TextStyle(color: Color(0xFF8888AA), fontSize: 12)),
//           const SizedBox(width: 8),
//           GestureDetector(
//             onTap: () => setState(() => _zoom = (_zoom + 10).clamp(50, 200)),
//             child: const Icon(Icons.add, size: 16, color: Color(0xFF6B6B8A)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _modeButton(IconData icon, String label, PreviewMode mode) {
//     final sel = _mode == mode;
//     return GestureDetector(
//       onTap: () => setState(() => _mode = mode),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         decoration: BoxDecoration(
//           color: sel ? const Color(0xFF252535) : Colors.transparent,
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Icon(icon,
//             size: 16, color: sel ? Colors.white : const Color(0xFF6B6B8A)),
//       ),
//     );
//   }
//
//   Widget _tabButton(String label, PreviewMode mode) {
//     final sel = _mode == mode;
//     return GestureDetector(
//       onTap: () => setState(() => _mode = mode),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//         decoration: BoxDecoration(
//           color: sel ? const Color(0xFF7C6FF7) : const Color(0xFF1A1A24),
//           borderRadius: BorderRadius.circular(8),
//           border: sel ? null : Border.all(color: const Color(0xFF252535)),
//         ),
//         child: Text(label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: sel ? Colors.white : const Color(0xFF6B6B8A),
//               fontSize: 10,
//               height: 1.3,
//             )),
//       ),
//     );
//   }
//
//   Widget _buildCanvas() {
//     final scale = _zoom / 100.0;
//
//     return Container(
//       color: const Color(0xFF0F0F14),
//       child: Center(
//         child: Transform.scale(
//           scale: scale,
//           child: _mode == PreviewMode.splitView
//               ? _buildSplitView()
//               : _buildSingleView(),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSplitView() {
//     return Container(
//       width: 620,
//       height: 340,
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1A24),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFF252535)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.4),
//             blurRadius: 40,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Row(
//           children: [
//             // Light mode side
//             Expanded(
//               child: Container(
//                 color: const Color(0xFFF1F5F9),
//                 child: Stack(
//                   children: [
//                     // Grid pattern
//                     CustomPaint(
//                       painter: GridPainter(color: const Color(0xFFE2E8F0)),
//                       size: const Size(double.infinity, double.infinity),
//                     ),
//                     Positioned(
//                       top: 12,
//                       left: 0,
//                       right: 0,
//                       child: Center(
//                         child: Text(
//                           'LIGHT MODE',
//                           style: TextStyle(
//                             color: const Color(0xFF94A3B8),
//                             fontSize: 9,
//                             fontWeight: FontWeight.w700,
//                             letterSpacing: 1.5,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: CustomToggleWidget(
//                         config: widget.config,
//                         forceValue: false,
//                         scale: 1.4,
//                         onTap: () => widget.onConfigChanged(
//                             widget.config.copyWith(isOn: !widget.config.isOn)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Divider
//             Container(width: 1, color: const Color(0xFF252535)),
//             // Dark mode side
//             Expanded(
//               child: Container(
//                 color: const Color(0xFF0F172A),
//                 child: Stack(
//                   children: [
//                     CustomPaint(
//                       painter: GridPainter(color: const Color(0xFF1E293B)),
//                       size: const Size(double.infinity, double.infinity),
//                     ),
//                     Positioned(
//                       top: 12,
//                       left: 0,
//                       right: 0,
//                       child: Center(
//                         child: Text(
//                           'DARK MODE',
//                           style: TextStyle(
//                             color: const Color(0xFF475569),
//                             fontSize: 9,
//                             fontWeight: FontWeight.w700,
//                             letterSpacing: 1.5,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: CustomToggleWidget(
//                         config: widget.config,
//                         forceValue: true,
//                         scale: 1.4,
//                         onTap: () => widget.onConfigChanged(
//                             widget.config.copyWith(isOn: !widget.config.isOn)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSingleView() {
//     return Container(
//       width: 400,
//       height: 300,
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1A24),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFF252535)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.4),
//             blurRadius: 40,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           CustomPaint(
//             painter: GridPainter(color: const Color(0xFF252535)),
//           ),
//           Center(
//             child: CustomToggleWidget(
//               config: widget.config,
//               scale: 1.8,
//               onTap: () => widget.onConfigChanged(
//                   widget.config.copyWith(isOn: !widget.config.isOn)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomUpload() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         color: Color(0xFF12121A),
//         border: Border(
//           top: BorderSide(color: Color(0xFF1E1E2E), width: 1),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.upload_file_rounded,
//                   size: 14, color: Color(0xFF7C6FF7)),
//               const SizedBox(width: 6),
//               const Text('Upload Custom Icons (SVGs)',
//                   style: TextStyle(
//                       color: Color(0xFF8888AA),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500)),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               _uploadSlot(null, null),
//               const SizedBox(width: 10),
//               _uploadSlot(Icons.bolt_rounded, 'lightning.svg'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _uploadSlot(IconData? icon, String? name) {
//     if (icon == null) {
//       return GestureDetector(
//         onTap: () {},
//         child: Container(
//           width: 100,
//           height: 60,
//           decoration: BoxDecoration(
//             color: const Color(0xFF1A1A24),
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//                 color: const Color(0xFF252535), style: BorderStyle.solid),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Icon(Icons.add_circle_outline_rounded,
//                   size: 20, color: Color(0xFF6B6B8A)),
//               SizedBox(height: 4),
//               Text('New Asset',
//                   style: TextStyle(color: Color(0xFF6B6B8A), fontSize: 10)),
//             ],
//           ),
//         ),
//       );
//     }
//     return Container(
//       width: 100,
//       height: 60,
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1A24),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: const Color(0xFF252535)),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 20, color: const Color(0xFF7C6FF7)),
//           const SizedBox(height: 4),
//           Text(name ?? '',
//               style: const TextStyle(color: Color(0xFF8888AA), fontSize: 9)),
//           const Text('VECTOR',
//               style: TextStyle(
//                   color: Color(0xFF6B6B8A), fontSize: 8, letterSpacing: 0.8)),
//         ],
//       ),
//     );
//   }
// }
//
// class GridPainter extends CustomPainter {
//   final Color color;
//   GridPainter({required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = 0.5;
//     const spacing = 24.0;
//     for (double x = 0; x < size.width; x += spacing) {
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
//     }
//     for (double y = 0; y < size.height; y += spacing) {
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
import 'package:flutter/material.dart';
import '../models/switch_config.dart';
import '../widgets/custom_toggle_widget.dart';

enum PreviewMode { splitView, single, preview }

class CenterCanvas extends StatefulWidget {
  final SwitchConfig config;
  final ValueChanged<SwitchConfig> onConfigChanged;

  const CenterCanvas({
    super.key,
    required this.config,
    required this.onConfigChanged,
  });

  @override
  State<CenterCanvas> createState() => _CenterCanvasState();
}

class _CenterCanvasState extends State<CenterCanvas> {
  PreviewMode _mode = PreviewMode.splitView;
  double _zoom = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildToolbar(),
        Expanded(
          child: _buildCanvas(),
        ),
        _buildBottomUpload(),
      ],
    );
  }

  Widget _buildToolbar() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF12121A),
        border: Border(
          bottom: BorderSide(color: Color(0xFF1E1E2E), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Left spacer (mirrors zoom width to keep center group truly centered)
          const Spacer(),
          // Centered controls
          _modeButton(
              Icons.desktop_windows_outlined, 'Desktop', PreviewMode.splitView),
          const SizedBox(width: 4),
          _modeButton(
              Icons.phone_android_outlined, 'Mobile', PreviewMode.single),
          const SizedBox(width: 12),
          Container(width: 1, height: 20, color: const Color(0xFF252535)),
          const SizedBox(width: 12),
          const Text('Preview\nMode:',
              style: TextStyle(
                  color: Color(0xFF6B6B8A), fontSize: 9, height: 1.3)),
          const SizedBox(width: 12),
          _tabButton('Split\nView', PreviewMode.splitView),
          const SizedBox(width: 4),
          _tabButton('Single', PreviewMode.single),
          // Right spacer
          const Spacer(),
          // Zoom controls pinned to right
          GestureDetector(
            onTap: () => setState(() => _zoom = (_zoom - 10).clamp(50, 200)),
            child: const Icon(Icons.remove, size: 16, color: Color(0xFF6B6B8A)),
          ),
          const SizedBox(width: 8),
          Text('${_zoom.toInt()}%',
              style: const TextStyle(color: Color(0xFF8888AA), fontSize: 12)),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => setState(() => _zoom = (_zoom + 10).clamp(50, 200)),
            child: const Icon(Icons.add, size: 16, color: Color(0xFF6B6B8A)),
          ),
        ],
      ),
    );
  }

  Widget _modeButton(IconData icon, String label, PreviewMode mode) {
    final sel = _mode == mode;
    return GestureDetector(
      onTap: () => setState(() => _mode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? const Color(0xFF252535) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon,
            size: 16, color: sel ? Colors.white : const Color(0xFF6B6B8A)),
      ),
    );
  }

  Widget _tabButton(String label, PreviewMode mode) {
    final sel = _mode == mode;
    return GestureDetector(
      onTap: () => setState(() => _mode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: sel ? const Color(0xFF7C6FF7) : const Color(0xFF1A1A24),
          borderRadius: BorderRadius.circular(8),
          border: sel ? null : Border.all(color: const Color(0xFF252535)),
        ),
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: sel ? Colors.white : const Color(0xFF6B6B8A),
              fontSize: 10,
              height: 1.3,
            )),
      ),
    );
  }

  Widget _buildCanvas() {
    final scale = _zoom / 100.0;

    return Container(
      color: const Color(0xFF0F0F14),
      child: Center(
        child: Transform.scale(
          scale: scale,
          child: _mode == PreviewMode.splitView
              ? _buildSplitView()
              : _buildSingleView(),
        ),
      ),
    );
  }

  Widget _buildSplitView() {
    return Container(
      width: 620,
      height: 340,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF252535)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            // Light mode side
            Expanded(
              child: Container(
                color: const Color(0xFFF1F5F9),
                child: Stack(
                  children: [
                    // Grid pattern
                    CustomPaint(
                      painter: GridPainter(color: const Color(0xFFE2E8F0)),
                      size: const Size(double.infinity, double.infinity),
                    ),
                    Positioned(
                      top: 12,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'LIGHT MODE',
                          style: TextStyle(
                            color: const Color(0xFF94A3B8),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: CustomToggleWidget(
                        config: widget.config,
                        forceValue: false,
                        scale: 1.4,
                        onTap: () => widget.onConfigChanged(
                            widget.config.copyWith(isOn: !widget.config.isOn)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Divider
            Container(width: 1, color: const Color(0xFF252535)),
            // Dark mode side
            Expanded(
              child: Container(
                color: const Color(0xFF0F172A),
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: GridPainter(color: const Color(0xFF1E293B)),
                      size: const Size(double.infinity, double.infinity),
                    ),
                    Positioned(
                      top: 12,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'DARK MODE',
                          style: TextStyle(
                            color: const Color(0xFF475569),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: CustomToggleWidget(
                        config: widget.config,
                        forceValue: true,
                        scale: 1.4,
                        onTap: () => widget.onConfigChanged(
                            widget.config.copyWith(isOn: !widget.config.isOn)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleView() {
    return Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF252535)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          CustomPaint(
            painter: GridPainter(color: const Color(0xFF252535)),
          ),
          Center(
            child: CustomToggleWidget(
              config: widget.config,
              scale: 1.8,
              onTap: () => widget.onConfigChanged(
                  widget.config.copyWith(isOn: !widget.config.isOn)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomUpload() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF12121A),
        border: Border(
          top: BorderSide(color: Color(0xFF1E1E2E), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.upload_file_rounded,
                  size: 14, color: Color(0xFF7C6FF7)),
              const SizedBox(width: 6),
              const Text('Upload Custom Icons (SVGs)',
                  style: TextStyle(
                      color: Color(0xFF8888AA),
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _uploadSlot(null, null),
              const SizedBox(width: 10),
              _uploadSlot(Icons.bolt_rounded, 'lightning.svg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _uploadSlot(IconData? icon, String? name) {
    if (icon == null) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A24),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color(0xFF252535), style: BorderStyle.solid),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add_circle_outline_rounded,
                  size: 20, color: Color(0xFF6B6B8A)),
              SizedBox(height: 4),
              Text('New Asset',
                  style: TextStyle(color: Color(0xFF6B6B8A), fontSize: 10)),
            ],
          ),
        ),
      );
    }
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF252535)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF7C6FF7)),
          const SizedBox(height: 4),
          Text(name ?? '',
              style: const TextStyle(color: Color(0xFF8888AA), fontSize: 9)),
          const Text('VECTOR',
              style: TextStyle(
                  color: Color(0xFF6B6B8A), fontSize: 8, letterSpacing: 0.8)),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final Color color;
  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;
    const spacing = 24.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
