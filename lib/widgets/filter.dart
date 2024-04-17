import 'package:flutter/material.dart';

class FilterPopup extends StatefulWidget {
  const FilterPopup({Key? key}) : super(key: key);

  @override
  FilterPopupState createState() => FilterPopupState();
}

class FilterPopupState extends State<FilterPopup> {
  final List<String> _selectedDietaryRestrictions = [];
  final List<String> _selectedCuisines = [];
  String? _selectedTiming;

  final List<String> _dietaryRestrictions = ['Vegan', 'Vegetarian', 'Gluten-Free', 'Dairy-Free', 'Kosher', 'Keto'];
  final List<String> _cuisines = ['American', 'Chinese', 'Cuban', 'Greek', 'Indian', 'Italian', 'Japanese', 'Korean', 'Mexican', 'Thai', 'Vietnamese'];
  final List<String> _timing = ['10 minutes', '30 minutes', '1 hour'];

  List<String> getSelectedDietaryRestrictions() {
    return _selectedDietaryRestrictions;
  }

  List<String> getSelectedCuisines() {
    return _selectedCuisines;
  }

  String? getSelectedTiming() {
    return _selectedTiming;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 219, 235, 188),
      title: const Text(
        'Filter Options',
        style: TextStyle(
          color: Color.fromARGB(255, 67, 107, 31),
          fontWeight: FontWeight.w600,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Dietary Restrictions Section
            _buildSection(
              title: 'Dietary Restrictions',
              options: _dietaryRestrictions,
              selectedOptions: _selectedDietaryRestrictions,
              isMultipleSelection: true,
            ),
            // Cuisine Section
            const SizedBox(height: 16),
            _buildSection(
              title: 'Cuisine',
              options: _cuisines,
              selectedOptions: _selectedCuisines,
              isMultipleSelection: true,
            ),
            // Timing Section
            const SizedBox(height: 16),
            _buildSection(
              title: 'Timing',
              options: _timing,
              selectedOptions: [_selectedTiming ?? ''],
              isMultipleSelection: false,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            // Apply changes and close the dialog
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 67, 107, 31)), // Button color
          ),
          child: const Text(
            'Apply Changes',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required List<String> options, required List<String> selectedOptions, required bool isMultipleSelection}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return ChoiceChip(
              label: Text(
                option,
                style: TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
              selected: isSelected,
              onSelected: (isSelected) {
                setState(() {
                  if (isMultipleSelection) {
                    if (isSelected) {
                      selectedOptions.add(option);
                    } else {
                      selectedOptions.remove(option);
                    }
                  } else {
                    _selectedTiming = option;
                  }
                });
              },
              backgroundColor: isSelected ? Colors.green : Colors.white,
              elevation: isSelected ? 2 : 0,
              pressElevation: 2,
              selectedColor: const Color.fromARGB(255, 114, 141, 90),
              labelPadding: const EdgeInsets.symmetric(horizontal: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: isSelected ? Colors.transparent : const Color.fromARGB(255, 230, 230, 230)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
