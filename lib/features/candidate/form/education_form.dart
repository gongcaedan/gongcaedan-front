import 'package:flutter/material.dart';

class EducationForm extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  final Function(String field, String value) onChanged;

  const EducationForm({
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
        Text('학력 ${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildLabeledTextField("학교명", (val) => onChanged('school', val)),
        const SizedBox(height: 8),
        _buildLabeledTextField("전공", (val) => onChanged('major', val)),
        const SizedBox(height: 8),
        _buildDegreeDropdown(),
        const SizedBox(height: 8),
        _buildLabeledTextField("졸업연도", (val) => onChanged('gradYear', val)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildLabeledTextField(String label, Function(String) onChanged) {
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

  Widget _buildDegreeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: data['degree'].isEmpty ? null : data['degree'],
          hint: const Text("학위"),
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: "학사", child: Text("학사")),
            DropdownMenuItem(value: "석사", child: Text("석사")),
            DropdownMenuItem(value: "박사", child: Text("박사")),
          ],
          onChanged: (val) {
            if (val != null) {
              onChanged('degree', val);
            }
          },
        ),
      ),
    );
  }
}
