// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:outsource_mate/models/notification_model.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/client_provider.dart';
import 'package:outsource_mate/providers/notifications_provider.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/components/project_widget.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/enums.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/utils/utility_functions.dart';
import 'package:outsource_mate/views/dashboard/notifications_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ProjectProvider projectsProvider = ProjectProvider();
  ClientProvider clientProvider = ClientProvider();
  NotificationsProvider notificationsProvider = NotificationsProvider();
  String? selectedFreelancerId;
  String? freelancerEmail;

  String getCollectionName() {
    print(UserModel.currentUser.userType);
    if (UserModel.currentUser.userType.toString() ==
        UserRoles.FREELANCER.name) {
      return 'freelancers';
    } else if (UserModel.currentUser.userType.toString() ==
        UserRoles.CLIENT.name) {
      return 'clients';
    } else if (UserModel.currentUser.userType.toString() ==
        UserRoles.EMPLOYEE.name) {
      return 'employees';
    } else {
      return 'N/A';
    }
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? deadlineController;
  final TextEditingController deadlineFieldController = TextEditingController();
  final freelancerController = TextEditingController();
  final moduleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    projectsProvider = Provider.of<ProjectProvider>(context, listen: false);
    clientProvider = Provider.of<ClientProvider>(context, listen: false);
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    if (projectsProvider.projectsList.isEmpty) {
      await projectsProvider.getProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final signinProvider = Provider.of<SigninProvider>(context);

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
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 25,
                    ),
                    title: Text(
                      'Hi! \n${UserModel.currentUser != null ? UserModel.currentUser.email : 'User'}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    subtitle: Text(
                      'Welcome to ${signinProvider.currentRoleSelected.name} Dashboard',
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    trailing: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.notifications);
                        },
                        child: const CircleAvatar(
                            child: Icon(Icons.notifications))),
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
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Active Projects',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                projectsProvider.projectsList.clear();
                                setState(() {});
                              },
                              icon: Icon(Icons.replay_rounded))
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: _loadProjects(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: SizedBox());
                          }
                          if (projectsProvider.projectsList.isEmpty) {
                            return const Center(child: Text("No Projects Yet"));
                          }
                          return ListView.builder(
                            itemCount: projectsProvider.projectsList.length,
                            itemBuilder: (context, index) {
                              final project =
                                  projectsProvider.projectsList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: ProjectWidget(projectModel: project),
                              );
                            },
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
                final formKey = GlobalKey<FormState>();
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
                          key: formKey,
                          child: SingleChildScrollView(
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
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Project title can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('freelancers')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return const Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text("Loading");
                                    }

                                    List<DropdownMenuItem<String>> items = [
                                      const DropdownMenuItem<String>(
                                        value: null,
                                        child: Text('Select a Freelancer'),
                                      ),
                                    ];

                                    for (var documentSnapshot
                                        in snapshot.data!.docs) {
                                      Map<String, dynamic> data =
                                          documentSnapshot.data()!
                                              as Map<String, dynamic>;
                                      items.add(
                                        DropdownMenuItem<String>(
                                          value: documentSnapshot.id,
                                          child: Text(
                                              data['name'] ?? data['email']),
                                        ),
                                      );
                                    }

                                    return DropdownButtonFormField<String>(
                                      value: selectedFreelancerId,
                                      items: items,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                          left: 20,
                                          top: 15,
                                          bottom: 15,
                                          right: 20,
                                        ),
                                      ),
                                      icon: const Icon(
                                          Icons.person_search_rounded),
                                      onChanged: (String? newValue) async {
                                        setState(() {
                                          selectedFreelancerId =
                                              newValue.toString();
                                          print(
                                              'selected ${selectedFreelancerId}');
                                        });
                                        if (newValue != null) {
                                          DocumentSnapshot freelancerDoc =
                                              await FirebaseFirestore.instance
                                                  .collection('freelancers')
                                                  .doc(newValue)
                                                  .get();
                                          freelancerEmail =
                                              freelancerDoc['email'] ?? '';
                                          print(
                                              'Sending ${freelancerDoc['email']}');
                                          setState(() {
                                            freelancerController.text =
                                                freelancerDoc['email'];
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
                                  controller: deadlineFieldController,
                                  readOnly: true,
                                  onTap: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate:
                                          DateTime(DateTime.now().year - 5),
                                      lastDate:
                                          DateTime(DateTime.now().year + 5),
                                    );
                                    if (pickedDate != null) {
                                      final DateTime currentTime =
                                          DateTime.now();
                                      deadlineController = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        currentTime.hour,
                                        currentTime.minute,
                                        currentTime.second,
                                      );

                                      // Format the selected date and set it to the TextEditingController
                                      final DateFormat formatter =
                                          DateFormat('MM/dd/yyyy HH:mm:ss');
                                      deadlineFieldController.text =
                                          formatter.format(deadlineController!);

                                      setState(() {});
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Select Deadline',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    suffixIcon: const Icon(Icons.timer_sharp),
                                    contentPadding: const EdgeInsets.only(
                                      left: 20,
                                      top: 15,
                                      bottom: 15,
                                      right: 20,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Deadline can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyTextField(
                                  textFieldController: descriptionController,
                                  hintText: 'Enter Project Description',
                                  isDescription: true,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Project description can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: moduleController,
                                  decoration: InputDecoration(
                                    hintText: 'Add a Module',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                      left: 20,
                                      top: 15,
                                      bottom: 15,
                                      right: 20,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        projectsProvider.addModule(
                                            {moduleController.text: false});
                                        moduleController.clear();
                                      },
                                      child: const Icon(
                                        Icons.add_circle,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (projectsProvider.modules.isEmpty) {
                                      return "Add one module at least";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                projectsProvider.modules.isNotEmpty
                                    ? const Text(
                                        'Modules:',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 18),
                                      )
                                    : const SizedBox(),
                                projectsProvider.modules.isNotEmpty
                                    ? Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: width,
                                        height: 200,
                                        child: ListView.builder(
                                          itemCount:
                                              projectsProvider.modules.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: CircleAvatar(
                                                  backgroundColor:
                                                      MyColors.pinkColor,
                                                  child: Text(
                                                      (index + 1).toString())),
                                              title: Text(projectsProvider
                                                  .modules[index].keys
                                                  .toString()),
                                              trailing: InkWell(
                                                  onTap: () {
                                                    projectsProvider.modules
                                                        .removeAt(index);
                                                  },
                                                  child:
                                                      const Icon(Icons.close)),
                                            );
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                                SizedBox(
                                  height: projectsProvider.modules.isNotEmpty
                                      ? 10
                                      : 0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final result =
                                        await FilePicker.platform.pickFiles();

                                    if (result != null) {
                                      File file =
                                          File(result.files.single.path!);
                                      String url = await UtilityFunctions
                                          .uploadFileToFirebaseStorage(
                                              file.path);
                                      projectsProvider.addFileUrl({
                                        'fileName': file.path.split('/').last,
                                        'fileUrl': url
                                      });
                                    } else {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const ListTile(
                                      title: Text('Upload a File'),
                                      trailing: CircleAvatar(
                                        child: Icon(Icons.upload_file_rounded),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RoundedRectangularButton(
                                  buttonText: 'Create',
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      print(freelancerController.text);
                                      ProjectModel newProject = ProjectModel(
                                          projectTitle: titleController.text,
                                          projectDescription:
                                              descriptionController.text,
                                          deadline: deadlineController,
                                          projectStatus: 'In Progress',
                                          freelancerEmail:
                                              freelancerEmail.toString(),
                                          startingTime: DateTime.now(),
                                          clientEmail:
                                              UserModel.currentUser.email,
                                          modules: projectsProvider.modules,
                                          files: projectsProvider.files);
                                      projectsProvider
                                          .addProject(newProject, context)
                                          .then((value) {
                                        projectsProvider.modules.clear();
                                        titleController.clear();
                                        freelancerController.clear();
                                        deadlineFieldController.clear();
                                        projectsProvider.files.clear();
                                        NotificationModel notificationModel =
                                            NotificationModel(
                                          title: 'New Project',
                                          description:
                                              'You created a new project',
                                          userId: UserModel.currentUser.email,
                                          time: DateTime.now(),
                                          notificationType:
                                              NotificationTypes.PROJECT.name,
                                        );
                                        notificationsProvider
                                            .addNotification(notificationModel);
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
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
