import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/data/models/appointment/appointment_history.dart';
import 'package:cara_app/data/repositories/appointment_repo.dart';
import 'package:cara_app/presentation/authentication/google_auth_screen.dart';
import 'package:cara_app/presentation/functions/status_button.dart';
import 'package:cara_app/presentation/widgets/common_app_bar.dart';
import 'package:cara_app/presentation/widgets/custom_progress_bar.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CartPageScreen extends StatelessWidget {
  const CartPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      appBar: commonAppBar(context),
      // Main Body of the page
      body: Provider.of<UserProvider>(context).isSignedIn == false
          ? Center(
              child: Builder(
                builder: (context) => AlertDialog(
                  title: Text('Looks like you are not Signed In'),
                  content: Text('Click below to Sign In and view your Order history.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (context) => GoogleAuthScreen()));
                      },
                      child: Text('Sign In'),
                    ),
                  ],
                ),
              ),
            )
          : FutureBuilder(
              future: AppointmentRepo().appointmentHistory(
                emailAddress: Provider.of<UserProvider>(context, listen: false).cuser.emailAddress,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                  List<AppointmentHistory> appointments = snapshot.data as List<AppointmentHistory>;
                  return appointments.length > 0 ? appointmentsList(appointments) : emptyCart(context);
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CustomProgressIndicator(text: 'loading...', marginBottom: 15));
                } else {
                  return Text('Oops something went wrong.');
                }
              },
            ),
    );
  }

/* 
  Actual implementation of the booked history appointment list
 */
  ListView appointmentsList(List<AppointmentHistory> appointments) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: appointments.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                offset: Offset(0, 2),
                color: Colors.grey.shade400,
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    appointments[index].salon!.salonName,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appointments[index].dateOfAppointment.toString().split(" ")[0]),
                    Text('₹' + appointments[index].totalPrice.toString()),
                  ],
                ),
                SizedBox(height: 10),
                // function to check status and display appropriate button and text with color
                statusButton(context, status: appointments[index].appointmentStatus!),
              ],
            ),
          ),
        ),
      );

  Column emptyCart(context) => Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: SvgPicture.asset(
              'assets/svg/empty-cart.svg',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Looks like you haven\'t booked any appointments, go back and make yourself fashionable.',
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
}


// TODO: Change the color of green to a darker green or any suitable color which looks good. 