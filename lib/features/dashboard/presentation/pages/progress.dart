import 'package:bimskrip/features/dashboard/data/models/progres_model.dart';
import 'package:bimskrip/utils/helper.dart';
import 'package:bimskrip/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/colors.dart';
import '../../../../utils/constraint.dart';
import '../provider/progres_provider.dart';
import '../provider/user_provider.dart';
import 'add_progress.dart';
import 'detail_progress.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<ProgresProvider>(context, listen: false).progress ==
          null) {
        String userId =
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).users!.Id.toString();
        String roleId =
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).users!.roleId.toString();
        Provider.of<ProgresProvider>(
          context,
          listen: false,
        ).eitherFailureOrProgress(roleId: roleId, userId: userId);
      }
    });
  }

  ProgresModel? progresModel;
  @override
  Widget build(BuildContext context) {
    var isLoading = Provider.of<ProgresProvider>(context).isLoading;
    progresModel = Provider.of<ProgresProvider>(context).progress;
    return Scaffold(
      backgroundColor: MyColors.forthColor,
      body: RefreshIndicator(
        onRefresh: () async {
          String userId =
              Provider.of<UserProvider>(
                context,
                listen: false,
              ).users!.Id.toString();
          String roleId =
              Provider.of<UserProvider>(
                context,
                listen: false,
              ).users!.roleId.toString();
          Provider.of<ProgresProvider>(
            context,
            listen: false,
          ).eitherFailureOrProgress(roleId: roleId, userId: userId);
        },
        backgroundColor: MyColors.blackColor,
        color: MyColors.whiteColor,
        child:
            isLoading == kLoading
                ? Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                )
                : progresModel == null
                ? Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                )
                : progresModel!.data.isEmpty
                ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textRandom(
                        text: "Not found",
                        textAlign: TextAlign.center,
                        size: 16,
                        color: MyColors.blackColor,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: buttonCustom(
                          text: "Refresh",
                          onTap: () {
                            String userId =
                                Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                ).users!.Id.toString();
                            String roleId =
                                Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                ).users!.roleId.toString();
                            Provider.of<ProgresProvider>(
                              context,
                              listen: false,
                            ).eitherFailureOrProgress(
                              roleId: roleId,
                              userId: userId,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: progresModel!.data.length,
                  itemBuilder: (context, index) => _buildCard(index: index),
                ),
      ),
      floatingActionButton:
          Provider.of<UserProvider>(context, listen: false).users!.RoleId ==
                  kRoleDosen
              ? const SizedBox()
              : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddProgressPage()),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: MyColors.primaryColor,
                  ),
                  child: Icon(Icons.add, color: MyColors.whiteColor),
                ),
              ),
    );
  }

  Widget _buildCard({required int index}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => DetailProgress(
                  statusID: progresModel!.data[index].statusId.toString(),
                  id: progresModel!.data[index].id.toString(),
                  file: progresModel!.data[index].url,
                  comment: progresModel!.data[index].comment,
                  text:
                      progresModel!.data[index].progres == null
                          ? ""
                          : progresModel!.data[index].desc,
                  progress:
                      progresModel!.data[index].progres == null
                          ? ""
                          : progresModel!.data[index].progres!.Name,
                ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 20,
          left: 20,
          top: index == 0 ? 30 : 10,
          bottom: 10,
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.secondColor,
        ),
        child: Row(
          children: [
            Expanded(
              child:
                  Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).users!.roleId ==
                          kRoleMahasiswa
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textRandom(
                            text:
                                progresModel!.data[index].progres == null
                                    ? ""
                                    : progresModel!.data[index].progres!.Name,
                            size: 16,
                            color: MyColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textRandom(
                            text: Helper().formatTanggal(
                              progresModel!.data[index].createdAt,
                            ),
                            size: 10,
                            color: MyColors.whiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                          textRandom(
                            text: progresModel!.data[index].desc,
                            size: 10,
                            color: MyColors.whiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textRandom(
                            text:
                                progresModel!.data[index].progres == null
                                    ? ""
                                    : progresModel!.data[index].progres!.Name,
                            size: 16,
                            color: MyColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textRandom(
                            text:
                                progresModel!.data[index].student == null
                                    ? ""
                                    : progresModel!.data[index].student!.Name,
                            size: 12,
                            color: MyColors.whiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color:
                    progresModel!.data[index].status == null
                        ? Colors.black
                        : progresModel!.data[index].status!.id == 1
                        ? Colors.blue
                        : progresModel!.data[index].status!.id == 2
                        ? Colors.green
                        : progresModel!.data[index].status!.id == 3
                        ? Colors.red
                        : Colors.black,
              ),
              child: textRandom(
                text:
                    progresModel!.data[index].status == null
                        ? ""
                        : progresModel!.data[index].status!.Name,
                textAlign: TextAlign.center,
                size: 12,
                color: MyColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
