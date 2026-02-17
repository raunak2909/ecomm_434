import 'package:ecomm_434/data/remote/helper/api_helper.dart';
import 'package:ecomm_434/domain/constants/app_constants.dart';
import 'package:ecomm_434/domain/constants/app_urls.dart';
import 'package:ecomm_434/ui/on_boarding/bloc/user_event.dart';
import 'package:ecomm_434/ui/on_boarding/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiHelper apiHelper;

  UserBloc({required this.apiHelper}) : super(UserInitialState()) {
    on<UserRegisterEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrls.register_url,
          isAuth: true,
          mBodyParams: {
            "name": event.name,
            "mobile_number": event.mobNo,
            "email": event.email,
            "password": event.pass,
          },
        );

        if (data["status"]) {
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    on<UserLoginEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrls.login_url,
          isAuth: true,
          mBodyParams: {"email": event.email, "password": event.pass},
        );

        if (data["status"]) {
          emit(UserSuccessState());

          ///prefs
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(AppConstants.PREF_USER_TOKEN, data["tokan"]);
        } else {
          emit(UserFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });
  }
}
