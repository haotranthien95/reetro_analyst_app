// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyStat _$DailyStatFromJson(Map<String, dynamic> json) => DailyStat(
      ngayTrongThang: (json['ngay_trong_thang'] as num).toInt(),
      tongGiaTri: (json['tong_gia_tri'] as num).toDouble(),
    );

Map<String, dynamic> _$DailyStatToJson(DailyStat instance) => <String, dynamic>{
      'ngay_trong_thang': instance.ngayTrongThang,
      'tong_gia_tri': instance.tongGiaTri,
    };
