import 'dart:io';
import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

/* listview item design */
class CustomListTile extends StatelessWidget {
  final double height;
  final Widget leading;
  final Widget title;
  final Widget trailing;

  const CustomListTile({
    required this.height,
    required this.leading,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading,
          Expanded(child: title),
          trailing,
        ],
      ),
    );
  }
}


class TrainingSummary extends StatefulWidget {
  final Map<String, String> training;

  const TrainingSummary({Key? key, required this.training}) : super(key: key);

  @override
  State<TrainingSummary> createState() => _TrainingSummaryState();
}

class _TrainingSummaryState extends State<TrainingSummary> {
  Uint8List? _pickedFileBytes;
  File? _pickedFile;
  bool _isfilePicked = false;

  Color buttonColor = Color(0xffa4a4a4); // upload aur provide button color
  Color presetButtonColor  = Color(0xffd6d6d6); //present wale button ke liye color


  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg'],
        withData: true,
        withReadStream: !kIsWeb,
      );

      if (result != null && result.files.isNotEmpty) {
        final fileBytes = result.files.first.bytes;
        final fileName = result.files.first.name;

        print("File picked: $fileName");

        setState(() {
          buttonColor = Color(0xff34b7ff);
          presetButtonColor = Color(0xff34b7ff);
          if (kIsWeb) {
            _pickedFileBytes = fileBytes;
            print('file picked in web successfully');
          } else {
            _pickedFile = File(result.files.single.path!);
          }
          _isfilePicked = true;
        });
      } else {
        print('User canceled the picker or no file selected');
      }
    } catch (e) {
      print("File picker error: $e");
      // Optionally show an alert or Snackbar to the user
    }
  }

  Future<void> _downloadFile() async {
    if (kIsWeb) {
      if (_pickedFileBytes != null) {
        String fileName = _pickedFile != null
            ? _pickedFile!.path.split('/').last
            : "downloaded_file";

        // Extract the file extension
        String fileExtension = _pickedFile != null
            ? _pickedFile!.path.split('.').last // Extract the extension
            : 'unknown'; // Set a default

        // Determine the file type based on the extracted extension
        String fileType;
        switch (fileExtension.toLowerCase()) {
          case 'jpg':
          case 'jpeg':
            fileType = 'image/jpeg';
            break;
          case 'png':
            fileType = 'image/png';
            break;
          case 'pdf':
            fileType = 'application/pdf';
            break;
          default:
            fileType = 'application/octet-stream'; // Generic file type
        }

        // Create a Blob and trigger a download in the browser
        final blob = html.Blob([_pickedFileBytes!], fileType);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", fileName) // Use the complete filename
          ..click();

        html.Url.revokeObjectUrl(url); // Cleanup the URL
      } else {
        print('No file picked to download on the web.');
      }
    } else {
      // Android-specific file open logic
      if (_pickedFile != null) {
        final result = await OpenFile.open(_pickedFile!.path);
        if (result.message != 'Success') {
          print('Could not open file: ${result.message}');
        }
      } else {
        print('No file picked to open on Android.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
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
                      'Training Name',
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
                  children: [
                    Container(
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
                              'assets/images/tpay_training_screen_image.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.training['name'] ?? 'N/A',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff010101),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _getStatusColor(widget.training['status']),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget.training['status'] ?? 'N/A',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: _getStatusColor(widget.training['status']),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit amet consectetur.',
                                  style: TextStyle(color: Color(0xff8b8b8b)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildDateInfo(Icons.calendar_month, 'Start Date:', widget.training['startDate'] ?? 'N/A'),
                                    _buildDateInfo(Icons.calendar_month, 'End Date:', widget.training['endDate'] ?? 'N/A'),
                                  ],
                                ),
                                SizedBox(height: 10),
                                _buildInfoRow(Icons.edit_calendar_outlined, 'Trainer:', widget.training['trainer'] ?? 'N/A'),
                                _buildInfoRow(Icons.padding, 'Venue:', widget.training['venue'] ?? 'N/A'),

                                if (_isfilePicked)
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Icon(Icons.file_copy_outlined, color: Color(0xff8b8b8b)),
                                        SizedBox(width: 5),
                                        InkWell(
                                          onTap: _downloadFile,
                                          child: Text(
                                            'Download Certificate',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff34b7ff),
                                              decoration: TextDecoration.underline,
                                              decorationColor: Color(0xff34b7ff),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Mark Attendance',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xffcccccc), width: 1),
                            left: BorderSide(color: Color(0xffcccccc), width: 1),
                            right: BorderSide(color: Color(0xffcccccc), width: 1),
                            bottom: BorderSide(color: Color(0xff34b7ff), width: 6),
                          ),
                          color: Colors.white,
                        ),
                        child: CustomListTile(
                          height: 100,
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '25',
                                  style: TextStyle(
                                    color: Color(0xff8a8a8a),
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  "Sep'24",
                                  style: TextStyle(
                                    color: Color(0xff34b7ff),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Time: 12:00 pm',
                                  style: TextStyle(
                                    color: Color(0xff626262),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'End Time: 12:00 pm',
                                  style: TextStyle(
                                    color: Color(0xff626262),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: presetButtonColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Present',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionButton('Upload Certificate'),
                        _buildActionButton('Provide Certificate'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateInfo(IconData icon, String label, String date) {
    return Row(
      children: [
        Icon(icon, color: Color(0xff8b8b8b)),
        SizedBox(width: 5),
        Text(
          '$label $date',
          style: TextStyle(color: Color(0xff8b8b8b)),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String info) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xff8b8b8b)),
          SizedBox(width: 5),
          Text(
            '$label $info',
            style: TextStyle(color: Color(0xff8b8b8b)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label) {
    return ElevatedButton(
      onPressed: () {
        _pickFile();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 14, horizontal: 30)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Not Started':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
