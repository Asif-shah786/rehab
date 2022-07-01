import 'package:flutter/material.dart';

enum TabItem { home, rehab, practice, profile }

class TabItemData {
  const TabItemData({required this.title, required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(title: 'Home', icon: Icons.home_rounded),
    TabItem.rehab: TabItemData(title: 'Rehab', icon: Icons.wheelchair_pickup_outlined),
    TabItem.practice: TabItemData(title: 'Practice', icon: Icons.compass_calibration_outlined),
    TabItem.profile: TabItemData(title: 'Profile', icon: Icons.person_outline),
  };
}
