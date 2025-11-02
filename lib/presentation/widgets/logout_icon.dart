import 'package:todolistgsg/imports.dart';

class LogoutIcon extends StatelessWidget {
  const LogoutIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showLogoutDialog(context);
      },
      child: Icon(Icons.logout, size: 36, color: Colors.blueGrey.shade200),
    );
  }
}
