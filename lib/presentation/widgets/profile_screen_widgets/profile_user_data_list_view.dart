import 'package:todolistgsg/imports.dart';

class ProfileUserDataListView extends StatelessWidget {
  const ProfileUserDataListView({
    super.key,
    required this.userData,
    required this.userModelData,
  });

  final List userData;
  final List userModelData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //list view builder to build the list of user data
      itemCount: userData.length,
      itemBuilder: (context, index) {
        return UserItem(userData: userModelData[index], title: userData[index]);
      },
    );
  }
}
