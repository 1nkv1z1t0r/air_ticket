import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

class PageDummy extends StatelessWidget {
  const PageDummy({super.key, required this.pageTitle});

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgIcon(
            icon: const SvgIconData('assets/icons/left_arrow.svg'),
            color: context.color.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(pageTitle),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Page Placeholder'),
      ),
    );
  }
}
