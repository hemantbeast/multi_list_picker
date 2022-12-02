import 'package:flutter/material.dart';

class MultiListModel {
  MultiListModel({
    required this.item,
    this.isSelected,
    this.checkIcon,
    this.uncheckIcon,
    this.checkIconData,
    this.uncheckIconData,
    this.iconSize = 24,
    this.unselectedIconColor = Colors.grey,
    this.selectedIconColor = Colors.blue,
  });

  dynamic item;
  bool? isSelected;
  String? checkIcon;
  String? uncheckIcon;
  IconData? checkIconData;
  IconData? uncheckIconData;
  double iconSize;
  Color unselectedIconColor;
  Color selectedIconColor;

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'isSelected': isSelected,
    };
  }
}
