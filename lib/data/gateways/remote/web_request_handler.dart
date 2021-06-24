import 'package:dio/dio.dart';

abstract class GenericWebRequest {
  ///Generic get request that uses dio's get function to retrive information from the specified [url]
  Future<dynamic> getRequest(String url);

  ///Generic get request that uses dio's get function to retrive lists of information from the specified [url]
  Future<List> getListRequest(String url);
  Future<dynamic> postRequest(String url, Map<String, dynamic> data);

  ///Get request that queries by [id] and returns the specified result
  Future<dynamic> getById(int id);

  //Get request that returns a list of all of that type of information
  Future<List> getAll();
  Future<dynamic> save(Map<String, dynamic> data);
}

class GenericWebRequestImpl implements GenericWebRequest {
  final String _base = "http://vacinas-teste.herokuapp.com/rest/";
  final String _path;
  final Dio _dio = Dio();

  GenericWebRequestImpl(this._path);

  @override
  Future<List> getListRequest(String url) async {
    Response response = await _dio.get(url);
    try {
      List data = response.data;
      if (data[0]["error"] != null) {
        throw Exception(data[0]);
      }
      return data;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<dynamic> getRequest(String url) async {
    Response response = await _dio.get(url);
    try {
      dynamic data = response.data;
      if (data["error"] != null) {
        throw Exception(data);
      }
      return data;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<dynamic> postRequest(String url, Map<String, dynamic> data) async {
    Response response = await _dio.post(url, data: data);
    try {
      dynamic data = response.data;
      if (data["error"] != null) {
        throw Exception(data);
      }
      return data;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<dynamic> getById(int id) async {
    String url = _base + _path + "/$id";
    try {
      dynamic map = await getRequest(url);
      return map;
    } catch (e) {
      print(e.toString()); //TODO handle dio error
      return (e as Map)["error"];
    }
  }

  @override
  Future<List> getAll() async {
    String url = _base + _path + "/todos";
    try {
      List map = await getListRequest(url);
      return map;
    } catch (e) {
      print(url + " ----" + e.toString());
      return [e as List];
    }
  }

  @override
  Future<dynamic> save(Map<String, dynamic> data) async {
    String url = _base + _path + "/salvar";
    try {
      dynamic map = await postRequest(url, data);
      return map;
    } catch (e) {
      print(e.toString()); //TODO handle dio error
      return (e as Map)["error"];
    }
  }
}
