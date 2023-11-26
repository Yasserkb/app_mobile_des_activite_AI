import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _lieu;
  late double _prix;
  late XFile?  _pickedImage = null;
  late String _categorie;
  File? _image;
  List? _output;

  // void _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _pickedImage = pickedFile;
  //   });
  // }



  Future<void> _pickImage() async {
//Pick an image from camera or gallery
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _image = File(image.path);
        detectimage(_image!);
      });
    } ;
//detectimage(_image!);
  }

  loadmodel() async {
    await Tflite.loadModel(model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  detectimage(File image) async {
    print("okkkkkkkkkkkkkk" + image.path);
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = prediction!;
      print(_output);
      _categorie = _output![0]['label'].toString().substring(2);
    });
  }

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your AppAA'),
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
                child: _pickedImage == null
                    ? Container(
                  height: 100,
                  color: Colors.grey,
                  child: Center(child: Text('Pick an Image')),
                )
                    : Image.file(
                  File(_pickedImage!.path),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
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
                  _prix = double.parse(value!);
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
                  _prix = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'catégorie'),
                keyboardType: TextInputType.number,
                enabled: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a minimum number of people';
                  }
                  return null;
                },
                onSaved: (value) {
                  _prix = double.parse(value!);
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Perform the action with the form data (image, lieu, prix)
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


