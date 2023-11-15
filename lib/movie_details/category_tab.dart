import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  String categoryName;
  CategoryTab(this.categoryName);

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 3,bottom: 3,right: 5),
      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white54)
      ),
      child: Text(categoryName,style: theme.textTheme.titleSmall!.copyWith(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w400),),
    );
  }
}
