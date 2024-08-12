import 'package:fashion_project/model/cardview_model.dart';
import 'package:fashion_project/screens/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final cartItems = cartModel.cartItems;

    Future<bool> showConfirmationBottomSheet(ProductModel product) async {
      final quantity = cartItems.firstWhere((item) => item['product'] == product)['quantity'];
      bool data = false;
      await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Remove from Cart?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Image.asset(product.image, height: 80, width: 80, fit: BoxFit.cover),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.productname,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  Text('Price: \$${product.price}', style: const TextStyle(fontSize: 14)),
                                  const Spacer(),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.remove, size: 16),
                                      onPressed: () {
                                        cartModel.decrementQuantity(product);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text('$quantity', style: const TextStyle(fontSize: 14)),
                                  const SizedBox(width: 5),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.brown[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add, size: 16, color: Colors.white),
                                      onPressed: () {
                                        cartModel.incrementQuantity(product);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            data = false;
                            Navigator.pop(context, false);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.brown),
                          ),
                          style: ElevatedButton.styleFrom(primary: Colors.grey),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            data = true;

                            Navigator.pop(context, true);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.brown),
                          child: const Text('Yes, Remove', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('CartScreen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.separated(
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final product = item['product'] as ProductModel;
                      final quantity = item['quantity'] as int;

                      return Dismissible(
                        key: Key(product.productname),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          bool data = await showConfirmationBottomSheet(product);
                          if (data) {
                            cartModel.removeItem(product);
                          }
                          return null;
                        },
                        onDismissed: (direction) async {},
                        background: Container(
                          color: const Color.fromARGB(255, 221, 177, 174),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                        child: ListTile(
                          leading: Image.asset(product.image),
                          title: Text(product.productname),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Price: ${product.price}'),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.remove, size: 15),
                                      onPressed: () {
                                        cartModel.decrementQuantity(product);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '$quantity',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.brown[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add, size: 15, color: Colors.white),
                                      onPressed: () {
                                        cartModel.incrementQuantity(product);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: cartItems.isEmpty
          ? const SizedBox.shrink()
          : Container(
              height: 350,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Promo Code',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                          },
                          child: const Text(
                            'Apply',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        const Text('Sub-total'),
                        const Spacer(),
                        Text('\$407.94'),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Delivery Fee'),
                        const Spacer(),
                        Text('\$25.00'),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Discount'),
                        const Spacer(),
                        Text('-35.00'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text('Total Cost'),
                        const Spacer(),
                        Text('\$397.94'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xff704F38),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(85),
                      ),
                      child: const Center(
                        child: Text(
                          "Proceed to Checkout",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
