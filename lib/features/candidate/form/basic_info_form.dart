import 'dart:io';
import 'package:flutter/material.dart';

class BasicInfoForm extends StatelessWidget {
  final String selectedParty;
  final Function(String) onPartyChanged;
  final VoidCallback onPickImage;
  final File? selectedImage;

  final Function(String) onNameChanged;
  final Function(String) onBirthChanged;

  const BasicInfoForm({
    super.key,
    required this.selectedParty,
    required this.onPartyChanged,
    required this.onPickImage,
    required this.selectedImage,
    required this.onNameChanged,
    required this.onBirthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField("이름", onNameChanged),
        const SizedBox(height: 16),
        _buildTextField("생년월일", onBirthChanged),
        const SizedBox(height: 16),
        _buildPartyDropdown(),
        const SizedBox(height: 16),
        _buildGenderSelector(),
        const SizedBox(height: 16),
        _buildImagePicker(context),
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

  Widget _buildPartyDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedParty,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: const [
            DropdownMenuItem(value: "더불어민주당", child: Text("더불어민주당")),
            DropdownMenuItem(value: "국민의힘", child: Text("국민의힘")),
            DropdownMenuItem(value: "정의당", child: Text("정의당")),
            DropdownMenuItem(value: "무소속", child: Text("무소속")),
          ],
          onChanged: (value) {
            if (value != null) {
              onPartyChanged(value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        children: [
          const Text("성별", style: TextStyle(fontSize: 16)),
          const SizedBox(width: 16),
          Container(width: 28, height: 28, color: Colors.blue),
          const SizedBox(width: 12),
          Container(width: 28, height: 28, color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: selectedImage == null
            ? const Center(child: Text("프로필 이미지 선택", style: TextStyle(color: Colors.black54)))
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(selectedImage!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
