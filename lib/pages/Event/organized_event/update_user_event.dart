import 'dart:io';

import 'package:event_booking/models/dropdown_category.dart';
import 'package:event_booking/models/event.dart';
import 'package:event_booking/repository/category_repository.dart';
import 'package:event_booking/repository/event_repositories.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class UpdateEventScreen extends StatefulWidget {
  const UpdateEventScreen({Key? key}) : super(key: key);

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
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

  // Update Event
  _updateEvent(Event event) async {
    try {
      bool isUpdated = await EventRepository().updateEvent(img, event);
      if (isUpdated) {
        _displayMessage(isUpdated);
      } else {
        _displayMessage(isUpdated);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Display message
  _displayMessage(bool isUpdated) {
    if (isUpdated) {
      MotionToast.success(description: const Text("Product added successfully"))
          .show(context);
      Navigator.pop(context);
    } else {
      MotionToast.error(description: const Text("Error adding product"))
          .show(context);
    }
  }

  var gap = const SizedBox(height: 10);

  final _formKey = GlobalKey<FormState>();

  String? _dropdownvalue;
  String? _value;

  @override
  Widget build(BuildContext context) {
    Event event = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _displayImage(event),
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
                    // controller: titleController,
                    initialValue: event.title,
                    onChanged: (value) {
                      event.title = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Event Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    // controller: contentController,
                    initialValue: event.content,
                    onChanged: (value) {
                      event.content = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Event Description',
                      hintText: 'Enter Event Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    // controller: ticketPriceController,
                    initialValue: event.ticketPrice.toString(),
                    onChanged: (value) {
                      event.ticketPrice = int.parse(value);
                    },
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
                    // controller: locationController,
                    initialValue: event.location,
                    onChanged: (value) {
                      event.location = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Location/Venue',
                      hintText: 'Enter Event location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    // controller: specialAppereanceController,
                    initialValue: event.specialAppereance,
                    onChanged: (value) {
                      event.specialAppereance = value;
                    },

                    decoration: const InputDecoration(
                      labelText: 'Special Appereance',
                      hintText: 'Enter Special Appereance',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    // controller: ratingController,
                    initialValue: event.id,

                    decoration: const InputDecoration(
                      labelText: 'Rating',
                      hintText: 'Enter rating',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    // controller: eventDateController,
                    initialValue: event.eventDate,
                    onChanged: (value) {
                      event.eventDate = value;
                    },
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
                          _updateEvent(event);
                        }
                      },
                      label: const Text('Update Event'),
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

  Widget _displayImage(Event event) {
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
                          event.eventImage!
                              .replaceAll('127.0.0.0', '192.168.1.101'),
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
