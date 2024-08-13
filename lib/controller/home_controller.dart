import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:refulgenceinc/model/model.dart';
import 'package:refulgenceinc/service/api_service.dart';

class HomeController extends ChangeNotifier {
  ApiService apiService = ApiService();
  List<DataModel> datas = [];
  bool isLoading = false;
  bool hasMore = true;
  int currentPage = 1;
  int offset = 0;
  final int limit = 20;

  Future<void> getAllDatas({bool isLoadMore = false}) async {
    if (isLoading) return;

    isLoading = true;
    //notifyListeners();

    try {
      List<DataModel> fetchedData = await apiService.getDatas(offset);
      
      if (fetchedData.isNotEmpty) {
        if (isLoadMore) {
          datas.addAll(fetchedData);
        } else {
          datas = fetchedData;
        }
        offset += limit;
        log('${offset}');
      } else {
        hasMore = false;
      }
    } catch (e) {
      log('Error in fetching datas in provider: $e');
      hasMore = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    datas.clear();
    currentPage = 1;
    offset = 0;
    hasMore = true;
    await getAllDatas();
  }

  void loadMore() async {
    if (hasMore) {
      await getAllDatas(isLoadMore: true);
    }
  }
}
