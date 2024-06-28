import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/utils/utility_functions.dart';

class UserProvider extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> updateUserField({required String fieldName, required dynamic newValue}) async {
    try {
      // Get the collection name based on the user type
      String collectionName = UtilityFunctions.getCollectionName(UserModel.currentUser.userType);

      // Query the collection for the document with the matching email
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection(collectionName)
          .where('email', isEqualTo: UserModel.currentUser.email)
          .get();

      // Check if a document with the matching email was found
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document (assuming emails are unique)
        DocumentSnapshot userDoc = querySnapshot.docs.first;

        // Update the specified field in the document
        await userDoc.reference.update({
          fieldName: newValue,
        }).then((value){
          getUserDataByEmail(UserModel.currentUser.email, UtilityFunctions.getCollectionName(UserModel.currentUser.userType));
        });

        print('User field updated successfully.');
      } else {
        print('No user found with the specified email.');
      }
    } catch (e) {
      print('Error updating user field: $e');
    }
  }

  Future<UserModel?> getUserDataByEmail(String email, String collection) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (result.docs.isEmpty) {
      return null;
    }

    final DocumentSnapshot document = result.docs.first;
    final Map<String, dynamic> userData =
        document.data() as Map<String, dynamic>;
    if (collection == 'freelancers') {
      return FreelancerModel.fromJson(userData);
    } else if (collection == 'clients') {
      return ClientModel.fromJson(userData);
    } else {
      return EmployeeModel.fromJson(userData);
    }
  }



  

}


