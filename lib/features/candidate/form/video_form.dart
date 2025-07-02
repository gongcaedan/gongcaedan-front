import 'package:flutter/material.dart';

class VideoForm extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function(String field, String value) onChanged;

  const VideoForm({
    super.key,
    required this.data,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField("영상 제목", (val) => onChanged("title", val)),
        const SizedBox(height: 8),
        _buildTextField("영상 URL", (val) => onChanged("url", val)),
        const SizedBox(height: 8),
        _buildTextField("방송 날짜", (val) => onChanged("date", val)),
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
}
