// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/routes_names.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<InboxScreen> {
  List<FreelancerModel> clientFreelancers = [];
  List<ClientModel> freelancerClients = [];
  List<EmployeeModel> freelancerEmployees = [];
  List<FreelancerModel> employeeFreelancers = [];

  Future<void> fetchClientFreelancers() async {
    EasyLoading.show(status: 'Loading');
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('freelancers').get();

    clientFreelancers = querySnapshot.docs
        .map((e) {
          if (UserModel.currentUser.freelancersList
                  ?.contains(e.data()['email']) ??
              false) {
            return FreelancerModel.fromJson(e.data());
          }
          return null;
        })
        .whereType<FreelancerModel>()
        .toList();

    setState(() {});
    print(clientFreelancers.length);
    EasyLoading.dismiss();
  }

  Future<void> fetchEmployeeFreelancers() async {
    EasyLoading.show(status: 'Loading');
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('freelancers').get();

    clientFreelancers = querySnapshot.docs
        .map((e) {
          if (UserModel.currentUser.freelancersList
                  ?.contains(e.data()['email']) ??
              false) {
            return FreelancerModel.fromJson(e.data());
          }
          return null;
        })
        .whereType<FreelancerModel>()
        .toList();

    setState(() {});
    print(clientFreelancers.length);
    EasyLoading.dismiss();
  }

  Future<void> fetchFreelancerClients() async {
    EasyLoading.show(status: 'Loading');
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('clients').get();

    freelancerClients = querySnapshot.docs
        .map((e) {
          if (UserModel.currentUser.clientsList?.contains(e.data()['email']) ??
              false) {
            return ClientModel.fromJson(e.data());
          }
          return null;
        })
        .whereType<ClientModel>()
        .toList();

    setState(() {});
    print(freelancerClients.length);
    EasyLoading.dismiss();
  }

  Future<void> fetchFreelancerEmployees() async {
    EasyLoading.show(status: 'Loading');
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('employees').get();

    freelancerEmployees = querySnapshot.docs
        .map((e) {
          if (UserModel.currentUser.employeesList
                  ?.contains(e.data()['email']) ??
              false) {
            return EmployeeModel.fromJson(e.data());
          }
          return null;
        })
        .whereType<EmployeeModel>()
        .toList();

    setState(() {});
    print(freelancerEmployees.length);
    EasyLoading.dismiss();
  }

  Future<void> fetchData() async {
    if (UserModel.currentUser.userType == UserRoles.CLIENT.name) {
      await fetchClientFreelancers();
    } else if (UserModel.currentUser.userType == UserRoles.FREELANCER.name) {
      await fetchFreelancerClients();
      await fetchFreelancerEmployees();
    } else if (UserModel.currentUser.userType == UserRoles.EMPLOYEE.name) {
      await fetchEmployeeFreelancers();
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: UserModel.currentUser.userType == UserRoles.FREELANCER.name
          ? Scaffold(
              body: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.aiChatRoom);
                    },
                    child: Card(
                      color: MyColors.purpleColor,
                      child: ListTile(
                        title: Text(
                          'MateBot Assist',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/logo/bot.jpg'),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          centerTitle: true,
                          automaticallyImplyLeading: false,
                          title: const Text(
                            'Inbox',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          bottom: TabBar(
                            tabs: [
                              Tab(
                                icon: Icon(Icons.person),
                                text: 'Clients',
                              ),
                              Tab(
                                icon: Icon(Icons.group),
                                text: 'Employees',
                              ),
                            ],
                          ),
                          elevation: 0,
                        ),
                        body: TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: freelancerClients.length,
                              itemBuilder: (context, index) {
                                final ClientModel clientModel =
                                    freelancerClients[index];
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.chatScreen,
                                          arguments: {
                                            'otherUser': clientModel,
                                          });
                                    },
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    title: Text(
                                      clientModel.name.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: const Text('Hello!'),
                                    trailing: const Text('8:46 PM'),
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: freelancerEmployees.length,
                              itemBuilder: (context, index) {
                                final EmployeeModel employeeModel =
                                    freelancerEmployees[index];
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.chatScreen,
                                          arguments: {
                                            'otherUser': employeeModel,
                                          });
                                    },
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    title: Text(
                                      employeeModel.name.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: const Text('Hello!'),
                                    trailing: const Text('8:46 PM'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: const Text(
                  'Inbox',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              body: UserModel.currentUser.userType == UserRoles.CLIENT
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.aiChatRoom);
                          },
                          child: Card(
                            color: MyColors.purpleColor,
                            child: ListTile(
                              title: Text(
                                'MateBot Assist',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/logo/bot.jpg'),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        clientFreelancers.isEmpty
                            ? Center(
                                child: Text('No Freelancers Found'),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: clientFreelancers.length,
                                  itemBuilder: (context, index) {
                                    FreelancerModel freelancerModel =
                                        clientFreelancers[index];
                                    return Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteName.chatScreen,
                                              arguments: {
                                                'otherUser': freelancerModel,
                                              });
                                        },
                                        leading: const CircleAvatar(
                                          child: Icon(Icons.person),
                                        ),
                                        title: Text(
                                          freelancerModel.name.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: const Text('Hello!'),
                                        trailing: const Text('8:46 PM'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    )
                  : Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.aiChatRoom);
                          },
                          child: Card(
                            color: MyColors.purpleColor,
                            child: ListTile(
                              title: Text(
                                'MateBot Assist',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/logo/bot.jpg'),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        employeeFreelancers.isEmpty
                            ? Center(
                                child: Text('No Freelancers Found'),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: employeeFreelancers.length,
                                  itemBuilder: (context, index) {
                                    FreelancerModel freelancerModel =
                                        employeeFreelancers[index];
                                    return Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteName.chatScreen,
                                              arguments: {
                                                'otherUser': freelancerModel,
                                              });
                                        },
                                        leading: const CircleAvatar(
                                          child: Icon(Icons.person),
                                        ),
                                        title: Text(
                                          freelancerModel.name.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: const Text('Hello!'),
                                        trailing: const Text('8:46 PM'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
            ),
    );
  }
}
