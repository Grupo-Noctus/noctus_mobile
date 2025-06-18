import 'package:flutter/material.dart';

class LessonItem extends StatelessWidget {
  final String title;
  final String duration;
  final bool isCurrent;
  final bool isDisabled;

  const LessonItem({
    required this.title,
    required this.duration,
    this.isCurrent = false,
    this.isDisabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isCurrent ? Colors.blue : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.play_arrow,
              color: isCurrent ? Colors.white : Colors.blue,
              size: 28,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(duration, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.green, size: 35),
        ],
      ),
    );

    return isDisabled ? Opacity(opacity: 0.2, child: content) : content;
  }
}
