import 'package:bimskrip/features/boarding/login.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/progres_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/schedule_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/selected_page_provider.dart';
import 'package:bimskrip/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/colors.dart';
import '../provider/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.forthColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            textRandom(
              text: "Nama",
              size: 15,
              color: MyColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
            textRandom(
              text:
                  Provider.of<UserProvider>(context, listen: false).users!.Name,
              size: 15,
              color: MyColors.blackColor,
            ),
            const SizedBox(height: 10),
            textRandom(
              text: "Email",
              size: 15,
              color: MyColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
            textRandom(
              text:
                  Provider.of<UserProvider>(
                    context,
                    listen: false,
                  ).users!.Email,
              size: 15,
              color: MyColors.blackColor,
            ),
            const SizedBox(height: 10),
            textRandom(
              text: "Phone",
              size: 15,
              color: MyColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
            textRandom(
              text:
                  Provider.of<UserProvider>(
                    context,
                    listen: false,
                  ).users!.Phone,
              size: 15,
              color: MyColors.blackColor,
            ),
            const SizedBox(height: 10),
            buttonCustom(
              text: "LogOut",
              onTap: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .selectedPage = 0;
                Provider.of<ScheduleProvider>(context, listen: false)
                    .schedules = null;
                Provider.of<ProgresProvider>(context, listen: false).progress =
                    null;
                Provider.of<ProgresProvider>(context, listen: false)
                    .createProgress = null;
                Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).eitherFailureOrLogOut(context);
                Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).eitherFailureOrLogOut(context);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
