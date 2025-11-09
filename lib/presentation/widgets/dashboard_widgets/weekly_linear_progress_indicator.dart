import 'package:todolistgsg/imports.dart';

class WeeklyLinearProgressIndicator extends StatelessWidget {
  const WeeklyLinearProgressIndicator({
    super.key,
    required this.completedCount,
    required this.pendingCount,
  });

  final int completedCount;
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weekly Progress',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          //linear progress indicator to show the weekly progress
          value:
              completedCount + pendingCount == 0
                  ? 0 //if there are no tasks, the progress is 0
                  : completedCount / (completedCount + pendingCount),
          //if there are tasks, the progress is the completed tasks divided by the total tasks
          color: Colors.black,
          backgroundColor: Colors.grey.shade400,
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
