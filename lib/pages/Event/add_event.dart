import 'dart:io';

import 'package:event_booking/models/dropdown_category.dart';
import 'package:event_booking/models/event.dart';
import 'package:event_booking/repository/category_repository.dart';
import 'package:event_booking/repository/event_repositories.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
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
  _addEvent(Event event) async {
    try {
      bool isAdded = await EventRepository().addEvent(img, event);
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
      MotionToast.success(description: const Text("Product added successfully"))
          .show(context);
      Navigator.pop(context);
    } else {
      MotionToast.error(description: const Text("Error adding product"))
          .show(context);
    }
  }

  var gap = const SizedBox(height: 10);
  final titleController = TextEditingController(text: "StartUp Fest");
  final contentController = TextEditingController(text: "StartUp Fest");
  final ticketPriceController = TextEditingController(text: '2000');
  final eventDateController = TextEditingController(text: '2022-08-01');
  final locationController = TextEditingController(text: 'Kathmandu');
  final specialAppereanceController =
      TextEditingController(text: "Swatika Khadka");
  final ratingController = TextEditingController(text: '3');

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
                  TextFormField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      labelText: 'Event Description',
                      hintText: 'Enter Event Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: ticketPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Ticket Price',
                      hintText: 'Enter Ticket Price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  //DropdownButton
                  FutureBuilder<List<DropdownCategory?>>(
                    future: CategoryRepository().loadCategory(),
                    builder: (context, snapshot) {
                      // _dropdownvalue = snapshot.data![0]!.id!;
                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category),
                            hintText: 'Select Category',
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _value = newValue!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null) {
                              return 'Please select category';
                            }
                            return null;
                          },
                          // Initial Value
                          value: _dropdownvalue,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          // Array list of items
                          items: snapshot.data!.map(
                            (DropdownCategory? items) {
                              return DropdownMenuItem<String>(
                                value: items!.id!,
                                child: Text(items.name!),
                              );
                            },
                          ).toList(),
                        );
                      } else if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  gap,
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location/Venue',
                      hintText: 'Enter Event location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    controller: specialAppereanceController,
                    decoration: const InputDecoration(
                      labelText: 'Special Appereance',
                      hintText: 'Enter Special Appereance',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: ratingController,
                    decoration: const InputDecoration(
                      labelText: 'Rating',
                      hintText: 'Enter rating',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: eventDateController,
                    decoration: const InputDecoration(
                      labelText: 'Event Date',
                      hintText: 'Enter Event Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Event event = Event(
                            title: titleController.text,
                            content: contentController.text,
                            ticketPrice: int.parse(ticketPriceController.text),
                            category: _value,
                            location: locationController.text,
                            specialAppereance: specialAppereanceController.text,
                            eventDate: eventDateController.text,
                          );

                          _addEvent(event);
                        }
                      },
                      label: const Text('Add Event'),
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
                          'http://www.clker.com/cliparts/o/G/p/l/g/M/add-student-hi.png',
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
