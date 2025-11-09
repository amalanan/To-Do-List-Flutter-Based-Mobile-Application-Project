import 'package:todolistgsg/imports.dart';

class DasboardScreenColumn extends StatelessWidget {
  const DasboardScreenColumn({
    super.key,
    required this.firstName,
    required this.completedCount,
    required this.pendingCount,
    required this.pendingTasks,
  });

  final String firstName;
  final int completedCount;
  final int pendingCount;
  final List<TaskModel> pendingTasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //  'Hello ${userId ?? 'Guest'}',
              'Hello ${firstName.toUpperCase()}',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'What Tasks Do You have Today?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              //grid view to show the completed and pending tasks
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                BuildStatusCard(
                  //build status card to show the completed and pending tasks
                  title: 'Completed',
                  value: '$completedCount',
                  color: Colors.blueGrey.shade800,
                ),
                BuildStatusCard(
                  //build status card to show the completed and pending tasks
                  title: 'Pending',
                  value: '$pendingCount',
                  color: Colors.blueGrey.shade700,
                ),
              ],
            ),
            const SizedBox(height: 25),
            TodaysTasks(pendingTasks: pendingTasks),
            //todays tasks to show the pending tasks
            const SizedBox(height: 25),
            WeeklyLinearProgressIndicator(
              //weekly linear progress indicator to show the weekly progress
              completedCount: completedCount,
              pendingCount: pendingCount,
            ),
            const SizedBox(height: 20),
            MotivationMessage(
              title: '"Small steps every day lead to big results."',
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
