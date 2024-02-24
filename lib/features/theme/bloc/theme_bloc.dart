import '/common_libraries.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ThemeSidebarItemExtended>(
      (event, emit) {
        final List<String> collapsedItems = List.from(state.collapsedItems);
        if (collapsedItems.contains(event.collapsedItem)) {
          if (!event.force) {
            collapsedItems.remove(event.collapsedItem);
          }
        } else {
          collapsedItems.add(event.collapsedItem);
        }
        emit(state.copyWith(collapsedItems: collapsedItems));
      },
    );

    on<ThemeSidebarHovered>(
      (event, emit) {
        emit(state.copyWith(hoveredItemName: event.hoveredItemName));
      },
    );

    on<UpdateTheme>(_onUpdateTheme);
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }

  void _onUpdateTheme(
    UpdateTheme event,
    Emitter<ThemeState> emit,
  ) {
    emit(state.copyWith(isDarkThemeOn: event.isDarkThemeOn));
  }
}
