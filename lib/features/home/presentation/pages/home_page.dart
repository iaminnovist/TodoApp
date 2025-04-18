import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todotask/core/services/firebase_service.dart';
import 'package:todotask/core/services/storage_service.dart';
import 'package:todotask/core/services/user_singlton.dart';
import 'package:todotask/model/test_model.dart';
import '../providers/home_provider.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/task_button.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      //bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Today",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Mon 20 March 2024",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff767E8C),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 56,
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Color(0xffADA4A5)),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Task",
                              hintStyle: TextStyle(color: Color(0xffDDDADA)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const TaskTypeButton(text: "To-Do"),
                      const SizedBox(width: 9),
                      const TaskTypeButton(text: "Habit"),
                      const SizedBox(width: 9),
                      const TaskTypeButton(text: "Journal"),
                      const SizedBox(width: 9),
                      const TaskTypeButton(text: "Note"),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/img/Vector.png",
                          height: 25,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                  StreamBuilder<List<Map<String, dynamic>>>(
                    stream: FirebaseService().listenToUserById(
                        UserSession().userId ?? "", "add_todo"),
                    builder: (context, snapshot) {
                      if (snapshot.data?.isNotEmpty ?? false) {
                        final user = snapshot.data!;
                        return Expanded(
                            child: ListView.builder(
                          itemCount: user.length,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _buildNotificationCard(
                                TaskModel.fromJson(user[index]));
                          },
                        ));
                      } else {
                        return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset(
                              "assets/img/horrey.png",
                              height: 280,
                              fit: BoxFit.fill,
                            ));
                      }
                    },
                  ),
                ],
              ),
            ),

            if (homeProvider.showAddOptions)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 0.6,
                child: GestureDetector(
                  onTap: () => homeProvider.hideAddOptions(),
                  child: Container(
                    color: Colors.white70,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),

            // Floating menu options
            if (homeProvider.showAddOptions)
              Positioned(
                bottom: 100,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildOptionButton(context, homeProvider, "Setup Journal"),
                    _buildOptionButton(context, homeProvider, "Setup Habit"),
                    _buildOptionButton(context, homeProvider, "Add List"),
                    _buildOptionButton(context, homeProvider, "Add Note"),
                    _buildOptionButton(context, homeProvider, "Add Todo",
                        highlight: true),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            Positioned(
              bottom: 60,
              right: 20,
              child: GestureDetector(
                onTap: () => homeProvider.toggleAddOptions(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD86628),
                    borderRadius: BorderRadius.circular(
                        homeProvider.showAddOptions ? 12 : 28),
                  ),
                  child: Icon(
                    homeProvider.showAddOptions ? Icons.close : Icons.add,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(TaskModel taskData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: (taskData.priority == "Medium"
                    ? Color(0xffED9611)
                    : taskData.priority == "High"
                        ? Color(0xffEA4335)
                        : Color(0xff23A26D)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flag_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    taskData.priority,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    color: Colors.white,
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Color(0xFFD86628),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Color(0xFF1D1517),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Color(0xFF1D1517),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        final homeProvider =
                            Provider.of<HomeProvider>(context, listen: false);
                      } else if (value == 'delete') {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text('Delete Task'),
                            content: Text(
                                'Are you sure you want to delete this task?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  final homeProvider =
                                      Provider.of<HomeProvider>(context,
                                          listen: false);
                                  FirebaseService.deleteDocument(
                                      collection: "add_todo",
                                      docId: taskData.id ?? "");
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD86628).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: Color(0xFFD86628),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            taskData.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1D1517),
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 12,
                      //     vertical: 6,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: statusColor.withOpacity(0.1),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Text(
                      //     ,
                      //     style: TextStyle(
                      //       color: statusColor,
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    taskData.description,
                    style: const TextStyle(
                      color: Color(0xFF7B6F72),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Color(0xFF7B6F72),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        taskData.time,
                        style: const TextStyle(
                          color: Color(0xFF7B6F72),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        taskData.dueDate.toString(),
                        style: const TextStyle(
                          color: Color(0xFF7B6F72),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(
      BuildContext context, HomeProvider provider, String label,
      {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: highlight ? const Color(0xFFD86628) : Colors.white,
          foregroundColor: highlight ? Colors.white : const Color(0xFFD86628),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: highlight
                ? BorderSide.none
                : const BorderSide(color: Color(0xFFD86628)),
          ),
          elevation: 4,
          shadowColor: Colors.black26,
        ),
        onPressed: () {
          provider.selectOption(context, label);
        },
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
