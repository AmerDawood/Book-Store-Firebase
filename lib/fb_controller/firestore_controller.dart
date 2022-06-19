import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/products_model.dart';
import '../model/user_model.dart';
import '../shared_preferences/user_preferences_controler.dart';

class FbFireStoreController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  Stream<QuerySnapshot> getProducts()async*{
    yield*  _firebaseFirestore.collection('books').snapshots();
  }


  Stream<QuerySnapshot> getNewProducts()async* {
    yield*  _firebaseFirestore.collection('new-books').snapshots();
  }





  Future<Users> readUser({required String id}) async {
    return await _firebaseFirestore
        .collection('users')
        .where('id', isEqualTo: id)
        .get()
        .then((value) {
      Users user = Users();
      user.id = value.docs.first.get('id');
      user.name = value.docs.first.get('name');
      user.email = value.docs.first.get('email');
      return user;
    },
        onError: (e) {
      return Users();
    });
  }

  Future<bool> updateUser( {required BuildContext context, required Users user}) async {
    bool secondUpdate = await _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toMap())
        .then((value) => true)
        .catchError((error) => false);

    bool result = secondUpdate;
    Users users = Users();
    if (result) {
      UserPreferenceController().saveUsers(
        users: users,
        email: user.email,
        name: users.name,
      );
    }

    return result;
  }




  // to add the product to cart
  //required String userId
  Future<bool> addProductToCart({required String productId,required String userId }) async {
    Map<String, dynamic> cart = <String, dynamic>{};
    cart['productId'] = productId;
    cart['userId'] = userId;
    return await _firebaseFirestore
        .collection('Carts')
        .add(cart)
        .then((value) => true)
        .catchError((error) => false);
  }


  // to get the product into cart  (Read from carts in Firebase).
  Future<List<Product>> getProductsCart({required String? userId}) async {
    List<Product> products = [];
    return await _firebaseFirestore
        .collection('Carts')
        .where('id', isEqualTo: userId)
        .get()
        .then((value) async {
      for (var element in value.docs){
        products.add(
            await getProduct(element.get('id')));
      }
      return products;
    }, onError: (e) {
      return products;
    }
    );
  }

  Future<Product> getProduct(String productId) async {
    Product product = Product(id: '', image: '', name: '', price: '');
    return await _firebaseFirestore.collection('books').doc(productId).get().then(
            (value) {
          product = Product(
            id: productId,
            image: value.get('imagePath'),
            name: value.get('title'),
            price: value.get('price'),
          );
          return product;
        }, onError: (e) {
        return product;
    });
  }


  Future<bool> deleteCart(String productId,String userId)async{
    return await _firebaseFirestore.collection('Carts').get().then((value){
      for(DocumentSnapshot doc in value.docs){
        if(doc.get('productId') == productId && doc.get('userId') == userId){
          doc.reference.delete();
        }
      }
      return true;
    },onError: (exception){
      return false;
    });
  }


}