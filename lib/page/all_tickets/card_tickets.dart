import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/page/ticket/ticket.dart';
import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:air_ticket/utils.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardTickets extends StatelessWidget {
  const CardTickets(
      {super.key, this.skeletonize = false, required this.ticket});

  final bool skeletonize;
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: skeletonize,
      containersColor: context.color.white,
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TicketPage(
                      ticket: ticket,
                    ))),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: context.color.grey1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${ticket.price.value.splitByThousands()} ₽ ',
                      style: context.theme.title1
                          .copyWith(color: context.color.white)),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: ShapeDecoration(
                                color: context.color.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          formatterHHmm
                                              .format(ticket.departure.date),
                                          style: context.theme.text2.copyWith(
                                              color: context.color.white)),
                                      Text(ticket.departure.airport,
                                          style: context.theme.text2.copyWith(
                                              color: context.color.grey6)),
                                    ],
                                  ),
                                  Text(' - ',
                                      style: context.theme.text2.copyWith(
                                          color: context.color.grey6)),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          formatterHHmm.format(ticket.arrival.date),
                                          style: context.theme.text2.copyWith(
                                              color: context.color.white)),
                                      Text(ticket.arrival.airport,
                                          style: context.theme.text2.copyWith(
                                              color: context.color.grey6)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      "${differenceHHmm(ticket.arrival.date,ticket.departure.date)} в пути",
                                  style: context.theme.text2
                                      .copyWith(color: context.color.white)),
                              TextSpan(
                                  text: ticket.has_transfer ? ' /' : "",
                                  style: context.theme.text2
                                      .copyWith(color: context.color.grey6)),
                              TextSpan(
                                  text: ticket.has_transfer
                                      ? ' Без пересадок'
                                      : "",
                                  style: context.theme.text2
                                      .copyWith(color: context.color.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: 8,
              child: Visibility(
                visible: ticket.badge != null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: context.color.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    ticket.badge == null ? "" : ticket.badge!,
                    style: context.theme.text2
                        .copyWith(color: context.color.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
