import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


class Github_class extends Equatable {
  final String userName;
  final String fullName;
  final String dateJoined;
  final String email;
  final int publicrepos;
  final String lastseen;
  final String imagez;
  final String location;

  Github_class({

    @required this.userName,
    @required this.fullName,
    @required this.dateJoined,
    @required this.email,
    @required this.publicrepos,
    @required this.lastseen,
    @required this.imagez,
    @required this.location

  })
  :super([userName, fullName,dateJoined,email,publicrepos,lastseen,imagez,location]);
}


