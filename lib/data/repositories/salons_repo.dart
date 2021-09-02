import 'dart:collection';

import 'package:cara_app/data/models/recommenedsalons.dart';
import 'package:cara_app/data/models/salon/salon.dart';
import 'package:cara_app/data/models/searchresults.dart';
import 'package:cara_app/data/provider/salons_api.dart';

class SalonsRepo {
  SalonsApi _salonsApi = SalonsApi();

  recommendedSalons({required String zipCode}) async {
    var decodedResponse = await _salonsApi.recommenedSalons(zipCode: zipCode);
    List<RecommendedSalons> recommendedSalonsList = [];

    if (decodedResponse is! LinkedHashMap) {
      for (var salon in decodedResponse) {
        recommendedSalonsList.add(RecommendedSalons.fromJson(salon));
      }
      return recommendedSalonsList;
    }
  }

  searchSalons({required String keyword}) async {
    var decodedResponse = await _salonsApi.searchSalons(keyword: keyword);

    List<SearchResults> searchResultsList = [];

    if (decodedResponse != null) {
      for (var salon in decodedResponse) {
        searchResultsList.add(SearchResults.fromJson(salon));
      }

      return searchResultsList;
    }
  }

  Future<Salon> getSalonById({required int id}) async {
    var decodedResponse = await _salonsApi.getSalonById(id: id);
    return Salon.fromJson(decodedResponse);
  }
}
