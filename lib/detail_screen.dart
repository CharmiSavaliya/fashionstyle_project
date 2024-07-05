import 'package:fashion_project/Provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/cardview_model.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel product;

  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  String _selectedSize = "";

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);
    final isFavorite = favoriteModel.isFavorite(widget.product);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    widget.product.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          color: isFavorite ? Colors.brown : Colors.brown,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            favoriteModel.removeFavorite(widget.product);
                          } else {
                            favoriteModel.addFavorite(widget.product);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Female's Style",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.productname,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          widget.product.rating,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Product Details",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Select Size",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: ["S", "M", "L", "XL", "XXL", "XXXL"].map((size) {
                        final bool isSelected = _selectedSize == size;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSize = size;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.brown : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.brown),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Select Color : Brown",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [Colors.brown, Colors.black, Colors.white].map((color) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor: color,
                            radius: 15,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Total Price",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.price,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Add to cart functionality
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
