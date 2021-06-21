import 'dart:convert';

import 'package:dio/dio.dart';

abstract class GenericWebRequest {
  ///Generic get request that uses dio's get function to retrive information from the specified [url], separates lists from single queries with [isList]
  Future<List> getRequest(String url, bool isList);

  ///Get request that queries by [id] and returns the specified result
  Future<dynamic> getById(int id);

  //Get request that returns a list of all of that type of information
  Future<List> getAll();
}

class GenericWebRequestImpl implements GenericWebRequest {
  final String _base = "http://vacinas-teste.herokuapp.com/rest/";
  final String _path;

  GenericWebRequestImpl(this._path);

  Future<List> getRequest(String url, bool isList) async {
    Response response = await Dio().get(url);
    try {
      if (!isList) {
        dynamic data = response.data;
        if (data["error"] != null) {
          throw Exception(data["error"]);
        }
        return [data];
      } else {
        List data = response.data;
        return data;
      }
    } on DioError catch (e) {
      if (e.message.contains("type 'List<dynamic>' is not a subtype")) {
        List data = response.data;
        return data;
      } else {
        throw Exception("Unspecified error");
      }
    }
  }

  Future<dynamic> getById(int id) async {
    String url = _base + _path + "/$id";
    try {
      List map = await getRequest(url, false);
      return map[0];
    } catch (e) {
      print(e.toString()); //TODO handle dio error
      List eMap = e as List;
      return eMap[0];
    }
  }

  Future<List> getAll() async {
    String url = _base + _path + "/todos";
    try {
      List map = await getRequest(url, true);
      return map;
    } catch (e) {
      print(url + " ----" + e.toString());
      return [e as List];
    }
  }
}
