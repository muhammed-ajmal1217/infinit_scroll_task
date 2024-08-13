import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:refulgenceinc/model/model.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<DataModel>> getDatas(int offset) async {
    final String url = "https://news.kumudam.com/api/posts/?limit=20&offset=$offset&order=id&orderType=desc";
    log('Service${offset}value');

    try {
      final Response response = await dio.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> outPut = response.data;
        final List<DataModel> newsDatas = outPut.map((data) => DataModel.fromJson(data)).toList();
        return newsDatas;
      } else {
        log('Failed to load data: ${response.statusCode} ${response.statusMessage}');
        log('Error details: ${response.data}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('Error in fetching data: $e');
      throw Exception('Error in fetching data: $e');
    }
  }
}
