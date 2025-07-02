import 'package:flutter/material.dart';

class PledgeForm extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  final Function(String field, String value) onChanged;

  const PledgeForm({
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
        Text('${index + 1}번 공약', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildTextField("공약 제목", (val) => onChanged("title", val)),
        const SizedBox(height: 8),
        _buildTextField("공약 내용", (val) => onChanged("content", val), maxLines: 3),
        const SizedBox(height: 8),
        _buildCategoryDropdown(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
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

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: data['category'].isEmpty ? null : data['category'],
          hint: const Text("카테고리"),
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: "경제", child: Text("경제")),
            DropdownMenuItem(value: "복지", child: Text("복지")),
            DropdownMenuItem(value: "교육", child: Text("교육")),
            DropdownMenuItem(value: "기타", child: Text("기타")),
          ],
          onChanged: (val) {
            if (val != null) {
              onChanged("category", val);
            }
          },
        ),
      ),
    );
  }
}
