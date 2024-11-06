import 'package:air_ticket/common/bottom_nav_bar.dart';
import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/page/all_tickets/bloc/all_tickets_bloc.dart';
import 'package:air_ticket/page/all_tickets/card_tickets.dart';
import 'package:air_ticket/repository/data_repository.dart';
import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:air_ticket/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:get_it/get_it.dart';

class AllTicketsPage extends StatelessWidget {
  const AllTicketsPage(
      {super.key,
      required this.arrival,
      required this.departure,
      required this.date});

  final arrival;
  final departure;
  final date;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AllTicketsBloc(
              dataRepository: GetIt.I.get<DataRepository>(),
            ),
        child: AllTicketsView(
            arrival: arrival, departure: departure, date: date));
  }
}

class AllTicketsView extends StatefulWidget {
  const AllTicketsView(
      {super.key,
      required this.arrival,
      required this.departure,
      required this.date});

  final arrival;
  final departure;
  final date;

  @override
  State<AllTicketsView> createState() =>
      _AllTicketsViewState(arrival: arrival, departure: departure, date: date);
}

class _AllTicketsViewState extends State<AllTicketsView> {
  _AllTicketsViewState(
      {required this.arrival, required this.departure, required this.date});

  final arrival;
  final departure;
  final date;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<AllTicketsBloc>();
    bloc.add(AllTicketsTicketsLoadingStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.black,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: context.color.gery2),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgIcon(
                        icon: const SvgIconData("assets/icons/left_arrow.svg"),
                        color: context.color.blue,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 172,
                            child: Text('$departure - $arrival',
                                style: context.theme.title3
                                    .copyWith(color: context.color.white)),
                          ),
                          SizedBox(
                            width: 172,
                            child: Text(
                              '${formatterDDMM.format(date)}, 1 пассажир',
                              style: context.theme.text2
                                  .copyWith(color: context.color.grey6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: BlocBuilder<AllTicketsBloc, AllTicketsState>(
                  builder: (context, state) {
                    if (state.tickets != null) {
                      final tickets = state.tickets;
                      return Stack(
                        children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: tickets!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => CardTickets(
                                    ticket: tickets[index],
                                  )),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 203,
                              height: 37,
                              padding: const EdgeInsets.all(10),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: context.color.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgIcon(
                                        icon: const SvgIconData(
                                            'assets/icons/filter.svg'),
                                        color: context.color.white,
                                      ),
                                      const SizedBox(width: 4),
                                      Text('Фильтр',
                                          style: context.theme.title4.copyWith(
                                              color: context.color.white)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgIcon(
                                        icon: const SvgIconData(
                                            'assets/icons/graph.svg'),
                                        color: context.color.white,
                                      ),
                                      const SizedBox(width: 4),
                                      Text('График цен',
                                          style: context.theme.title4.copyWith(
                                              color: context.color.white)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      final tickets = List.generate(
                          10,
                          (index) => Ticket(
                                arrival: Place(
                                    town: "town",
                                    airport: "airport",
                                    date: DateTime.now()),
                                badge: 'badge',
                                provider_name: 'provider_name',
                                company: 'company',
                                departure: Place(
                                    town: "town",
                                    airport: "airport",
                                    date: DateTime.now()),
                                has_transfer: true,
                                has_visa_transfer: true,
                                id: 1,
                                luggage: Luggage(
                                    has_luggage: true,
                                    price: Price(value: 5000)),
                                hand_luggage: HardLuggage(
                                    hasHandLuggage: true, size: "51515"),
                                is_returnable: true,
                                is_exchangable: true,
                                price: Price(value: 8900),
                              ));
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: tickets.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => CardTickets(
                              ticket: tickets[index], skeletonize: true));
                    }
                  },
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
