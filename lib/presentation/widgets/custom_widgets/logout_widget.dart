import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistgsg/imports.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (_) => Dialog(
          backgroundColor: Colors.blueGrey.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.logout, color: Colors.white, size: 36),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.blueGrey.shade100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        //logout the user
                        context
                            .read<AuthCubit>()
                            .logout(); // CALLING THE LOGOUT METHOD FROM THE AUTH CUBIT
                        Navigator.pop(context); //close the dialog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
  );
}
