import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:air_ticket/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key, required this.ticket});

  final Ticket ticket;

  SvgIcon getSvgIcon(bool isAccept, BuildContext context) {
    return isAccept
        ? const SvgIcon(
            icon: SvgIconData("assets/icons/accept.svg",
                colorSource: SvgColorSource.specialColors),
          )
        : SvgIcon(
            icon: const SvgIconData('assets/icons/close.svg'),
            color: context.color.white,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.black,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: SvgIcon(
                        icon: const SvgIconData("assets/icons/left_arrow.svg"),
                        color: context.color.white,
                      )),
                  Row(
                    children: [
                      SizedBox(
                          width: 28,
                          height: 28,
                          child: SvgIcon(
                            icon: const SvgIconData(
                                "assets/icons/notification.svg"),
                            color: context.color.white,
                          )),
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: SvgIcon(
                          icon: const SvgIconData('assets/icons/share.svg'),
                          color: context.color.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: context.color.grey1,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text('Дешевый тариф',
                        style: context.theme.title3
                            .copyWith(color: context.color.white)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          getSvgIcon(
                              ticket.hand_luggage.hasHandLuggage, context),
                          Text(
                            'Ручная кладь 1х5 кг',
                            style: context.theme.text2
                                .copyWith(color: context.color.white),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: ticket.hand_luggage.hasHandLuggage,
                        child: Text(
                          '${ticket.hand_luggage.size} см',
                          style: context.theme.text2
                              .copyWith(color: context.color.grey5),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      getSvgIcon(ticket.luggage.has_luggage, context),
                      Text(
                        'Без багажа',
                        style: context.theme.text2
                            .copyWith(color: context.color.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      getSvgIcon(ticket.is_exchangable, context),
                      Text(
                        'Обмен платный',
                        style: context.theme.text2
                            .copyWith(color: context.color.white),
                      ),
                      const SvgIcon(
                        icon: SvgIconData('assets/icons/tooltip.svg',
                            colorSource: SvgColorSource.specialColors),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      getSvgIcon(ticket.is_returnable, context),
                      Text(
                        'Без возврата',
                        style: context.theme.text2
                            .copyWith(color: context.color.white),
                      ),
                      const SvgIcon(
                        icon: SvgIconData('assets/icons/tooltip.svg',
                            colorSource: SvgColorSource.specialColors),
                      ),
                    ],
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: context.color.gery2,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: context.color.grey4),
                            ),
                          ),
                          child: Visibility(
                            visible: !ticket.luggage.has_luggage,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Добавить багаж ',
                                        style: context.theme.text1.copyWith(
                                            color: context.color.white),
                                      ),
                                      TextSpan(
                                        text: ticket.luggage.has_luggage
                                            ? ""
                                            : '+ ${ticket.luggage.price!.value.splitByThousands()} ₽ ',
                                        style: context.theme.text1.copyWith(
                                            color: context.color.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(value: true, onChanged: (value) {}),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                'Изменить обмен или возврат',
                                style: context.theme.text1
                                    .copyWith(color: context.color.white),
                              ),
                              SizedBox(
                                height: 16,
                                width: 16,
                                child: SvgIcon(
                                  icon: const SvgIconData(
                                      'assets/icons/right_arrow.svg'),
                                  color: context.color.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ticket.departure.town} - ${ticket.arrival.town}',
                    style: context.theme.title3
                        .copyWith(color: context.color.white),
                  ),
                  Text(
                    '${differenceHHmm(ticket.arrival.date, ticket.departure.date)} в пути',
                    style: context.theme.title4
                        .copyWith(color: context.color.grey6),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: context.color.grey1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: OvalBorder(),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ticket.company,
                                  style: context.theme.title4
                                      .copyWith(color: context.color.white),
                                ),
                                SizedBox(
                                  width: 172,
                                  child: Text(
                                      '${differenceHHmm(ticket.arrival.date, ticket.departure.date)} в полете',
                                      style: context.theme.text2.copyWith(
                                          color: context.color.grey6)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: context.color.grey6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Подробнее',
                          style: context.theme.title4
                              .copyWith(color: context.color.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: ShapeDecoration(
                                  shape: OvalBorder(
                                    side: BorderSide(
                                        width: 5, color: context.color.grey6),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formatterHHmm
                                          .format(ticket.departure.date),
                                      style: context.theme.title4
                                          .copyWith(color: context.color.white),
                                    ),
                                    Text(
                                      formatterDDMM
                                              .format(ticket.departure.date) +
                                          formatterEE
                                              .format(ticket.departure.date),
                                      style: context.theme.title4
                                          .copyWith(color: context.color.grey6),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticket.departure.town,
                                    style: context.theme.title4
                                        .copyWith(color: context.color.white),
                                  ),
                                  Text(
                                    'Внуково, ${ticket.departure.airport}',
                                    style: context.theme.title4
                                        .copyWith(color: context.color.grey6),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 54,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: ShapeDecoration(
                                  shape: OvalBorder(
                                    side: BorderSide(
                                        width: 4, color: context.color.grey6),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formatterHHmm.format(ticket.arrival.date),
                                      style: context.theme.title4
                                          .copyWith(color: context.color.white),
                                    ),
                                    Text(
                                      formatterDDMM
                                              .format(ticket.arrival.date) +
                                          formatterEE
                                              .format(ticket.arrival.date),
                                      style: context.theme.title4
                                          .copyWith(color: context.color.grey6),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticket.arrival.town,
                                    style: context.theme.title4
                                        .copyWith(color: context.color.white),
                                  ),
                                  Text(
                                    'Адлер, ${ticket.arrival.airport}',
                                    style: context.theme.title4
                                        .copyWith(color: context.color.grey6),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 7,
                          top: 15,
                          child: Container(
                            width: 2,
                            height: 43,
                            decoration: BoxDecoration(
                              color: context.color.grey6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: context.color.grey4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 38,
                    height: 5,
                    decoration: ShapeDecoration(
                      color: context.color.grey5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: ShapeDecoration(
                              color: context.color.white,
                              shape: const OvalBorder(),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${ticket.price.value.splitByThousands()} ₽ ',
                                    style: context.theme.title2
                                        .copyWith(color: context.color.white)),
                                Text(ticket.provider_name,
                                    style: context.theme.text2
                                        .copyWith(color: context.color.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 6),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: context.color.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text('Купить',
                            textAlign: TextAlign.center,
                            style: context.theme.title3
                                .copyWith(color: context.color.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
