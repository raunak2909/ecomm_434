import 'package:ecomm_434/data/remote/helper/api_helper.dart';
import 'package:ecomm_434/domain/constants/app_routes.dart';
import 'package:ecomm_434/ui/on_boarding/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserBloc(apiHelper: ApiHelper()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.route_splash,
      routes: AppRoutes.mRoutes,
    );
  }
}
