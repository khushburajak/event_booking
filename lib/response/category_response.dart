// ignore: depend_on_referenced_packages
import 'package:event_booking/models/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  bool? success;
  List<Category>? categories;
  

  CategoryResponse({
    this.success,
    this.categories,
  });
  

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
