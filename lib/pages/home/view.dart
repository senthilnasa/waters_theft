import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'menu.dart';

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
                          title: const Text('Home'),
                          onTap: () {
                            _.selectedMenuId = 0;
                            _.update();
                          },
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

      default:
        return const Center(
          child: Text('Select a menu item'),
        );
    }
  }
}
