import 'package:flutter/material.dart';

// A model to set the list of items with custom checkbox icon
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

  // A list item either a String or a Model
  dynamic item;

  // Set the item as selected or not
  bool? isSelected;

  // Set the asset check icon
  String? checkIcon;

  // Set the asset uncheck icon
  String? uncheckIcon;

  // Set the check icon using IconData
  IconData? checkIconData;

  // Set the uncheck icon using IconData
  IconData? uncheckIconData;

  // Set the size of the check icons
  double iconSize;

  // Set the color of the unselected check icon
  Color unselectedIconColor;

  // Set the color of the selected check icon
  Color selectedIconColor;

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'isSelected': isSelected,
    };
  }
}
