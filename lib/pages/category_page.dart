import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // Custom color constants (matching other pages)
  static const primaryColor = Color(0xFF4CAF50);
  static const secondaryColor = Color(0xFFFFC107);
  static const accentColor = Color(0xFF03A9F4);
  static const backgroundColor = Color(0xFFF5F5F5);
  static const textColorPrimary = Color(0xFF212121);
  static const textColorSecondary = Color(0xFF757575);

  // Sample category data
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Work',
      'type': 'Professional',
      'icon': Icons.work,
      'color': Color(0xFF4CAF50),
      'taskCount': 12
    },
    {
      'name': 'Personal',
      'type': 'Private',
      'icon': Icons.person,
      'color': Color(0xFF2196F3),
      'taskCount': 8
    },
    {
      'name': 'Shopping',
      'type': 'Personal',
      'icon': Icons.shopping_bag,
      'color': Color(0xFFFFC107),
      'taskCount': 5
    },
    {
      'name': 'Health',
      'type': 'Wellness',
      'icon': Icons.favorite,
      'color': Color(0xFFE91E63),
      'taskCount': 3
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Categories',
          style: GoogleFonts.poppins(
            color: textColorPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: textColorPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildCategoryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategorySheet(context),
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryCard(category);
      },
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: category['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    category['icon'],
                    color: category['color'],
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColorPrimary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        category['type'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: textColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: category['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${category['taskCount']} Tasks',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: category['color'],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCategorySheet(),
    );
  }
}

class AddCategorySheet extends StatefulWidget {
  @override
  _AddCategorySheetState createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends State<AddCategorySheet> {
  static const primaryColor = Color(0xFF4CAF50);
  static const textColorPrimary = Color(0xFF212121);
  static const textColorSecondary = Color(0xFF757575);

  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'Personal';
  Color _selectedColor = Color(0xFF4CAF50);
  IconData _selectedIcon = Icons.folder;

  final List<Color> _colorOptions = [
    Color(0xFF4CAF50),
    Color(0xFF2196F3),
    Color(0xFFFFC107),
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFF795548),
  ];

  final List<IconData> _iconOptions = [
    Icons.folder,
    Icons.work,
    Icons.person,
    Icons.shopping_bag,
    Icons.favorite,
    Icons.school,
    Icons.sports_esports,
    Icons.flight,
    Icons.restaurant,
    Icons.fitness_center,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSheetHeader(),
                SizedBox(height: 24),
                _buildNameField(),
                SizedBox(height: 24),
                _buildTypeSelector(),
                SizedBox(height: 24),
                _buildColorSelector(),
                SizedBox(height: 24),
                _buildIconSelector(),
                SizedBox(height: 32),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSheetHeader() {
    return Row(
      children: [
        Text(
          'New Category',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColorPrimary,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.close, color: textColorSecondary),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: textColorPrimary,
      ),
      decoration: InputDecoration(
        labelText: 'Category Name',
        labelStyle: GoogleFonts.poppins(color: textColorSecondary),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter a category name';
        }
        return null;
      },
    );
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColorPrimary,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedType,
              isExpanded: true,
              items: ['Personal', 'Professional', 'Health', 'Shopping', 'Other']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.poppins(color: textColorPrimary),
                        ),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedType = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColorPrimary,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _colorOptions.map((color) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                });
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _selectedColor == color
                        ? Colors.white
                        : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    if (_selectedColor == color)
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: _selectedColor == color
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildIconSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColorPrimary,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _iconOptions.length,
            itemBuilder: (context, index) {
              final icon = _iconOptions[index];
              final isSelected = _selectedIcon == icon;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIcon = icon;
                  });
                },
                child: Container(
                  width: 56,
                  height: 56,
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _selectedColor.withOpacity(0.1)
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? _selectedColor
                          : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? _selectedColor : textColorSecondary,
                    size: 24,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Create Category',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement category creation logic
      Navigator.pop(context);
    }
  }
}
