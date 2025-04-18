import 'package:flutter/material.dart';

class AddOptionsSheet extends StatelessWidget {
  const AddOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption('Setup Journal', () => Navigator.pop(context)),
          _buildOption('Setup Habit', () => Navigator.pop(context)),
          _buildOption('Add List', () => Navigator.pop(context)),
          _buildOption('Add Note', () => Navigator.pop(context)),
          _buildOption(
            'Add Todo',
                () => Navigator.pop(context),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String text, VoidCallback onTap,
      {Color? color, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: color == null
                ? Border.all(color: Colors.grey[300]!)
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor ?? const Color(0xFF1D1517),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
