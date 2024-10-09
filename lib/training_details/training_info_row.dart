import 'package:flutter/material.dart';

class TrainingInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const TrainingInfoRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Color(0xff8b8b8b),
          ),
          SizedBox(width: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xff8b8b8b),
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0xff8b8b8b),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}