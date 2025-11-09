import 'package:todolistgsg/imports.dart';

class StatsCardsGridView extends StatelessWidget {
  const StatsCardsGridView({
    super.key,
    required this.completedCount,
    required this.pendingCount,
  });

  final int completedCount;
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        BuildStatusCard(
          title: 'Completed',
          value: '$completedCount',
          color: Colors.blueGrey.shade800,
        ),
        BuildStatusCard(
          title: 'Pending',
          value: '$pendingCount',
          color: Colors.blueGrey.shade700,
        ),
      ],
    );
  }
}
