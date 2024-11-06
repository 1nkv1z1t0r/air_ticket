import 'package:air_ticket/page/profile/profile.dart';
import 'package:air_ticket/page/subscriptions/subscription.dart';
import 'package:air_ticket/page/home/home_page.dart';
import 'package:air_ticket/page/hotels/hotels.dart';
import 'package:air_ticket/page/route/route.dart';
import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.currentPageIndex});

  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: context.color.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgIcon(icon: SvgIconData('assets/icons/air.svg')),
          activeIcon: SvgIcon(icon: SvgIconData('assets/icons/air.svg')),
          label: 'Авиабилеты',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(icon: SvgIconData('assets/icons/hotel.svg')),
          label: 'Отели',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(icon: SvgIconData('assets/icons/location.svg')),
          label: 'Короче',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(icon: SvgIconData('assets/icons/bell.svg')),
          label: 'Подписки',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(icon: SvgIconData('assets/icons/person.svg')),
          label: 'Профиль',
        ),
      ],
      currentIndex: currentPageIndex,
      selectedItemColor: context.color.blue,
      unselectedItemColor: context.color.grey6,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(pageBuilder: (_, __, ___) => const HomePage()),
                (route) => !(route.isFirst && route.isCurrent));
          case 1:
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(pageBuilder: (_, __, ___) => const HotelsPage()),
                    (route) => !(route.isFirst && route.isCurrent));
          case 2:
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(pageBuilder: (_, __, ___) => const RoutePage()),
                    (route) => !(route.isFirst && route.isCurrent));
          case 3:
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(pageBuilder: (_, __, ___) => const SubscriptionPage()),
                    (route) => !(route.isFirst && route.isCurrent));
          case 4:
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(pageBuilder: (_, __, ___) => const ProfilePage()),
                    (route) => !(route.isFirst && route.isCurrent));
          default:
            break;
        }
      }, // new
    );
  }
}
