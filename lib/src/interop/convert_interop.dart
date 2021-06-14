@JS()
library stringify;

import 'dart:convert';

import 'package:js/js.dart';
import 'package:js/js_util.dart' as js;

// Calls invoke JavaScript `JSON.stringify(obj)`.
@JS('JSON.stringify')
external String stringify(Object obj);

/// convert the a javascript object to a valid map
Map<String, dynamic> convert(dynamic object) {
  return jsonDecode(stringify(object));
}

/// convert the a javascript object to a valid list
List<dynamic> convertList(dynamic object) {
  return jsonDecode(stringify(object));
}

Object mapToJSObj(Map<dynamic, dynamic> a) {
  var object = js.newObject();
  a.forEach((k, v) {
    var key = k;
    var value = v;
    js.setProperty(object, key, value);
  });
  return object;
}
