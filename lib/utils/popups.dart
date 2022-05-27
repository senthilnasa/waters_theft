import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> confirm(String text,
    {String content = '', String ok = 'OK', String cancel = 'CANCEL'}) async {
  bool? ret = await Get.dialog<bool>(
      AlertDialog(
        title: Text(
          text,
          style: const TextStyle(color: Colors.teal),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        content: content.isEmpty ? null : Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: Get.back,
            style: TextButton.styleFrom(
                onSurface: Get.theme.colorScheme.secondary),
            child: Text(cancel.toUpperCase()),
          ),
          const SizedBox(width: 5),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            style: TextButton.styleFrom(
                onSurface: Get.theme.colorScheme.secondary),
            child: Text(ok.toUpperCase()),
          ),
          const SizedBox(width: 5),
        ],
      ),
      barrierDismissible: false);
  return ret ?? false;
}

Future<void> alert(String text,
    {String content = '', String ok = 'close'}) async {
  await Get.dialog<bool>(
    AlertDialog(
      title: Text(
        text,
        style: const TextStyle(color: Colors.teal),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      content: content.isEmpty ? null : Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: Get.back,
          style:
              TextButton.styleFrom(onSurface: Get.theme.colorScheme.secondary),
          child: Text(ok.toUpperCase()),
        ),
        const SizedBox(width: 10),
      ],
    ),
    // useRootNavigator: false,
    barrierDismissible: false,
    transitionCurve: Curves.bounceInOut,
  );
}

void toast(msg, [bool long = false]) {
  BotToast.showText(
    text: msg ?? '',
  );
}

Future<String?> prompt(String title,
    {String ok = 'OK',
    String cancel = 'CANCEL',
    String initialValue = '',
    int textLimit = 100,
    String hint = '',
    TextInputType inputType = TextInputType.text,
    TextAlign align = TextAlign.start,
    String? prefix,
    String? helperText}) async {
  final TextEditingController _c = TextEditingController(text: initialValue);
  String? ret;
  await Get.dialog(
    AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.teal,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      content: TextField(
        decoration: InputDecoration(
          hintText: hint,
          helperText: helperText,
          prefixText: prefix,
        ),
        textAlign: align,
        autofocus: true,
        controller: _c,
        maxLength: textLimit,
        keyboardType: inputType,
        onSubmitted: (s) {
          ret = _c.text;
          Get.back();
        },
      ),
      actions: [
        TextButton(
            onPressed: Get.back,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(cancel.toUpperCase()),
            )),
        TextButton(
          onPressed: () {
            ret = _c.text;
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(ok.toUpperCase()),
          ),
        ),
      ],
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
    ),
    barrierDismissible: false,
  );
  return ret;
}
