import 'package:cara_app/data/models/salon/salon.dart';
import 'package:cara_app/data/repositories/salons_repo.dart';
import 'package:cara_app/presentation/authentication/google_auth_screen.dart';
import 'package:cara_app/presentation/salon/cart.dart';
import 'package:cara_app/presentation/salon/cartRemedy.dart';
import 'package:cara_app/providers/appointment_provider.dart';
import 'package:cara_app/providers/salon_provider.dart';
import 'package:cara_app/providers/slot_provider.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(),
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
                        Text(salon.salonName!),
                        Text(salon.emailAddress!),
                        Text(salon.salonId!.toString()),
                        // Text(salon.numberOfChairs!.toString()),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: salon.categories!.length,
                          itemBuilder: (context, categoriesIndex) => Column(
                            children: [
                              ListTile(
                                title: Text(
                                  salon.categories![categoriesIndex].categoryName!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  child: ListTile(
                                    title:
                                        Text(salon.categories![categoriesIndex].services![servicesIndex].serviceName!),
                                    trailing: Provider.of<SalonProvider>(context).doesContain(
                                            service: salon.categories![categoriesIndex].services![servicesIndex])
                                        ? Icon(Icons.remove)
                                        : Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
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
              label: Text('Cart'))
          : null,
    );
  }
}


// TODO: Check if the user is signed in and only then give user the access to go to the cart other wise just give a popup asking to sign in
//TODO: empty the cart when user exists the salon page