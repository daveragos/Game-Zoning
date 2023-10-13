import 'package:flutter/material.dart';

class Toggler extends StatefulWidget {
  const Toggler({Key? key, required this.labels, required this.onToggle})
      : super(key: key);

  final List<String> labels;
  final void Function(int) onToggle;

  @override
  _TogglerState createState() => _TogglerState();
}

class _TogglerState extends State<Toggler> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ToggleButtons(
          isSelected: isSelected,
          onPressed: (index) {
            setState(() {
              isSelected[index] = !isSelected[index];
              isSelected[1 - index] = !isSelected[1 - index];
            });
            widget.onToggle(index);
          },
          children: widget.labels.map((label) => Text(label)).toList(),
        ),
      ],
    );
  }
}
