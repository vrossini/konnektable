import 'package:flutter/material.dart';
import 'package:konnektable/models/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konnektable/bloc/app_blocs.dart';
import 'package:konnektable/bloc/app_events.dart';
import 'package:konnektable/bloc/app_states.dart';
import 'package:konnektable/repo/repositories.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RepoPage extends StatefulWidget {
  final String login;
  const RepoPage(this.login, {super.key});

  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {

  bool isDescending = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RepoBloc>(
          create: (BuildContext context) => RepoBloc(RepoRepository(widget.login)),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(title: const Text('Repositories')),
          body: blocBody()),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => RepoBloc(
        RepoRepository(widget.login),
      )..add(LoadRepoEvent()),
      child: BlocBuilder<RepoBloc, RepoState>(
        builder: (context, state) {
          if (state is RepoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RepoErrorState) {
            return const Center(child:  Text("Error"));
          }
          if (state is RepoLoadedState) {
            List<Repo> repoList = state.repos;
            repoList.sort((a, b) => a.stars.toString().compareTo(b.stars.toString()));
            return Column(
              children: [
                TextButton.icon(
                    onPressed: () => setState(() => isDescending = !isDescending),
                    icon: const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(Icons.compare_arrows, size: 28),
                    ),
                    label: Text(
                      isDescending ? 'Descending' : 'Ascending',
                      style: const TextStyle(fontSize: 16),
                    )
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: repoList.length,
                        itemBuilder: (_, index) {
                          final sortedItems = isDescending ? repoList.reversed.toList() : repoList;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Card(
                              color: Theme.of(context).primaryColor,
                              child: ListTile(
                                contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                                title: Text(
                                  '${sortedItems[index].name}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  sortedItems[index].description.toString().length > 80
                                      ? sortedItems[index].description.toString().substring(0, 80)
                                      : sortedItems[index].description.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: RatingBarIndicator(
                                  rating: sortedItems[index].stars ?? 0,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 12,
                                ),
                              ),
                            ),
                          );
                        }),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
