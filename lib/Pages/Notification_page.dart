import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Notifikasi_Model.dart';
import 'package:flutter_application_1/widgets/Notifikasi_Widget.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  final List<NotifikasiModel> _notifs = [
    NotifikasiModel(
      id: "1",
      icon: CupertinoIcons.cart,
      iconBg: const Color(0xFFE46802),
      title: "Payment Successful",
      subtitle: "Your payment has been completed.",
      time: "5m",
      isNew: true,
    ),
    NotifikasiModel(
      id: "2",
      icon: CupertinoIcons.heart_fill,
      iconBg: Colors.red,
      title: "Flash Sale Alert!",
      subtitle: "Don't miss 50% off all items today!",
      time: "10m",
      isNew: false,
    ),
    NotifikasiModel(
      id: "3",
      icon: CupertinoIcons.bell,
      iconBg: Colors.orangeAccent,
      title: "Update Available",
      subtitle: "A new version is now available.",
      time: "30m",
      isNew: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003466),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NotifikasiButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),

                  InkWell(
                    onTap: () {
                      setState(() {
                        _notifs.clear();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xfff5f9fd),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: _notifs.isEmpty
                  ? Center(
                      child: Text(
                        "No Notifications",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(bottom: 20),
                      itemCount: _notifs.length,
                      itemBuilder: (context, index) {
                        final item = _notifs[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 6,
                          ),
                          child: Dismissible(
                            key: ValueKey(item.id),
                            direction: DismissDirection.endToStart,

                            confirmDismiss: (direction) async {
                              return true;
                            },

                            onDismissed: (direction) {
                              setState(() {
                                _notifs.removeWhere((e) => e.id == item.id);
                              });
                            },

                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),

                            child: notifikasiCard(notif: item),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
