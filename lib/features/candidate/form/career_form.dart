import 'package:flutter/material.dart';

class CareerForm extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  final Function(String field, String value) onChanged;

  const CareerForm({
    super.key,
    required this.index,
    required this.data,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('경력 ${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildTextField("직책", (val) => onChanged("position", val)),
        const SizedBox(height: 8),
        _buildTextField("소속기관", (val) => onChanged("organization", val)),
        const SizedBox(height: 8),
        _buildTextField("시작일", (val) => onChanged("startDate", val)),
        const SizedBox(height: 8),
        _buildTextField("종료일", (val) => onChanged("endDate", val)),
        const SizedBox(height: 24),
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
