import 'package:book_store/utility/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../fb_controller/firestore_controller.dart';
import '../provider/product_provider.dart';
import '../shared_preferences/user_preferences_controler.dart';

// Detail screen.
class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}
class _DetailScreenState extends State<DetailScreen> with Helpers{
  final Color _accentColor = Color(0xFF272727);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Iconsax.arrow_left, color: Colors.grey[600]),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Icon(Iconsax.save_add, color: Colors.grey[600]),
            ),
          ],
        ),
        body: SafeArea(
            child: Stack(
          fit: StackFit.loose,
          children: [
            Align(
              alignment: Alignment(-0.8, 0),
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.green.withOpacity(0.5)),
              ),
            ),
            Align(
              alignment: Alignment(-0.5, -0.9),
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    color: Colors.red.withOpacity(0.5)),
              ),
            ),
            Align(
              alignment: Alignment(0.8, -0.3),
              child: Container(
                width: 180.0,
                height: 180.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(150.0)),
                    color: Colors.blue.withOpacity(0.4)),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.8),
              child: Container(
                width: 250.0,
                height: 300.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            Provider.of<ProductProvider>(context)
                                .product
                                .image
                        ))),
              ),
            ),
            Align(
                alignment: Alignment(0, 0.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text( Provider.of<ProductProvider>(context)
                        .product
                        .name,
                        style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black)),
                    const SizedBox(height: 10.0),
                    Text('Reed Hastings / Erin Meyer',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: 4.5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15,
                          ignoreGestures: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            //
                            //
                            //
                            //
                            //
                          },
                        ),
                        const SizedBox(width: 10.0),
                        Text('4.5',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey))
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                          Provider.of<ProductProvider>(context)
                              .product
                              .description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                              height: 1.5)),
                    )
                  ],
                )),
            Align(
              alignment: Alignment(0, 0.9),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: _accentColor,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      performAddToCart(
                          Provider.of<ProductProvider>(context,listen: false).product.id
                      );
                    },
                    child: Text('ADD TO CART',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                ),
              ),
            )
          ],
        )));
  }

  Future performAddToCart(String productId) async {
    showDialog(
      context: context,
      builder: (context) =>  Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.black,
          size: 30,
        ),
      ),
    );
    bool status = await FbFireStoreController().addProductToCart(
        productId: productId,
        userId: UserPreferenceController().userInformation.id,
    );
    Navigator.pop(context);
    if(status){
      showSnackBar(context: context, message: 'Added To Cart Successfully');
    }else{
      showSnackBar(context: context, message: 'Added To Cart Successfully');
    }
  }
}
