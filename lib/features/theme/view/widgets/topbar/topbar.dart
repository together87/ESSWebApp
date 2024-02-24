import '../sidebar/widgets/header.dart';
import '/common_libraries.dart';
import '/features/theme/view/widgets/topbar/topbar_widgets/logo.dart';
import '/features/theme/view/widgets/topbar/topbar_widgets/search_field.dart';

class Topbar extends StatelessWidget {
  const Topbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, stateTheme) {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Container(
            height: topbarHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    Logo(),
                    SearchField(),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ThemeBloc>().add(UpdateTheme(isDarkThemeOn: stateTheme.isDarkThemeOn ? false : true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Icon(
                          stateTheme.isDarkThemeOn ? Icons.dark_mode : Icons.light_mode,
                          color: black.withOpacity(0.8),
                        ),
                      ),
                    ),
                    spacerx5,
                    Header(
                      isSidebarExtended: false,
                      userName: state.authUser?.name ?? '',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
