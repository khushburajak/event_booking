import 'package:dio/dio.dart';
import 'package:event_booking/models/category.dart';
import 'package:event_booking/models/dropdown_category.dart';
import 'package:event_booking/response/category_response.dart';
import 'package:event_booking/services/http_services.dart';
import 'package:event_booking/utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:motion_toast/motion_toast.dart';

class CategoryAPI {
  Future<List<DropdownCategory?>> loadCategory() async {
    List<DropdownCategory?> dropdownCategoryList = [];
    Response response;
    var url = baseUrl + categoryUrl + getcategoryUrl;
    var dio = HttpServices().getDioInstance();

    try {
      response = await dio.get(url);

      if (response.statusCode == 200) {
        CategoryResponse categoryResponse =
            CategoryResponse.fromJson(response.data);

        for (var categories in categoryResponse.categories!) {
          dropdownCategoryList.add(
            DropdownCategory(
              id: categories.id,
              name: categories.name,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to get category $e');
    }

    return dropdownCategoryList;
  }

  Future<CategoryResponse?> getCategories() async {
    CategoryResponse? categoryResponse;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + categoryUrl + getcategoryUrl;

      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        categoryResponse = CategoryResponse.fromJson(response.data);
      } else {
        categoryResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return categoryResponse;
  }

  // to create Category
  Future<bool> createCategory(Category category) async {
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + categoryUrl + createcategoryUrl;
      var data = {'name': category.name, 'image': category.image};
      Response response = await dio.post(url, data: data);
      if (response.statusCode == 201) {
        return true;
      } else {
        MotionToast.error(description: const Text("Something went wrong"));
      }
    } catch (e) {
      throw Exception(e);
    }
    return true;
  }
}
