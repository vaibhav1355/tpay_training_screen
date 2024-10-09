import 'package:flutter/material.dart';
import 'package:tpay_training/training_details/training_card.dart';

class TrainingDetails extends StatefulWidget {
  const TrainingDetails({Key? key}) : super(key: key);

  @override
  State<TrainingDetails> createState() => _TrainingDetailsState();
}

class _TrainingDetailsState extends State<TrainingDetails> {

  final List<Map<String, String>> trainings = [
    {
      'image': 'assets/images/tpay_training_screen_image.jpg',
      'name': 'Training Name',
      'status': 'Completed',
      'startDate': '01-09-2024',
      'endDate': '01-09-2024',
      'trainer': 'Mukesh Kumar',
      'venue': 'Akal Information System Ltd. Green Park',
    },
    {
      'image': 'assets/images/tpay_training_screen_image.jpg',
      'name': 'Training Name',
      'status': 'Pending',
      'startDate': '15-09-2024',
      'endDate': '20-09-2024',
      'trainer': 'Anjali Singh',
      'venue': 'Green Valley Conference Center.',
    },
    {
      'image': 'assets/images/tpay_training_screen_image.jpg',
      'name': 'Training Name',
      'status': 'Completed',
      'startDate': '25-09-2024',
      'endDate': '30-09-2024',
      'trainer': 'Rahul Sharma',
      'venue': 'Tech Hub, City Center.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Image.asset(
            'assets/images/menu.png',
            height: 14,
            width: 8,
            color: Color(0xFFEAFFFF),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Image.asset(
              'assets/images/comment.png',
              height: 30,
              width: 30,
              color: Color(0xFFEAFFFF),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA1DFFE),
                Color(0xFF39BAFC),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Trainings Text
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                color: Color(0xFF39BAFC),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Trainings',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(28.0),
              child: Column(
                children: trainings.map((training) {
                  Color statusColor = training['status'] == 'Pending'
                      ? Color(0xffeaa988)
                      : Color(0xff378f61);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: TrainingCard(
                      training: training,
                      statusColor: statusColor,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
