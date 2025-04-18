import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todotask/core/services/firebase_service.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../model/test_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

import '../../../onboarding/presentation/providers/onboarding_provider.dart';
import '../widgets/add_options_sheet.dart';
import '../widgets/bottom_sheets/custom_task_sheet.dart';

class HomeProvider extends ChangeNotifier {
  final AuthProvider authProvider;
  final FirebaseAuthService firebaseAuthService;
  bool _isLoading = false;
  int _selectedIndex = 0;
  String _selectedCategory = 'To-DO';
  bool _showAddOptions = false;
  String? selectedOption;
  GlobalKey flagKey = GlobalKey();
  String? selectedPriority;
  String? _selectedIcon;
  DateTime? _selectedDate;
  bool _is12HourFormat = true;
  DateTime _focusedDate = DateTime.now();
  DateTime _tempSelectedDate = DateTime.now();
  String _selectedTime = '10:30 AM';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<TaskModel> items = [];

  HomeProvider({
    required this.authProvider,
    required this.firebaseAuthService,
  });

  int get selectedIndex => _selectedIndex;
  String? get selectedIcon => _selectedIcon;
  String get selectedCategory => _selectedCategory;
  bool get showAddOptions => _showAddOptions;
  DateTime? get selectedDate => _selectedDate;
  bool get is12HourFormat => _is12HourFormat;
  DateTime get focusedDate => _focusedDate;
  DateTime get tempSelectedDate => _tempSelectedDate;
  String get selectedTime => _selectedTime;
  bool get isLoading => _isLoading;

  void changeTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void changeCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleAddOptions() {
    _showAddOptions = !_showAddOptions;
    notifyListeners();
  }

  void hideAddOptions() {
    if (_showAddOptions) {
      _showAddOptions = false;
      notifyListeners();
    }
  }

  void selectOption(BuildContext context, String option) {
    selectedOption = option;
    _showAddOptions = false;
    notifyListeners();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => CustomTaskSheet(selectedOption: selectedOption),
    );
  }

  void selectIcon(String iconName) {
    _selectedIcon = iconName;
    notifyListeners();
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _selectedDate = picked;
      selectIcon('calendar');
      notifyListeners();
    }
  }

  void toggleFormat(bool is12Hour) {
    _is12HourFormat = is12Hour;
    notifyListeners();
  }

  void updateTempSelectedDate(DateTime selectedDay, DateTime focusedDay) {
    _tempSelectedDate = selectedDay;
    _focusedDate = focusedDay;
    notifyListeners();
  }
  void confirmSelectedDate() {
    _selectedDate = _tempSelectedDate;
    notifyListeners();
  }

  void updateSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void showAddOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const AddOptionsSheet(),
    );
  }

  void showPriorityMenu(BuildContext context) {
    showPriorityMenu(context);
  }

  void showDueDatePicker(BuildContext context) {
    showDueDatePicker(context);
  }

  void showTimePickerSheet(BuildContext context) {
    showTimePickerSheet(context);
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await firebaseAuthService.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveTaskToFirestore() async {
    StorageService _storageService = StorageService();
    final hasloggedIn = await _storageService.getString('logged_in') ?? "";
    // if (_selectedDate == null || selectedPriority == null) return;
    final task = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      dueDate: _selectedDate!,
      time: _selectedTime,
      priority: selectedPriority!,
    );

    await FirebaseService.createOrUpdate(
        collection: "add_todo", docId: hasloggedIn, data: task.toMap());
  }

  // Add more methods for home page functionality here
  // For example:
  // - Create todo
  // - Update todo
  // - Delete todo
  // - Get todos
  
  // - Filter todos
  // etc.
}
