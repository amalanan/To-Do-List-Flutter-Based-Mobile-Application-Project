// bottom nav

import '../../../imports.dart';

class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  List screens = [
    DashboardScreen(),
    const TasksScreen(),
     CreateEditScreen(),
     ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      backgroundColor: Colors.blueGrey.shade200,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blueGrey.shade700,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home, size: 40),
            activeIcon: Icon(Icons.home_filled, size: 40),
          ),
          BottomNavigationBarItem(
            label: "Tasks",
            icon: Icon(Icons.task_outlined, size: 40),
            activeIcon: Icon(Icons.task, size: 40),
          ),
          BottomNavigationBarItem(
            label: "Create",
            icon: Icon(Icons.edit_outlined, size: 40),
            activeIcon: Icon(Icons.edit, size: 40),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person_outline, size: 40),
            activeIcon: Icon(Icons.person, size: 40),
          ),
        ],
      ),
    );
  }
}
