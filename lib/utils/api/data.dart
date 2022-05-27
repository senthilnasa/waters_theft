import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as h;

import '../dlog.dart';
import '../loader.dart';
import '../utils.dart';
import 'api_header.dart';
import 'uri.dart';

class DataApiService<T> {
  Uri uri = Uri();

  final bool showLoader;
  final bool errToast;
  CancelFunc? _indicator;

  final Map<String, String> _headers = {};

  Map<String, dynamic> _body = {};
  T get data => _body['data'];

  DataApiService(String endPoint,
      {this.showLoader = true, this.errToast = true}) {
    var pathSegment = [ApiConst.version, 'data'];
    if (endPoint.trim().isNotEmpty) {
      pathSegment.addAll(endPoint.split('/'));
    }
    uri = uri.replace(
      scheme: kReleaseMode ? 'https' : 'http',
      host: ApiConst.apiHost,
      pathSegments: pathSegment,
    );
    _headers.addAll(getHeaders());
  }

  void _disposeIndicator() {
    if (_indicator != null) {
      _indicator!();
      _indicator = null;
    }
  }

  Future<bool> gets(
      [Map<String, String>? query, Map<String, String>? headers]) {
    if (query != null) {
      query.addAll(uri.queryParameters);
      uri = uri.replace(queryParameters: query);
    }
    if (headers != null) {
      _headers.addAll(headers);
    }
    dPrint(uri.toString());
    return _processRequest(h.get(uri, headers: _headers));
  }

  Future<bool> post([Map<String, dynamic>? body]) async {
    return await _processRequest(
        h.post(uri, headers: _headers, body: jsonEncode(body)));
  }

  Future<bool> put([Map<String, dynamic>? body]) async {
    return await _processRequest(
        h.put(uri, headers: _headers, body: jsonEncode(body)));
  }

  Future<bool> delete([Map<String, dynamic>? body]) async {
    return await _processRequest(
        h.put(uri, headers: _headers, body: jsonEncode(body)));
  }

  Future<bool> _processRequest(Future<h.Response> request) async {
    if (showLoader) _indicator = loader();

    try {
      h.Response response = await request;

      _disposeIndicator();
      dPrint(response.body);
      _body = jsonDecode(response.body);
      if (_body.containsKey('ok') && _body['ok']) {
        return true;
      }

      if (_body.containsKey('err-code') && _body['err-code'] == 1000) {
        logout();
        return false;
      }

      if (_body.containsKey('err-msg') && errToast) toast(_body['err-msg']);
    } catch (e) {
      toast('Unknown error');
      dPrint(e.toString());
      _disposeIndicator();
    }
    return false;
  }

  void logout() {
    h.get(uri, headers: _headers);
  }
}
