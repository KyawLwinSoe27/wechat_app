import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/home_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/utils/extensions.dart';

class AddNewMomentScreen extends StatelessWidget {
  const AddNewMomentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: BACKGROUND_COLOR,
          leading: InkWell(
            onTap: () => navigateToScreen(context,const HomeScreen()),
            child: const Icon(
              Icons.close,
              size: 30,
              color: PRIMARY_COLOR,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "New Moment",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: PRIMARY_COLOR),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(MARGIN_LEVEL_1_MIDDLE),
              width: 60,
              height: 32,
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(MARGIN_LEVEL_1_5),
              ),
              child: const Center(
                  child: Text(
                "Create",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )),
            )
          ],
        ),
        backgroundColor: BACKGROUND_COLOR,
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_LEVEL_1_LAST),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: MARGIN_LEVEL_1_MIDDLE),
                  child: Row(
                    children: const [
                      ProfilePicture(),
                      SizedBox(
                        width: MARGIN_LEVEL_1_5,
                      ),
                      Text(
                        "Ana De Armas",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: PRIMARY_COLOR),
                      ),
                    ],
                  ),
                ),
                const TextField(
                  maxLines: 30,
                  decoration: InputDecoration(
                    hintText: "What's on your mind",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(MARGIN_LEVEL_1_LAST),
                          border: Border.all(color: PRIMARY_COLOR)),
                      child: const Center(
                          child: Icon(
                        Icons.add,
                        color: PRIMARY_COLOR,
                      )),
                    ),
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) => Container(
                          margin:const EdgeInsets.only(left: MARGIN_LEVEL_1_5),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(MARGIN_LEVEL_1_LAST),
                              border: Border.all(color: PRIMARY_COLOR)),
                          child: const Center(
                              child: Icon(
                            Icons.add,
                            color: PRIMARY_COLOR,
                          )),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 40,
      height: 40,
      child: CircleAvatar(
        radius: 20, // Image radius
        backgroundImage: NetworkImage(
          'https://i.redd.it/dry65gj3b8a31.jpg',
        ),
      ),
    );
  }
}
