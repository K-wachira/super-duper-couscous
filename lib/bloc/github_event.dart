import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class GithubEvent extends Equatable {
  GithubEvent([List props = const []]) : super(props);
}


class GetgitName extends GithubEvent{
  final String Username;

  GetgitName(this.Username) : super([Username]);
}
