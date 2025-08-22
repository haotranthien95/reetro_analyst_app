import 'package:json_annotation/json_annotation.dart';
part 'daily_stat.g.dart';

@JsonSerializable()
class DailyStat {
  @JsonKey(name: 'ngay_trong_thang')
  final int ngayTrongThang;

  /// tong_gia_tri từ API là số nguyên (VND). Để an toàn dùng int.
  @JsonKey(name: 'tong_gia_tri')
  final double tongGiaTri;

  DailyStat({
    required this.ngayTrongThang,
    required this.tongGiaTri,
  });

  factory DailyStat.fromJson(Map<String, dynamic> json) =>
      _$DailyStatFromJson(json);

  Map<String, dynamic> toJson() => _$DailyStatToJson(this);
}
