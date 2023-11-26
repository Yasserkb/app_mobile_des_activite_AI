import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categorieController = TextEditingController(); // Added
  late String _titre;
  late String _lieu;
  late String _prix;
  late String _nombreDePersonne;
  late String _categorie = '';

  File? _image;
  List? _output;

  Future<void> uploadActivity(
      String titre,
      String lieu,
      String prix,
      String nombreDePersonne,
      Uint8List imageBytes) async {
    try {
      // Convert the Uint8List imageBytes to a base64-encoded string
      String base64Image = base64Encode(imageBytes);

      String collectionName = _categorie.toLowerCase(); // Use the _categorie variable

      // Replace 'your_collection_name' with the actual name of your Firestore collection
      await FirebaseFirestore.instance.collection(collectionName).add({
        'titre': titre,
        'lieu': lieu,
        'prix': prix,
        'nombredepersonne': nombreDePersonne,
        'catégorie': _categorieController.text, // Use the controller value
        'image': base64Image, // Save the base64 encoded image
        // Add other fields as needed
      });

      print(_categorieController.text);

      print('Activity uploaded successfully');

      Fluttertoast.showToast(
        msg: 'Activity uploaded successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purpleAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Reset the form fields after successful upload
      _formKey.currentState!.reset();


    } catch (e) {
      print('Error uploading activity: $e');
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _image = File(image.path);
      });

      detectImage(_image!);
    }
  }

  loadModel() async {
    await Tflite.loadModel(model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  detectImage(File image) async {
    var prediction = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = prediction;
      _categorie = 'Unknown';

      if (_output != null && _output!.isNotEmpty) {
        _categorie = (_output![0]['label']).toString().substring(2).toLowerCase();
        _categorieController.text = _categorie; // Update the controller
      }
    });
  }

  void handleImageSelection() {
    if (_image != null) {
      detectImage(_image!);
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une Activité'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _image == null
                    ? Container(
                  height: 100,
                  color: Colors.grey,
                  child: Center(child: Text('Pick an Image')),
                )
                    : Image.file(
                  _image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _titre = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lieu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a lieu';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lieu = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a prix';
                  }
                  return null;
                },
                onSaved: (value) {
                  _prix = value!; // Convert value to string
                   // Assign the string value to _prix
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Le nombre de personne minimum nécessaire'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a minimum number of people';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nombreDePersonne = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Catégorie'),
                enabled: false,
                controller: _categorieController, // Use the controller
                onSaved: (value) {
                  // Handle the form data as needed
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Perform the action with the form data (image, lieu, prix, categorie)

                    // Convert the image file to bytes
                    if (_image != null) {
                      List<int> imageBytes = _image!.readAsBytesSync();
                      Uint8List uint8List = Uint8List.fromList(imageBytes);

                      // Call the upload function
                      uploadActivity(_titre,_lieu, _prix,_nombreDePersonne, uint8List);
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
