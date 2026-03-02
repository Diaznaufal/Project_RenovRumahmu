import 'package:flutter/material.dart';

class CaraBayar extends StatelessWidget {
  final String title;
  final String content;
  final bool isOpen;
  final VoidCallback onTap;

  const CaraBayar({
    super.key,
    required this.title,
    required this.content,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(44),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isOpen ? Color(0xff045097) : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          if (isOpen)
            Padding(
              padding: const EdgeInsets.fromLTRB(23, 0, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildSteps(content),
              ),
            ),
        ],
      ),
    );
  }
}

List<Widget> _buildSteps(String content) {
  final lines = content.split("\n");

  return lines.map((line) {
    final parts = line.split(". ");
    if (parts.length < 2) {
      return Text(line);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${parts[0]}. ",
            style: const TextStyle(fontSize: 13, height: 1.2),
          ),
          Expanded(
            child: Text(
              parts[1],
              style: const TextStyle(fontSize: 13, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }).toList();
}
