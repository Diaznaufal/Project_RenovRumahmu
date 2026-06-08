import 'package:flutter/material.dart';
import '../../Features/StatusPesanan/Models/Timeline_Status.dart';

class RiwayatStatus extends StatelessWidget {
  final TimelineStatus status;
  final int index;
  final int currentStep;
  final bool isLast;

  const RiwayatStatus({
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
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? Color(0xff045097) : Colors.white,
                  border: Border.all(
                    color: isCompleted || isActive
                        ? Color(0xff045097)
                        : Colors.grey,
                    width: isActive ? 2 : 1,
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
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
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
                      fontFamily: "Inria Sans",
                      color: isPending ? Colors.grey : Colors.black,
                    ),
                  ),
                  SizedBox(height: 1),
                  if (status.subtitle != null)
                    Text(
                      status.subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Inria Sans",
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
