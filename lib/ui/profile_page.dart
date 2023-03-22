import 'package:flutter/material.dart';
import 'package:konnektable/ui/repo_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konnektable/bloc/app_blocs.dart';
import 'package:konnektable/bloc/app_events.dart';
import 'package:konnektable/bloc/app_states.dart';
import 'package:konnektable/ui/follower_page.dart';
import 'package:konnektable/repo/repositories.dart';
import 'package:konnektable/models/profile.dart';

class ProfilePage extends StatelessWidget {
  final String login;
  const ProfilePage(this.login, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(ProfileRepository(login)),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(title: const Text('User Profile')),
          body: blocBody()),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => ProfileBloc(
      ProfileRepository(login),
    )..add(LoadProfileEvent()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileErrorState) {
            return const Center(child:  Text("Error"));
          }
          if (state is ProfileLoadedState) {
            Profile profile = state.profile;
            return Container(
              height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueGrey.shade300],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: const [0.5, 0.9],
                  ),
                ),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white70,
                              minRadius: 60.0,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage:
                                NetworkImage(
                                    profile.avatar.toString()),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${profile.name}',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${profile.location}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '${profile.bio}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RepoPage(login),
                                ));
                          },
                          child: Container(
                            color: Colors.deepOrange.shade300,
                            child: ListTile(
                              title: Text(
                                '${profile.repos}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: const Text(
                                'Repositories',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FollowerPage(login),
                            ));
                          },
                          child: Container(
                            color: Colors.red,
                            child: ListTile(
                              title: Text(
                                '${profile.followers}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: const Text(
                                'Followers',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            );
          }

          return Container();
        }
      ),
    );
  }
}
