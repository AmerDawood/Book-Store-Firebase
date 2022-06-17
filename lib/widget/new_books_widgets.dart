import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../fb_controller/firestore_controller.dart';
import '../model/new_product_model.dart';
import '../provider/new_product_provider.dart';

class NewBooksWidget extends StatelessWidget {
  const NewBooksWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: StreamBuilder<QuerySnapshot>(
          stream: FbFireStoreController().getNewProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return  Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 25,
                  ),);
            } else if (snapshot.hasData &&
                snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> allNewProducts =
                  snapshot.data!.docs;
              return ListView.builder(
                padding: const EdgeInsetsDirectional.only(top: 10),
                itemCount: allNewProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<NewProductProvider>(context,
                          listen: false)
                          .changeProduct(
                        newProduct: NewProduct(
                          image: allNewProducts[index].get('image'),
                          name: allNewProducts[index].get('name'),
                          description: allNewProducts[index].get('description'),
                          price: allNewProducts[index].get('price'),
                          productId: allNewProducts[index].id,
                        ),
                      );
                      // Navigator.pushNamed(context, '/product_details_screen');
                    },
                    child: Container(
                      width: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network('${allNewProducts[index].get('image')}', height: 140.0),
                          const SizedBox(height: 10.0),
                          Text('${allNewProducts[index].get('name')}',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0), overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 5.0),
                          RatingBar.builder(
                            initialRating: 3.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 10,
                            ignoreGestures: true,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {

                            },
                          )
                          // Text("★️ 3.5", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0, color: Colors.orangeAccent)),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // Icon(Icons.warning, size: 40),
                    Text(
                      'NOT EXIST ANY BOOKS',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
