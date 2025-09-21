import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../utils/colors.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/widgets.dart';
import '../../data/models/schedule_model.dart';
import '../provider/mahasiswa_by_dosen_provider.dart';
import '../provider/schedule_provider.dart';
import '../provider/user_provider.dart';
import 'add_schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<ScheduleProvider>(context, listen: false).schedules ==
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
        Provider.of<ScheduleProvider>(
          context,
          listen: false,
        ).eitherFailureOrSchedules(roleId: roleId, userId: userId);
        if (roleId == kRoleDosen.toString()) {
          Provider.of<MahasiswaByDosenProvider>(
            context,
            listen: false,
          ).eitherFailureOrGetMahasiswaByDosen(id: int.parse(userId));
        }
      }
    });
  }

  ScheduleModel? schedules;
  @override
  Widget build(BuildContext context) {
    schedules = Provider.of<ScheduleProvider>(context).schedules;
    var isLoading = Provider.of<ScheduleProvider>(context).isLoading;
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
          Provider.of<ScheduleProvider>(
            context,
            listen: false,
          ).eitherFailureOrSchedules(roleId: roleId, userId: userId);
        },
        backgroundColor: MyColors.blackColor,
        color: MyColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              isLoading == kLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    ),
                  )
                  : schedules == null
                  ? Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    ),
                  )
                  : schedules!.data.isEmpty
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
                              Provider.of<ScheduleProvider>(
                                context,
                                listen: false,
                              ).eitherFailureOrSchedules(
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
                    itemCount: schedules!.data.length,
                    itemBuilder: (context, index) {
                      return _buildCard(index);
                    },
                  ),
        ),
      ),
      floatingActionButton:
          Provider.of<UserProvider>(context, listen: false).users!.RoleId ==
                  kRoleMahasiswa
              ? const SizedBox()
              : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddSchedulePage()),
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

  Widget _buildCard(int index) {
    int roleID =
        Provider.of<UserProvider>(context, listen: false).users!.RoleId;
    return Container(
      margin: EdgeInsets.only(
        bottom: index == schedules!.data.length - 1 ? 40 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          index == 0 ? const SizedBox(height: 40) : const SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: MyColors.secondColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textRandom(
                  text:
                      roleID == kRoleDosen
                          ? "Kamu ada jadwal!"
                          : "Kamu punya jadwal dengan dosen!",
                  size: 15,
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
                textRandom(
                  text:
                      roleID == kRoleDosen
                          ? "jangan lupa dengan jadwal mu yaa"
                          : "Jangan sampai dospem mu menunggu yaa",
                  size: 11,
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MyColors.forthColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      textRandom(
                        text: Helper().formatTanggal(
                          schedules!.data[index].date,
                        ),
                        size: 20,
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textRandom(
                        text: schedules!.data[index].tempat,
                        size: 16,
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
