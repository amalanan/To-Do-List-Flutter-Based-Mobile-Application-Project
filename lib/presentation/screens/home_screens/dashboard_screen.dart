// dashboard
import 'package:todolistgsg/imports.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key, this.name});

  String? name;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    String? v = ModalRoute.of(context)!.settings.arguments as String?;
    String z = v?.toUpperCase() ?? '';
    widget.name = z.replaceAll('@GMAIL.COM', '');

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: CustomAppbarTitle(title: 'Home'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: const [LogoutIcon()],
      ),
      /*  floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Task',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.createEdit);
        },
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ${widget.name ?? 'Guest'}',
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
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildStatusCard('Completed', '12', Colors.blueGrey.shade800),
                  _buildStatusCard('Pending', '5', Colors.blueGrey.shade700),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "Today's Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TaskItem(
                taskModel: TaskModel(
                  taskName: 'Finish project report',
                  taskCompleted: true,
                ),
              ),
              TaskItem(
                taskModel: TaskModel(
                  taskName: 'Buy groceries',
                  taskCompleted: false,
                ),
              ),
              TaskItem(
                taskModel: TaskModel(taskName: 'Workout', taskCompleted: false),
              ),

              const SizedBox(height: 25),
              const Text(
                'Weekly Progress',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.6,
                color: Colors.black,
                backgroundColor: Colors.grey.shade400,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  '"Small steps every day lead to big results."',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
