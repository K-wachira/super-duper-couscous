import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gitappredone/model/github_class.dart';
import './bloc.dart';
import 'package:http/http.dart';
import 'dart:convert';

class GithubBloc extends Bloc<GithubEvent, GithubState> {
  @override
  GithubState get initialState => GitInitial();

  @override
  Stream<GithubState> mapEventToState(
    GithubEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is GetgitName){

      yield GitLoading();
      final github_class = await _fetchdatafromAPI(event.Username);
      yield GitLoaded(github_class);

//      print(event.Username);

    }
  }

  Future<Github_class> _fetchdatafromAPI(String userName) async {

    String Username = userName;
    print(Username);
    Response response = await get("https://api.github.com/users/$Username");
    Map data = jsonDecode(response.body);
    print(data);

    return Github_class(
        userName: data["name"],
        fullName: data["login"],
        dateJoined: data["created_at"],
        email: data["email"],
        publicrepos: data["public_repos"],
        lastseen: data["updated_at"],
        imagez :data["avatar_url"],
        location: data["location"],
        );
  }
}




