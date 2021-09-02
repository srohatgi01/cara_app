import 'dart:convert';

class CaraStandard {
  CaraStandard({
    this.safetyMeasures,
    this.professionalism,
    this.socialConscience,
    this.miscellaneous,
  });

  final int? safetyMeasures;
  final int? professionalism;
  final int? socialConscience;
  final int? miscellaneous;

  factory CaraStandard.fromRawJson(String str) =>
      CaraStandard.fromJson(json.decode(str));

  factory CaraStandard.fromJson(Map<String, dynamic> json) => CaraStandard(
        safetyMeasures:
            json["safety_measures"] == null ? null : json["safety_measures"],
        professionalism:
            json["professionalism"] == null ? null : json["professionalism"],
        socialConscience: json["social_conscience"] == null
            ? null
            : json["social_conscience"],
        miscellaneous:
            json["miscellaneous"] == null ? null : json["miscellaneous"],
      );
}
