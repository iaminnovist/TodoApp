import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todotask/features/home/presentation/widgets/bottom_sheets/time_picker_sheet.dart';
import '../../providers/home_provider.dart';
import '../menu/priority_menu.dart';
import 'due_date_picker.dart';

class CustomTaskSheet extends StatelessWidget {
  final String? selectedOption;

  const CustomTaskSheet({super.key, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeProvider>(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFD86628),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  selectedOption ?? 'New Task',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: controller.titleController,
                        decoration: const InputDecoration(
                          hintText: "eg : Meeting with client",
                          hintStyle: TextStyle(color: Color(0xFFADA4A5)),
                          border: InputBorder.none,
                        ),
                      ),
                      TextField(
                        controller: controller.descriptionController,
                        decoration: const InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(color: Color(0xFFADA4A5)),
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.selectIcon('calendar');
                              showDueDatePicker(context, controller);
                            },
                            child: Icon(
                              Icons.calendar_month_rounded,
                              color: controller.selectedIcon == 'calendar'
                                  ? const Color(0xFFD86628)
                                  : const Color(0xFFADA4A5),
                            ),
                          ),
                          const SizedBox(width: 18),
                          GestureDetector(
                            onTap: () {
                              controller.selectIcon('time');
                              showTimePickerSheet(context, controller);  
                            },
                            child: Icon(
                              Icons.access_time_filled,
                              color: controller.selectedIcon == 'time'
                                  ? const Color(0xFFD86628)
                                  : const Color(0xFFADA4A5),
                            ),
                          ),
                          const SizedBox(width: 18),
                          GestureDetector(
                            key: controller.flagKey,
                            onTap: () {
                              controller.selectIcon('flag');
                              showPriorityMenu(context, controller);
                            },
                            child: Icon(
                              Icons.flag,
                              color: controller.selectedIcon == 'flag'
                                  ? const Color(0xFFD86628)
                                  : const Color(0xFFADA4A5),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              controller.saveTaskToFirestore();
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.send,
                                color: Color(0xFFD86628)),
                          ),
                        ],
                      ),
                      const Divider(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
