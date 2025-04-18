import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';

void showTimePickerSheet(BuildContext context, HomeProvider controller) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Consumer<HomeProvider>(
        builder: (_, controller, __) {
          final times = ['09:30 AM', '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM', '12:00 PM'];

          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Text('Friday', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('Apr 18, 2024'),
                          ],
                        ),
                        ToggleButtons(
                          borderRadius: BorderRadius.circular(8),
                          isSelected: [controller.is12HourFormat, !controller.is12HourFormat],
                          onPressed: (index) {
                            controller.toggleFormat(index == 0);
                          },
                          constraints: const BoxConstraints(
                            minHeight: 30,
                          ),
                          selectedColor: Colors.white,
                          fillColor: const Color(0xFFEB5E00),
                          children: const [
                            Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('12h')),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('24h')),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(height: 18,thickness: 0.5,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.language, size: 18),
                      SizedBox(width: 8),
                      Text('Indian Standard Time (UTC+05:30)'),
                      Icon(Icons.expand_more),
                    ],
                  ),
                  const Divider(height: 18),
                  ...times.map((time) {
                    final selected = controller.selectedTime == time;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.updateSelectedTime(time),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: selected ? Colors.black87 : Color(0xFFF3F5F9),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Color(0xffD6DAE1))
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                alignment: Alignment.center,
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    color: selected ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (selected) ...[
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              decoration: BoxDecoration(color: Color(0xFFEB5E00), borderRadius: BorderRadius.circular(12)),
                              child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                            ),
                          ]
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F5F9),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            alignment: Alignment.center,
                            child: const Text("Back", style: TextStyle(color: Color(0xffEB5E00))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEB5E00),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            alignment: Alignment.center,
                            child: const Text("Next", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            ),
          );
        },
      );
    },
  );
}


