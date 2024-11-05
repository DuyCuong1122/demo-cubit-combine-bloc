import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';
import 'profile_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ProfileBloc()),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cubit và bloc"), centerTitle : true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState.isAuthenticated) {
                  context.read<ProfileBloc>().add(FetchProfile());
                  return Center(
                    child: Column(
                      children: [
                        const Text("Đăng nhập"),
                        ElevatedButton(
                          onPressed: () => context.read<AuthCubit>().logout(),
                          child: const Text("Đăng xuất"),
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, profileState) {
                            if (profileState is ProfileLoading) {
                              return const CircularProgressIndicator();
                            } else if (profileState is ProfileLoaded) {
                              return Column(
                                children: [
                                  Text("Username: ${profileState.username}"),
                                  ElevatedButton(
                                    onPressed: () => context.read<ProfileBloc>().add(UpdateProfile("Văn Vương")),
                                    child: const Text("Cập nhật hồ sơ"),
                                  ),
                                ],
                              );
                            } else if (profileState is ProfileError) {
                              return Text("Lỗi: ${profileState.message}");
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      const Text("Mời đăng nhập"),
                      ElevatedButton(
                        onPressed: () => context.read<AuthCubit>().login(),
                        child: const Text("Đăng nhập"),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
