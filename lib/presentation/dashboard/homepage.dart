import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/data/models/recommenedsalons.dart';
import 'package:cara_app/data/models/searchresults.dart';
import 'package:cara_app/data/models/upperbanner.dart';
import 'package:cara_app/data/repositories/salons_repo.dart';
import 'package:cara_app/data/repositories/upper_banner_repo.dart';
import 'package:cara_app/presentation/salon/salons.dart';
import 'package:cara_app/providers/salon_provider.dart';
import 'package:cara_app/providers/search_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cara_app/presentation/widgets/homeappbar.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  CarouselController sliderController = CarouselController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Color(backgroundColor),
      appBar: homeAppBar(
        context: context,
        zipCode: userProvider.cuser.zipcode,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Hello ' + (userProvider.isSignedIn == true ? userProvider.cuser.firstName : 'User') + ',',
                ),
                Text('Welcome back!'),
                TextFormField(
                  autofocus: false,
                  onChanged: (value) {
                    print(value);
                    Provider.of<SearchProvider>(context, listen: false).setKeyword = value;
                  },
                ),
                StreamBuilder(
                  stream: (Provider.of<SearchProvider>(context).getKeyword != null &&
                          Provider.of<SearchProvider>(context).getKeyword.length != 0)
                      ? Stream.fromFuture(
                          SalonsRepo().searchSalons(keyword: Provider.of<SearchProvider>(context).getKeyword),
                        )
                      : null,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                      List<SearchResults> searchResults = snapshot.data as List<SearchResults>;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Provider.of<SalonProvider>(
                              context,
                              listen: false,
                            ).setSalonId = searchResults[index].salonId;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SalonScreen(),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(searchResults[index].salonName!),
                            subtitle: Text(searchResults[index].salonType!),
                          ),
                        ),
                      );
                    } else if (snapshot.connectionState == ConnectionState.waiting &&
                        Provider.of<SearchProvider>(context).getKeyword.length != 0) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sponsored'),
                          StreamBuilder(
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                List<UpperBanner> banners = snapshot.data as List<UpperBanner>;
                                return CarouselSlider.builder(
                                  itemCount: banners.length,
                                  itemBuilder: (context, index, ind) => GestureDetector(
                                    onTap: () {
                                      Provider.of<SalonProvider>(
                                        context,
                                        listen: false,
                                      ).setSalonId = banners[index].salonId;

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SalonScreen(),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        banners[index].bannerUrl!,
                                      ),
                                    ),
                                  ),
                                  options: CarouselOptions(
                                    viewportFraction: 1,
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                  ),
                                  carouselController: sliderController,
                                );
                              } else if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  height: 300,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Center(child: Text('Something went wrong'));
                              }
                            },
                            stream: Stream.fromFuture(
                              UpperBannerRepo().fetchUpperBanner(zipCode: userProvider.cuser.zipcode),
                            ),
                          ),
                          Text('Recommended Salons'),
                          StreamBuilder(
                            stream: Stream.fromFuture(
                              SalonsRepo().recommendedSalons(zipCode: userProvider.cuser.zipcode),
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                                List<RecommendedSalons> salons = snapshot.data as List<RecommendedSalons>;
                                return GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: salons.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                    itemBuilder: (context, index) => GestureDetector(
                                          onTap: () {
                                            Provider.of<SalonProvider>(
                                              context,
                                              listen: false,
                                            ).setSalonId = salons[index].salonId;

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SalonScreen(),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              // Image.network(salons[index].logo!),
                                              Text(salons[index].salonName!),
                                              Text(salons[index].average!),
                                            ],
                                          ),
                                        ));
                              } else if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Center(
                                  child: Text('Oops... Something went wrong'),
                                );
                              }
                            },
                          ),
                          Center(
                            child: Text('Made with <3 for all the fashion people.'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
