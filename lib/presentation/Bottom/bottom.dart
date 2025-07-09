import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../cubits/global_cubit/global_cubit.dart';
import 'BottomAppbar/bottom_cubit.dart';

class Bottombar extends StatelessWidget {
   Bottombar({super.key});
  static String id = 'Bottombar';

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    BottomCubit cubit = BottomCubit.get(context);
    return BlocProvider(
      lazy: false,
      create: (context) => GlobalCubit()..getUserData(),
      child: BlocBuilder<BottomCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                cubit.changeitem(index); // Update the cubit state
              },
              children: cubit.screens,
            ),
            bottomNavigationBar: Container(
              color: const Color(0xff000000).withOpacity(0.01),
              width: double.infinity,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavItem(context, selectedIndex, 0, "Image/Icons/Home.svg", _pageController),
                  buildNavItem(context, selectedIndex, 1, "Image/Icons/Message.svg", _pageController),
                  buildNavItem(context, selectedIndex, 2, "Image/Icons/Profile.svg", _pageController),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildNavItem(BuildContext context, int selectedIndex, int index, String iconPath, PageController pageController) {
  // Determine the color based on whether the icon is selected or not
  Color color = (selectedIndex == index) ? const Color(0xFF199A8E) : const Color(0xFFADADAD);

  return GestureDetector(
    onTap: () {
      // Update the PageController's page
      BottomCubit cubit = BlocProvider.of<BottomCubit>(context);
      cubit.changeitem(index);
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 30),
        curve: Curves.easeInOut,
      );
    },
    child: SvgPicture.asset(
      iconPath,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    ),
  );
}
