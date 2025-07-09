import 'package:flutter/material.dart';

class SummuryBookContainer extends StatefulWidget {
  const SummuryBookContainer({super.key});

  @override
  State<SummuryBookContainer> createState() => _SummuryBookContainerState();
}

class _SummuryBookContainerState extends State<SummuryBookContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0XFFF7FAFE),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Displaying an image (assuming it's in the assets folder)
          Row(
            children: [
              Text(
                'Yousef Mansor',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Image.asset(
                "",
                width: 100, // Adjust the width as needed
                height: 100, // Adjust the height as needed
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ],
          ),
          Divider(),
          SizedBox(height: 10),
          buildDetailRow('Type', 'Carpinter'),
          buildDetailRow('Material', 'Not Included'),
          buildDetailRow('Traveling', 'Free'),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

/////////////////////////////
class withoudimage extends StatefulWidget {
  const withoudimage({super.key});

  @override
  State<withoudimage> createState() => _withoudimageState();
}

class _withoudimageState extends State<withoudimage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0XFFF7FAFE),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Displaying an image (assuming it's in the assets folder)

          buildDetailRow('Address',
              'Street No. 23, Gamal Abdel Nasser Street, Mansoura, Dakahlia, Egypt, '),
          buildDetailRow('Booking date', 'December 18, 2025'),
          buildDetailRow('Booking Hours', '10:00 AM'),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
