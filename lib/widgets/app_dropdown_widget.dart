import 'package:flutter/material.dart';

class AppDropDownWidget extends StatefulWidget {
  final List<String> items;
  final String? value;
  ValueChanged? onChanged;

  AppDropDownWidget({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _AppDropDownWidgetState createState() => _AppDropDownWidgetState();
}

class _AppDropDownWidgetState extends State<AppDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        iconEnabledColor: Colors.white,
        value: widget.value,
        style:
            TextStyle(color: Colors.white), // Text color for the selected item
        items: widget.items.map(
          (curItem) {
            if (curItem == widget.value) {
              return DropdownMenuItem(
                value: curItem,
                child: Text(curItem.toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              );
            } else {
              return DropdownMenuItem(
                value: curItem,
                child: Text(curItem.toString(),
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              );
            }
          },
        ).toList(),
        onChanged: widget.onChanged,
      ),
    );
  }
}
