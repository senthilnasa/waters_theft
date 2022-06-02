import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/popups.dart';
import '../../utils/services/app.dart';
import 'controller.dart';

class AppMenuList extends GetView<HomeController> {
  const AppMenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppService.to.user;
    if (user == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        UserAccountsDrawerHeader(
          margin: EdgeInsets.zero,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(),
          ),
          accountName: Text(
            user.userName.capitalize!,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          accountEmail: Text(
            user.userMailId,
            style: const TextStyle(color: Colors.black),
          ),
          currentAccountPicture: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              user.userPhotoUrl,
            ),
          ),
          otherAccountsPictures: [
            IconButton(
              onPressed: () {
                confirm(
                  'Are you sure you want to logout?',
                  ok: 'Logout',
                ).then((value) {
                  if (value) {
                    AppService.to.logout();
                  }
                });
              },
              tooltip: 'Logout',
              color: Colors.redAccent,
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
        const Divider(height: 1),
        Expanded(
          child: GetBuilder<HomeController>(
            builder: (_) {
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: user.menu.map((menu) {
                  bool selected = controller.selectedMenuId == menu.resourceId;
                  return ListTile(
                    selected: selected,
                    leading: SizedBox(
                      width: 40,
                      child: Text(
                        selected
                            ? '${menu.resourceIcon}_rounded'
                            : '${menu.resourceIcon}_outlined',
                        style: TextStyle(
                            fontFamily: 'MaterialIcons',
                            fontSize: 22,
                            fontWeight: selected ? FontWeight.w600 : null),
                      ),
                    ),
                    title: Text(menu.resourceName),
                    onTap: () {
                      if (selected) return;
                      if (!context.showNavbar) {
                        Get.back();
                      }
                      controller.setUI(menu.resourceId);
                    },
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
