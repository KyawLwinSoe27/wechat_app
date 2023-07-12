import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/contacts_bloc.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/pages/qr_scan_screen.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/widgets/page_title_text.dart';

import '../resources/colors.dart';
import '../resources/dimensions.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PURE_WHITE_COLOR,
        title: const PageTitleText(text: CONTACTS),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const QRViewExample(),
              ));
            },
            child: Container(
              margin: const EdgeInsets.all(MARGIN_LEVEL_1_MIDDLE),
              width: 60,
              height: 32,
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(MARGIN_LEVEL_1_5),
              ),
              child: Center(child: Image.asset(ADD_PEOPLE)),
            ),
          )
        ],
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => ContactsBloc(),
        child: Column(
          children: [
            const SearchFieldWidget(),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: MARGIN_LEVEL_1_MIDDLE,
                  vertical: MARGIN_LEVEL_1_MIDDLE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Groups(5)",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: MARGIN_LEVEL_1_MIDDLE,
                  ),
                  Row(
                    children: const [
                      AddNewGroupWidget(),
                      SizedBox(
                        width: MARGIN_LEVEL_1_5,
                      ),
                      GroupViewWidget(),
                    ],
                  ),
                  // Consumer<ContactsBloc>(
                  //   builder: (context, bloc, child) => Container(
                  //       margin: const EdgeInsets.only(
                  //         top: MARGIN_LEVEL_1_MIDDLE,
                  //         left: MARGIN_LEVEL_1_5,
                  //       ),
                  //       height: 490,
                  //       child: ListView.builder(
                  //           itemCount: bloc.userList.length,
                  //           itemBuilder: (context, int index) =>  FriendList(friend : bloc.userList[index]))),
                  // )
                  Consumer<ContactsBloc>(
                    builder: (BuildContext context, bloc, Widget? child) =>
                        Row(
                      children: [
                        SizedBox(
                          width: 340,
                          height: 500,
                          child: bloc.groupedUsers != null
                              ? ListView.builder(
                                  itemCount: bloc.groupedUsers?.length,
                                  itemBuilder: (context, index) {
                                    String? character =
                                        bloc.groupedUsers?.keys.toList()[index];
                                    List<UserVO>? users =
                                        bloc.groupedUsers?[character]!;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text(character ?? ""),
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: users?.length ?? 0,
                                          separatorBuilder: (context, index) =>
                                              const Divider(),
                                          itemBuilder: (context, index) {
                                            UserVO user = users![index];
                                            return ListTile(
                                              title: Text(user.name!),
                                              // Add other UI elements for the user
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : Container(),
                        ),
                        Align(
                         alignment: Alignment.center,
                          child: SizedBox(
                            height: 500,
                            width: 30,
                            child: ListView.builder(
                              itemCount: bloc.indexList.length,
                              itemBuilder: (context, index) {
                                String character = bloc.indexList[index];
                                return ListTile(
                                  title: Text(character),
                                  // Add any desired styling for the index list
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FriendList extends StatelessWidget {
  final UserVO friend;
  const FriendList({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: MARGIN_LEVEL_1_5),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: friend.profilePicture != null
                ? NetworkImage(friend.profilePicture!)
                : const NetworkImage(
                    "https://ca-times.brightspotcdn.com/dims4/default/522c102/2147483647/strip/true/crop/4718x3604+0+0/resize/1200x917!/format/webp/quality/80/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Ffd%2F21%2F3491434e446c83711360a43f6978%2Fla-photos-1staff-471763-en-ana-de-armas-mjc-09.jpg"),
          ),
          const SizedBox(
            width: MARGIN_LEVEL_1_LAST,
          ),
          Text(
            friend.name ?? "",
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: PRIMARY_COLOR),
          ),
        ],
      ),
    );
  }
}

class GroupViewWidget extends StatelessWidget {
  const GroupViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 277,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: MARGIN_LEVEL_1_5),
                width: 90.0,
                height: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: PURE_WHITE_COLOR,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Offset to create a bottom shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.group,
                        size: 40,
                      ),
                      SizedBox(
                        height: MARGIN_LEVEL_1_5,
                      ),
                      Text("Smiles")
                    ],
                  ),
                ),
              )),
    );
  }
}

class AddNewGroupWidget extends StatelessWidget {
  const AddNewGroupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.0,
      height: 90.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: PRIMARY_COLOR),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(CREATE_GROUP_ICON),
            const SizedBox(
              height: MARGIN_LEVEL_1_MIDDLE,
            ),
            const Text(
              "Add New",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: PURE_WHITE_COLOR),
            )
          ],
        ),
      ),
    );
  }
}

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: MARGIN_LEVEL_1_MIDDLE, vertical: MARGIN_LEVEL_1_MIDDLE),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: SEARCH_FIELD_BG_COLOR,
      ),
      child: Row(
        children: const [
          SizedBox(
            width: MARGIN_LEVEL_1_MIDDLE,
          ),
          Icon(Icons.search),
          SizedBox(
            width: MARGIN_LEVEL_1_LAST,
          ),
          SizedBox(
            width: 280,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Username',
              ),
            ),
          ),
          Icon(Icons.close)
        ],
      ),
    );
  }
}
