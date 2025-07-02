import 'package:flutter/material.dart';

class CriminalRecordForm extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  final Function(String field, String value) onChanged;

  const CriminalRecordForm({
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
        Text('사건 ${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildTextField("사건 상세", (val) => onChanged("details", val)),
        const SizedBox(height: 8),
        _buildTextField("형량", (val) => onChanged("sentence", val)),
        const SizedBox(height: 8),
        _buildTextField("판결일자", (val) => onChanged("judgementDate", val)),
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
