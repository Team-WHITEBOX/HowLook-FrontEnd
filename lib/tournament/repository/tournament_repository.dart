import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/main_tournament/main_tournament_data.dart';
import '../model/main_tournament_result/main_tournament_result_data.dart';
import '../model/params/tournament_result_params.dart';

part 'tournament_repository.g.dart';

final tournamentRepositoryProvider = Provider<TournamentRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository = TournamentRepository(dio,
        baseUrl: 'http://$API_SERVICE_URI/tournament');
    return repository;
  },
);

@RestApi()
abstract class TournamentRepository {
  factory TournamentRepository(Dio dio, {String baseUrl}) =
      _TournamentRepository;

  @GET('/post/{date}')
  @Headers({
    'accessToken': 'true',
  })
  Future<MainTournamentData> getTodayTournament({
    @Path('date') required String date,
  });

  @GET('/history/{date}')
  @Headers({
    'accessToken': 'true',
  })
  Future<MainTournamentResultData> getTodayTournamentResult({
    @Path('date') required String date,
  });

  @PUT('/result')
  @Headers({
    'accessToken': 'true',
  })
  Future<HttpResponse<dynamic>> putTodayTournament({
    @Body() required List<MainTournamentResultParams> mainTournamentResultParams,
  });
}
