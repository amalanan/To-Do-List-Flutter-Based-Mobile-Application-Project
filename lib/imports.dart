export 'package:flutter/material.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:todolistgsg/routes.dart';

//widgets

export 'package:todolistgsg/presentation/widgets/items_widgets/task_item.dart';
export 'package:todolistgsg/presentation/widgets/items_widgets/user_item.dart';

export 'package:todolistgsg/presentation/widgets/custom_widgets/custom_text_field.dart';
export 'package:todolistgsg/presentation/widgets/custom_widgets/custom_button.dart';
export 'package:todolistgsg/presentation/widgets/custom_widgets/custom_appbar_title.dart';
export 'package:todolistgsg/presentation/widgets/custom_widgets/logout_widget.dart';
export 'package:todolistgsg/presentation/widgets/custom_widgets/logout_icon.dart';

export 'package:todolistgsg/presentation/widgets/profile_screen_widgets/profile_screen_ui.dart';
export 'package:todolistgsg/presentation/widgets/profile_screen_widgets/profile_screen_circular_progress_indicator.dart';
export 'package:todolistgsg/presentation/widgets/profile_screen_widgets/profile_user_data_list_view.dart';
export 'package:todolistgsg/presentation/widgets/profile_screen_widgets/user_profile_image.dart';
export 'package:todolistgsg/presentation/widgets/profile_screen_widgets/user_profile_image_and_name.dart';

export 'package:todolistgsg/presentation/widgets/dashboard_widgets/motivation_message.dart';
export 'package:todolistgsg/presentation/widgets/dashboard_widgets/build_status_card.dart';
export 'package:todolistgsg/presentation/widgets/dashboard_widgets/weekly_linear_progress_indicator.dart';
export 'package:todolistgsg/presentation/widgets/dashboard_widgets/todays_tasks.dart';
export 'package:todolistgsg/presentation/widgets/dashboard_widgets/stats_cards_grid_view.dart';
export 'package:todolistgsg/presentation/widgets/dashboard_widgets/dashboard_screen_column.dart';

export 'package:todolistgsg/presentation/widgets/crud_screen_widgets/add_new_task_text_field.dart';
export 'package:todolistgsg/presentation/widgets/crud_screen_widgets/edit_task_dialog.dart';

//screens
export 'package:todolistgsg/presentation/screens/auth/login_screen.dart';
export 'package:todolistgsg/presentation/screens/splash/splash.dart';
export 'package:todolistgsg/presentation/screens/auth/signup_screen.dart';

export 'package:todolistgsg/presentation/screens/home_screens/main_navigation_screen.dart';
export 'package:todolistgsg/presentation/screens/home_screens/profile_screen.dart';
export 'package:todolistgsg/presentation/screens/home_screens/tasks_screen.dart';
export 'package:todolistgsg/presentation/screens/home_screens/create_edit_screen.dart';
export 'package:todolistgsg/presentation/screens/home_screens/dashboard_screen.dart';

//models
export 'package:todolistgsg/data/models/task_model.dart';
export 'package:todolistgsg/data/models/user_model.dart';

//services
export 'package:todolistgsg/data/services/api_services/api_service.dart';
export 'package:todolistgsg/data/services/repository/task_service.dart';
export 'package:todolistgsg/data/services/shared_preferences/session_service.dart';
export 'package:todolistgsg/data/services/api_services/auth_service.dart';
export 'package:todolistgsg/data/services/database/tasks_sqlite_db.dart';

//cubits
export 'package:todolistgsg/cubits/task_cubit/task_cubit.dart';
export 'package:todolistgsg/cubits/task_cubit/task_state.dart';
export 'package:todolistgsg/cubits/auth_cubit/auth_cubit.dart';
export 'package:todolistgsg/cubits/auth_cubit/auth_state.dart';
