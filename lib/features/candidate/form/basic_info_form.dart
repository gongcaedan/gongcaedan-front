import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'api/party_api.dart';
import 'models/party_model.dart';

class BasicInfoForm extends StatefulWidget {
  final Function(Party?) onPartyChanged;
  final VoidCallback onPickImage;
  final File? selectedImage;
  final Function(String) onNameChanged;
  final Function(String) onBirthChanged;
  final Function(String) onGenderChanged;

  const BasicInfoForm({
    super.key,
    required this.onPartyChanged,
    required this.onPickImage,
    required this.selectedImage,
    required this.onNameChanged,
    required this.onBirthChanged,
    required this.onGenderChanged,
  });

  @override
  State<BasicInfoForm> createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm> {
  List<Party> _partyList = [];
  Party? _selectedParty;
  String _selectedGender = 'M';

  final TextEditingController _birthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadParties();
  }

  Future<void> _loadParties() async {
    try {
      final parties = await PartyApi.fetchParties();
      setState(() {
        _partyList = parties;
        _selectedParty = parties.first;
        widget.onPartyChanged(_selectedParty);
      });
    } catch (e) {
      print("정당 불러오기 실패: $e");
    }
  }

  Future<void> _pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      _birthController.text = formatted;
      widget.onBirthChanged(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField("이름", widget.onNameChanged),
        const SizedBox(height: 16),
        _buildBirthDatePicker(),
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

  Widget _buildBirthDatePicker() {
    return TextField(
      controller: _birthController,
      readOnly: true,
      onTap: _pickBirthDate,
      decoration: InputDecoration(
        labelText: '생년월일 (yyyy-MM-dd)',
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

  Widget _buildPartyDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Party>(
          value: _selectedParty,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: _partyList.map((party) {
            return DropdownMenuItem<Party>(
              value: party,
              child: Text(party.name),
            );
          }).toList(),
          onChanged: (party) {
            setState(() {
              _selectedParty = party;
              widget.onPartyChanged(party);
            });
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
          ChoiceChip(
            label: const Text('남'),
            selected: _selectedGender == 'M',
            onSelected: (selected) {
              if (selected) {
                setState(() => _selectedGender = 'M');
                widget.onGenderChanged('M');
              }
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('여'),
            selected: _selectedGender == 'F',
            onSelected: (selected) {
              if (selected) {
                setState(() => _selectedGender = 'F');
                widget.onGenderChanged('F');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPickImage,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: widget.selectedImage == null
            ? const Center(child: Text("프로필 이미지 선택", style: TextStyle(color: Colors.black54)))
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(widget.selectedImage!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
