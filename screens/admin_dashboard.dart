import 'package:ampify_admin_bloc/widgets/circle_icon_widget.dart';
import 'package:ampify_admin_bloc/widgets/custom_text_styles.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Dashboard', style: CustomTextStyles.heading2()),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Text('Dashboard', style: CustomTextStyles.heading2()),
            SizedBox(
              height: 300,
              width: 500,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 8,
                child: const Padding(
                  padding: EdgeInsets.all(35.0),
                  child: Wrap(
                    spacing: 30,
                    runSpacing: 65,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: [
                      CircleIconWidget(icon: Icons.add),
                      CircleIconWidget(icon: Icons.edit),
                      CircleIconWidget(icon: Icons.delete),
                      CircleIconWidget(icon: Icons.folder_open_rounded),
                      CircleIconWidget(
                          icon: Icons.supervised_user_circle_sharp),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
