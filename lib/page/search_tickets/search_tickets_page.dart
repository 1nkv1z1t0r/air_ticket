import 'package:air_ticket/common/bottom_nav_bar.dart';
import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/page/all_tickets/all_tickets.dart';
import 'package:air_ticket/page/filter/filter.dart';
import 'package:air_ticket/page/search_tickets/bloc/search_tickets_bloc.dart';
import 'package:air_ticket/page/search_tickets/ticket_offer_card.dart';
import 'package:air_ticket/repository/data_repository.dart';
import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:air_ticket/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:get_it/get_it.dart';

class SearchTicketsPage extends StatelessWidget {
  const SearchTicketsPage({
    super.key,
    required this.arrival,
    required this.departure,
  });

  final arrival;
  final departure;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SearchTicketsBloc(
              dataRepository: GetIt.I.get<DataRepository>(),
              context: context,
            ),
        child: SearchTicketsView(arrival: arrival, departure: departure));
  }
}

class SearchTicketsView extends StatefulWidget {
  const SearchTicketsView(
      {super.key, required this.departure, required this.arrival});

  final arrival;
  final departure;

  @override
  State<SearchTicketsView> createState() =>
      _SearchTicketsView(departure: departure, arrival: arrival);
}

class _SearchTicketsView extends State<SearchTicketsView> {
  _SearchTicketsView({required this.departure, required this.arrival});

  final arrival;
  final departure;
  final _departureController = TextEditingController();
  final _arrivalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _departureController.text = departure;
    _arrivalController.text = arrival;

    final bloc = context.read<SearchTicketsBloc>();
    bloc.add(SearchTicketsTicketsOffersLoadingStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.black,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: context.color.grey3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: SvgIcon(
                          icon:
                              const SvgIconData('assets/icons/left_arrow.svg'),
                          color: context.color.white),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                              controller: _departureController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[а-яА-Я]')),
                              ],
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: SvgIcon(
                                        icon: const SvgIconData(
                                            'assets/icons/change.svg'),
                                        color: context.color.white),
                                    onPressed: () {
                                      var arrivalText =
                                          _departureController.text;
                                      _departureController.text =
                                          _arrivalController.text;
                                      _arrivalController.text = arrivalText;
                                    },
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Откуда - Москва",
                                  hintStyle: context.theme.title3
                                      .copyWith(color: context.color.grey6)),
                              style: context.theme.title3
                                  .copyWith(color: context.color.white)),
                          Divider(color: context.color.grey6, endIndent: 16),
                          TextField(
                              controller: _arrivalController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[а-яА-Я]')),
                              ],
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _arrivalController.text = '';
                                    },
                                    icon: SvgIcon(
                                      icon: const SvgIconData(
                                          'assets/icons/close.svg'),
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
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<SearchTicketsBloc>()
                              .add(ReturnTicketSelectDateTappedEvent());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: context.color.grey3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: BlocBuilder<SearchTicketsBloc,
                              SearchTicketsState>(builder: (context, state) {
                            return state.returnTicketDate == null
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 2,
                                          right: 1.27,
                                          bottom: 1.27,
                                        ),
                                        child: SvgIcon(
                                          icon: const SvgIconData(
                                              'assets/icons/plus.svg'),
                                          color: context.color.grey7,
                                        ),
                                      ),
                                      Text(
                                        'обратно',
                                        style: context.theme.title4.copyWith(
                                            color: context.color.white),
                                      ),
                                    ],
                                  )
                                : Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: formatterDDMM
                                              .format(state.returnTicketDate!),
                                          style: context.theme.title4.copyWith(
                                              color: context.color.white),
                                        ),
                                        TextSpan(
                                          text: formatterEE
                                              .format(state.returnTicketDate!),
                                          style: context.theme.title4.copyWith(
                                              color: context.color.grey6),
                                        ),
                                      ],
                                    ),
                                  );
                          }),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<SearchTicketsBloc>()
                              .add(TicketSelectDateTappedEvent());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: context.color.grey3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: BlocBuilder<SearchTicketsBloc,
                              SearchTicketsState>(builder: (context, state) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: formatterDDMM
                                            .format(state.ticketDate),
                                        style: context.theme.title4.copyWith(
                                            color: context.color.white),
                                      ),
                                      TextSpan(
                                        text: formatterEE
                                            .format(state.ticketDate),
                                        style: context.theme.title4.copyWith(
                                            color: context.color.grey6),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: context.color.grey3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: SvgIcon(
                                icon: const SvgIconData(
                                    'assets/icons/person.svg'),
                                color: context.color.grey5,
                              ),
                            ),
                            Text(
                              '1,эконом',
                              style: context.theme.title4
                                  .copyWith(color: context.color.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FilterPage()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: context.color.grey3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.only(
                                    top: 3, left: 2, right: 2, bottom: 2),
                                child: SvgIcon(
                                  icon: const SvgIconData(
                                      'assets/icons/filter.svg'),
                                  color: context.color.white,
                                ),
                              ),
                              Text(
                                'фильтры',
                                style: context.theme.title4
                                    .copyWith(color: context.color.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 6,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: context.color.grey1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Прямые рейсы',
                        style: context.theme.title2
                            .copyWith(color: context.color.white)),
                    BlocBuilder<SearchTicketsBloc, SearchTicketsState>(
                      builder: (context, state) {
                        if (state.ticketsOffers != null) {
                          final ticketsOffers = state.ticketsOffers;
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 3,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => TicketOfferCard(
                                    index: index,
                                    ticketOffer: ticketsOffers![index],
                                  ));
                        } else {
                          final ticketsOffers = List.generate(
                              3,
                              (index) => TicketOffer(
                                      id: 1,
                                      title: 'Title',
                                      price: Price(value: 1000),
                                      time_range: [
                                        "dadada",
                                        "sdadasdasda",
                                        "dsadasda"
                                      ]));
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 3,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => TicketOfferCard(
                                    index: index,
                                    ticketOffer: ticketsOffers[index],
                                    skeletonize: true,
                                  ));
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 24),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: context.color.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => AllTicketsPage(
                                departure: _departureController.text,
                                arrival: _arrivalController.text,
                                date: context
                                    .read<SearchTicketsBloc>()
                                    .state
                                    .ticketDate,
                              )),
                      (route) => !(route.isFirst && route.isCurrent)),
                  child: Text('Посмотреть все билеты',
                      textAlign: TextAlign.center,
                      style: context.theme.title3
                          .copyWith(color: context.color.white)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 51,
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 16,
                  right: 8,
                  bottom: 11,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: context.color.grey3,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgIcon(
                              icon: const SvgIconData('assets/icons/bell.svg'),
                              color: context.color.blue,
                            ),
                          ),
                          Text('Подписка на цену',
                              style: context.theme.text1
                                  .copyWith(color: context.color.white)),
                        ],
                      ),
                    ),
                    Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentPageIndex: 0),
    );
  }
}
