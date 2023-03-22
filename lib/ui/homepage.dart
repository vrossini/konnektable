import 'package:flutter/material.dart';
import 'package:konnektable/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konnektable/bloc/app_blocs.dart';
import 'package:konnektable/bloc/app_events.dart';
import 'package:konnektable/bloc/app_states.dart';
import 'package:konnektable/ui/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GithubUserBloc>(context).add(InitGithubUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Github Users')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                if (value.length > 2) {
                  BlocProvider.of<GithubUserBloc>(context).add(TextChangeEvent(data: value));
                } else {
                  BlocProvider.of<GithubUserBloc>(context).add(InitGithubUserEvent());
                }
              },
              controller: editingController,
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(child: blocBody()),
        ],
      ),
    );
  }

  Widget blocBody() {
    return BlocBuilder<GithubUserBloc, GithubUserState>(
        builder: (context, state) {
          if (state is InitGithubUserState) {
            return Container();
          }
          if (state is GithubUserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GithubUserErrorState) {
            return const Center(child:  Text("Error"));
          }
          if (state is GithubUserLoadedState) {
            List<GithubUser> userList = state.githubUsers;
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                        color: Theme.of(context).primaryColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage('${userList[index].login}'),
                                ));
                          },
                          title: Text(
                            '${userList[index].login}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${userList[index].location}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                userList[index].gravatar.toString()),
                          ))
                    ),
                  );
                });
          }
          return Container();
        },
      );
    // );
  }
}
