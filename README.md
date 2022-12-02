
# Multi List Picker

A flutter package to select multiple or single item from a list picker dialog.

## Installation

In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
dependencies:
  multi_list_picker: <latest_version>
```

## Features

- `MultiListPicker` is a dialog widget providing multiple or single item selection from a list.
- You can customise the title, content, button UI using their styles.
- You need to use this picker in a `showDialog`'s builder function.
- You can provide custom asset icon or `IconData` within `MultiListModel`.

<img src="https://github.com/hemantbeast/multi_list_picker/blob/master/gifs/preview.gif?raw=true" width="250"/><br /><sub><b>Dialog</b></sub>

## Usage

#### Using list of `String` as items

```dart
var list = <MultiListModel>[
    MultiListModel(item: 'Dog'),
    MultiListModel(item: 'Cat'),
    MultiListModel(item: 'Lion'),
    MultiListModel(item: 'Cheetah'),
];
```

```dart
showDialog<void>(
  context: context,
  builder: (BuildContext context) {
    return MultiListPicker(
      title: 'Select Animal',
      items: list,
      onSelected: (values) {
          // here values is List<String>
        _selectedAnimals = values;
      },
    );
  },
);
```

#### Using list of `Model` as items

If you have any model class like `Animal` with different field's as `name`, `type`, `color`, etc; so you can use this model class as items and use the `displayPropertyName: 'name'` to show the text selection in the dialog.

The model class must have the `toJson()` method in it.

```dart
class Animal {
  Animal({
    this.name,
    this.type,
    this.color,
  });

  String? name;
  String? type;
  Color? color;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type
    };
  }
}
```

```dart
var list = <MultiListModel>[
    MultiListModel(item: Animal(name: 'Dog', type: 'herbi')),
    MultiListModel(item: Animal(name: 'Cat', type: 'herbi')),
    MultiListModel(item: Animal(name: 'Lion', type: 'carni')),
    MultiListModel(item: Animal(name: 'Cheetah', type: 'carni')),
];
```

```dart
showDialog<void>(
  context: context,
  builder: (BuildContext context) {
    return MultiListPicker(
      title: 'Select Animal',
      items: lstAnimals,
      displayPropertyName: 'name',
      onSelected: (values) {
          // here values is List<Animal>
        _selectedAnimals = values;
      },
    );
  },
);
```

## Customizations

#### `MultiListPicker` customizations

- `title` - Set title of the dialog
- `titleStyle` - Set `TextStyle` of the title
- `items` - List of items as String or Model
- `displayPropertyName` - Property field name when items is provided as `List<Model>`
- `isSingleSelection` - Bool value to set the single item selection. Default is `false`
- `closeIcon` - Widget to set the close icon
- `itemTextStyle` - Set `TextStyle` of the item text
- `buttonText` - Set the text of the button. Default is `OK`
- `buttonStyle` - Set `ButtonStyle` of the button
- `dialogRadius` - Set corner radius of the dialog. Default is `10`
- `dividerColor` - Set the color for the divider. Default is `#F2F2F2`
- `onSelected` - Gets list of selected items on button tapped

#### `MultiListModel` customizations

- `item` - Set a string or model
- `isSelected` - Set or get the item is selected
- `checkIcon` - Set a check icon from asset
- `uncheckIcon` - Set a uncheck icon from asset
- `checkIconData` - Set a check icon using `Icon` widget
- `uncheckIconData` - Set a uncheck icon using `Icon` widget
- `iconSize` - Set size of a icon, default is `24`
- `selectedIconColor` - Set the color of selected icon, default is blue.
- `unselectedIconColor` - Set the color of unselected icon, default is grey.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

