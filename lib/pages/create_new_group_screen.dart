import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/create_new_group_bloc.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/utils/extensions.dart';
import 'package:we_chat_app/widgets/input_text_field.dart';

import '../resources/dimensions.dart';
import '../widgets/LoadingWidget.dart';
import '../widgets/search_field_widget.dart';

class CreateNewGroup extends StatelessWidget {
  const CreateNewGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
  create: (BuildContext context) => CreateNewGroupBloc(),
  child: Selector<CreateNewGroupBloc, bool>(
  selector: (context, bloc) => bloc.isLoading,
  builder: (context, isLoading, child) {
    return Stack(
    children: [
      Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: BACKGROUND_COLOR,
          title: Title(
              color: PRIMARY_COLOR,
              child: const Text(
                "New Group",
                style: TextStyle(color: PRIMARY_COLOR),
              )),
          centerTitle: true,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.close,
                color: PRIMARY_COLOR,
              )),
          actions: [
            Consumer<CreateNewGroupBloc>(
              builder: (context, bloc, child) => InkWell(
                onTap: () => bloc.onTapGroupCreate(),
                child: Container(
                  margin: const EdgeInsets.all(MARGIN_LEVEL_1_MIDDLE),
                  width: 60,
                  height: 32,
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(MARGIN_LEVEL_1_5),
                  ),
                  child: const Center(child: Text("Create")),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Consumer<CreateNewGroupBloc>(
                  builder: (BuildContext context, bloc, Widget? child) =>
                      InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            bloc.onImageChoose(File(image.path));
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: PRIMARY_COLOR),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: bloc.chooseProfilePicture != null
                              ? CircleAvatar(
                              backgroundImage:
                              FileImage(bloc.chooseProfilePicture!))
                              : const Icon(Icons.cloud_upload_outlined),
                        ),
                      ),
                ),
              ),
              Consumer<CreateNewGroupBloc>(
                builder: (BuildContext context, bloc, Widget? child) =>
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: MARGIN_LEVEL_1_LAST),
                        child: TextField(
                          decoration: const InputDecoration(
                            focusedBorder:UnderlineInputBorder(
                              borderSide: BorderSide(color: PRIMARY_COLOR),
                            ),
                            enabledBorder:UnderlineInputBorder(
                              borderSide: BorderSide(color: PRIMARY_COLOR),
                            ),
                            labelText: "Group Name",
                            labelStyle:TextStyle(color: Colors.grey),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (val) => bloc.onGroupNameChange(val),
                        )),
              ),
              const SearchFieldWidget(),
              Consumer<CreateNewGroupBloc>(
                builder: (context, bloc, child) => bloc
                    .selectedUserList.isNotEmpty
                    ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bloc.selectedUserList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            width: 90,
                            height: 100,
                            decoration:
                            BoxDecoration(color: PURE_WHITE_COLOR),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(bloc
                                                  .selectedUserList[
                                              index]
                                                  .profilePicture ??
                                                  "https://ca-times.brightspotcdn.com/dims4/default/522c102/2147483647/strip/true/crop/4718x3604+0+0/resize/1200x917!/format/webp/quality/80/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Ffd%2F21%2F3491434e446c83711360a43f6978%2Fla-photos-1staff-471763-en-ana-de-armas-mjc-09.jpg"),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: ACTIVE_NOW_COLOR,
                                                border: Border.all(
                                                    color:
                                                    PURE_WHITE_COLOR,
                                                    width: 4.0),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Center(
                                        child: SizedBox(
                                          child: Text(bloc
                                              .selectedUserList[index]
                                              .name ??
                                              ""),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () => bloc.onUnselectUser(
                                        bloc.selectedUserList[index]),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: GREY_COLOR,
                                            borderRadius:
                                            BorderRadius.circular(
                                                15.0)),
                                        child: const Icon(
                                          Icons.close,
                                          color: PRIMARY_COLOR,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          )),
                )
                    : Container(),
              ),
              Consumer<CreateNewGroupBloc>(
                builder: (BuildContext context, bloc, Widget? child) => Row(
                  children: [
                    SizedBox(
                      width: 340,
                      height: bloc.selectedUserList.isNotEmpty ? 450 : 550,
                      child: bloc.groupedUsers != null
                          ? ListView.builder(
                        itemCount: bloc.groupedUsers?.length,
                        itemBuilder: (context, index) {
                          String? character =
                          bloc.groupedUsers?.keys.toList()[index];
                          List<UserVO>? users =
                          bloc.groupedUsers?[character]!;

                          return Container(
                            margin: const EdgeInsets.only(
                                top: MARGIN_LEVEL_1_MIDDLE),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10.0),
                                    child: Text(character ?? "")),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  itemCount: users?.length ?? 0,
                                  separatorBuilder: (context, index) =>
                                  const Divider(),
                                  itemBuilder: (context, index) {
                                    UserVO user = users![index];
                                    return FriendList(friend: user);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      )
                          : Container(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: bloc.selectedUserList.isNotEmpty ? 450 : 550,
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
        ),
      ),
      Visibility(
        visible: isLoading,
        child: Container(
          color: Colors.black12,
          child: const Center(
            child: LoadingWidget(),
          ),
        ),
      )
    ],
  );
  },
),
);
  }
}

class FriendList extends StatelessWidget {
  final UserVO friend;
  const FriendList({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateNewGroupBloc>(
      builder: (context, bloc, child) => InkWell(
        onTap: () => bloc.onSelectUser(friend),
        child: Container(
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
              const Spacer(),
              Checkbox(
                value: bloc.selectedUserList.contains(friend),
                onChanged: (bool? value) => bloc.onSelectUser(friend),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
