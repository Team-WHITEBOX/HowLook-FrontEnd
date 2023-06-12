// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_tournament_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainTournamentData _$MainTournamentDataFromJson(Map<String, dynamic> json) =>
    MainTournamentData(
      data: (json['data'] as List<dynamic>)
          .map((e) => MainTournamentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainTournamentDataToJson(MainTournamentData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
