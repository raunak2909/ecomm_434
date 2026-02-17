import 'package:ecomm_434/data/remote/helper/api_helper.dart';
import 'package:ecomm_434/data/remote/models/product_model.dart';
import 'package:ecomm_434/domain/constants/app_urls.dart';
import 'package:ecomm_434/ui/dashboard/nav_pages/home/bloc/product_event.dart';
import 'package:ecomm_434/ui/dashboard/nav_pages/home/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ApiHelper apiHelper;

  ProductBloc({required this.apiHelper}) : super(ProductInitialState()) {
    on<FetchAllProductEvent>((event, emit) async{
      emit(ProductLoadingState());

      try {

        dynamic mData = await apiHelper.postAPI(url: AppUrls.product_url);
        if(mData["status"]){
          List<ProductModel> mProducts = [];
          for(Map<String, dynamic> eachMap in mData["data"]){
            mProducts.add(ProductModel.fromJson(eachMap));
          }
          emit(ProductLoadedState(products: mProducts));
        } else {
          emit(ProductErrorState(errorMsg: mData["message"]));
        }

      } catch (e) {
        emit(ProductErrorState(errorMsg: e.toString()));
      }
    });
  }
}
