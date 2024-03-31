import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    super.key,
    this.backgroundColor = Colors.green,
    this.iconsColor = Colors.white,
    this.circleColor = Colors.yellow
  });

  final Color backgroundColor;
  final Color iconsColor;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {

    final switchProvider = Provider.of<SwitchButtonProvider>(context);

    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),

      child: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home_outlined,color: iconsColor,),
                Icon(Icons.location_on_outlined,color: iconsColor,),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: switchProvider._selectedSide=='left'?MainAxisAlignment.start:MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      switchProvider.changeSelectedSide();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: circleColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchButtonProvider extends ChangeNotifier{
  String _selectedSide = 'left';
  PageController pageController = PageController();

  String get selectedSide => _selectedSide;

  void changeSelectedSide(){
    if(_selectedSide=='left'){
      _selectedSide = 'right';
      pageController.animateToPage(1, duration: Duration(milliseconds: 10), curve: Curves.ease);
    }else{
      _selectedSide='left';
      pageController.animateToPage(0, duration: Duration(milliseconds: 10), curve: Curves.ease);
    }
    notifyListeners();
  }

}

