// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainTournamentModel _$MainTournamentModelFromJson(Map<String, dynamic> json) =>
    MainTournamentModel(
      tournamentPostId: json['tournamentPostId'] as int,
      date: (json['date'] as List<dynamic>).map((e) => e as int).toList(),
      postId: json['postId'] as int,
      photo: DataUtils.pathToUrl(json['photo'] as String),
      memberId: json['memberId'] as String,
      score: json['score'] as int,
      tournamentType: json['tournamentType'] as String,
    );

Map<String, dynamic> _$MainTournamentModelToJson(
        MainTournamentModel instance) =>
    <String, dynamic>{
      'tournamentPostId': instance.tournamentPostId,
      'date': instance.date,
      'postId': instance.postId,
      'photo': instance.photo,
      'memberId': instance.memberId,
      'score': instance.score,
      'tournamentType': instance.tournamentType,
    };
