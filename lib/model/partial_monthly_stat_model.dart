import 'package:json_annotation/json_annotation.dart';

part 'partial_monthly_stat_model.g.dart';

@JsonSerializable()
class PartialMonthlyStatModel {
  final int totalThisMonth;
  final int totalLastMonth;

  PartialMonthlyStatModel({
    required this.totalThisMonth,
    required this.totalLastMonth,
  });

  factory PartialMonthlyStatModel.fromJson(Map<String, dynamic> json) =>
      _$PartialMonthlyStatModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartialMonthlyStatModelToJson(this);
}
