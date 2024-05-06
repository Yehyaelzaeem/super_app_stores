
import 'package:cogina_restaurants/presentation/modules/auth/auth_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/branches/branch_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/layout_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/account_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/injection.dart';
import 'domain/provider/local_auth_provider_cubit.dart';

class GenerateMultiBloc extends StatelessWidget {
  final Widget child;
  const GenerateMultiBloc({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ///TODO add bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LocalAuthCubit>()),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<LayoutCubit>()),
        BlocProvider(create: (_) => getIt<HomeCubit>()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
        BlocProvider(create: (_) => getIt<BranchCubit>()),
        BlocProvider(create: (_) => getIt<AccountCubit>()),
      ],
      child: child,
    );
  }
}
