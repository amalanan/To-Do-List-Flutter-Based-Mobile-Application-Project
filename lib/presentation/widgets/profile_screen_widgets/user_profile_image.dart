import 'package:todolistgsg/imports.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({super.key, required this.image});

  final String? image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.black,
      child:
          image != null && image!.isNotEmpty
              ? Image.network(image!)
              : Image.asset(
                'assets/images/person.jpg',
              ), //if the image is null or empty it will show the person image
    );
  }
}
