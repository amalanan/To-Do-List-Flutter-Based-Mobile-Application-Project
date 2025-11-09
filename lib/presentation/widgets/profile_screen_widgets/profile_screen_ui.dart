import 'package:todolistgsg/imports.dart';

class ProfileScreenUI extends StatelessWidget {
  const ProfileScreenUI({
    super.key,
    required this.image,
    required this.user,
    required this.userData,
    required this.userModelData,
  });

  final String? image;
  final UserModel? user;
  final List userData;
  final List userModelData;

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            UserProfileImageAndName(image: image, user: user),
            //user profile image and name
            const SizedBox(height: 20),
            Expanded(
              child: ProfileUserDataListView(
                userData: userData,
                userModelData: userModelData,
              ),
            ),
            //user data list view
            // const SizedBox(height: 10),
            MotivationMessage(
              title: "People couldn\'t believe what I've become💗",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
