enum OrderType { material, project }

class OrderHistory {
  final String id;
  final OrderType type;
  final String title;
  final DateTime date;
  final String status;
  final int? totalPrice; // material 
  final int? progress; // project 

  OrderHistory({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    required this.status,
    this.totalPrice,
    this.progress,
  });
}
