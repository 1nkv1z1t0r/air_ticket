import 'package:air_ticket/page/difficult_route/difficult_route.dart';
import 'package:air_ticket/page/hot_tickets/hot_tickets.dart';
import 'package:air_ticket/page/search_tickets/search_tickets_page.dart';
import 'package:air_ticket/page/weekend/weekend.dart';
import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

class SearchShellPage extends StatefulWidget {
  const SearchShellPage({super.key, required this.departure});

  final departure;

  @override
  State<SearchShellPage> createState() =>
      _SearchShellPageState(departure: departure);
}

class _SearchShellPageState extends State<SearchShellPage> {
  _SearchShellPageState({required this.departure});

  final departure;
  final _departureController = TextEditingController();
  final _arrivalController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _departureController.text = departure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.90,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: context.color.grey3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: 38,
              height: 5,
              decoration: ShapeDecoration(
                color: context.color.grey5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: context.color.grey4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: [
                  BoxShadow(
                    color: context.color.grey3,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      controller: _departureController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[а-яА-Я]')),
                      ],
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: SvgIcon(
                            icon:
                                const SvgIconData('assets/icons/air_plane.svg'),
                            color: context.color.grey6,
                          ),
                          hintText: "Откуда - Москва",
                          hintStyle: context.theme.title3
                              .copyWith(color: context.color.grey6)),
                      style: context.theme.title3
                          .copyWith(color: context.color.white)),
                  Divider(color: context.color.grey6),
                  TextField(
                      controller: _arrivalController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[а-яА-Я]')),
                      ],
                      decoration: InputDecoration(
                          icon: SvgIcon(
                            icon: const SvgIconData('assets/icons/search.svg'),
                            color: context.color.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _arrivalController.text = '';
                            },
                            icon: SvgIcon(
                              icon: const SvgIconData('assets/icons/close.svg'),
                              color: context.color.grey7,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: "Куда - Турция",
                          hintStyle: context.theme.title3
                              .copyWith(color: context.color.grey6)),
                      style: context.theme.title3
                          .copyWith(color: context.color.white)),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _hotButton(
                  context,
                  icon: 'assets/icons/route.svg',
                  color: context.color.green,
                  textButton: 'Сложный маршрут',
                ),
                _hotButton(
                  context,
                  icon: 'assets/icons/ball.svg',
                  color: context.color.blue,
                  textButton: 'Куда угодно',
                ),
                _hotButton(
                  context,
                  icon: 'assets/icons/calendar.svg',
                  color: context.color.darkBlue,
                  textButton: 'Выходные',
                ),
                _hotButton(
                  context,
                  icon: 'assets/icons/fire.svg',
                  color: context.color.red,
                  textButton: 'Горячие билеты',
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: context.color.grey4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardPopularDestination(context,
                      image: "assets/images/istanbul.png", town: 'Стамбул'),
                  _cardPopularDestination(context,
                      image: "assets/images/sochi.png", town: 'Сочи'),
                  _cardPopularDestination(context,
                      image: "assets/images/phuket.png", town: 'Пхукеt'),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _cardPopularDestination(BuildContext context,
      {required String image, required String town}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _arrivalController.text = town;
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => SearchTicketsPage(
                      arrival: _arrivalController.text,
                      departure: _departureController.text,
                    )),
            (route) => !(route.isFirst && route.isCurrent));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: context.color.grey5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 8, 8),
              width: 40,
              height: 40,
              decoration: ShapeDecoration(
                image:
                    DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  town,
                  style:
                      context.theme.title3.copyWith(color: context.color.white),
                ),
                Text(
                  'Популярное направление',
                  style:
                      context.theme.text2.copyWith(color: context.color.grey5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _hotButton(BuildContext context,
      {required String icon,
      required Color color,
      required String textButton}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        switch (textButton) {
          case 'Сложный маршрут':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DifficultRoutePage()));
          case 'Куда угодно':
            _arrivalController.text = "Куда угодно";
          case 'Выходные':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WeekendPage()));
          case 'Горячие билеты':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HotTicketsPage()));
          default:
            break;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: SvgIcon(
                icon: SvgIconData(icon),
                color: context.color.white,
              )),
          SizedBox(
            width: 79,
            child: Text(textButton,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    context.theme.title4.copyWith(color: context.color.white)),
          ),
        ],
      ),
    );
  }
}
