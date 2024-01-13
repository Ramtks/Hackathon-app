import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/app_routes.dart';
import 'package:hackathon_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:hackathon_app/features/home/components/streamer_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var items = [
      'profile',
      'logout',
    ];
    return Scaffold(
      body: RefreshIndicator(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Parties',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(
                        child: DropdownButton(
                          underline: const SizedBox(),
                          // Down Arrow Icon
                          icon: const SizedBox(
                              height: 40, width: 40, child: Icon(Icons.menu)),
                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            switch (newValue) {
                              case 'profile':
                                context.pushNamed(AppRoutes.profilePage);
                              case 'logout':
                                context
                                    .read<AuthenticationBloc>()
                                    .add(LogoutButtonPressed());

                              default:
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) => PartyCard(
                            name: 'name',
                            movieName: 'movieName',
                            onPressed: () =>
                                context.pushNamed(AppRoutes.partyPage)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onRefresh: () {
            return Future.value(null);
          }),
    );
  }
}
