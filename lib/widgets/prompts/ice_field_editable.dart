import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class IceFieldEditable extends StatefulWidget {
  final String _text;
  final Function(String) _onEditComplete;
  const IceFieldEditable(
      {required dynamic Function(String) onEditComplete,
      String text = '',
      Key? key})
      : _onEditComplete = onEditComplete,
        _text = text,
        super(key: key);
  @override
  State<IceFieldEditable> createState() => _IceFieldEditableState();
}

class _IceFieldEditableState extends State<IceFieldEditable> {
  bool _isEditing = false;
  late TextEditingController controller;
  late String baseText;

  @override
  void initState() {
    super.initState();
    baseText = widget._text;
    controller = TextEditingController(text: baseText);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isEditing
                  ? SizedBox(
                      width: 200,
                      child: TextField(
                        style: const TextStyle(fontSize: 24),
                        onEditingComplete: widget._onEditComplete(baseText),
                        controller: controller,
                      ),
                    )
                  : Text(
                      baseText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          overflow: TextOverflow.ellipsis,
                          color:
                              widget._text.isEmpty ? discreetText : darkText),
                    ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                    baseText = controller.text;
                    if (!_isEditing) widget._onEditComplete(baseText);
                  });
                },
                icon: Icon(
                    color: secondaryColor,
                    _isEditing ? Icons.done : Icons.edit),
                padding: EdgeInsets.zero,
                iconSize: 32,
              )
            ],
          ),
        ),
      ],
    );
  }
}
