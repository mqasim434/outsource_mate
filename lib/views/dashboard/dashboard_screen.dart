import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/chat_provider.dart';
import 'package:outsource_mate/providers/client_provider.dart';
import 'package:outsource_mate/providers/freelancersProvider.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/components/project_widget.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ProjectProvider projectsProvider = ProjectProvider();
  ClientProvider clientProvider = ClientProvider();
  String getCollectionName() {
    print(UserModel.currentUser.userType);
    if (UserModel.currentUser.userType.toString() ==
        UserRoles.FREELANCER.name) {
      return 'freelancers';
    } else if (UserModel.currentUser.userType.toString() ==
        UserRoles.CLIENT.name) {
      return 'clients';
    } else if (UserModel.currentUser.userType.toString() == UserRoles.EMPLOYEE.name) {
      return 'employees';
    } else {
      return 'N/A';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    projectsProvider = Provider.of<ProjectProvider>(context,listen: false);
    clientProvider = Provider.of<ClientProvider>(context,listen: false);
    projectsProvider.getProjects(
        UserModel.currentUser.email, getCollectionName());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final signinProvider = Provider.of<SigninProvider>(context);
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final deadlineController = TextEditingController();
    final freelancerController = TextEditingController();

    return Scaffold(
      backgroundColor: MyColors.purpleColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height * 0.2,
              decoration: const BoxDecoration(
                color: MyColors.purpleColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(
                      'Hi! ${UserModel.currentUser != null ? UserModel.currentUser.email : 'User'}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    subtitle: Text(
                      'Welcome to ${signinProvider.currentRoleSelected.name} Dashboard',
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      child: Text(
                        'Active Projects',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: projectsProvider.projectsList.isEmpty
                          ? const Center(
                              child: Text("No Projects Yet"),
                            )
                          : ListView.builder(
                              itemCount: projectsProvider.projectsList.length,
                              itemBuilder: (context, index) {
                                // Print the project to the console to check if it's being displayed
                                print(
                                    'Projects ${projectsProvider.projectsList[index]}');

                                final project =
                                    projectsProvider.projectsList[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: ProjectWidget(
                                    projectModel: project,
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: signinProvider.currentRoleSelected ==
              UserRoles.CLIENT
          ? FloatingActionButton(
              backgroundColor: MyColors.pinkColor,
              onPressed: () {
                String? selectedFreelancerId = null;
                String freelancerEmail = '';
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.5),
                  shape: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).viewInsets.bottom == 0
                          ? MediaQuery.of(context).size.height * 0.60
                          : MediaQuery.of(context).size.height * 0.90,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.cancel)),
                                ],
                              ),
                              const Text(
                                'Create Project',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextField(
                                textFieldController: titleController,
                                hintText: 'Enter Project Title',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('freelancers').snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Text("Loading");
                                  }

                                  List<DropdownMenuItem<String>> items = [
                                    const DropdownMenuItem<String>(
                                      value: null,
                                      child: Text('Select a Freelancer'),
                                    ),
                                  ];

                                  for (var documentSnapshot in snapshot.data!.docs) {
                                    Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
                                    items.add(
                                      DropdownMenuItem<String>(
                                        value: documentSnapshot.id,
                                        child: Text(data['name']),
                                      ),
                                    );
                                  }

                                  return DropdownButtonFormField<String>(
                                    value: selectedFreelancerId,
                                    items: items,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    icon: const Icon(Icons.person_search_rounded),
                                    onChanged: (String? newValue) async {
                                      setState(() {
                                        selectedFreelancerId = newValue.toString();
                                      });
                                      if (newValue != null) {
                                        DocumentSnapshot freelancerDoc = await FirebaseFirestore.instance
                                            .collection('freelancers')
                                            .doc(newValue)
                                            .get();
                                        setState(() {
                                          freelancerEmail = freelancerDoc['email'];
                                          freelancerController.text = freelancerDoc['name'];
                                        });
                                      }
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: deadlineController,
                                readOnly: true,
                                onTap: () async {
                                  final DateTime? pickedDateTime =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 5),
                                    lastDate: DateTime(DateTime.now().year + 5),
                                  );
                                  if (pickedDateTime != null) {
                                    final TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      deadlineController.text =
                                          '${pickedDateTime.day}/${pickedDateTime.month}/${pickedDateTime.year} ${pickedTime.hour}:${pickedTime.minute} ${pickedTime.hour < 12 ? 'AM' : 'PM'}';
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Select Deadline',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                    50,
                                  )),
                                  suffixIcon: const Icon(Icons.timer_sharp),
                                  contentPadding: const EdgeInsets.only(
                                    left: 20,
                                    top: 15,
                                    bottom: 15,
                                    right: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyTextField(
                                textFieldController: descriptionController,
                                hintText: 'Enter Project Description',
                                isDescription: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RoundedRectangularButton(
                                buttonText: 'Create',
                                onPress: () {
                                  ProjectModel newProject = ProjectModel(
                                    projectTitle: titleController.text,
                                    projectDescription:
                                        descriptionController.text,
                                    deadline: deadlineController.text,
                                    projectStatus: 'In Progress',
                                    freelancerName: freelancerController.text,
                                    startingTime: DateTime.now().toString(),
                                    clientName: UserModel.currentUser.name,
                                  );
                                  projectsProvider.addProject(newProject);
                                  clientProvider.addProjectToFreelancerByEmail(freelancerEmail, newProject).then((value){
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text('New Project Created'),
                                        );
                                      },
                                    );
                                  });

                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.add_box_rounded),
            )
          : const SizedBox(),
    );
  }
}
