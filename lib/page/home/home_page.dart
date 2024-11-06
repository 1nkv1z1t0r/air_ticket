import 'dart:async';

import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/page/home/bloc/home_bloc.dart';
import 'package:air_ticket/common/bottom_nav_bar.dart';
import 'package:air_ticket/page/home/offer_card.dart';
import 'package:air_ticket/page/search_shell/search_shell.dart';
import 'package:air_ticket/repository/data_repository.dart';
import 'package:air_ticket/repository/local_storage_repository.dart';
import 'package:air_ticket/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => HomeBloc(
              dataRepository: GetIt.I.get<DataRepository>(),
              localStorageRepository: GetIt.I.get<LocalStorageRepository>(),
            ),
        child: const HomeView());
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _departureController = TextEditingController();

  late final StreamSubscription<dynamic> _departureSubscription;

  bool _departureChangeFromBloc = false;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<HomeBloc>();

    // start loading offers on bloc creation
    bloc.add(HomeOffersLoadingStarted());

    _departureController.text = bloc.state.departure;
    _departureSubscription = bloc.stream.listen((state) {
      if (_departureController.text != state.departure) {
        _departureChangeFromBloc = true;
        _departureController.text = state.departure;
      }
    });

    _departureController.addListener(() {
      if (_departureChangeFromBloc) return;

      context
          .read<HomeBloc>()
          .add(HomeDepartureChanged(_departureController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.color.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 94, vertical: 28),
              child: Text(
                'Поиск дешевых авиабилетов',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    context.theme.title1.copyWith(color: context.color.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: context.color.grey3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: context.color.grey5,
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
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _onSearchShell(context,
                          departure: context.read<HomeBloc>().state.departure),
                      icon: SvgIcon(
                          icon: const SvgIconData('assets/icons/search.svg'),
                          color: context.color.black),
                    ),
                    Flexible(
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
                                  border: InputBorder.none,
                                  hintText: "Откуда - Москва",
                                  hintStyle: context.theme.title3
                                      .copyWith(color: context.color.grey6)),
                              style: context.theme.title3
                                  .copyWith(color: context.color.white)),
                          Divider(color: context.color.grey6, endIndent: 16),
                          TextField(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                _onSearchShell(context,
                                    departure: context
                                        .read<HomeBloc>()
                                        .state
                                        .departure);
                              },
                              decoration: InputDecoration(
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
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text('Музыкально отлететь',
                  style: context.theme.title1
                      .copyWith(color: context.color.white)),
            ),
            SizedBox(
              height: 220,
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.offers != null) {
                    final offers = state.offers!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: offers.length,
                      itemBuilder: (context, index) => OfferCard(
                        isLast: index == offers.length - 1,
                        offer: offers[index],
                      ),
                    );
                  } else {
                    final offers = List.generate(
                        3,
                        (index) => Offer(
                            id: 1,
                            title: 'Title',
                            town: 'Town',
                            price: Price(value: 1000)));
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: offers.length,
                      itemBuilder: (context, index) => OfferCard(
                        isLast: index == offers.length - 1,
                        offer: offers[index],
                        skeletonize: true,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentPageIndex: 0),
    );
  }

  @override
  void dispose() {
    _departureSubscription.cancel();
    _departureController.dispose();

    super.dispose();
  }

  void _onSearchShell(BuildContext context, {required String departure}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) => SearchShellPage(departure: departure));
  }
}
