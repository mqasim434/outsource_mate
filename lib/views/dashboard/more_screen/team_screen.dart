import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/employee_provider.dart';
import 'package:outsource_mate/providers/freelancersProvider.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/utility_functions.dart';
import 'package:provider/provider.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final roleController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Team',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('employees').snapshots(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : snapshot.data!.docs.isEmpty
                    ? const Center(
                        child: Text('No Employee Yet'),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TeamMemberWidget(
                              employeeModel: EmployeeModel.fromJson(
                                  snapshot.data!.docs[index].data()),
                            ),
                          );
                        },
                      );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
                      ? MediaQuery.of(context).size.height * 0.55
                      : MediaQuery.of(context).size.height * 0.85,
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
                            'Add New Employee',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                            textFieldController: nameController,
                            hintText: 'Enter Employee Name',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                            textFieldController: emailController,
                            hintText: 'Enter Email',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                            textFieldController: phoneController,
                            hintText: 'Enter Phone',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                            textFieldController: roleController,
                            hintText: 'Enter Employee Role',
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          RoundedRectangularButton(
                            buttonText: 'Add Employee',
                            onPress: () {
                              EmployeeModel newEmployee = EmployeeModel(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                position: roleController.text,
                              );
                              employeeProvider.createEmployee(
                                  newEmployee, context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text('New Employee Added'),
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
          child: const Icon(Icons.person_add),
        ),
      ),
    );
  }
}

class TeamMemberWidget extends StatefulWidget {
  const TeamMemberWidget({super.key, required this.employeeModel});
  final EmployeeModel employeeModel;

  @override
  State<TeamMemberWidget> createState() => _TeamMemberWidgetState();
}

class _TeamMemberWidgetState extends State<TeamMemberWidget> {
  ProjectProvider projectProvider = ProjectProvider();
  FreelancersProvider freelancersProvider = FreelancersProvider();
  @override
  void initState() {
    // TODO: implement initState
    projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    projectProvider.getProjects(
        UserModel.currentUser.email.toString(),
        UtilityFunctions.getCollectionName(
            UserModel.currentUser.userType.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    print(widget.employeeModel.empId);
    return Container(
      width: screenWidth * 0.45,
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
        gradient: MyColors.purplePinkGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.employeeModel.name.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 0.6,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.employeeModel.position.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  child: Icon(
                    Icons.chat,
                    size: 10,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 10,
                  child: Icon(
                    Icons.call,
                    size: 10,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Center(
              child: SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Assign Project'),
                            content: SizedBox(
                              width: screenWidth * 0.8,
                              height: 200,
                              child: ListView.builder(
                                  itemCount:
                                      projectProvider.projectsList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(projectProvider
                                            .projectsList[index].projectTitle
                                            .toString()),
                                        leading: Radio(
                                          value: index,
                                          groupValue: projectProvider.selectedProjectIndex,
                                          onChanged: (value) {
                                            print(value);
                                            projectProvider.updateIndex(value as int);
                                            setState(() {

                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            actions: [
                              RoundedRectangularButton(buttonText: 'Assign', onPress: (){
                                freelancersProvider.assignProjectToEmployee(widget.employeeModel.email.toString(), projectProvider.projectsList[projectProvider.selectedProjectIndex]).then((value){
                                  Navigator.pop(context);
                                });
                              }),
                            ],
                          );
                        });
                  },
                  child: const Text('Assign Project'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
