import 'package:fashion_project/model/bottom_data_model.dart';
import 'package:fashion_project/profile_screen.dart';
import 'package:fashion_project/screens/cart_screen.dart';
import 'package:fashion_project/screens/chat_screen.dart';
import 'package:fashion_project/screens/favourite_screen.dart';
import 'package:fashion_project/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationbarScreen extends StatefulWidget {
  const BottomNavigationbarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationbarScreen> createState() => _BottomNavigationbarScreenState();
}

class _BottomNavigationbarScreenState extends State<BottomNavigationbarScreen> {
  int currentIndex = 0;

  List screens = const [
    HomeScreen(),
    CartScreen(),
    FavouriteScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  List<BottomDataModel> bottomDataList = [
    BottomDataModel(icon: Icons.home, indextext: 0),
    BottomDataModel(icon: Icons.shopping_cart, indextext: 1),
    BottomDataModel(icon: Icons.favorite, indextext: 2),
    BottomDataModel(icon: Icons.chat, indextext: 3),
    BottomDataModel(icon: Icons.person, indextext: 4),
  ];

  void _onitemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: screens[currentIndex],
      bottomNavigationBar: ClipRRect(
        child: BottomAppBar(
          elevation: 8, 
          child: Container(
            height: 70, 
            width: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50), 
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                bottomDataList.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      _onitemTapped(index);
                    },
                    child: InkWell(
                      onTap: () {
                        _onitemTapped(bottomDataList[index].indextext);
                      },
                      child: Container(
                        width: 45,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: bottomDataList[index].indextext == currentIndex ? Colors.white : Colors.transparent,
                        ),
                        child: Icon(
                          bottomDataList[index].icon,
                          size: 30,
                          color: bottomDataList[index].indextext == currentIndex
                              ? const Color.fromARGB(255, 139, 69, 19)
                              : const Color.fromARGB(255, 207, 204, 204),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
