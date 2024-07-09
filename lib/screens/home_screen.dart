import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_project/Provider/favourite_provider.dart';
import 'package:fashion_project/detail_screen.dart';
import 'package:fashion_project/model/cardview_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  int _current = 0;
  int _selectedCategory = 0;
  final List<String> imgList = [
    'assets/image1.png',
    'assets/image2.jpeg',
    'assets/image3.png',
  ];
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool('seen') ?? false;
    print('Seen: $seen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 10),
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
      ),
    );
  }

  Widget topbar({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Location",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
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
          child: SizedBox(
            width: 325,
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
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "Search",
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.brown),
                ),
                isDense: true,
              ),
            ),
          ),
        ),
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
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(item, fit: BoxFit.cover, width: MediaQuery.of(context).size.width * 0.9),
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

    return Column(
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
              style: TextStyle(fontSize: 16, color: Colors.brown),
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
        Row(
          children: [
            const Text(
              'Flash Sale',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const Spacer(),
            const Text(
              'Closing in : ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SlideCountdownSeparated(
              duration: const Duration(
                hours: 5,
              ),
              slideDirection: SlideDirection.down,
              onDone: () {},
              separator: ':',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown),
              decoration: BoxDecoration(
                color: const Color(0xffF7F2Ed),
                borderRadius: BorderRadius.circular(5),
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
                    _selectedCategory = index;
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
                    color: selected == index ? Colors.brown : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      items[index],
                      style: TextStyle(
                        color: selected == index ? Colors.white : Colors.black,
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
    );
  }

  Widget _buildCategoryItem(String iconPath, String label) {
    return GestureDetector(
      onTap: () {
        switch (label) {
          case 'T-shirt':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TShirtScreen()),
            );
            break;
          case 'Pants':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PantsScreen()),
            );
            break;
          case 'Jacket':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JacketScreen()),
            );
            break;
          case 'Dress':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DressScreen()),
            );
            break;

          default:
            break;
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: const Color(0xffF7F2Ed),
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
      ),
    );
  }

  Widget cardView() {
    List<ProductModel> productList = [];

    // Filter products based on selected category
    if (_selectedCategory != 0) {
      String selectedCategoryName = categoryList.firstWhere((category) => category.index == _selectedCategory).name;
      print('Selected Category: $selectedCategoryName');
      productList = productAll.where((product) {
        bool matchesCategory = product.category == selectedCategoryName;
        print('Product: ${product.productname}, Category: ${product.category}, Matches: $matchesCategory');
        return matchesCategory;
      }).toList();
    } else {
      productList = List.from(productAll);
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
        childAspectRatio: (65 / 80),
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
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 160,
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
                                const SizedBox(width: 33),
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

class TShirtScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T-shirt Screen'),
      ),
      body: const Center(
        child: Text('T-shirt Screen Content'),
      ),
    );
  }
}

class PantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pants Screen'),
      ),
      body: const Center(
        child: Text('Pants Screen Content'),
      ),
    );
  }
}

class JacketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jacket Screen'),
      ),
      body: const Center(
        child: Text('Jacket Screen Content'),
      ),
    );
  }
}

class DressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dress Screen'),
      ),
      body: const Center(
        child: Text('Dress Screen Content'),
      ),
    );
  }
}
