import 'package:equatable/equatable.dart';
import 'package:gitappredone/model/github_class.dart';

abstract class GithubState extends Equatable {
  GithubState([List props = const []]) : super(props);

}

class GitInitial extends GithubState{}

class GitLoading extends GithubState{}

class GitLoaded extends GithubState {

  final Github_class github_class;

  GitLoaded(this.github_class): super([github_class]);

}




