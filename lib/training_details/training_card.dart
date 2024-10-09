import 'package:flutter/material.dart';
import 'package:tpay_training/training_details/training_info_row.dart';

import '../training_summary/training_summary.dart';

class TrainingCard extends StatelessWidget {

  final Map<String, String> training;
  final Color statusColor;

  const TrainingCard({
    Key? key,
    required this.training,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TrainingSummary(training: training)),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffd8d8d8),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                training['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      training['name']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff010101),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: statusColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          training['status']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TrainingInfoRow(
              icon: Icons.calendar_month,
              label: 'Start Date',
              value: training['startDate']!,
            ),
            TrainingInfoRow(
              icon: Icons.calendar_month,
              label: 'End Date',
              value: training['endDate']!,
            ),
            TrainingInfoRow(
              icon: Icons.edit_calendar_outlined,
              label: 'Trainer',
              value: training['trainer']!,
            ),
            TrainingInfoRow(
              icon: Icons.location_on_outlined,
              label: 'Venue',
              value: training['venue']!,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
