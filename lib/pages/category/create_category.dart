import 'package:event_booking/models/category.dart';
import 'package:event_booking/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  // Load camera and gallery images and store it to the File object.

  // Add product
  _addCategory(Category category) async {
    try {
      bool isAdded = await CategoryRepository().createCategory(category);
      if (isAdded) {
        _displayMessage(isAdded);
      } else {
        _displayMessage(isAdded);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Display message
  _displayMessage(bool isAdded) {
    if (isAdded) {
      MotionToast.success(
              description: const Text("Category added successfully"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Error adding Category"))
          .show(context);
    }
  }

  var gap = const SizedBox(height: 10);
  final nameController = TextEditingController(text: "Technology");
  final imageController = TextEditingController(
      text:
          "https://i0.wp.com/marketbusinessnews.com/wp-content/uploads/2018/11/Information-Technology-thumbnail.jpg?fit=509%2C267&ssl=1");

  final _formKey = GlobalKey<FormState>();

  String? _dropdownvalue;
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text(
          'Edit Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    gap,
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter Category Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    gap,
                    TextFormField(
                      controller: imageController,
                      decoration: const InputDecoration(
                        labelText: 'Image',
                        hintText: 'Enter Image URL',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Category category = Category(
                              name: nameController.text,
                              image: imageController.text,
                            );

                            _addCategory(category);
                          }
                        },
                        label: const Text('Add Category'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
