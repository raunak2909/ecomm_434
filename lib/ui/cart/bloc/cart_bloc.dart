import 'package:ecomm_434/data/remote/helper/api_helper.dart';
import 'package:ecomm_434/domain/constants/app_urls.dart';
import 'package:ecomm_434/ui/cart/bloc/cart_event.dart';
import 'package:ecomm_434/ui/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState>{
  ApiHelper apiHelper;
  CartBloc({required this.apiHelper}) : super(CartInitialState()){
    
    on<AddToCartEvent>((event, emit) async {
      
      emit(CartLoadingState());
      
      try{
        
        dynamic mData = await apiHelper.postAPI(url: AppUrls.add_to_cart_url, mBodyParams: {
          "product_id": event.productId,
          "quantity": event.qty
        });

        if(mData["status"] == "true" || mData["status"]){ ///true, "true"
          emit(CartSuccessState());
        }else{
          emit(CartFailureState(errorMsg: mData["message"]));
        }
        
      } catch (e){
        emit(CartFailureState(errorMsg: e.toString()));
      }
      
    });
    
  }
}