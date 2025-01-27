import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_hive/pages/add_note.dart';

class HomePage extends StatelessWidget {
  // Custom color constants
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            _buildDashboardCards(),
            _buildFilterSection(),
            _buildTaskList(),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      title: Text(
        'Task Hive',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: textColorPrimary,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: textColorPrimary),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert, color: textColorPrimary),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDashboardCards() {
    return SliverToBoxAdapter(
      child: Container(
        height: 160,
        child: ListView(
          padding: EdgeInsets.all(16),
          scrollDirection: Axis.horizontal,
          children: [
            _buildMetricCard(
              'Tasks Today',
              '12',
              Icons.today,
              [Color(0xFF4CAF50), Color(0xFF45B649)],
            ),
            _buildMetricCard(
              'Pending',
              '5',
              Icons.pending_actions,
              [Color(0xFFFFC107), Color(0xFFFFEB3B)],
            ),
            _buildMetricCard(
              'Completed',
              '18',
              Icons.task_alt,
              [Color(0xFF03A9F4), Color(0xFF00BCD4)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
      String title, String value, IconData icon, List<Color> gradientColors) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white, size: 32),
                Spacer(),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text(
              'My Tasks',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColorPrimary,
              ),
            ),
            Spacer(),
            PopupMenuButton<String>(
              icon: Icon(Icons.filter_list, color: textColorPrimary),
              itemBuilder: (context) => [
                PopupMenuItem(value: 'all', child: Text('All Tasks')),
                PopupMenuItem(value: 'completed', child: Text('Completed')),
                PopupMenuItem(value: 'pending', child: Text('Pending')),
                PopupMenuItem(value: 'overdue', child: Text('Overdue')),
              ],
              onSelected: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildTaskCard(
          'Task ${index + 1}',
          'This is a description for task ${index + 1}. It demonstrates how multiple lines of text would appear.',
          DateTime.now().add(Duration(days: index)),
          index % 3 == 0,
        ),
        childCount: 10,
      ),
    );
  }

  Widget _buildTaskCard(
      String title, String description, DateTime dueDate, bool isCompleted) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColorPrimary,
                        ),
                      ),
                    ),
                    Checkbox(
                      value: isCompleted,
                      onChanged: (value) {},
                      activeColor: primaryColor,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: textColorSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: textColorSecondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      DateFormat('MMM dd, yyyy').format(dueDate),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: textColorSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddTaskPage()),
        );
      },
      backgroundColor: primaryColor,
      child: Icon(Icons.add),
      elevation: 4,
    );
  }
}
