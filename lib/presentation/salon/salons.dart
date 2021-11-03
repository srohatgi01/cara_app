import 'package:cara_app/data/models/salon/salon.dart';
import 'package:cara_app/data/repositories/salons_repo.dart';
import 'package:cara_app/presentation/authentication/google_auth_screen.dart';
import 'package:cara_app/presentation/salon/cart.dart';
import 'package:cara_app/presentation/salon/cartRemedy.dart';
import 'package:cara_app/presentation/widgets/custom_progress_bar.dart';
import 'package:cara_app/providers/appointment_provider.dart';
import 'package:cara_app/providers/salon_provider.dart';
import 'package:cara_app/providers/slot_provider.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class SalonScreen extends StatefulWidget {
  const SalonScreen({Key? key}) : super(key: key);

  @override
  _SalonScreenState createState() => _SalonScreenState();
}

class _SalonScreenState extends State<SalonScreen> {
  var future;
  int? numberOfChairs = 0;

  @override
  void initState() {
    future = SalonsRepo().getSalonById(id: Provider.of<SalonProvider>(context, listen: false).getSalonId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salon Details'), centerTitle: true),
      body: WillPopScope(
        onWillPop: () async {
          await Provider.of<SalonProvider>(context, listen: false).emptyCart();
          return true;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: FutureBuilder<Salon>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    Salon salon = snapshot.data as Salon;

                    numberOfChairs = salon.numberOfChairs;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image carousel
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              ),
                          child: salon.photos!.isNotEmpty
                              ? CarouselSlider.builder(
                                  itemCount: salon.photos!.length,
                                  itemBuilder: (context, carouselIndex, ind) => Image.network(
                                    salon.photos![carouselIndex],
                                    fit: BoxFit.cover,
                                  ),
                                  options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    autoPlay: false,
                                    enlargeCenterPage: true,
                                  ),
                                )
                              : CarouselSlider.builder(
                                  itemCount: 2,
                                  itemBuilder: (context, carouselIndex, ind) => Image.asset(
                                    'assets/smaple_salon_logo.png',
                                  ),
                                  options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    autoPlay: false,
                                  ),
                                ),
                        ),
                        // Salon name and salon type
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  salon.salonName!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NexaBold',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xFFdddaed),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Text(salon.salonType!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'RalewayBold',
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ),
                            ],
                          ),
                        ),

                        // Empty space above the chairs column
                        SizedBox(height: 20),

                        // Column for chairs heading and chairs
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text('Chairs: ', style: TextStyle(fontSize: 14, color: Colors.black54)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: ListView.builder(
                                itemCount: salon.numberOfChairs!,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    Image.asset('assets/chairs/chair_filled.png', height: 30),
                              ),
                            ),
                          ],
                        ),

                        // Empty space below the chairs column
                        SizedBox(height: 20),

                        // List of services of the salon
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Services',
                            style: TextStyle(fontSize: 22, fontFamily: 'NexaBold'),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: salon.categories!.length,
                          itemBuilder: (context, categoriesIndex) => Column(
                            children: [
                              ListTile(
                                title: Text(
                                  salon.categories![categoriesIndex].categoryName!,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: salon.categories![categoriesIndex].services!.length,
                                itemBuilder: (context, servicesIndex) => GestureDetector(
                                  onTap: () {
                                    Provider.of<UserProvider>(context, listen: false).isSignedIn
                                        ? Provider.of<SalonProvider>(context, listen: false).doesContain(
                                                service: salon.categories![categoriesIndex].services![servicesIndex])
                                            ? Provider.of<SalonProvider>(context, listen: false).removeFromCart(
                                                service: salon.categories![categoriesIndex].services![servicesIndex])
                                            : Provider.of<SalonProvider>(context, listen: false).addToCart(
                                                service: salon.categories![categoriesIndex].services![servicesIndex])
                                        : showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Looks like you are not signed In"),
                                              content: Text("Sign In to book appointments"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pushReplacement(
                                                        MaterialPageRoute(builder: (context) => GoogleAuthScreen()));
                                                  },
                                                  child: Text('Sign In'),
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: ListTile(
                                      title: Text(
                                        salon.categories![categoriesIndex].services![servicesIndex].serviceName!,
                                        style: TextStyle(fontWeight: FontWeight.w100, fontFamily: 'RalewayMedium'),
                                      ),
                                      subtitle: Text(
                                        '₹' +
                                            salon.categories![categoriesIndex].services![servicesIndex].servicePrice!
                                                .toString(),
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      trailing: Provider.of<SalonProvider>(context).doesContain(
                                              service: salon.categories![categoriesIndex].services![servicesIndex])
                                          ? Icon(Icons.remove)
                                          : Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    // Custom Progress Indicator
                    return Center(
                        child: CustomProgressIndicator(
                      text: 'loading...',
                      marginBottom: 15,
                      marginTop: MediaQuery.of(context).size.height / 3,
                    ));
                  } else {
                    return Center(child: Text('Something went wrong'));
                  }
                }),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Provider.of<SalonProvider>(context).getServices.length > 0
          ? FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider<AppointmentProvider>(
                          create: (context) => AppointmentProvider(numberOfChairs: numberOfChairs),
                        ),
                        ChangeNotifierProvider<SlotProvider>(
                          create: (context) => SlotProvider(),
                        ),
                      ],
                      child: CartScreen(),
                    ),
                  ),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CartRemedy(
                //       salonId: Provider.of<SalonProvider>(context).getSalonId.toString(),
                //       userId: Provider.of<UserProvider>(context).cuser.emailAddress,
                //       services: Provider.of<SalonProvider>(context).getServices,
                //     ),
                //   ),
                // );
              },
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text('Cart', style: TextStyle(fontSize: 18)),
              ),
            )
          : null,
    );
  }
}
