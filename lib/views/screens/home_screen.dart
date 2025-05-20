import 'package:flutter/material.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/views/screens/search_screen.dart';
import 'package:mufreak/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'MuFreak',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            pageIndex = index;
          });
        },
        backgroundColor: backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.info, size: 30), label: 'AI',),
          BottomNavigationBarItem(icon: CustomIcon() , label: '',),
          BottomNavigationBarItem(icon: Icon(Icons.message, size: 30), label: 'Message',),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 30), label: 'Profile',),
        ],
        
      ),
      
      body: pages[pageIndex],
    );
  }
}
