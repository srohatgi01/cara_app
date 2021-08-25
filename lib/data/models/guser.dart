import 'package:firebase_auth/firebase_auth.dart';

class GUser {
  final String firstName;
  final String lastName;
  final String email;
  String? phoneNumber;
  final String photoUrl;
  final String uuid;
  final bool emailVerified;
  final bool isAnonymous;

  GUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
    required this.uuid,
    required this.emailVerified,
    required this.isAnonymous,
  });

  set phoneNum(String number) {
    this.phoneNumber = number;
  }

  // To convert Google User to GUser
  factory GUser.fromGoogleUser({required User user}) => GUser(
        firstName: user.displayName!.split(' ').first,
        lastName: user.displayName!.split(' ').last,
        email: user.email!,
        phoneNumber: user.phoneNumber ?? null,
        photoUrl: user.photoURL!,
        uuid: user.uid,
        emailVerified: user.emailVerified,
        isAnonymous: user.isAnonymous,
      );

  //To take guser without phonenumber and save phonenumber in it.
  // factory GUser.fromGUser({required GUser guser, required String number}) =>
  //     GUser(
  //       firstName: guser.firstName,
  //       lastName: guser.lastName,
  //       email: guser.email,
  //       phoneNumber: number,
  //       photoUrl: guser.photoUrl,
  //       uuid: guser.uuid,
  //       emailVerified: guser.emailVerified,
  //       isAnonymous: guser.isAnonymous,
  //     );
}
