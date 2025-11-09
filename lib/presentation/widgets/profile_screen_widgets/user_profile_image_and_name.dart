import 'package:todolistgsg/imports.dart';

class UserProfileImageAndName extends StatelessWidget {
  const UserProfileImageAndName({
    super.key,
    required this.image,
    required this.user,
  });

  final String? image;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserProfileImage(image: image),
        const SizedBox(width: 10),
        Text(
          'Hello ${user!.firstName.toUpperCase()}',
          //  'Hello ${user!.username[0].toUpperCase()}${firstName?.split(username![0])}',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
