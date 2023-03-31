
import 'package:flutter/material.dart';
import 'favourites.dart';
import 'home.dart';
import 'settings.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new

import 'package:go_router/go_router.dart';               // new

import 'package:provider/provider.dart';                 // new
import 'package:google_fonts/google_fonts.dart';
import 'app_state.dart';  
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide EmailAuthProvider, PhoneAuthProvider;                               // new

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    
    create: (context) => ApplicationState(),
    builder: ((context, page) => const App()),
  ));
 
}



final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RootPage(),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) {
            return SignInScreen(
              actions: [
                ForgotPasswordAction(((context, email) {
                  final uri = Uri(
                    path: '/sign-in/forgot-password',
                    queryParameters: <String, String?>{
                      'email': email,
                    },
                  );
                  context.push(uri.toString());
                })),
                AuthStateChangeAction(((context, state) {
                  if (state is SignedIn || state is UserCreated) {
                    var user = (state is SignedIn)
                        ? state.user
                        : (state as UserCreated).credential.user;
                    if (user == null) {
                      return;
                    }
                    if (state is UserCreated) {
                      user.updateDisplayName(user.email!.split('@')[0]);
                    }
                    if (!user.emailVerified) {
                      user.sendEmailVerification();
                      const snackBar = SnackBar(
                          content: Text(
                              'Please check your email to verify your email address'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    context.pushReplacement('/');
                  }
                })),
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.queryParams;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) {
            return ProfileScreen(
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
            );
          },
        ),
      ],
    ),
  ],
);
// end of GoRouter configuration

// Change MaterialApp to MaterialApp.router and add the routerConfig
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(primarySwatch: Colors.amber),
      routerConfig: _router, // new
    );
  }
}



class RootPage extends StatefulWidget {
  

  const RootPage({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
  final auth = FirebaseAuth.instance;
  return StreamBuilder<User?>(
    stream: auth.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      final user = snapshot.data;
      if (user == null) {
        return const SignInScreen();
      }
      return const App();
    },
  );
}




  State<RootPage> createState() => _RootPageState();
}

bool _iconbool = false;

IconData _iconLight = Icons.wb_sunny;
IconData _icondark = Icons.nightlight;

ThemeData _lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
);
ThemeData _darkTheme = ThemeData(
 primarySwatch: Colors.deepOrange,
 brightness: Brightness.dark,
);

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
   String searchValue = '';
  final List<String> _suggestions = ['pahaa ruokaa helposti', 'kova nälkä on','helppo ruoka alle 1 euro'];
  List<Widget> pages =   [
    
    
    const Favourites(),
    Home(),
    const settings()
    
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       theme: _iconbool ? _darkTheme : _lightTheme,
       home: Scaffold(

         appBar: EasySearchBar(
          onSearch: (value) => setState(() => searchValue = value),
          suggestions: _suggestions,
        title: const Text('ezfood'),
        actions: [
          IconButton(onPressed:(){
              setState(() {
                _iconbool = !_iconbool;
              });
            } , icon: Icon(_iconbool ? _icondark : _iconLight))
          ],
      ),
      body: pages[currentPage],

        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.favorite), label: 'Favourites'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),  
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
        ),
    ));
  }
  
}
