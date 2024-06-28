import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageRepository {
  FirebaseStorageRepository({
    FirebaseStorage? firebaseStorage
  }) : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;
  final FirebaseStorage _firebaseStorage;

  Future<String?> addImageToSignUp(XFile? image) async {
    try {
      final name = image!.name;
      final id = FirebaseAuth.instance.currentUser!.uid;
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'uploaded_by': 'fcb_pay_app',
          'uploaded_date': '${DateTime.now()}'
        }
      );

      final storageRef =  _firebaseStorage.ref('signup/$id/$name');
      final uploadTask = storageRef.putFile(File(image.path), metadata);
      final taskSnapshot = await uploadTask.whenComplete(() {});

      return await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  UploadTask addImageReturnUploadTask(XFile? image) {
    final name = image!.name;
    final id = FirebaseAuth.instance.currentUser!.uid;
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {
        'uploaded_by': 'fcb_pay_app',
        'uploaded_date': '${DateTime.now()}'
      }
    );
    
    return _firebaseStorage.ref('signup/$id/$name').putFile(File(image.path), metadata);
  }
}