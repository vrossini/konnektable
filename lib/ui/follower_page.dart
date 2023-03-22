import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konnektable/bloc/app_blocs.dart';
import 'package:konnektable/bloc/app_events.dart';
import 'package:konnektable/bloc/app_states.dart';
import 'package:konnektable/models/follower.dart';
import 'package:konnektable/repo/repositories.dart';

class FollowerPage extends StatelessWidget {
  final String login;
  const FollowerPage(this.login, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FollowerBloc>(
          create: (BuildContext context) => FollowerBloc(FollowerRepository(login)),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(title: const Text('Followers')),
          body: blocBody()),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => FollowerBloc(
        FollowerRepository(login),
      )..add(LoadFollowerEvent()),
      child: BlocBuilder<FollowerBloc, FollowerState>(
        builder: (context, state) {
          if (state is FollowerLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FollowerErrorState) {
            return const Center(child:  Text("Error"));
          }
          if (state is FollowerLoadedState) {
            List<Follower> followersList = state.followers;
            return ListView.builder(
                itemCount: followersList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        title: Text(
                          '${followersList[index].login}',
                          style: const TextStyle(color: Colors.white),
                        ),

                        subtitle: const Text(
                          '',
                          style: TextStyle(color: Colors.white),
                        ),

                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              followersList[index].avatar.toString()),
                        ),
                      ),
                    ),
                  );
                });
          }

          return Container();
        },
      ),
    );
  }
}
