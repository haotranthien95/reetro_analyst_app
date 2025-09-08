// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_monthly_stat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialMonthlyStatModel _$PartialMonthlyStatModelFromJson(
        Map<String, dynamic> json) =>
    PartialMonthlyStatModel(
      totalThisMonth: (json['totalThisMonth'] as num).toInt(),
      totalLastMonth: (json['totalLastMonth'] as num).toInt(),
    );

Map<String, dynamic> _$PartialMonthlyStatModelToJson(
        PartialMonthlyStatModel instance) =>
    <String, dynamic>{
      'totalThisMonth': instance.totalThisMonth,
      'totalLastMonth': instance.totalLastMonth,
    };
