import 'dart:async';
import 'package:flutter/material.dart';

class BannerIklan extends StatefulWidget {
  final List<String> images;
  final double height;

  const BannerIklan({super.key, required this.images, this.height = 160});

  @override
  State<BannerIklan> createState() => _AutoBannerSliderState();
}

class _AutoBannerSliderState extends State<BannerIklan> {
  late PageController _controller;
  late List<String> _images;
  int _currentPage = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Tambah gambar pertama di akhir & terakhir di awal
    _images = [widget.images.last, ...widget.images, widget.images.first];

    _controller = PageController(initialPage: 1);

    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      _currentPage++;

      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _handlePageChanged(int index) {
    if (index == _images.length - 1) {
      // kalau sampai clone terakhir
      Future.delayed(Duration(milliseconds: 300), () {
        _controller.jumpToPage(1);
      });
      _currentPage = 1;
    } else if (index == 0) {
      // kalau sampai clone pertama
      Future.delayed(Duration(milliseconds: 300), () {
        _controller.jumpToPage(_images.length - 2);
      });
      _currentPage = _images.length - 2;
    } else {
      _currentPage = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
        onPageChanged: _handlePageChanged,
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              _images[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
