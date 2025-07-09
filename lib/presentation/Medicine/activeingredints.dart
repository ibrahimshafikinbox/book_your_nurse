import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/app/style/custom_text.dart';
import 'package:medical_app/const/colors.dart';
import 'package:medical_app/presentation/Medicine/model/activeingerdints.dart';
import 'MedicineCubit/medicine_cubit.dart';

class ActiveIngredientsScreen extends StatelessWidget {
  final String activeIngredients;
  final String title;
  final String sub;

  const ActiveIngredientsScreen({
    super.key,
    required this.activeIngredients,
    required this.title,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MedicineCubit>(context);
    cubit.fetchActiveIngredintDetail(activeIngredients);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          text: activeIngredients,
        ),
        backgroundColor: AppColor.kWhite,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<MedicineCubit, MedicineState>(
        builder: (context, state) {
          if (state is ActiveIngredintsloading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ActiveIngredintsSucceful) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: cubit.activeIngredintDetail.length,
              itemBuilder: (context, index) {
                ActiveIngredients ingredient = cubit.activeIngredintDetail[index];

                return ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: CustomText(
                    text: title,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  subtitle: CustomText(
                    text: sub,
                    fontSize: 14,
                    maxLines: 5000,
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load data'));
          }
        },
      ),
    );
  }
}
