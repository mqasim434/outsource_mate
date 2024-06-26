// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:outsource_mate/models/notification_model.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/client_provider.dart';
import 'package:outsource_mate/providers/notifications_provider.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/consts.dart';
import 'package:outsource_mate/utils/enums.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/utils/utility_functions.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddProjectScreen extends StatefulWidget {
  AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  ProjectProvider projectProvider = ProjectProvider();
  ClientProvider clientProvider = ClientProvider();
  NotificationsProvider notificationsProvider = NotificationsProvider();

  String? selectedFreelancerId;
  String? freelancerEmail;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? deadlineController;
  final TextEditingController deadlineFieldController = TextEditingController();
  final freelancerController = TextEditingController();
  final moduleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<FreelancerModel> freelancersList = [];

  @override
  void initState() {
    // TODO: implement initState

    projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    clientProvider = Provider.of<ClientProvider>(context, listen: false);
    notificationsProvider =
        Provider.of<NotificationsProvider>(context, listen: false);
    projectProvider.files.clear();
    projectProvider.modules.clear();
    fetchFreelancers().then((value) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> fetchFreelancers() async {
    EasyLoading.show(status: 'Loading');
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('freelancers').get();
      freelancersList = querySnapshot.docs.map((e) {
        print(e.data()['email']);
        return FreelancerModel.fromJson(e.data());
      }).toList();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    EasyLoading.dismiss();
  }

  Map<String, dynamic>? paymentIntent = {};

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(amountController.text, 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['clientSecret'],
                  merchantDisplayName: 'Outsource Mate'))
          .then((value) {});
    } catch (e) {
      print(e);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $STRIPER_SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Create Project',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Consumer<ProjectProvider>(
                  builder: (context, projectsProvider, child) {
                return Column(
                  children: [
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
                    DropdownButtonFormField(
                      items: freelancersList
                          .map((e) => DropdownMenuItem(
                                value: e.email.toString(),
                                child: Text(
                                  e.email.toString(),
                                ),
                              ))
                          .toList(),
                      hint: Text('Select a Freelancer'),
                      onChanged: (value) {
                        selectedFreelancerId = value.toString();
                        freelancerController.text = value.toString();
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: deadlineFieldController,
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 5),
                          lastDate: DateTime(DateTime.now().year + 5),
                        );
                        if (pickedDate != null) {
                          final DateTime currentTime = DateTime.now();
                          deadlineController = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            currentTime.hour,
                            currentTime.minute,
                            currentTime.second,
                          );

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
                      textFieldController: amountController,
                      hintText: 'Enter Project Cost',
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "Project Cost can't be empty";
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
                            projectsProvider
                                .addModule({moduleController.text: false});
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
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: screenWidth,
                            height: 200,
                            child: ListView.builder(
                              itemCount: projectsProvider.modules.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                      backgroundColor: MyColors.pinkColor,
                                      child: Text((index + 1).toString())),
                                  title: Text(projectsProvider
                                      .modules[index].keys
                                      .toString()),
                                  trailing: InkWell(
                                      onTap: () {
                                        projectsProvider.removeModule(index);
                                      },
                                      child: const Icon(Icons.close)),
                                );
                              },
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: projectsProvider.modules.isNotEmpty ? 10 : 0,
                    ),
                    InkWell(
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles();

                        if (result != null) {
                          File file = File(result.files.single.path!);
                          String url = await UtilityFunctions
                              .uploadFileToFirebaseStorage(file.path);
                          projectsProvider.addFileUrl({
                            'fileName': file.path.split('/').last,
                            'fileUrl': url
                          });
                        } else {}
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
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
                    SizedBox(
                      height: projectsProvider.files.isNotEmpty ? 10 : 0,
                    ),
                    projectsProvider.files.isNotEmpty
                        ? Container(
                            height: 50,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: projectsProvider.files
                                    .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Chip(
                                            deleteIcon: Icon(
                                              Icons.close,
                                            ),
                                            onDeleted: () {
                                              projectProvider.remoceFileUrl(e);
                                            },
                                            backgroundColor: MyColors.pinkColor,
                                            label:
                                                Text(e['fileName'].toString()),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          )
                        : SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundedRectangularButton(
                      buttonText: 'Create',
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          EasyLoading.show(status: 'Adding Project');
                          print(freelancerController.text);
                          ProjectModel newProject = ProjectModel(
                              projectTitle: titleController.text,
                              projectDescription: descriptionController.text,
                              deadline: deadlineController,
                              projectStatus: 'In Progress',
                              freelancerEmail: freelancerEmail.toString(),
                              startingTime: DateTime.now(),
                              clientEmail: UserModel.currentUser.email,
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
                            descriptionController.clear();
                            NotificationModel notificationModel =
                                NotificationModel(
                              title: 'New Project',
                              description: 'You created a new project',
                              userId: UserModel.currentUser.email,
                              time: DateTime.now(),
                              notificationType: NotificationTypes.PROJECT.name,
                            );
                            NotificationModel freelancerNotification =
                                NotificationModel(
                              title: 'New Project',
                              description:
                                  '${UserModel.currentUser.email} created a new project',
                              userId: freelancerController.text,
                              time: DateTime.now(),
                              notificationType: NotificationTypes.PROJECT.name,
                            );
                            notificationsProvider
                                .addNotification(notificationModel);
                            notificationsProvider
                                .addNotification(freelancerNotification);
                            EasyLoading.dismiss();
                          }).then((value) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Project Created Successfully'),
                                    actions: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  MyColors.pinkColor),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text('Ok'))
                                    ],
                                  );
                                });
                          });
                        }
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
