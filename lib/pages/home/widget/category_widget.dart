import 'package:event_booking/models/category.dart';
import 'package:event_booking/repository/category_repository.dart';
import 'package:event_booking/response/category_response.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: FutureBuilder<CategoryResponse?>(
        future: CategoryRepository().getCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Category> lstCategory = snapshot.data!.categories!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: lstCategory.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: const Color.fromARGB(255, 55, 80, 92),
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(lstCategory[index].image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      lstCategory[index].name!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
