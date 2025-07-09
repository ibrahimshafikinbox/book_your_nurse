import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/const/chat_const.dart';
import 'package:medical_app/const/colors.dart';
import 'package:medical_app/cubits/connection/connection_cubit.dart';
import 'package:medical_app/cubits/global_cubit/global_cubit.dart';
import 'package:medical_app/presentation/chat/model/chat_model.dart';
import 'package:medical_app/services/fire_chat.dart';
import 'package:medical_app/const/shared_preferences.dart';

import '../../app/style/custom_icon_button.dart';
import '../../app/style/custom_list_view_chat.dart';
import '../../app/style/custom_search.dart';
import '../../app/style/custom_text.dart';
import '../../cubits/connection/connection_event.dart';
import '../../cubits/connection/connection_state.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  static String id = 'Chat';

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isVisible = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userModel =
        BlocProvider.of<GlobalCubit>(context, listen: true).userModel;
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.04,
        left: width * 0.05,
        right: width * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: 'المحادثات',
                colorText: AppColor.kText1,
                fontSize: width * 0.06,
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              CustomIconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                    if (!isVisible) {
                      searchController.clear();
                    }
                  });
                },
                icon: isVisible
                    ? const Icon(
                        Icons.close_rounded,
                        size: 30,
                      )
                    : const Icon(
                        Icons.search_rounded,
                        size: 30,
                      ),
              ),
            ],
          ),
          if (isVisible)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearch(
                      controller: searchController,
                    ),
                  ),
                  CustomIconButton(
                    onPressed: () {
                      if (searchController.text.isNotEmpty) {
                        _searchAndStartChat(searchController.text);
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                      color: AppColor.kPrimaryColor1,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: BlocBuilder<InternetBloc, InternetState>(
              builder: (context, connectState) {
                if (connectState is InternetConnectedState) {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(kRoomsCollections)
                        .where(kMembers, arrayContains: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(color: AppColor.kPrimaryColor1));
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('حدث خطأ أثناء تحميل المحادثات'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('لا توجد محادثات بعد. ابدأ محادثة جديدة!'));
                      }
                      List<ChatModel> items = snapshot.data!.docs
                          .map((e) => ChatModel.fromJson(e.data()))
                          .toList()
                        ..sort((a, b) => b.lastMessageTime!.compareTo(a.lastMessageTime!));
                      // فلترة البحث
                      if (isVisible && searchController.text.isNotEmpty) {
                        items = items.where((chat) {
                          return chat.id?.toLowerCase().contains(searchController.text.toLowerCase()) ?? false;
                        }).toList();
                        if (items.isEmpty) {
                          return const Center(child: Text('لا توجد نتائج مطابقة للبحث.'));
                        }
                      }
                      return ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return CustomListViewChat(
                            chatModel: items[index],
                          );
                        },
                      );
                    },
                  );
                } else if (connectState is InternetDisconnectedState) {
                  return const Center(
                    child: CustomText(
                      text: "لا يوجد اتصال بالإنترنت",
                      colorText: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  );
                } else {
                  return const Center(
                    child: CustomText(
                      text: "جاري التحقق من الاتصال...",
                      colorText: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _searchAndStartChat(String email) async {
    String? userType = sharedPreferences?.getString('userType');
    String collection = userType == 'nurse' ? 'users' : 'nurse';
    final query = await FirebaseFirestore.instance
        .collection(collection)
        .where('email', isEqualTo: email.trim())
        .get();
    if (query.docs.isNotEmpty) {
      await FireChat().createChat(email.trim(), collection: collection);
      setState(() {
        searchController.text = '';
        isVisible = false;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد مستخدم بهذا الإيميل')),
        );
      }
    }
  }
}
