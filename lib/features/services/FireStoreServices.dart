import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static Future<List<Activity>> getActivitiesFromCollection(String collectionName) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collectionName).get();

    List<Activity> activities = querySnapshot.docs.map((DocumentSnapshot doc) {
      return Activity(
        title: doc['titre'],
        location: doc['lieu'],
        price: doc['prix'],
        image: doc['image'],
        categorie: doc['catégorie'],
        numberOfPeople: doc['nombredepersonne'],
      );
    }).toList();

    return activities;
  }
}

class Activity {
  final String title;
  final String location;
  final String price;
  final String image;
  final String categorie;
  final String numberOfPeople;

  Activity({
    required this.title,
    required this.location,
    required this.price,
    required this.image,
    required this.categorie,
    required this.numberOfPeople
  });

}
