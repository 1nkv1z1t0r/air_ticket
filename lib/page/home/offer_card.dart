import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:air_ticket/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.isLast,
    required this.offer,
    this.skeletonize = false,
  });

  final bool isLast;
  final bool skeletonize;
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: skeletonize,
      child: Card(
        margin: EdgeInsets.only(
          left: 12,
          right: isLast ? 12 : 55,
        ),
        color: context.color.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 132,
              height: 133.16,
              decoration: ShapeDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/${offer.id}.png"),
                    fit: BoxFit.fill),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Text(offer.title,
                  style: context.theme.title3
                      .copyWith(color: context.color.white)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(offer.town,
                    style: context.theme.title4
                        .copyWith(color: context.color.white)),
                Row(
                  children: [
                    SvgIcon(
                        icon: const SvgIconData('assets/icons/air.svg'),
                        color: context.color.grey6),
                    Text(
                      'от ${offer.price.value.splitByThousands()} ₽ ',
                      style: context.theme.title4
                          .copyWith(color: context.color.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
