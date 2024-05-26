import 'package:flutter/material.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/client_provider.dart';
import 'package:outsource_mate/providers/freelancersProvider.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    freelancersProvider =
        Provider.of<FreelancersProvider>(context, listen: false);
    clientsProvider = Provider.of<ClientProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    freelancersProvider.fetchFreelancers();
    clientsProvider.fetchClients();
    return SafeArea(
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
          elevation: 0,
        ),
        body: UserModel.currentUser.userType == 'CLIENT'
            ? freelancersProvider.freelancersList.isEmpty
                ? const Center(
                    child: Text('No Freelancers Found'),
                  )
                : ListView.builder(
                    itemCount: freelancersProvider.freelancersList.length,
                    itemBuilder: (context, index) {
                      final FreelancerModel freelancer =
                          freelancersProvider.freelancersList[index];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.chatScreen,
                                arguments: {
                                  'otherUser': freelancer,
                                });
                          },
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(
                            freelancer.name.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text('Hello!'),
                          trailing: const Text('8:46 PM'),
                        ),
                      );
                    },
                  )
            : UserModel.currentUser.userType == 'FREELANCER'
                ? clientsProvider.clientsList.isNotEmpty? ListView.builder(
                    itemCount: clientsProvider.clientsList.length,
                    itemBuilder: (context, index) {
                      final ClientModel clientModel =
                          clientsProvider.clientsList[index];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.chatScreen,
                                arguments: {
                                  'otherUser':
                                      clientModel,
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
                  ):Text('')
                : Text(''),
      ),
    );
  }
}
