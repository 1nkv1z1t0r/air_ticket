import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 328,
                  height: 40,
                  margin: const EdgeInsets.all(16),
                  color: context.color.gery2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          width: 24,
                          height: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: SvgIcon(
                            icon: const SvgIconData('assets/icons/close.svg'),
                            color: context.color.grey7,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        child: Text(
                          'Фильтры',
                          style: context.theme.title2
                              .copyWith(color: context.color.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  width: 172,
                  child: Text('Пересадки',
                      style: context.theme.title3
                          .copyWith(color: context.color.white)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: 328,
                  height: 141,
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 16,
                    right: 8,
                    bottom: 0,
                  ),
                  color: context.color.gery2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Без пересадок',
                        style: context.theme.text1
                            .copyWith(color: context.color.white),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  width: 328,
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 16,
                    right: 8,
                    bottom: 10,
                  ),
                  color: context.color.gery2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Только с багажом',
                        style: context.theme.text1
                            .copyWith(color: context.color.white),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 328,
                height: 48,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                padding: const EdgeInsets.only(top: 14, bottom: 13),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: context.color.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'Готово',
                  textAlign: TextAlign.center,
                  style:
                      context.theme.title3.copyWith(color: context.color.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
