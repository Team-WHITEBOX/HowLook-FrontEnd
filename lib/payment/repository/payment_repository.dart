import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../payment_model.dart';

part 'payment_repository.g.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        PaymentRepository(dio, baseUrl: 'http://$API_SERVICE_URI/payment');
    return repository;
  },
);

@RestApi()
abstract class PaymentRepository {
  factory PaymentRepository(Dio dio, {String baseUrl}) = _PaymentRepository;

  @POST('/charge')
  @Headers({
    'accessToken': 'true',
    'content-type': 'application/json',
  })
  Future<HttpResponse<dynamic>> postCharge(
    @Queries() PaymentModel paymentModel,
  );
}
