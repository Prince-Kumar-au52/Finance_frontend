import 'package:flutter/material.dart';

class DrawerItemData {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DrawerItemData({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

// Drawer widget

