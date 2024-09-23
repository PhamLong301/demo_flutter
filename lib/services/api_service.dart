import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../api_postman/model/products_model.dart';

class ApiService{
  final Dio _dio = Dio();
  ApiService(){
    _dio.options.baseUrl = 'https://api.spoonacular.com/';
    _dio.options.queryParameters = {
      'apiKey' : 'd2a12b3c5e88427eab0695d845158ad1'
    };
    _dio.interceptors.add(PrettyDioLogger());
  }
  Future<ProductsTotalResponse?> fetchRecipes({
    required int currentSize,
    required int skipSize,
  }) async {
    try {
      final response = await _dio.get('/recipes/complexSearch', queryParameters: {
        'number': currentSize,
        'offSet': skipSize,
      });
      if (response.statusCode == 200) {
        try {
          return ProductsTotalResponse.fromJson(response.data as Map<String, dynamic>);
        } catch (_) {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }
}