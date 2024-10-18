import 'package:ResiEasy/models/base_response.dart';
import 'package:ResiEasy/models/news_model.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:flutter/material.dart';

class NewsViewModel extends ChangeNotifier{
  ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  String? _error;
  String? get error => _error;

  List<NewsModel> listNews = [];

  int totalPage = 0;

  //load data from api
  Future<void> fetchNews(int page, int limit) async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await apiService.get('/article/articles', queryParameters: {
        'page': page,
        'limit': limit,
      });
      BaseResponse response = BaseResponse.fromJson(res);
      listNews = response.data?.data.map<NewsModel>((e) => NewsModel.fromJson(e)).toList();
      totalPage = response.data?.pagination?.totalPages ?? 0;
   
    } catch (e) {
      _error = 'Failed to load news: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}