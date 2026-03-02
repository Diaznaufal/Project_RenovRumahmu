import 'package:flutter/material.dart';
import '../models/Order_status.dart';

class RiwayatStatus extends StatelessWidget {
  final OrderStatus status;
  final int index;
  final int currentStep;
  final bool isLast;

  RiwayatStatus({
    super.key,
    required this.status,
    required this.index,
    required this.currentStep,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = index < currentStep;
    final bool isActive = index == currentStep;
    final bool isPending = index > currentStep;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? Color(0xff045097) : Colors.white,
                  border: Border.all(
                    color: isCompleted || isActive
                        ? Color(0xff045097)
                        : Colors.grey,
                    width: isActive ? 3 : 2,
                  ),
                ),
                child: isCompleted
                    ? Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),

              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? Color(0xff045097) : Colors.grey,
                  ),
                ),
            ],
          ),

          SizedBox(width: 12),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.title,
                    style: TextStyle(
                      fontWeight: isCompleted
                          ? FontWeight.w600
                          : FontWeight.normal,
                      fontSize: 12,
                      color: isPending ? Colors.grey : Colors.black,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    status.subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: isPending ? Colors.grey : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
