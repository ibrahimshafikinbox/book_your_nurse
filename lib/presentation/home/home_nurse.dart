import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_cubit/home_cubit.dart';
import 'model/nurse_model.dart';
import 'model/service.dart';

class HomeNurse extends StatelessWidget {
  const HomeNurse({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().fetchIamDoctorData();

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is TopdoctorHomeloading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TopdoctorHomeError) {
            return Center(child: Text(state.error));
          } else if (state is TopdoctorHomeSuccefully) {
            final cubit = context.read<HomeCubit>();
            final nurseList = cubit.data2;

            if (nurseList.isEmpty) {
              return const Center(child: Text("No nurse data available."));
            }

            final nurse = nurseList[0];

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        child: Image.asset(
                          "Image/Nurse.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 30),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nurse.nameAr ?? "Nurse Name",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  nurse.phone ?? "",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatColumn("4.8", "Rating", Icons.star),
                            _buildStatColumn(
                                "4 Years", "Experience", Icons.work),
                            _buildStatColumn(nurse.cityEn ?? "City", "Location",
                                Icons.place),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Available Time",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildTimeButton("7:00 AM"),
                            const SizedBox(width: 8),
                            _buildTimeButton("10:00 PM"),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showAddServiceDialog(context, nurse);
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Add Service"),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Bio",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Compassionate and dedicated registered nurse with hands-on experience in patient care, medication administration, and emergency response. Committed to promoting patient well-being through attentive and empathetic support.",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 24),

                        // Services List
                        const Text(
                          "Services",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),

                        ...List.generate(nurse.services?.length ?? 0, (index) {
                          final service = nurse.services![index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              title: Text(service.nameEn),
                              subtitle: Text("Price: ${service.price} EGP"),
                              leading: const Icon(Icons.medical_services),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  nurse.services!.removeAt(index);
                                  await cubit.updateNurseServices(nurse);
                                  cubit.fetchIamDoctorData();
                                },
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 32),
                        const SizedBox(height: 24),
                        const Text(
                          "Bookings",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),

                        FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('nurse')
                              .doc(nurse
                                  .id) // nurse.id must be their Firestore UID
                              .collection('bookings')
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Text("No bookings found.");
                            }

                            final bookings = snapshot.data!.docs;

                            return Column(
                              children: bookings.map((doc) {
                                final data = doc.data();
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: ListTile(
                                    leading: const Icon(Icons.calendar_today),
                                    title: Text("Date: ${data['date'] ?? ''}"),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Time: ${data['time'] ?? ''}"),
                                        Text(
                                            "Address: ${data['fullAddress'] ?? ''}"),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Loading data..."));
          }
        },
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[700], size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildTimeButton(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Text(
        time,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showAddServiceDialog(BuildContext context, Nurse nurse) {
    final nameArController = TextEditingController();
    final nameEnController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add New Service"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameArController,
                  decoration: const InputDecoration(labelText: "Arabic Name"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameEnController,
                  decoration: const InputDecoration(labelText: "English Name"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Price"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = NurseService(
                  nameAr: nameArController.text.trim(),
                  nameEn: nameEnController.text.trim(),
                  price: int.tryParse(priceController.text.trim()) ?? 0,
                );

                nurse.services ??= [];
                nurse.services!.add(service);

                final cubit = context.read<HomeCubit>();
                await cubit.updateNurseServices(nurse);
                cubit.fetchIamDoctorData();

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
