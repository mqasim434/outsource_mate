import 'package:flutter/material.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/providers/user_provider.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/components/project_widget.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final projectProvider = Provider.of<ProjectProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final deadlineController = TextEditingController();
    final employeeController = TextEditingController();

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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text(
                      'Hi! Muhammad Qasim',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    subtitle: Text(
                      'Welcome to Dashboard',
                      style: TextStyle(fontSize: 14, color: Colors.white),
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
                        'Highlights',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Projects',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '3',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Delivery Due less thn 24 hours: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: projectProvider.projectsList.length,
                          itemBuilder: (context, index) {
                            final project = projectProvider.projectsList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: ProjectWidget(
                                title: project.projectTitle.toString(),
                                description: project.deadline.toString(),
                                employeeName: project.employeeName.toString(),
                                startingTime: project.startingTime.toString(),
                                deadline: project.deadline.toString(),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.pinkColor,
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
                        TextFormField(
                          controller: employeeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Select an Employee',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  50,
                                )
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 20,
                              top: 15,
                              bottom: 15,
                              right: 20,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: DropdownButton(
                                underline: Container(),
                                items: userProvider.usersList.map((user) {
                                  return DropdownMenuItem(
                                    value: user.name,
                                    child: Text(user.name ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  employeeController.text = value.toString();
                                },
                              ),
                            )
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: deadlineController,
                          readOnly: true,
                          onTap: () async {
                            final DateTime? pickedDateTime = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5),
                            );
                            if (pickedDateTime != null) {
                              final TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                deadlineController.text = '${pickedDateTime.day}/${pickedDateTime.month}/${pickedDateTime.year} ${pickedTime.hour}:${pickedTime.minute} ${pickedTime.hour < 12 ? 'AM' : 'PM'}';
                              }
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Select Deadline',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    50,
                                  )
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 20,
                                top: 15,
                                bottom: 15,
                                right: 20,
                              ),
                          ),
                        ),
                        // MyTextField(
                        //   textFieldController: deadlineController,
                        //   hintText: 'Select Deadline',
                        // ),
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
                              projectDescription: descriptionController.text,
                              deadline: deadlineController.text,
                              projectStatus: 'In Progress',
                              employeeName: employeeController.text,
                            );
                            projectProvider.projectsList.add(newProject);
                            showDialog(context: context, builder: (context){
                              return const AlertDialog(
                                title: Text('New Project Created'),
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
      ),
    );
  }
}
