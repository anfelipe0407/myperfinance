import 'package:flutter/material.dart';
import 'package:myperfinance/screens/tabs/juego_tab.dart';
import 'package:myperfinance/screens/tabs/lecciones_tab.dart';
import 'tabs/presupuesto_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lista de las pantallas correspondientes a cada tab
  final List<Widget> _tabs = [
    PresupuestoTab(),
    LeccionesTab(),
    PuntajeYAvatarTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfinance'),
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Presupuesto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Lecciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mi mascota',
          ),
        ],
      ),
    );
  }
}
