import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/providers/projects_filter_widget_provider.dart';
import 'package:outsource_mate/res/components/project_widget.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:provider/provider.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final filterProvider = Provider.of<ProjectsFilterWidgetProvider>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Projects',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ProjectsFilterWidget(
                    label: 'In Progress',
                    count: projectProvider
                        .getProjectsTypeCount('In Progress')
                        .toString(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ProjectsFilterWidget(
                    label: 'In Revision',
                    count: projectProvider
                        .getProjectsTypeCount('In Revision')
                        .toString(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ProjectsFilterWidget(
                    label: 'Completed',
                    count: projectProvider
                        .getProjectsTypeCount('Completed')
                        .toString(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ProjectsFilterWidget(
                    label: 'Cancelled',
                    count: projectProvider
                        .getProjectsTypeCount('Cancelled')
                        .toString(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: projectProvider.projectsList.where((element) => element.projectStatus==filterProvider.selectedLabel).length,
                itemBuilder: (context, index) {
                  final project = projectProvider.projectsList[index];
                  if (projectProvider.projectsList.isNotEmpty) {
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
                  } else {
                    return const Center(
                      child: Text(
                        'No Project Yet',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    ));
  }
}

class ProjectsFilterWidget extends StatelessWidget {
  const ProjectsFilterWidget({
    super.key,
    required this.label,
    required this.count,
  });

  final String? label;
  final String? count;

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<ProjectsFilterWidgetProvider>(context);
    return InkWell(
      onTap: () {
        filterProvider.switchLabel(label.toString());
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            color: filterProvider.selectedLabel == label.toString()
                ? MyColors.purpleColor
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: filterProvider.selectedLabel == label.toString()
                    ? Colors.transparent
                    : MyColors.purpleColor)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Text(
                label.toString(),
                style: TextStyle(
                  color: filterProvider.selectedLabel == label.toString()
                      ? Colors.white
                      : MyColors.purpleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: filterProvider.selectedLabel == label.toString()
                    ? Colors.white
                    : MyColors.purpleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5.0,
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: filterProvider.selectedLabel == label.toString()
                        ? MyColors.purpleColor
                        : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
