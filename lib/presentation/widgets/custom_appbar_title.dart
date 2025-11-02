import 'package:todolistgsg/imports.dart';

class CustomAppbarTitle extends StatelessWidget {
  CustomAppbarTitle({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.blueGrey.shade200,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
