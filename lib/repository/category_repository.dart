import 'package:event_booking/api/category_api.dart';
import 'package:event_booking/models/dropdown_category.dart';
import 'package:event_booking/response/category_response.dart';

import '../models/category.dart';

class CategoryRepository {
  Future<List<DropdownCategory?>> loadCategory() {
    return CategoryAPI().loadCategory();
  }

  Future<CategoryResponse?> getCategory() async {
    return CategoryAPI().getCategories();
  }

  // to add category
  Future<bool> createCategory(Category category) async {
    return CategoryAPI().createCategory(category);
  }
}
