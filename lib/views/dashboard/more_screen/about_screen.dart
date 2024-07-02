// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool isIntroductionExpanded = true;
  bool isFeaturesExpanded = false;
  bool isWhyChooseExpanded = false;
  bool isGetStartedExpanded = false;
  bool isContactUsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Outsource Mate'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    if (index == 0) {
                      isIntroductionExpanded = !isIntroductionExpanded;
                    } else if (index == 1) {
                      isFeaturesExpanded = !isFeaturesExpanded;
                    } else if (index == 2) {
                      isWhyChooseExpanded = !isWhyChooseExpanded;
                    } else if (index == 3) {
                      isGetStartedExpanded = !isGetStartedExpanded;
                    } else if (index == 4) {
                      isContactUsExpanded = !isContactUsExpanded;
                    }
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text('Introduction'),
                      );
                    },
                    body: ListTile(
                      title: Text(
                          'Welcome to Outsource Mate, your all-in-one solution for project and employee management. Our platform simplifies the process of assigning projects to freelancers and managing teams effectively, ensuring seamless collaboration and productivity.'),
                    ),
                    isExpanded: isIntroductionExpanded,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text('Key Features'),
                      );
                    },
                    body: ListTile(
                      title: Text(
                          '1. Project Management: Easily create, assign, and track projects. Streamline communication and progress monitoring.\n'
                          '2. Team Collaboration: Build and manage teams of freelancers and employees. Delegate tasks and enhance teamwork.\n'
                          '3. Payment Integration: Seamlessly integrate with Stripe for secure and efficient payment transactions.\n'
                          '4. Task Tracking: Monitor task completion and project milestones in real-time.\n'
                          '5. Reporting Tools: Generate detailed reports on project status, team performance, and financials.\n'
                          '6. User-Friendly Interface: Intuitive design that caters to both clients and freelancers, ensuring a smooth user experience.'),
                    ),
                    isExpanded: isFeaturesExpanded,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text('Why Choose Outsource Mate?'),
                      );
                    },
                    body: ListTile(
                      title: Text(
                          'Efficiency and Productivity: Optimize project workflows and enhance team productivity with our comprehensive management tools.\n'
                          'Secure Payments: Ensure secure and hassle-free transactions with Stripe integration, giving clients and freelancers peace of mind.\n'
                          'Scalability: Scale your business operations effortlessly by managing projects and teams efficiently.\n'
                          'Support and Community: Join a supportive community of clients and freelancers, backed by dedicated customer support.'),
                    ),
                    isExpanded: isWhyChooseExpanded,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text('Get Started'),
                      );
                    },
                    body: ListTile(
                      title: Text(
                          'Ready to elevate your project and team management? Sign up for Outsource Mate today and experience a new level of efficiency and collaboration. Empower your business with our powerful tools and intuitive platform.'),
                    ),
                    isExpanded: isGetStartedExpanded,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text('Contact Us'),
                      );
                    },
                    body: ListTile(
                      title: Text(
                          'Have questions or need assistance? Our support team is available to help you.\n'
                          'Email: support@outsourcemate.com\n'
                          'Phone: +1 (123) 456-7890\n'
                          'Visit our website for more information: www.outsourcemate.com\n'
                          'Thank you for choosing Outsource Mate – revolutionizing project and employee management.'),
                    ),
                    isExpanded: isContactUsExpanded,
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
