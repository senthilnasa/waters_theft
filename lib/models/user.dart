class UserModel {
  UserModel({
    required this.userName,
    required this.userMailId,
    required this.menu,
    required this.userPhotoUrl,
  });

  final String userName;
  final String userMailId;
  final String userPhotoUrl;
  final List<Menu> menu;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json["user_name"],
        userMailId: json["user_mail"],
        userPhotoUrl: json["user_img"],
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
      );
}

class Menu {
  Menu({
    required this.resourceId,
    required this.resourceName,
    required this.resourceIcon,
  });

  final int resourceId;
  final String resourceName;
  final String resourceIcon;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        resourceId: json["resource_id"],
        resourceName: json["resource_name"],
        resourceIcon: (json["resource_icon"] ?? '').toString().isEmpty
            ? 'dashboard'
            : json["resource_icon"],
      );
}
