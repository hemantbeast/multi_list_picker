library multi_list_picker;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multi_list_picker/models/multi_list_model.dart';

export 'multi_list_picker.dart';

// A dialog with multiple or single item pick from a list.
class MultiListPicker extends StatefulWidget {
  const MultiListPicker({
    super.key,
    required this.title,
    required this.items,
    this.displayPropertyName = '',
    this.width = 320,
    this.height = 200,
    this.dialogRadius = 10,
    this.buttonText = 'OK',
    this.isSingleSelection = false,
    this.dividerColor = const Color(0xFFF2F2F2),
    this.closeIcon,
    this.titleStyle,
    this.itemTextStyle,
    this.buttonStyle,
    this.onSelected,
  });

  // Set the title of dialog
  final String title;

  // Set width of the dialog
  final double width;

  // Set height of the dialog
  final double height;

  // List of items to select from
  final List<MultiListModel> items;

  // Field name of the item to be visible in list
  final String displayPropertyName;

  // Close icon widget to be show in top right
  final Widget? closeIcon;

  // Customise the title text style
  final TextStyle? titleStyle;

  // Customise the item text style
  final TextStyle? itemTextStyle;

  // Corner radius of the dialog
  final double? dialogRadius;

  // Set the text of button
  final String? buttonText;

  // Customise the button style
  final ButtonStyle? buttonStyle;

  // Differentiate between multiple or single item selection
  final bool? isSingleSelection;

  // Color of the divider between list of items
  final Color? dividerColor;

  // Fires when the button is tapped.
  final void Function(List<dynamic>)? onSelected;

  @override
  State<MultiListPicker> createState() => _MultiListPickerState();
}

class _MultiListPickerState extends State<MultiListPicker> {
  late List<MultiListModel> items = widget.items;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.dialogRadius!),
      ),
      title: _getTitleWidget(),
      contentTextStyle: widget.itemTextStyle,
      content: Container(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.only(bottom: 10),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 17),
          itemCount: items.length,
          itemBuilder: (context, index) {
            String? text = '';

            if (items[index].item is String) {
              text = items[index].item;
            } else {
              final json = jsonEncode(items[index].item);
              final item = jsonDecode(json);
              text = item[widget.displayPropertyName];
            }

            return InkWell(
              onTap: () {
                setState(() {
                  if (widget.isSingleSelection!) {
                    _singleSelection(index);
                  } else {
                    _multiSelection(index);
                  }
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    _getCheckboxIcon(items[index]),
                    const SizedBox(width: 12),
                    Text(
                      text ?? '',
                      style: widget.itemTextStyle,
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              color: widget.dividerColor,
            );
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final list = items.where((e) => e.isSelected != null && e.isSelected!).map((e) => e.item).toList();
                widget.onSelected?.call(list);
                Navigator.pop(context);
              },
              style: widget.buttonStyle,
              child: Text(widget.buttonText!),
            ),
          ],
        ),
      ],
    );
  }

  // Gets the checkbox icon from the model or the default one
  Widget _getCheckboxIcon(MultiListModel model) {
    final color = model.isSelected != null && model.isSelected! ? model.selectedIconColor : model.unselectedIconColor;

    if (model.checkIconData != null && model.uncheckIconData != null) {
      final icon = model.isSelected != null && model.isSelected! ? model.checkIconData : model.uncheckIconData;
      return Icon(icon, color: color, size: model.iconSize);
    } else if (model.checkIcon != null && model.uncheckIcon != null) {
      final icon = model.isSelected != null && model.isSelected! ? model.checkIcon : model.uncheckIcon;
      return Image.asset(
        icon ?? '',
        color: color,
        height: model.iconSize,
        width: model.iconSize,
      );
    } else {
      final icon = model.isSelected != null && model.isSelected! ? Icons.check_box : Icons.check_box_outline_blank;
      return Icon(icon, color: color, size: model.iconSize);
    }
  }

  // Gets the title widget with close icon if provided
  Widget _getTitleWidget() {
    if (widget.closeIcon == null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
        child: Text(widget.title, style: widget.titleStyle),
      );
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: widget.titleStyle),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: widget.closeIcon,
            )
          ],
        ),
      );
    }
  }

  // Single item selection logic
  void _singleSelection(int index) {
    for (var i = 0; i < items.length; i++) {
      items[i].isSelected = i == index;
    }
  }

  // Multiple item selection logic
  void _multiSelection(int index) {
    final item = items[index];

    if (item.isSelected == null) {
      item.isSelected = true;
    } else {
      item.isSelected = !item.isSelected!;
    }
  }
}
