import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Future<void> _pickDate(BuildContext context, String label, String field) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      onChanged(field, formatted);
    }
  }

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
        _buildDatePicker(context, "시작일", data['startDate'] ?? '', 'startDate'),
        const SizedBox(height: 8),
        _buildDatePicker(context, "종료일", data['endDate'] ?? '', 'endDate'),
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

  Widget _buildDatePicker(BuildContext context, String label, String value, String field) {
    return GestureDetector(
      onTap: () => _pickDate(context, label, field),
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: const Icon(Icons.calendar_today),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }
}
