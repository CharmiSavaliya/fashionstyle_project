import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_project/Provider/favourite_provider.dart';
import 'package:fashion_project/detail_screen.dart';
import 'package:fashion_project/model/cardview_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int seletected = 0;
  int _current = 0;
  int _selectedCategory = 0;
  final List<String> imgList = [
    'assets/image1.png',
    'assets/image2.jpeg',
    'assets/image3.png',
  ];
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              topbar(context: context),
              search(),
              const SizedBox(height: 10),
              shoppingCard(),
              category(),
              const SizedBox(height: 15),
              cardView(),
              const SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }

  Widget topbar({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Location",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/location.svg',
                    width: 30,
                    height: 30,
                    colorFilter: const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "New York, USA",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[200],
                child: Stack(
                  children: [
                    const Icon(Icons.notifications, color: Colors.black),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: const Text(
                          '5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget search() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 330,
            height: 42,
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/search.svg',
                    width: 24.0,
                    height: 24.0,
                    colorFilter: const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                    fit: BoxFit.contain,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "Search",
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                isDense: true,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown,
            child: SvgPicture.asset(
              'assets/filter.svg',
              width: 20.0,
              height: 20.0,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }

  Widget shoppingCard() {
    return Column(
      children: [
        CarouselSlider(
          items: imgList
              .map((item) => ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Center(
                      child: Image.asset(item, fit: BoxFit.cover, width: MediaQuery.of(context).size.width * 0.8),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: false,
            aspectRatio: 2.0,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? const Color.fromRGBO(0, 0, 0, 0.9) : const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget category() {
    List<String> items = ['All', 'Newest', 'Popular', 'Men', 'Women'];
    int selected = _selectedCategory; 

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Row(
            children: [
              Text(
                'Category',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                'See All',
                style: TextStyle(fontSize: 20, color: Colors.brown),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryItem('assets/tshirt.svg', 'T-shirt'),
                const SizedBox(width: 20),
                _buildCategoryItem('assets/pant.svg', 'Pants'),
                const SizedBox(width: 20),
                _buildCategoryItem('assets/jacket.svg', 'Jacket'),
                const SizedBox(width: 20),
                _buildCategoryItem('assets/dress.svg', 'Dress'),
                const SizedBox(width: 20),
                _buildCategoryItem('assets/pant.svg', 'Pants'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Text(
                'Flash Sale',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 35,
            width: double.infinity,
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCategory = index; // Update selected category
                    });
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      border: Border.all(
                        color: selected != index ? const Color(0xffD0D5DD) : Colors.transparent,
                        width: 1.1,
                      ),
                      color: selected == index ? Colors.brown : Colors.transparent, // Changed selected color to brown
                    ),
                    child: Center(
                      child: Text(
                        items[index],
                        style: TextStyle(
                          color:
                              selected == index ? Colors.white : Colors.black, // Text color change based on selection
                          fontSize: 16,
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
    );
  }

  Widget _buildCategoryItem(String iconPath, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.brown[100],
          child: SvgPicture.asset(
            iconPath,
            width: 30,
            height: 30,
            colorFilter: const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
          ),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }

  Widget cardView() {
    List<ProductModel> productList = [];
    if (seletected != 0) {
      productList.addAll(productAll.where((element) => element.categoryId == seletected).toList());
    } else {
      productList.addAll(productAll);
    }
    // Filter products based on search query
    if (searchQuery.isNotEmpty) {
      productList = productList.where((product) {
        return product.productname.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (65 / 75),
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        final favoriteModel = Provider.of<FavoriteModel>(context);
        final isFavorite = favoriteModel.isFavorite(product);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(product: product),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover, // Ensure the image covers the entire area
                        width: double.infinity, // Expand to fill available width
                        height: 150, // Adjust height as needed
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  product.productname,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                Text(
                                  product.rating,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Text(
                              product.price,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                  right: 5,
                  top: 10,
                  child: GestureDetector(
                    onTap: () {
                      if (isFavorite) {
                        favoriteModel.removeFavorite(product);
                      } else {
                        favoriteModel.addFavorite(product);
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
