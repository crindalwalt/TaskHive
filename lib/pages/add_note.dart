import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_hive/models/task.dart';
import 'package:task_hive/providers/task_provider.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedPriority = 'Medium';
  String _selectedCategory = 'Personal';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // Custom color constants (matching home page)
  static const primaryColor = Color(0xFF4CAF50);
  static const secondaryColor = Color(0xFFFFC107);
  static const accentColor = Color(0xFF03A9F4);
  static const backgroundColor = Color(0xFFF5F5F5);
  static const textColorPrimary = Color(0xFF212121);
  static const textColorSecondary = Color(0xFF757575);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add New Task',
          style: GoogleFonts.poppins(
            color: textColorPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: textColorPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTaskTitleField(),
                SizedBox(height: 24),
                _buildTaskDescriptionField(),
                SizedBox(height: 24),
                _buildDateTimePicker(),
                SizedBox(height: 24),
                _buildPrioritySelector(),
                SizedBox(height: 24),
                _buildCategorySelector(),
                SizedBox(height: 24),
                _buildReminderToggle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskTitleField() {
    return TextFormField(
      controller: _titleController,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: textColorPrimary,
      ),
      decoration: InputDecoration(
        labelText: 'Task Title',
        labelStyle: GoogleFonts.poppins(color: textColorSecondary),
        filled: true,
        fillColor: Colors.white,
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
        prefixIcon: Icon(Icons.title, color: textColorSecondary),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter a task title';
        }
        return null;
      },
    );
  }

  Widget _buildTaskDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 3,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: textColorPrimary,
      ),
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: GoogleFonts.poppins(color: textColorSecondary),
        filled: true,
        fillColor: Colors.white,
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
        prefixIcon: Icon(Icons.description, color: textColorSecondary),
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date & Time',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColorPrimary,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: _selectDate,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: textColorSecondary),
                      SizedBox(width: 8),
                      Text(
                        DateFormat('MMM dd, yyyy').format(_selectedDate),
                        style: GoogleFonts.poppins(color: textColorPrimary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: _selectTime,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: textColorSecondary),
                      SizedBox(width: 8),
                      Text(
                        _selectedTime.format(context),
                        style: GoogleFonts.poppins(color: textColorPrimary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrioritySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority',
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedPriority,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: textColorSecondary),
              items: ['Low', 'Medium', 'High']
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
                  _selectedPriority = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: textColorSecondary),
              items: ['Personal', 'Work', 'Shopping', 'Health', 'Others']
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
                  _selectedCategory = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderToggle() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.notifications_outlined, color: textColorSecondary),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Set Reminder',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: textColorPrimary,
              ),
            ),
          ),
          Switch(
            value: false,
            onChanged: (value) {},
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: textColorPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: textColorPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitForm() {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      // TODO: Implement task creation logic
      provider.addTask(
        Task(
          id: Uuid().v4(),
          userId: 'user1',
          title: _titleController.text,
          description: _descriptionController.text,
          isCompleted: false,
          dueDate: DateTime.now(),
        ),
      );
      print('Task added: ${_titleController.text}');
      // print('Task description: ${_descriptionController.text}');
      Navigator.pop(context);
    }
  }
}
