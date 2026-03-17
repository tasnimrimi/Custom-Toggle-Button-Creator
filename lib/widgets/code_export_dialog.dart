import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/switch_config.dart';

class CodeExportDialog extends StatefulWidget {
  final SwitchConfig config;

  const CodeExportDialog({super.key, required this.config});

  @override
  State<CodeExportDialog> createState() => _CodeExportDialogState();
}

class _CodeExportDialogState extends State<CodeExportDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  void _copy(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final flutterCode = widget.config.generateFlutterCode();
    final cssCode = widget.config.generateCssCode();

    return Dialog(
      backgroundColor: const Color(0xFF1A1A24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 600,
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF252535))),
              ),
              child: Row(
                children: [
                  const Icon(Icons.code_rounded,
                      color: Color(0xFF7C6FF7), size: 20),
                  const SizedBox(width: 10),
                  const Text('Export Code',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close_rounded,
                        color: Color(0xFF6B6B8A), size: 20),
                  ),
                ],
              ),
            ),

            // Tabs
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TabBar(
                controller: _tabCtrl,
                labelColor: const Color(0xFF7C6FF7),
                unselectedLabelColor: const Color(0xFF6B6B8A),
                indicatorColor: const Color(0xFF7C6FF7),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: 'Flutter / Dart'),
                  Tab(text: 'CSS / HTML'),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: [
                  _codeView(flutterCode),
                  _codeView(cssCode),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFF252535))),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded,
                      size: 14, color: Color(0xFF6B6B8A)),
                  const SizedBox(width: 6),
                  const Text(
                    'Paste code directly into your project',
                    style: TextStyle(color: Color(0xFF6B6B8A), fontSize: 11),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () =>
                        _copy(_tabCtrl.index == 0 ? flutterCode : cssCode),
                    icon: Icon(
                        _copied ? Icons.check_rounded : Icons.copy_rounded,
                        size: 14),
                    label: Text(_copied ? 'Copied!' : 'Copy Code',
                        style: const TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _copied
                          ? const Color(0xFF10B981)
                          : const Color(0xFF7C6FF7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _codeView(String code) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF252535)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFFE2E8F0),
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
