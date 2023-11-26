import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../services/FireStoreServices.dart';
import 'DetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Activity> activities = [];
  late List<Activity> displayedActivities = [];
  late String selectedCategory = 'tout'; // Default to show all activities

  late Future<void> data;


  Future<List<Activity>> fetchData() async {
    try {
      // Fetch activities from the "football" collection
      List<Activity> footballActivities =
      await FirestoreService.getActivitiesFromCollection('football');

      // Fetch activities from the "équitation" collection
      List<Activity> equitationActivities =
      await FirestoreService.getActivitiesFromCollection('équitation');

      // Combine the two lists and update the state
      setState(() {
        activities = [...footballActivities, ...equitationActivities];
        displayedActivities = activities; // Initially, display all activities
      });

      // Print the fetched activities for debugging
      // print('Fetched Activities:');
      // for (var activity in activities) {
      //   print('Title: ${activity.title}');
      // }

    // , Image: ${activity.image}

      return activities;
    } catch (error) {
      print('Error fetching data: $error');
      return [];
    }
  }




  // Future<List<Activity>> fetchData() async {
  //   try {
  //     // Fetch activities from the "football" collection
  //     List<Activity> footballActivities =
  //     await FirestoreService.getActivitiesFromCollection('football');
  //
  //     // Fetch activities from the "équitation" collection
  //     List<Activity> equitationActivities =
  //     await FirestoreService.getActivitiesFromCollection('équitation');
  //
  //     // Combine the two lists and update the state
  //     setState(() {
  //       activities = [...footballActivities, ...equitationActivities];
  //       displayedActivities = activities; // Initially, display all activities
  //     });
  //     print('tesssssssssssssstttttttttttttt');
  //     print(activities);
  //
  //     return activities;
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //     return [];
  //   }
  // }


  void filterActivitiesByCategory(String category) {
    if (category == 'tout') {
      // Show all activities
      setState(() {
        displayedActivities = activities;
        selectedCategory = 'tout';
      });
      print(displayedActivities);
    } else {
      // Filter activities by the selected category
      List<Activity> filteredActivities = activities
          .where((activity) {
        print('Category: $category, Activity Category: ${activity.categorie}');
        return activity.categorie.toLowerCase() == category.toLowerCase();
      })
          .toList();
      print(filteredActivities);
      setState(() {
        displayedActivities = filteredActivities;
        selectedCategory = category;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    // Initialize the activities list here
    data = fetchData();

    print("fffffffffffffffffffffffffffffffffff");

    // Set 'tout' as the initial selected category
    filterActivitiesByCategory('tout');
  }


  Widget buildCategoryButton(String category) {
    return ElevatedButton(
      onPressed: () {
        filterActivitiesByCategory(category);
      },
      style: ElevatedButton.styleFrom(
        primary:
        selectedCategory == category ? Color.fromRGBO(143, 148, 251, 1) : Color.fromRGBO(230, 230, 255, 1), // Change the color based on selection
      ),
      child: Text(category),
    );
  }


  Widget _buildImageWidget(String image) {
    // Check if the string is a URL
    if (Uri.parse(image).isAbsolute) {
      return Image.network(
        image,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } else {
      // Assume it's base64-encoded byte code and decode it
      try {
        Uint8List bytes = base64Decode(image);
        return Image.memory(
          bytes,
          height: 100,
          width: 100,
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
          title: const Text('Liste des activité'),
        ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchData();
    },
    child:
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCategoryButton('tout'),
              buildCategoryButton('football'),
              buildCategoryButton('équitation'),
            ],
          ),
          // List of activities
          Expanded(
            child: ListView.builder(
              itemCount: displayedActivities.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          activity: displayedActivities[index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(displayedActivities[index].title),
                      subtitle: Text(displayedActivities[index].location),
                      trailing: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Price: ${displayedActivities[index].price}'),
                            SizedBox(width: 8),
                        _buildImageWidget(displayedActivities[index].image),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      ));

  }


}
