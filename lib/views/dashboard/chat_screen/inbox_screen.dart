// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/client_provider.dart';
import 'package:outsource_mate/providers/employee_provider.dart';
import 'package:outsource_mate/providers/freelancersProvider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen();

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  FreelancersProvider freelancersProvider = FreelancersProvider();
  ClientProvider clientsProvider = ClientProvider();
  EmployeeProvider employeeProvider = EmployeeProvider();

  @override
  void initState() {
    // TODO: implement initState
    freelancersProvider =
        Provider.of<FreelancersProvider>(context, listen: false);
    clientsProvider = Provider.of<ClientProvider>(context, listen: false);
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    if (UserModel.currentUser.userType == UserRoles.CLIENT.name) {
      await freelancersProvider.fetchFreelancers();
    } else if (UserModel.currentUser.userType == UserRoles.EMPLOYEE.name) {
      await freelancersProvider.fetchFreelancers();
    } else {
      await clientsProvider.fetchClients();
      await employeeProvider.fetchEmployees();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: UserModel.currentUser.userType == 'FREELANCER'
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
                            itemCount: clientsProvider.clientsList.length,
                            itemBuilder: (context, index) {
                              final ClientModel clientModel =
                                  clientsProvider.clientsList[index];
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
                                    clientModel.email.toString(),
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
                            itemCount: employeeProvider.employeeList.length,
                            itemBuilder: (context, index) {
                              final EmployeeModel employeeModel =
                                  employeeProvider.employeeList[index];
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
                                    employeeModel.email.toString(),
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
                elevation: 0,
              ),
              body: Column(
                children: [
                  UserModel.currentUser.userType == 'CLIENT'
                      ? freelancersProvider.freelancersList.isEmpty
                          ? const Center(
                              child: Text('No Freelancers Found'),
                            )
                          : Expanded(
                              child: Column(children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteName.aiChatRoom);
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
                              Expanded(
                                child: ListView.builder(
                                  itemCount: freelancersProvider
                                      .freelancersList.length,
                                  itemBuilder: (context, index) {
                                    final FreelancerModel freelancer =
                                        freelancersProvider
                                            .freelancersList[index];

                                    // Check if the freelancer's email is in UserMode.currentUser.freelancersList
                                    if (UserModel.currentUser.freelancersList !=
                                            null &&
                                        UserModel.currentUser.freelancersList!
                                            .contains(freelancer.email)) {
                                      return Card(
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('freelancers')
                                                .where('email',
                                                    isEqualTo: freelancer.email)
                                                .limit(1)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              return ListTile(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      RouteName.chatScreen,
                                                      arguments: {
                                                        'otherUser': freelancer,
                                                      });
                                                },
                                                leading: snapshot.data !=
                                                            null &&
                                                        snapshot.data!.docs
                                                                    .first
                                                                    .data()[
                                                                'imageUrl'] !=
                                                            null
                                                    ? Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(snapshot
                                                                        .data!
                                                                        .docs
                                                                        .first
                                                                        .data()['imageUrl'] ??
                                                                    ''),
                                                          ),
                                                          Container(
                                                            width: 10,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                                color: (snapshot.data !=
                                                                            null &&
                                                                        snapshot.data!.docs.first.data()['isOnline'] ==
                                                                            true)
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .grey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                          ),
                                                        ],
                                                      )
                                                    : Stack(
                                                        children: [
                                                          CircleAvatar(
                                                            child: Icon(
                                                                Icons.person),
                                                          ),
                                                          Container(
                                                              width: 10,
                                                              height: 10,
                                                              decoration: BoxDecoration(
                                                                  color: (snapshot.data !=
                                                                              null &&
                                                                          snapshot.data!.docs.first.data()['isOnline'] ==
                                                                              true)
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20))),
                                                        ],
                                                      ),
                                                title: Text(
                                                  freelancer.name.toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: snapshot
                                                            .connectionState ==
                                                        ConnectionState.waiting
                                                    ? Text('')
                                                    : Text(
                                                        ((snapshot.data !=
                                                                    null) &&
                                                                (snapshot
                                                                        .data!
                                                                        .docs
                                                                        .first
                                                                        .data()['isTyping'] ==
                                                                    true))
                                                            ? 'typing...'
                                                            : 'Last Seen ${snapshot.data!.docs.first.data()['lastSeen'].toString().split(' ')[1]}',
                                                        style: TextStyle(
                                                            color: ((snapshot
                                                                            .data !=
                                                                        null) &&
                                                                    (snapshot
                                                                            .data!
                                                                            .docs
                                                                            .first
                                                                            .data()['isTyping'] ==
                                                                        true))
                                                                ? Colors.green
                                                                : Colors.black),
                                                      ),
                                                // trailing: const Text('8:46 PM'),
                                              );
                                            }),
                                      );
                                    } else {
                                      // Return an empty container if the freelancer's email is not in the list
                                      return Container();
                                    }
                                  },
                                ),
                              )
                            ]))
                      : UserModel.currentUser.userType == 'EMPLOYEE'
                          ? Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.aiChatRoom);
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
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: freelancersProvider
                                            .freelancersList.length,
                                        itemBuilder: (context, index) {
                                          FreelancerModel freelancer =
                                              freelancersProvider
                                                  .freelancersList[index];
                                          return Card(
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    RouteName.chatScreen,
                                                    arguments: {
                                                      'otherUser': freelancer,
                                                    });
                                              },
                                              leading: const CircleAvatar(
                                                child: Icon(Icons.person),
                                              ),
                                              title: Text(
                                                (freelancer.name
                                                            .toString()
                                                            .isNotEmpty ||
                                                        freelancer.name != null)
                                                    ? freelancer.name.toString()
                                                    : freelancer.email
                                                        .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              subtitle: const Text('Hello!'),
                                              trailing: const Text('8:46 PM'),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                ],
              ),
            ),
    );
  }
}
