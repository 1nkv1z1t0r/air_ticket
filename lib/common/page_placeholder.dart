import 'package:air_ticket/common/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class PagePlaceholder extends StatelessWidget {
  const PagePlaceholder({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Page Placeholder'),
      ),
      bottomNavigationBar: BottomNavBar(currentPageIndex: pageIndex),
    );
  }
}
