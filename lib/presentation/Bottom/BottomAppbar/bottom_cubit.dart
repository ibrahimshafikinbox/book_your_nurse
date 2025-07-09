import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../chat/chat_view.dart';
import '../../home/home.dart';
import '../../home/home_nurse.dart';
import '../../profile_user/profile_view.dart';

class BottomCubit extends Cubit<int> {
  BottomCubit() : super(0);
  static BottomCubit get(context) => BlocProvider.of<BottomCubit>(context);

  void changeitem(int index) {
    emit(index);
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const Chat(),
    // const Schedule(),
    const ProfileView(),
  ];

  final List<Widget> screensdoctor = [
    const HomeNurse(),
    const Chat(),
    // const Schedule(),
    const ProfileView(),
  ];

  String? currentPage;
  int? currentIndex;
  List<String> pageKeys = ['home', 'chat', 'booking', 'profile'];

  void selectTab(String tabItem, int index) {
    // currentTab = pageKeys[index];
    // selectedIndex = index;
  }
}
