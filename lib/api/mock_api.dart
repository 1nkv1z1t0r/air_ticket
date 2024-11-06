import 'package:air_ticket/api/api.dart';
import 'package:air_ticket/model/model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'mock_api.g.dart';

@RestApi(baseUrl: 'https://run.mocky.io/v3')
abstract class MockApi extends Api {
  factory MockApi(Dio dio, {String baseUrl}) = _MockApi;

  @override
  @GET('/1bb78083-391c-4aef-ad93-c4be56bde7e5')
  Future<Offers> getOffers();

  @override
  @GET('/c2976d3c-b04d-4a0e-aec8-b7e15ec28ae1')
  Future<TicketsOffers> getTicketsOffers();

  @override
  @GET('/a31faad9-3039-467c-a634-965246393509')
  Future<Tickets> getTickets();
}
