import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/presentation/Booking/booking_view_1.dart';
import 'package:medical_app/presentation/resources/colors/colors.dart';
import '../../../const/colors.dart';
import '../../app/style/custom_button.dart';
import 'model/service.dart';
import 'model/nurse_model.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key, required this.nurse});
  final Nurse nurse;
  static String id = 'DoctorDetails';

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  NurseService? _selectedService;

  void _bookAppointment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingAddressForm_1(
          userId: widget.nurse.uid,
        ),
      ),
    );
  }

  void _showReviewDialog() {
    showDialog(
      context: context,
      builder: (_) => ReviewDialog(nurseId: widget.nurse.uid),
    );
  }

  Future<List<Review>> fetchNurseReviewsByUid(String uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('nurse')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return [];

      final data = snapshot.docs.first.data();
      final List<dynamic> reviewList = data['reviews'] ?? [];

      return reviewList.map((r) => Review.fromJson(r)).toList();
    } catch (e) {
      print("❌ Error fetching reviews: $e");
      return [];
    }
  }

  Future<List<NurseService>> fetchNurseServicesByUid(String uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('nurse')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return [];

      final data = snapshot.docs.first.data();
      final List<dynamic> serviceList = data['services'] ?? [];

      return serviceList.map((s) => NurseService.fromJson(s)).toList();
    } catch (e) {
      print("❌ Error fetching services: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nurse Profile"),
        centerTitle: false,
        backgroundColor: AppColor.kPrimaryColor1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.nurse.photo),
              ),
              const SizedBox(height: 8),
              Text(
                "Dr. ${widget.nurse.nameEn}",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text("surgeon doctor",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),

              // Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("4.7",
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  Text(" (12 reviews)", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),

              // Location & Experience
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  Text(widget.nurse.cityEn,
                      style: const TextStyle(color: Colors.black)),
                  const SizedBox(width: 20),
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const Text(" 5 years experience",
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 16),

              // Book Appointment Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.kPrimaryColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _bookAppointment,
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                label: const Text("Book Appointment",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 24),
              Text("Services",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),

              FutureBuilder<List<NurseService>>(
                future: fetchNurseServicesByUid(widget.nurse.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return const Text("No services available.");
                  } else {
                    return Column(
                      children: snapshot.data!.map((service) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(service.serviceName),
                            subtitle: Text("Duration: ${service.duration}"),
                            trailing: Text("EGP ${service.price}"),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reviews",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  TextButton.icon(
                    onPressed: _showReviewDialog,
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text("Write Review"),
                  ),
                ],
              ),
              FutureBuilder<List<Review>>(
                future: fetchNurseReviewsByUid(widget.nurse.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Failed to load reviews."),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("No reviews available."),
                    );
                  } else {
                    return ReviewList(reviews: snapshot.data!);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NurseService {
  final String serviceName;
  final int price;
  final String duration;

  NurseService({
    required this.serviceName,
    required this.price,
    required this.duration,
  });

  factory NurseService.fromJson(Map<String, dynamic> json) {
    return NurseService(
      serviceName: json['service_name'] ?? '',
      price: json['price'] ?? 0,
      duration: json['duration'] ?? '',
    );
  }
}

class ReviewDialog extends StatefulWidget {
  final String nurseId;

  const ReviewDialog({super.key, required this.nurseId});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  int _currentRating = 0; // To store the selected star rating
  final TextEditingController _commentController =
      TextEditingController(); // Controller for the comment text field

  @override
  void dispose() {
    _commentController
        .dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // Rounded corners for the dialog
      ),
      title: const Center(
        child: Text(
          'Rate Your Nurse', // You might want to localize this
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.blueAccent,
          ),
        ),
      ),
      content: SingleChildScrollView(
        // Use SingleChildScrollView to prevent overflow if content is too long
        child: Column(
          mainAxisSize: MainAxisSize.min, // Make column take minimum space
          children: <Widget>[
            const Text(
              'How would you rate nurse expeience ?', // You might want to localize this
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            // Star rating row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _currentRating
                        ? Icons.star
                        : Icons
                            .star_border, // Fill star if index is less than current rating
                    color: Colors.amber, // Star color
                    size: 35,
                  ),
                  onPressed: () {
                    setState(() {
                      _currentRating =
                          index + 1; // Update rating when a star is pressed
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            // Comment text field
            TextField(
              controller: _commentController,
              maxLines: 4, // Allow multiple lines for comments
              decoration: InputDecoration(
                hintText:
                    'Share your detailed feedback...', // You might want to localize this
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.blueAccent, width: 2),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 25),
            // Submit and Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(color: Colors.blueAccent),
                    ),
                    child: const Text(
                      'Cancel', // You might want to localize this
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_currentRating == 0 ||
                          _commentController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please rate and write a comment')),
                        );
                        return;
                      }

                      final currentUser = FirebaseAuth.instance.currentUser;
                      final reviewData = {
                        'user_id': currentUser?.uid ?? 'anonymous',
                        'user_name': currentUser?.displayName ?? 'Anonymous',
                        'rating': _currentRating,
                        'review_text': _commentController.text.trim(),
                        'review_date':
                            DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      };

                      try {
                        final querySnapshot = await FirebaseFirestore.instance
                            .collection('nurse')
                            .where('uid',
                                isEqualTo:
                                    widget.nurseId) // ← nurseId هنا هو uid
                            .limit(1)
                            .get();

                        if (querySnapshot.docs.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Nurse not found by UID')),
                          );
                          print(
                              '❌ Nurse not found with UID: ${widget.nurseId}');
                          return;
                        }

                        final docId = querySnapshot.docs.first.id;

                        await FirebaseFirestore.instance
                            .collection('nurse')
                            .doc(docId)
                            .update({
                          'reviews': FieldValue.arrayUnion([reviewData])
                        });

                        print(
                            '✅ Review added to nurse document with doc ID: $docId');

                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Review submitted successfully')),
                        );
                      } catch (e) {
                        print('❌ Error submitting review by UID: $e');
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Submit Review', // You might want to localize this
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<Review> reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text("No reviews available",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            )),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ReviewCard(review: reviews[index]);
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/img/Group 1000003542.png'),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(review.userName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(review.reviewDate,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 18,
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(review.reviewText,
                style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String userName;
  final String reviewText;
  final int rating;
  final String reviewDate;

  Review({
    required this.userName,
    required this.reviewText,
    required this.rating,
    required this.reviewDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userName: json['user_name'] ?? '',
      reviewText: json['review_text'] ?? '',
      rating: json['rating'] ?? 0,
      reviewDate: json['review_date'] ?? '',
    );
  }
}
