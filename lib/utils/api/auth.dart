import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as h;

import '../dlog.dart';
import '../loader.dart';
import '../utils.dart';
import 'uri.dart';

class AuthApiService<T> {
  Uri uri = Uri();

  final bool showLoader;
  final bool errToast;
  CancelFunc? _indicator;

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  Map<String, dynamic> _body = {};
  T get data => _body['data'];

  AuthApiService(String endPoint,
      {this.showLoader = true, this.errToast = true}) {
    uri = uri.replace(
      scheme: 'https',
      host: ApiConst.apiHost,
      pathSegments: [ApiConst.version, ...endPoint.split('/')],
    );

    _headers['DeviceId'] = 'test';
  }

  void _disposeIndicator() {
    if (_indicator != null) _indicator!();
  }

  Future<bool> gets(
      [Map<String, String>? query, Map<String, String>? headers]) {
    if (query != null) {
      uri = uri.replace(queryParameters: query);
    }
    if (headers != null) {
      _headers.addAll(headers);
    }

    return _processRequest(h.get(uri, headers: _headers));
  }

  Future<bool> post([Map<String, String>? body]) async {
    dPrint(body?.toString());
    return await _processRequest(
        h.post(uri, headers: _headers, body: jsonEncode(body)));
  }

  Future<bool> _processRequest(Future<h.Response> request) async {
    if (showLoader) _indicator = loader();

    try {
      h.Response response = await request;
      dPrint(_headers.toString());
      dPrint(response.body.toString());
      _body = jsonDecode(response.body);
      if (_body.containsKey('ok') && _body['ok']) {
        _disposeIndicator();
        return true;
      }
      if (!_body.containsKey('ok') || !_body['ok']) {
        if (_body.containsKey('err-msg') && errToast) toast(_body['err-msg']);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    _disposeIndicator();
    return false;
  }
}
