// bottom nav

import '../../../imports.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0; // controls the index of the current screen

  List screens = [
    //list of screens
    DashboardScreen(),
    TasksScreen(),
    CreateEditScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex], // the current screen
      backgroundColor: Colors.blueGrey.shade200,
      bottomNavigationBar: BottomNavigationBar(
        // bottom navigation bar
        currentIndex: currentIndex,
        // the current index of the screen
        selectedItemColor: Colors.blueGrey.shade700,
        // the selected item color
        unselectedItemColor: Colors.grey,
        //the unselected item color
        onTap: (value) {
          setState(() {
            // changing the state of the screen
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            // bottom navigation bar items
            label: "Home", // the label of the item
            icon: Icon(Icons.home, size: 40), // the icon of the item
            activeIcon: Icon(
              Icons.home_filled,
              size: 40,
            ), // the active icon of the item
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
