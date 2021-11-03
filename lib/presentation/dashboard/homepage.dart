import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/data/models/recommenedsalons.dart';
import 'package:cara_app/data/models/searchresults.dart';
import 'package:cara_app/data/models/upperbanner.dart';
import 'package:cara_app/data/repositories/salons_repo.dart';
import 'package:cara_app/data/repositories/upper_banner_repo.dart';
import 'package:cara_app/presentation/salon/salons.dart';
import 'package:cara_app/presentation/widgets/custom_progress_bar.dart';
import 'package:cara_app/providers/salon_provider.dart';
import 'package:cara_app/providers/search_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cara_app/presentation/widgets/homeappbar.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
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
      // App Bar for the home page consisting of location and coins action button
      appBar: homeAppBar(
        context: context,
        zipCode: userProvider.cuser.zipcode,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Hello ' + (userProvider.isSignedIn == true ? userProvider.cuser.firstName : 'User') + ',',
                  style: TextStyle(
                    fontFamily: 'RalewaySemiBold',
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 0),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontFamily: 'NexaBoldDemo',
                    fontSize: 26,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(0.3, 2.0), //(x,y)
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  // Search Bar
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        LineIcons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      alignLabelWithHint: true,
                      hintText: 'Search',
                    ),
                    autofocus: false,
                    onChanged: (value) {
                      print(value);
                      Provider.of<SearchProvider>(context, listen: false).setKeyword = value;
                    },
                  ),
                ),
                // Search Results
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
                        physics: PageScrollPhysics(),
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
                          // Single Search Result
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(blurRadius: 4, color: Colors.grey.shade300, offset: Offset(0, 4)),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  leading: searchResults[index].logo != null
                                      ? Image.network(searchResults[index].logo!)
                                      : Image.asset('assets/smaple_salon_logo.png'),
                                  title: Text(searchResults[index].salonName!),
                                  subtitle: Text(searchResults[index].addressLineOne!),
                                  trailing: Text(
                                    searchResults[index].salonType!,
                                    style: TextStyle(color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    // Progress indicator
                    else if (snapshot.connectionState == ConnectionState.waiting &&
                        Provider.of<SearchProvider>(context).getKeyword.length != 0) {
                      return CustomProgressIndicator(
                        text: 'searching...',
                        marginTop: 60,
                        marginBottom: 15,
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 18),
                          Text(
                            'Sponsored',
                            style: TextStyle(fontFamily: 'NexaBoldDemo', fontSize: 16),
                          ),
                          SizedBox(height: 5),
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
                                  height: 200,
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
                          SizedBox(height: 12),
                          Text(
                            'Recommended Salons',
                            style: TextStyle(fontFamily: 'NexaBoldDemo', fontSize: 16),
                          ),
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
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: .86,
                                    ),
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
                                          child: Container(
                                            margin: EdgeInsets.all(13),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade400,
                                                  offset: Offset(0.3, 2.0), //(x,y)
                                                  blurRadius: 6.0,
                                                )
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.symmetric(horizontal: 30),
                                                        child: salons[index].logo != null
                                                            ? Image.network(salons[index].logo!)
                                                            : Image.asset('assets/smaple_salon_logo.png'),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            salons[index].salonName!,
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: Color(0xFFDE9F22),
                                                                size: 18,
                                                              ),
                                                              const SizedBox(width: 5),
                                                              Text(salons[index].average!),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                    height: 43,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.only(
                                                        bottomRight: Radius.circular(25),
                                                        bottomLeft: Radius.circular(25),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text('OPEN', style: TextStyle(color: Colors.white)),
                                                        Icon(
                                                          LineIcons.arrowRight,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ));
                              } else if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  alignment: Alignment.center,
                                  height: 300,
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.connectionState == ConnectionState.done) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 60),
                                    Center(
                                      child: SvgPicture.asset(
                                        'assets/svg/not_found.svg',
                                        width: MediaQuery.of(context).size.width / 2,
                                      ),
                                    ),
                                    Text(
                                      'Salons not found for this Zipcode',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 40),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: const Text('Error Recieved'),
                                );
                              } else {
                                return Center(
                                  child: Text('Oops... Something went wrong'),
                                );
                              }
                            },
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Made with '),
                                    Icon(
                                      LineIcons.heartAlt,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                Text('For all the fashionable people.'),
                                SizedBox(height: 30)
                              ],
                            ),
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
