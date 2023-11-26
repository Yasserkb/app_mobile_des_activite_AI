import 'package:flutter/material.dart';
import 'package:mobile_ai/features/home/DetailsPage.dart';
import '../services/FireStoreServices.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Activity>? activities=[];

  // Future<List<Activity>> fetchData() async {
  //   print('fetchData');
  //   try {
  //     // Fetch activities from the "football" collection
  //     List<Activity> footballActivities =
  //     await FirestoreService.getActivitiesFromCollection('football');
  //     // Fetch activities from the "équitation" collection
  //     List<Activity> equitationActivities =
  //     await FirestoreService.getActivitiesFromCollection('équitation');
  //
  //     // Combine the two lists
  //     return [...footballActivities, ...equitationActivities];
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //     // Return an empty list in case of an error
  //     return [];
  //   }
  // }


  // Future<List<Activity>> fetchData() async {
  //   print('fetchData');
  //
  //   // Fetch activities from the "football" collection
  //   List<Activity> footballActivities =
  //   await FirestoreService.getActivitiesFromCollection('football');
  //   setState(() {
  //
  //   });
  //   // Fetch activities from the "équitation" collection
  //   List<Activity> equitationActivities =
  //   await FirestoreService.getActivitiesFromCollection('équitation');
  //
  //   // Combine the two lists
  //   setState(() {
  //     activities = [...footballActivities, ...equitationActivities];
  //   });
  // }


  Future<List<Activity>> fetchData() async {

    print('fetchData');
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
      });

      // Return the combined list
      return activities ?? []; // If activities is null, return an empty list
    } catch (error) {
      print('Error fetching data: $error');
      // Handle the error as needed

      // Return an empty list in case of an error
      return [];
    }
  }
  @override
  void initState() {
    print('eze');
    super.initState();
    // Initialize the activities list here
    fetchData();
    // Call the fetchData method to populate the list
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App'),
      ),
      body:  ListView.builder(
        itemCount: activities!.length,
        itemBuilder: (context, index) {
          // Use the activities data to build your UI here
          return GestureDetector(
            onTap: () {
              // Navigate to the details page when an item is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(activity: activities![index]),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(activities![index].title),
                subtitle: Text(activities![index].location),
                trailing: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text('Price: ${activities![index].price}'),
                      SizedBox(width: 8),
                      Image.network(
                        activities![index].image,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          // Use the activities data to build your UI here
          // return Card(
          //   margin: EdgeInsets.all(8),
          //   child: ListTile(
          //     title: Text(activities![index].title),
          //     subtitle: Text(activities![index].location),
          //     trailing: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         children: [
          //           Text('Price: ${activities![index].price}'),
          //           SizedBox(width: 8),
          //           Image.network(
          //             activities![index].imageLink,
          //             height: 100, // Adjust the height as needed
          //             width: 100, // Adjust the width as needed
          //             fit: BoxFit.cover,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }

}


