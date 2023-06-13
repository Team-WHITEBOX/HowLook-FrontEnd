// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_result_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainTournamentResultParams _$MainTournamentResultParamsFromJson(
        Map<String, dynamic> json) =>
    MainTournamentResultParams(
      tournamentPostId: json['tournamentPostId'] as int,
      date: json['date'] as String,
      postId: json['postId'] as int,
      photo: json['photo'] as String,
      memberId: json['memberId'] as String,
      score: json['score'] as int,
      tournamentType: json['tournamentType'] as String,
    );

Map<String, dynamic> _$MainTournamentResultParamsToJson(
        MainTournamentResultParams instance) =>
    <String, dynamic>{
      'tournamentPostId': instance.tournamentPostId,
      'date': instance.date,
      'postId': instance.postId,
      'photo': instance.photo,
      'memberId': instance.memberId,
      'score': instance.score,
      'tournamentType': instance.tournamentType,
    };
