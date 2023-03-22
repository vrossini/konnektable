import 'package:flutter/material.dart';
import 'package:konnektable/ui/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konnektable/bloc/app_blocs.dart';
import 'package:konnektable/repo/repositories.dart';

void main() {
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<GithubUserBloc>(create: (context) => GithubUserBloc(GithubUserRepository())),
      ],
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}
