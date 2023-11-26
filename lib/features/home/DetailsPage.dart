import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_ai/features/services/FireStoreServices.dart';


class DetailsPage extends StatelessWidget {
  final Activity activity;

  const DetailsPage({Key? key, required this.activity}) : super(key: key);




  Widget _buildImageWidget(String image) {
    // Check if the string is a URL
    if (Uri.parse(image).isAbsolute) {
      return Image.network(
        image,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      // Assume it's base64-encoded byte code and decode it
      try {
        Uint8List bytes = base64Decode(image);
        return Image.memory(
          bytes,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      } catch (e) {
        print('Error decoding base64 image: $e');
        return Container(); // Return an empty container if decoding fails
      }
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network(
            //   activity.image,
            //   height: 200,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),
            _buildImageWidget(activity.image),
            Text('Title: ${activity.title}'),
            Text('Location: ${activity.location}'),
            Text('Price: ${activity.price}'),
            Text('Catégorie: ${activity.categorie}'),
            Text('Le nombre de personne minimum nécessaire: ${activity.numberOfPeople}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
