// widgets
export 'package:dartz/dartz.dart' hide State, Order;
export 'package:flutter/material.dart' hide TextDirection;
export 'package:flutter/services.dart' hide TextInput, TextDirection;
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:get_storage/get_storage.dart';
export 'package:go_router/go_router.dart';
export 'package:logger/logger.dart';
export 'package:riverpod/riverpod.dart';
// models
export 'package:tasker/assets.dart';
// most used packages
export 'package:tasker/core/app_router.dart';
export 'package:tasker/core/extensions/context_extension.dart';
export 'package:tasker/core/extensions/num_extension.dart';
export 'package:tasker/core/extensions/string_extension.dart';
export 'package:tasker/core/extensions/widget_extension.dart';
export 'package:tasker/core/view/widgets/switch_tile.dart';
export 'package:tasker/i18n/strings.g.dart';

export 'core/app_colors.dart';
// translations
export 'core/app_routes.dart';
export 'core/constants.dart';
// network
export 'core/error/failures.dart';
export 'core/feature/data/datasources/local_data_source.dart';
export 'core/feature/data/datasources/remote_data_source.dart';
// routes
export 'core/injection_container.dart';
export 'core/language.dart';
export 'core/network/server_response.dart';
// constants
export 'core/theme.dart';
// utils
export 'core/utils/utils.dart';
export 'core/validators.dart';
export 'core/view/widgets/rounded_corner_button.dart';
export 'core/view/widgets/rounded_corner_loading_button.dart';
export 'core/view/widgets/text_input.dart';
export 'core/view/widgets/valid_button.dart';
