import 'package:flutter/material.dart';

class Lab03 extends StatefulWidget {
  @override
  Lab03State createState() {
    return Lab03State();
  }
}

class Lab03State extends State<Lab03> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [
    Text('1'),
    Text('2'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Видео',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Камера',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
