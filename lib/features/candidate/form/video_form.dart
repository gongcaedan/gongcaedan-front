import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VideoForm extends StatefulWidget {
  final Map<String, dynamic> data;
  final Function(String field, String value) onChanged;

  const VideoForm({
    super.key,
    required this.data,
    required this.onChanged,
  });

  @override
  State<VideoForm> createState() => _VideoFormState();
}

class _VideoFormState extends State<VideoForm> {
  final TextEditingController _broadcastDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _broadcastDateController.text = widget.data['broadcastDate'] ?? '';
  }

  Future<void> _pickBroadcastDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      _broadcastDateController.text = formatted;
      widget.onChanged('broadcastDate', formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField("영상 제목", (val) => widget.onChanged("title", val)),
        const SizedBox(height: 8),
        _buildTextField("영상 URL", (val) => widget.onChanged("videoUrl", val)),
        const SizedBox(height: 8),
        _buildBroadcastDatePicker(), // ✅ 날짜 선택 필드
      ],
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildBroadcastDatePicker() {
    return TextField(
      controller: _broadcastDateController,
      readOnly: true,
      onTap: _pickBroadcastDate,
      decoration: InputDecoration(
        labelText: '방송 날짜 (yyyy-MM-dd)',
        suffixIcon: const Icon(Icons.calendar_today),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
