import 'package:expense_tracker/Firebase/Auth/AuthLogin.dart';
import 'package:expense_tracker/Provider/providerDB.dart';
import 'package:expense_tracker/Screens/Home.dart';
import 'package:expense_tracker/Screens/Splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider, Consumer;

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Authlogin();
        } else {
          final provider = Provider.of<ExpenseProvider>(context, listen: false);
          provider.listenToBudget();
          provider.listenToExpenses();
          return Consumer<ExpenseProvider>(
            builder: (context, p, _) {
              if (p.isLoadingBudget || p.isLoadingExpenses) {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              else if (p.budget <=0) {
                return Splash();
              }

              return Home(current: p.budget.toString());
            },
          );
        }
      },
    );
  }
}
