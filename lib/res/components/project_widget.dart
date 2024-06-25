import 'package:flutter/material.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/utils/routes_names.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({super.key, required this.projectModel});

  final ProjectModel projectModel;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.projectDetailsScreen,
            arguments: {'project': projectModel});
      },
      child: Container(
        width: width,
        height: height * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            20,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                projectModel.projectTitle.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    UserModel.currentUser.userType == 'CLIENT'
                        ? 'Freelancer Email: '
                        : UserModel.currentUser.userType == 'FREELANCER'
                            ? 'Employee Email'
                            : 'Freelancer Name',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    UserModel.currentUser.userType == 'CLIENT'
                        ? projectModel.freelancerEmail.toString()
                        : UserModel.currentUser.userType == 'FREELANCER'
                            ? projectModel.employeeEmail.toString()
                            : projectModel.freelancerEmail.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Started on: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    projectModel.startingTime.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Due on:  ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    projectModel.deadline.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time Remaining: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '11:26:25',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
