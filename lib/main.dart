import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirogi/src/bloc/blocs.dart';
import 'package:nirogi/src/bloc/events.dart';
import 'package:nirogi/src/bloc/states.dart';
import 'package:nirogi/src/models/models.dart';
import 'package:nirogi/src/repository/repositories.dart';
import 'package:nirogi/src/screens/provincePage.dart';
import 'package:nirogi/src/screens/screens.dart';
import 'package:nirogi/src/screens/splashScreenPage.dart';
import 'package:nirogi/src/widgets/loading_indicator.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp(
      changeThemeBloc: changeThemeBloc,
      userRepository: userRepository,
    ));
  });
}

class MyApp extends StatefulWidget {
  final ChangeThemeBloc changeThemeBloc;
  final UserRepository userRepository;
  MyApp({
    @required this.changeThemeBloc,
    @required this.userRepository,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    widget.changeThemeBloc.onDecideThemeChange();
    authenticationBloc =
        AuthenticationBloc(userRepository: widget.userRepository);
    authenticationBloc.dispatch(AppStartedEvent());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User loggedinUser;
    return BlocProvider<AuthenticationBloc>(
      bloc: authenticationBloc,
      child: BlocBuilder<ChangeThemeEvent, ChangeThemeState>(
        bloc: changeThemeBloc,
        builder: (BuildContext context, ChangeThemeState state) {
          return MaterialApp(
            title: 'Hami Nirogi',
            home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
              bloc: authenticationBloc,
              builder: (BuildContext context, AuthenticationState authstate) {
                if (authstate is AuthenticationUninitialisedState) {
                  return SplashPage();
                }
                if (authstate is AuthenticationAuthenticatedState) {
                  loggedinUser = User(
                    address: authstate.address,
                    email: authstate.email,
                    imageUrl: authstate.imageUrl,
                    name: authstate.name,
                  );
                  return HomePage(
                    loggedInUser: loggedinUser,
                  );
                }
                if (authstate is AuthenticationUnauthenticatedState) {
                  return LoginSignup(
                    userRepository: widget.userRepository,
                  );
                }
                if (authstate is AuthenticationLoadingState) {
                  return LoadingIndicator();
                }
              },
            ),
            routes: <String, WidgetBuilder>{
              "/diseases": (context) =>
                  DiseasesPage(loggedInUser: loggedinUser),
              "/symptoms": (context) =>
                  SymptomsPage(loggedInUser: loggedinUser),
              "/news": (context) => HealthNewsPage(loggedInUser: loggedinUser),
              "/about": (context) => AboutPage(loggedInUser: loggedinUser),
              "/profile": (context) => ProfilePage(
                    loggedInUser: loggedinUser,
                  ),
              "/editprofile": (context) => EditProfile(
                    loggedInUser: loggedinUser,
                  ),
              "/changepw": (context) => ChangePasswordPage(),
              "/forum": (context) => ForumPage(loggedInUser: loggedinUser),
              "/tools": (context) =>
                  HealthToolsPage(loggedInUser: loggedinUser),
              "/province": (context) => ProvincePage(
                    loggedInUser: loggedinUser,
                  ),
            },
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
          );
        },
      ),
    );
  }
}
