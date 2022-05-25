import 'package:flutter/material.dart';

import 'package:pointsf/Services/AuthService/auth_service.dart';

import 'package:pointsf/View/export_all_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final AuthService auth = AuthService();
  String? user = "Loading";
  String? email = "Loading";

  @override
  void initState() {
    super.initState();
    auth;
    user = auth.userName;
    email = auth.getUserEmail();
  }

  setNome() async {
    await auth.setUserName();
    setState(() {
      user = auth.getUserName();
    });
  }

  getFirtsLastLetterFullName() {
    setNome();
    var firstLetterFirstName = user!.split("").first;
    var lastName = user!.split(" ").last;
    var firstLetterLastName = lastName.split("").first;

    return firstLetterFirstName + firstLetterLastName;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 89, 53, 99),
            ),
            currentAccountPicture: CircleAvatar(
              child: Text(
                getFirtsLastLetterFullName(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 240, 240, 240),
            ),
            accountName: Text(auth.userName!),
            accountEmail: Text(email.toString()),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            title: const Text(
              "Conta",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            trailing: const Icon(
              Icons.person_outline_rounded,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UserAccount()),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Pedidos",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyOrders()),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Meus endereços",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            trailing: const Icon(
              Icons.house,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ListAddress()),
              );
            },
          ),
        ],
      ),
    );
  }
}
