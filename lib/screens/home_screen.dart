import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/switch_config.dart';
import '../widgets/left_sidebar.dart';
import '../widgets/center_canvas.dart';
import '../widgets/right_properties_panel.dart';
import '../widgets/code_export_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SwitchConfig _config = SwitchConfig();
  String _projectName = 'Basic_Toggle_v2';
  bool _isSaving = false;

  final List<({String name, SwitchConfig config})> _savedItems = [
    (
      name: 'Dark_Switch',
      config: SwitchConfig(
        accentColor: const Color(0xFF7C6FF7),
        isOn: true,
        borderRadius: 20,
      ),
    ),
  ];

  void _onConfigChanged(SwitchConfig newConfig) {
    setState(() => _config = newConfig);
  }

  void _onSave() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _savedItems.insert(0, (name: _projectName, config: _config.copyWith()));
      _isSaving = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved "$_projectName"'),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void _showCodeDialog() {
    showDialog(
      context: context,
      builder: (_) => CodeExportDialog(config: _config),
    );
  }

  void _onCopyCode() async {
    final code = _config.generateFlutterCode();
    await Clipboard.setData(ClipboardData(text: code));
    _showCodeDialog();
  }

  void _onNewProject() {
    showDialog(
      context: context,
      builder: (ctx) {
        String newName = 'New_Toggle_v1';
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A24),
          title: const Text('New Project',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Project name',
              hintStyle: const TextStyle(color: Color(0xFF6B6B8A)),
              filled: true,
              fillColor: const Color(0xFF252535),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
            onChanged: (v) => newName = v,
            controller: TextEditingController(text: newName),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF6B6B8A))),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _config = SwitchConfig();
                  _projectName = newName;
                });
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C6FF7)),
              child:
                  const Text('Create', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: Row(
              children: [
                LeftSidebar(
                  config: _config,
                  savedItems: _savedItems,
                  onConfigChanged: _onConfigChanged,
                  onNewProject: _onNewProject,
                ),
                Container(width: 1, color: const Color(0xFF1E1E2E)),
                Expanded(
                  child: CenterCanvas(
                    config: _config,
                    onConfigChanged: _onConfigChanged,
                  ),
                ),
                Container(width: 1, color: const Color(0xFF1E1E2E)),
                RightPropertiesPanel(
                  config: _config,
                  onConfigChanged: _onConfigChanged,
                  onCopyCode: _onCopyCode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF12121A),
        border: Border(
          bottom: BorderSide(color: Color(0xFF1E1E2E), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF7C6FF7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.toggle_on_rounded,
                size: 18, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Text(
            'Switch Creation Tool',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 20),

          // Breadcrumb
          const Icon(Icons.folder_outlined, size: 14, color: Color(0xFF6B6B8A)),
          const SizedBox(width: 4),
          const Text('Projects',
              style: TextStyle(color: Color(0xFF6B6B8A), fontSize: 13)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.chevron_right_rounded,
                size: 14, color: Color(0xFF6B6B8A)),
          ),
          GestureDetector(
            onTap: () => _showRenameDialog(),
            child: Text(
              _projectName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),

          // Preview button
          OutlinedButton.icon(
            onPressed: () => _showCodeDialog(),
            icon: const Icon(Icons.play_circle_outline_rounded,
                size: 16, color: Color(0xFF7C6FF7)),
            label: const Text('Preview',
                style: TextStyle(color: Color(0xFF7C6FF7), fontSize: 12)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF252535)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(width: 8),

          // Save button
          OutlinedButton(
            onPressed: _isSaving ? null : _onSave,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF252535)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: _isSaving
                ? const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Text('Save', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),

          // Export Code button
          ElevatedButton.icon(
            onPressed: _onCopyCode,
            icon: const Icon(Icons.download_rounded, size: 14),
            label: const Text('Export Code',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C6FF7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(width: 16),
          // User avatar
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFF7C6FF7).withOpacity(0.2),
            child: const Text('TA',
                style: TextStyle(
                    color: Color(0xFF7C6FF7),
                    fontSize: 10,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showRenameDialog() {
    final ctrl = TextEditingController(text: _projectName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A24),
        title: const Text('Rename Project',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF252535),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF6B6B8A))),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _projectName = ctrl.text);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C6FF7)),
            child: const Text('Rename', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
