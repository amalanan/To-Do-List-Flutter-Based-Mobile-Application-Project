import 'package:todolistgsg/imports.dart';

class ProfileScreenCircularProgressIndicator extends StatelessWidget {
  const ProfileScreenCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: CustomAppbarTitle(title: 'Profile'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: const [LogoutIcon()],
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ), // CircularProgressIndicator
    );
  }
}
