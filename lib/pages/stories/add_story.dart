import 'dart:io';

import 'package:event_booking/models/story.dart';
import 'package:event_booking/repository/story_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({Key? key}) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  // Load camera and gallery images and store it to the File object.
  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  // Add product
  _addStory(Story story) async {
    try {
      bool isAdded = await StoryRepository().addStory(img, story);
      debugPrint(isAdded.toString());
      _displayMessage(isAdded);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Display message
  _displayMessage(bool isAdded) {
    if (isAdded) {
      Navigator.pop(context);
    } else {
      MotionToast.error(description: const Text("Error adding Story"))
          .show(context);
    }
  }

  var gap = const SizedBox(height: 10);
  final titleController = TextEditingController(text: "StartUp Fest");

  final _formKey = GlobalKey<FormState>();

  String? _dropdownvalue;
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _displayImage(),
                  gap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _loadImage(ImageSource.camera);
                          },
                          icon: const Icon(Icons.camera_enhance),
                          label: const Text('Open Camera'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _loadImage(ImageSource.gallery);
                          },
                          icon: const Icon(Icons.browse_gallery_sharp),
                          label: const Text('Open Gallery'),
                        ),
                      ),
                    ],
                  ),
                  gap,
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Event Name',
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
                          _addStory(Story(
                            title: titleController.text,
                          ));
                        }
                      },
                      label: const Text('Add Story'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayImage() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
      ),
      child: ClipRRect(
        // For rounded upper right corner and left corner in imageview
        borderRadius: BorderRadius.circular(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: img == null
                    ? SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.network(
                          "https://i.pinimg.com/originals/95/0f/4d/950f4df946e0a373e47df37fb07ea1f9.jpg",
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                        ),
                      )
                    : Image.file(img!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
