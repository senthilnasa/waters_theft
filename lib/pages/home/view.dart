import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/services/app.dart';
import 'controller.dart';
import 'menu.dart';
import 'modules/usage_log/view.dart';
import 'modules/user_dashboard/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: context.showNavbar
            ? IconButton(
                onPressed: () {
                  controller.showDrawer = !controller.showDrawer;
                  controller.update();
                },
                tooltip: 'Toggle menu',
                icon: const Icon(Icons.menu),
              )
            : null,
        title: const Text(
          'Water Theft',
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
        centerTitle: true,
      ),
      drawer: context.showNavbar
          ? null
          : const Drawer(
              child: AppMenuList(),
            ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GetBuilder<HomeController>(builder: (_) {
            return Offstage(
              offstage: !_.showDrawer,
              child: const Drawer(
                elevation: 8,
                child: AppMenuList(),
              ),
            );
          }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GetBuilder<HomeController>(
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_.selectedMenuId != 0)
                        ListTile(
                          title: Text(
                            AppService.to.user!.menu
                                .firstWhere(
                                    (e) => e.resourceId == _.selectedMenuId)
                                .resourceName,
                            style: const TextStyle(fontSize: 24),
                          ),
                          trailing: IconButton(
                            tooltip: 'Refresh',
                            icon: const Icon(Icons.refresh),
                            onPressed: _.reload,
                          ),
                        ),
                      Expanded(child: _getView(_.selectedMenuId)),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getView(int id) {
    switch (id) {
      case 0:
        return const Center(child: CircularProgressIndicator());
      case 7:
        return const UserDashboard();
      case 8:
        return UserUsageLog();
      default:
        return const Center(
          child: Text(
            'Under construction',
            style: TextStyle(fontSize: 24),
          ),
        );
    }
  }
}
