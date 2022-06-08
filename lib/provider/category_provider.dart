import 'package:flutter/material.dart';
import 'package:swape_user_app/data/model/response/base/api_response.dart';
import 'package:swape_user_app/data/model/response/category.dart';
import 'package:swape_user_app/data/repository/category_repo.dart';
import 'package:swape_user_app/helper/api_checker.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepo categoryRepo;

  CategoryProvider({@required this.categoryRepo});

  List<AllCategory> _categoryList = [];
  int _categorySelectedIndex;

  List<AllCategory> get categoryList => _categoryList;
  int get categorySelectedIndex => _categorySelectedIndex;

  Future<void> getCategoryList(
      bool reload, BuildContext context, String languageCode) async {
    if (_categoryList.length == 0 || reload) {
      ApiResponse apiResponse =
          await categoryRepo.getCategoryList(languageCode);
      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        _categoryList.clear();
        apiResponse.response.data.forEach(
            (category) => _categoryList.add(AllCategory.fromJson(category)));
        _categorySelectedIndex = 0;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
    return _categoryList;
  }

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }
}
