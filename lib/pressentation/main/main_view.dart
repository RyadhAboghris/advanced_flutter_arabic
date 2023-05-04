import 'package:advanced_flutter_arabic/pressentation/main/pages/home/view/home_page.dart';
import 'package:advanced_flutter_arabic/pressentation/main/pages/home/view/home_page.dart';
import 'package:advanced_flutter_arabic/pressentation/main/pages/notification/notifications_page.dart';
import 'package:advanced_flutter_arabic/pressentation/main/pages/search/search_page.dart';
import 'package:advanced_flutter_arabic/pressentation/main/pages/setting/setting_page.dart';
import 'package:advanced_flutter_arabic/pressentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/pressentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/pressentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

List<Widget> pages = [
  HomePage(),
  SearchPage(),
  NotificationPage(),
  SettingsPage(),
];

List<String> titles = [
  AppStrings.home.tr(),
  AppStrings.search.tr(),
  AppStrings.notification.tr(),
  AppStrings.settings.tr(),
];

var _title = AppStrings.home.tr();
var _currentIndex = 0;

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        _title,
        style: Theme.of(context).textTheme.titleSmall,
      )),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items:  [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: AppStrings.home.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.search.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notification.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.settings.tr()),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex == index;
      _title = titles[index];
    });
  }
}
