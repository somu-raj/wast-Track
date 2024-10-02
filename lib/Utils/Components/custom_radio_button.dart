import 'package:flutter/material.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

class CustomRadioButton extends StatefulWidget {
  String? label;
  final bool isSelected;
  final Function(bool) onChanged;

  CustomRadioButton({
    this.label,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.isSelected);
      },
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:
                  widget.isSelected ? Colors.transparent : Colors.transparent,
              border: Border.all(
                color: AppColor.green,
              ),
            ),
            child: widget.isSelected
                ? Icon(
                    Icons.circle_rounded,
                    color: AppColor.green,
                    size: 13,
                  )
                : null,
          ),
          SizedBox(width: 8),
          Text(
            widget.label ?? "",
            style: TextStyle(fontFamily: AppFont.poppinsRegular, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
