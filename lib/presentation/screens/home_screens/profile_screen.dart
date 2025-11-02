import 'package:todolistgsg/imports.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, this.name});

  String? name;

  @override
  Widget build(BuildContext context) {
    name = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: CustomAppbarTitle(title: 'Profile'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [LogoutIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
              child: Container(
                color: Colors.black,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                      vertical: 2,
                    ),
                    child: Image.asset(
                      'assets/images/person.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Text(
                    name ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${DateTime.now()}',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('', style: TextStyle(fontSize: 22)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
