import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'ScreenStart/loginscreen.dart';
import 'ScreenStart/signup.dart';
import 'CallWidget/callwidget.dart';


void main() => runApp(const MyApp());



final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const InitializeScreen();
          },
        routes: <RouteBase>[
          GoRoute(
            path: 'log-in',
            builder: (BuildContext context, GoRouterState state) {
              return LoginScreen();
            },
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: LoginScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),

          ),
          GoRoute(
            path: 'sign-up',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpWidget();
            },
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SignUpWidget(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          ),
          GoRoute(
            path: 'call-widget',
            builder: (BuildContext context, GoRouterState state) {
              return const CallWidget();
            },
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const CallWidget(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          ),
        ],
      )
    ]
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

/// The details screen
class InitializeScreen extends StatefulWidget {

  const InitializeScreen({super.key});

  @override
  State<InitializeScreen> createState() => _InitializeScreenState();
}


class _InitializeScreenState extends State<InitializeScreen> {
  List<Widget> _children = <Widget>[];

  void resetMenu() {
    setState(() {
      _children = <Widget>[];
    });
  }
  void displayMenu() {
    if (_children.isEmpty) {
      setState(() {
        _children.add(ElevatedButton(
          key: UniqueKey(),
          onPressed: () => context.go('/sign-up'),
          child: const Text('Registrarse')
        ));
        _children.add(ElevatedButton(
          key: UniqueKey(),
          onPressed: () => context.go('/log-in'),
          child: const Text('Iniciar Sesion'),
        ));
        _children.add(ElevatedButton(
          key: UniqueKey(),
          onPressed: () => context.go('/call-widget'),
          child: const Text('Llamada de emergencia'),
        ));
        _children.add(ElevatedButton(
          key: UniqueKey(),
          onPressed: () => resetMenu(),
          child: const Text('Reset Menu'),
        ));
      });
    }}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      backgroundColor: const Color.fromARGB(255, 115, 162, 218),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 115, 162, 218),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Developing'),
            ElevatedButton(
                onPressed: () {
                  displayMenu();
                  },
                child: const Text("Desplegar menu")),
            Expanded(
              child: Container(
                color: const Color.fromRGBO(91,205,247,255),
                child: Column(
                    children: _children.toList()
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTransitionPage<T> extends Page<T> {
  final Widget child;
  final Widget Function(BuildContext, Animation<double>, Animation<double>, Widget) transitionsBuilder;

  const CustomTransitionPage({
    required this.child,
    required this.transitionsBuilder,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
    key: key,
    name: name,
    arguments: arguments,
    restorationId: restorationId,
  );

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: transitionsBuilder,
    );
  }
}