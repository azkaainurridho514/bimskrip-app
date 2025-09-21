import 'package:bimskrip/utils/helper.dart';
import 'package:bimskrip/utils/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constraint.dart';
import '../../data/models/dashboard_model.dart';
import '../../data/models/schedule_model.dart';
import '../provider/dashboard_provider.dart';
import '../provider/schedule_provider.dart';
import '../provider/selected_page_provider.dart';
import '../provider/user_provider.dart';
import 'add_schedule.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
      ).eitherFailureOrTodaySchedules(roleId: roleId, userId: userId);
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).eitherFailureOrDashboard();
    });
  }

  ScheduleModel? todaySchedules;
  DashboardModel? dashboard;
  var isLoading;
  @override
  Widget build(BuildContext context) {
    todaySchedules = Provider.of<ScheduleProvider>(context).todaySchedules;
    dashboard = Provider.of<DashboardProvider>(context).dashboard;
    isLoading = Provider.of<DashboardProvider>(context).isLoading;
    return Scaffold(
      backgroundColor: MyColors.forthColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RefreshIndicator(
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
            Provider.of<ScheduleProvider>(
              context,
              listen: false,
            ).eitherFailureOrTodaySchedules(roleId: roleId, userId: userId);
            Provider.of<DashboardProvider>(
              context,
              listen: false,
            ).eitherFailureOrDashboard();
          },
          backgroundColor: MyColors.blackColor,
          color: MyColors.whiteColor,
          child:
              Provider.of<UserProvider>(context, listen: false).users!.RoleId !=
                          kRoleDosen &&
                      Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).users!.RoleId !=
                          kRoleMahasiswa
                  ? isLoading == kLoading
                      ? Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      )
                      : dashboard == null
                      ? Center(
                        child: textRandom(
                          text: "Data Not Found",
                          size: 15,
                          color: MyColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : dashboard!.data == null
                      ? Center(
                        child: textRandom(
                          text: "Data Not Found",
                          size: 15,
                          color: MyColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : Container(
                        margin: EdgeInsets.only(top: 50),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColors.primaryColor,
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textRandom(
                                          text:
                                              dashboard!
                                                  .data!
                                                  .users!
                                                  .totalMahasiswa
                                                  .toString(),
                                          size: 15,
                                          color: MyColors.whiteColor,
                                        ),
                                        const SizedBox(height: 10),
                                        textRandom(
                                          textAlign: TextAlign.center,
                                          text: "Jumlah Mahasiswa",
                                          size: 13,
                                          color: MyColors.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColors.primaryColor,
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textRandom(
                                          text:
                                              dashboard!.data!.users!.totalDosen
                                                  .toString(),
                                          size: 15,
                                          color: MyColors.whiteColor,
                                        ),
                                        const SizedBox(height: 10),
                                        textRandom(
                                          textAlign: TextAlign.center,
                                          text: "Jumlah Dosen",
                                          size: 13,
                                          color: MyColors.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.primaryColor,
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textRandom(
                                    text:
                                        dashboard!.data!.progres!.total
                                            .toString(),
                                    size: 15,
                                    color: MyColors.whiteColor,
                                  ),
                                  const SizedBox(height: 10),
                                  textRandom(
                                    textAlign: TextAlign.center,
                                    text: "Total Progress",
                                    size: 13,
                                    color: MyColors.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green,
                                    ),
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textRandom(
                                          text:
                                              dashboard!.data!.progres!.terima
                                                  .toString(),
                                          size: 15,
                                          color: MyColors.whiteColor,
                                        ),
                                        const SizedBox(height: 10),
                                        textRandom(
                                          textAlign: TextAlign.center,
                                          text: "Total Di Terima",
                                          size: 10,
                                          color: MyColors.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textRandom(
                                          text:
                                              dashboard!.data!.progres!.tolak
                                                  .toString(),
                                          size: 15,
                                          color: MyColors.whiteColor,
                                        ),
                                        const SizedBox(height: 10),
                                        textRandom(
                                          textAlign: TextAlign.center,
                                          text: "Total Di Tolak",
                                          size: 10,
                                          color: MyColors.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.amber,
                                    ),
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textRandom(
                                          text:
                                              dashboard!.data!.progres!.pending
                                                  .toString(),
                                          size: 15,
                                          color: MyColors.whiteColor,
                                        ),
                                        const SizedBox(height: 10),
                                        textRandom(
                                          textAlign: TextAlign.center,
                                          text: "Total Di Pending",
                                          size: 10,
                                          color: MyColors.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  : ListView(
                    children: [
                      _buildCardHeader(context),
                      Provider.of<UserProvider>(
                                context,
                                listen: false,
                              ).users!.RoleId ==
                              kRoleDosen
                          ? const SizedBox()
                          : _buildCardInfoDospem(context),
                      todaySchedules == null
                          ? const SizedBox()
                          : todaySchedules!.data.isEmpty
                          ? _buildNotSchedule(context)
                          : _buildInfoSchedule(context),
                    ],
                  ),
        ),
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textRandom(
                  text:
                      "Hello, ${Provider.of<UserProvider>(context, listen: false).users!.Name}",
                  size: 17,
                  color: MyColors.blackColor,
                  fontWeight: FontWeight.bold,
                ),
                textRandom(
                  text: "How do you feel today?",
                  size: 12,
                  color: MyColors.blackColor,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),

          SizedBox(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).users!.Photo,
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                        CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: MyColors.primaryColor,
                        ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardInfoDospem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textRandom(
              text: "Your Consultation",
              size: 15,
              color: MyColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.keyboard_arrow_right_rounded, size: 25),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.secondColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      // color: MyColors.primaryColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            Provider.of<UserProvider>(
                              context,
                              listen: false,
                            ).users!.dosenPA!.Photo,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  color: MyColors.primaryColor,
                                ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textRandom(
                          text:
                              Provider.of<UserProvider>(
                                context,
                                listen: false,
                              ).users!.DosenPA!.Name.toString(),
                          size: 15,
                          color: MyColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textRandom(
                          text: "Dosen Pembimbing",
                          size: 12,
                          color: MyColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        textRandom(
                          text: "Belum ada jadwal pertemuan",
                          size: 9,
                          textAlign: TextAlign.right,
                          color: MyColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotSchedule(BuildContext context) {
    int role = Provider.of<UserProvider>(context, listen: false).users!.roleId;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        textRandom(
          text: "Schedule",
          size: 15,
          color: MyColors.blackColor,
          fontWeight: FontWeight.bold,
        ),
        GestureDetector(
          onTap: () {
            if (role == kRoleDosen) {
              Future.delayed(const Duration(milliseconds: 500), () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Provider.of<SelectedPageProvider>(
                    context,
                    listen: false,
                  ).changePage(2);
                });
              });
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddSchedulePage()),
              );
            }
          },
          child: Container(
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
                      role == kRoleDosen
                          ? "Kamu belum punya jadwal hari ini!"
                          : "Belum ada jadwal hari ini yaa!",
                  size: 15,
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
                textRandom(
                  text:
                      role == kRoleDosen
                          ? "Klik di sini untuk menambahkan jadwal"
                          : "Hubungi dospem mu jika ingin buat pertemuan",
                  size: 11,
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSchedule(BuildContext context) {
    int role = Provider.of<UserProvider>(context, listen: false).users!.roleId;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        textRandom(
          text: "Schedule",
          size: 15,
          color: MyColors.blackColor,
          fontWeight: FontWeight.bold,
        ),
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
                    role == kRoleDosen
                        ? "Kamu belum punya jadwal dengan mahasiswa hari ini!"
                        : "Kamu punya jadwal dengan dosen!",
                size: 15,
                color: MyColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
              textRandom(
                text:
                    role == kRoleDosen
                        ? "Jangan lupa dengan jadwal mu yaa!"
                        : "Jangan sampai dospem mu menunggu yaa!",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    todaySchedules!.data.length,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textRandom(
                          text: Helper().formatTanggal(
                            todaySchedules!.data[index].date,
                          ),
                          size: 20,
                          color: MyColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textRandom(
                          text: todaySchedules!.data[index].tempat,
                          size: 16,
                          color: MyColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
