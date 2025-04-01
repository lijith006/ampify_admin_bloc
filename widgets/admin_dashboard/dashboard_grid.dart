// import 'package:ampify_admin_bloc/widgets/admin_dashboard/animated_container.dart';
import 'package:flutter/material.dart';

import 'animated_container.dart';

class AdminDashboardGrid extends StatelessWidget {
  final List<Map<String, dynamic>> features;

  const AdminDashboardGrid({Key? key, required this.features})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          return FeatureCard(
            title: feature['title'],
            icon: feature['icon'],
            onTap: feature['onTap'],
          );
        },
      ),
    );
  }
}
