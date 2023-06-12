// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_tournament_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainTournamentResultModel _$MainTournamentResultModelFromJson(
        Map<String, dynamic> json) =>
    MainTournamentResultModel(
      tournamentHistoryId: json['tournamentHistoryId'] as int,
      date: (json['date'] as List<dynamic>).map((e) => e as int).toList(),
      postDTOS: (json['postDTOS'] as List<dynamic>)
          .map((e) => MainTournamentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainTournamentResultModelToJson(
        MainTournamentResultModel instance) =>
    <String, dynamic>{
      'tournamentHistoryId': instance.tournamentHistoryId,
      'date': instance.date,
      'postDTOS': instance.postDTOS,
    };
