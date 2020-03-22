import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitappredone/bloc/github_event.dart';
import 'bloc/github_bloc.dart';
import 'bloc/github_state.dart';
import 'model/github_class.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Git info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mainpage(),
    );
  }
}

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final gitbloc = GithubBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Git"),
        backgroundColor: Colors.grey,
      ),
      body: BlocProvider(
        bloc: gitbloc,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocBuilder(
            bloc: gitbloc,
            // ignore: missing_return
            builder: (BuildContext context, GithubState state) {
              if (state is GitInitial) {
                return buildInitialInput();
              } else if (state is GitLoading) {
                return buildLoading();
              } else if (state is GitLoaded) {
                return buildColumnwithdata(state.github_class);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: UserInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnwithdata(Github_class github_class) {
    String jiji = github_class.dateJoined;
    return Column(
      children: <Widget>[
        UserInputField(),
        SizedBox(
          height: 100,
        ),

        Text(
          github_class.userName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  color: Colors.grey,
                  height: 300,
                  width: 300,
                  margin: EdgeInsets.only(right: 10),
                  child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/waiting.png",
                      image: github_class.imagez),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  github_class.lastseen.toString(),
                  style: TextStyle(
                      color: Colors.green,

                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(github_class.fullName),
                SizedBox(
                  height: 10,
                ),

                Text("Email : " + github_class.email.toString()),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text(github_class.location.toString()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),


                Text("Joined :"+jiji.substring(0,4)),
                SizedBox(
                  height: 10,
                ),
                Text("Public repositories: " +
                    github_class.publicrepos.toString()),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gitbloc.dispose();
  }
}

class UserInputField extends StatefulWidget {
  const UserInputField({
    Key key,
  }) : super(key: key);

  @override
  _UserInputFieldState createState() => _UserInputFieldState();
}

class _UserInputFieldState extends State<UserInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: submitUserName,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitUserName(String UserName) {
    // We will use the User name to search for the fake forecast
    final githubBloc = BlocProvider.of<GithubBloc>(context);
    githubBloc.dispatch(GetgitName(UserName));
  }
}
