import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:air_ticket/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TicketOfferCard extends StatelessWidget {
  const TicketOfferCard(
      {super.key,
      required this.index,
      this.skeletonize = false,
      required this.ticketOffer});

  final int index;
  final bool skeletonize;
  final TicketOffer ticketOffer;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (index) {
      case 0:
        color = context.color.red;
      case 1:
        color = context.color.blue;
      case 2:
        color = context.color.white;
      default:
        color = context.color.white;
        break;
    }
    ;
    return Skeletonizer(
      enabled: skeletonize,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: context.color.grey4),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 4, 8, 0),
              width: 24,
              height: 24,
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  width: 257,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticketOffer.title,
                        style: context.theme.title4
                            .copyWith(color: context.color.white),
                      ),
                      Row(
                        children: [
                          Text(
                            '${ticketOffer.price.value.splitByThousands()} ₽ ',
                            textAlign: TextAlign.right,
                            style: context.theme.title4
                                .copyWith(color: context.color.blue),
                          ),
                          Container(
                            width: 16,
                            height: 16,
                            padding: const EdgeInsets.only(
                                top: 3, left: 2, right: 2, bottom: 2),
                            child: SvgIcon(
                              icon: const SvgIconData(
                                  'assets/icons/right_arrow.svg'),
                              color: context.color.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 257,
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    ticketOffer.time_range.join(' '),
                    style: context.theme.text2
                        .copyWith(color: context.color.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
