import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_expense/create_expense_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_categorybloc/create_categorybloc_bloc.dart';
import 'package:expense_tracker/screens/add_expense/views/add_expense.dart';
import 'package:expense_tracker/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expense_tracker/screens/home/views/MainScreen.dart';
import 'package:expense_tracker/screens/stats/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  late Color selecteditem = Colors.blue;
  Color unselecteditem = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if(state is GetExpensesSuccess) {

        
        return Scaffold(
          body: index == 0 ? MainScreen(state.expenses) : StatsScreen(),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            child: BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
                // showSelectedLabels: false,
                // showUnselectedLabels: false,

                elevation: 3,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.home,
                        color: index == 0 ? selecteditem : unselecteditem,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.graph_square_fill,
                        color: index == 1 ? selecteditem : unselecteditem,
                      ),
                      label: 'Stats'),
                ]),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () async{
              var newExpense = await Navigator.push(
                  context,
                  MaterialPageRoute<Expense>(
                      builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    CreateCategoryblocBloc(FirebaseExpense()),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    GetCategoriesBlocBloc(FirebaseExpense())
                                      ..add(GetCategories()),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    CreateExpenseBloc(FirebaseExpense()),
                              ),
                            ],
                            child: AddExpense(),
                          )));

                          if(newExpense != null) {
                            setState(() {
                              state.expenses.insert(0,newExpense);
                            });
                          }
            },
            shape: CircleBorder(),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary
                    ],
                    transform: GradientRotation(pi / 4),
                  )),
              child: const Icon(CupertinoIcons.add),
            ),
          ),
        );
        }else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
