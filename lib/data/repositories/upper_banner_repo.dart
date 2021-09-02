import 'dart:collection';
import 'dart:convert';

import 'package:cara_app/data/models/upperbanner.dart';
import 'package:cara_app/data/provider/upperbanner.dart';

class UpperBannerRepo {
  final UpperBannerApi _upperBannerApi = UpperBannerApi();

  fetchUpperBanner({required String zipCode}) async {
    var decodedResponse =
        await _upperBannerApi.fetchUpperBanner(zipCode: zipCode);

    if (decodedResponse is! LinkedHashMap) {
      List<UpperBanner> upperBanners = [];

      for (var banner in decodedResponse) {
        var element = UpperBanner.fromJson(banner);
        upperBanners.add(element);
      }

      return upperBanners;
    }
  }
}
