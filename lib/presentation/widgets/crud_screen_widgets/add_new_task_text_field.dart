import 'package:todolistgsg/imports.dart';

class AddNewTaskTextField extends StatelessWidget {
  const AddNewTaskTextField({
    super.key,
    required TextEditingController taskController,
  }) : _taskController = taskController;

  final TextEditingController _taskController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _taskController,
      style: const TextStyle(fontSize: 15, color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: 'Add a new Task',
        hintStyle: const TextStyle(fontSize: 15, color: Colors.white54),
        filled: true,
        fillColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade200),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade200),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
