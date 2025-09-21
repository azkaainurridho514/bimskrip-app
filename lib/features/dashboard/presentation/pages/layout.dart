import 'package:bimskrip/features/dashboard/presentation/provider/selected_page_provider.dart';
import 'package:bimskrip/utils/constraint.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../../../../../utils/colors.dart';
import '../provider/user_provider.dart';
import 'home.dart';
import 'profile.dart';
import 'progress.dart';
import 'schedule.dart';

final List _screens = [
  {"screen": const HomePage(), "title": "Home"},
  {"screen": const ProgressPage(), "title": "Progress"},
  {"screen": const SchedulePage(), "title": "Status"},
  {"screen": const ProfilePage(), "title": "Akun"},
];
final List _screensStaff = [
  {"screen": const HomePage(), "title": "Home"},
  {"screen": const ProfilePage(), "title": "Akun"},
];

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    int role = Provider.of<UserProvider>(context, listen: false).users!.roleId;

    return Scaffold(
      backgroundColor: MyColors.forthColor,
      body:
          role == kRoleStaff
              ? IndexedStack(
                index: selectedPage,
                children: List.generate(
                  _screensStaff.length,
                  (int i) => _screensStaff[i]['screen'],
                ),
              )
              : IndexedStack(
                index: selectedPage,
                children: List.generate(
                  _screens.length,
                  (int i) => _screens[i]['screen'],
                ),
              ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          backgroundColor: MyColors.primaryColor,
          selectedItemColor: MyColors.secondColor,
          currentIndex: selectedPage,
          onTap: (int index) {
            Provider.of<SelectedPageProvider>(
              context,
              listen: false,
            ).changePage(index);
          },
          items: role == kRoleStaff ? navStaff() : nav(),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> navStaff() {
    return [
      BottomNavigationBarItem(
        activeIcon: Icon(LucideIcons.home, color: MyColors.secondColor),
        icon: Icon(LucideIcons.home, color: MyColors.blackColor),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(LucideIcons.user, color: MyColors.secondColor),
        icon: Icon(LucideIcons.user, color: MyColors.blackColor),
        label: 'Akun',
      ),
    ];
  }

  List<BottomNavigationBarItem> nav() {
    return [
      BottomNavigationBarItem(
        activeIcon: Icon(LucideIcons.home, color: MyColors.secondColor),
        icon: Icon(LucideIcons.home, color: MyColors.blackColor),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(LucideIcons.barChart2, color: MyColors.secondColor),
        icon: Icon(LucideIcons.barChart2, color: MyColors.blackColor),
        label: 'Progres',
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(LucideIcons.checkCircle2, color: MyColors.secondColor),
        icon: Icon(LucideIcons.checkCircle2, color: MyColors.blackColor),
        label: 'Jadwal',
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(LucideIcons.user, color: MyColors.secondColor),
        icon: Icon(LucideIcons.user, color: MyColors.blackColor),
        label: 'Akun',
      ),
    ];
  }
}
