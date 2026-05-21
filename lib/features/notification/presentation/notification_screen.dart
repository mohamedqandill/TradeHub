import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tradehub/core/colors/app_colors.dart';
import 'package:tradehub/core/extensions/base_inherited_context.dart';
import 'package:tradehub/core/extensions/is_dark_mode.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
import 'package:tradehub/core/utils/animations/loading_product_animation.dart';
import 'package:tradehub/core/utils/di/di.dart';
import 'package:tradehub/features/notification/data/models/notification_model.dart';
import 'package:tradehub/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:tradehub/features/notification/presentation/state/notification_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<int>? notificationIds;
  late NotificationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationCubit>()
        ..fetchNotifications()
        ..fetchUnreadCount(),
      child: Scaffold(
        appBar: MainLayoutAppBar(
          widgets: [
            notificationIds != null && notificationIds!.isEmpty
                ? const SizedBox.shrink()
                : InkWell(
                    onTap: () {
                      if (notificationIds!.isEmpty) {
                        return;
                      }
                      cubit.markAllAsRead(notificationIds!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Text(
                            "Mark All",
                            style: context.base.theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.blue),
                          ),
                        )),
                      ),
                    ),
                  )
          ],
          title: "Notifications",
          enableLeading: true,
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
          if (state is NotificationLoading) {
            return loadingProductAnimation();
          }
          final notificationCubit = context.read<NotificationCubit>();
          cubit = notificationCubit;
          notificationIds = notificationCubit.notifications
              .where((e) => !e.isRead)
              .map((e) => e.id)
              .toList();
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return NotificationItemWidget(
                        notification: notificationCubit.notifications[index],
                        onMarkAsRead: () {
                          notificationCubit.markAsRead(
                              notificationCubit.notifications[index].id);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox.shrink();
                    },
                    itemCount: notificationCubit.notifications.length),
              )
            ],
          );
        }),
      ),
    );
  }
}

class NotificationItemWidget extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onMarkAsRead;
  const NotificationItemWidget(
      {super.key, required this.notification, this.onMarkAsRead});

  String _formattedTime() {
    final now = DateTime.now();
    final diff = now.difference(notification.createdAt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return DateFormat('MMM d, h:mm a').format(notification.createdAt);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.lightBlack : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.credit_card_rounded,
                      color: Colors.blueAccent, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1A1A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B6B6B),
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Timestamp + read status
                          Text(
                            _formattedTime(),
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF9E9E9E),
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text('·',
                              style: TextStyle(color: Color(0xFFCCCCCC))),
                          const SizedBox(width: 6),
                          Icon(
                            notification.isRead
                                ? Icons.done_all
                                : Icons.fiber_manual_record,
                            size: 12,
                            color: notification.isRead
                                ? const Color(0xFF9E9E9E)
                                : const Color(0xFF378ADD),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            notification.isRead ? 'Read' : 'Unread',
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xFF9E9E9E)),
                          ),
                          const Spacer(),
                        ],
                      ),
                      // 👇 Mark as read button — only shows when unread
                      if (!notification.isRead && onMarkAsRead != null)
                        GestureDetector(
                          onTap: onMarkAsRead,
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F1FB),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Mark as read',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF185FA5),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!notification.isRead)
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF378ADD),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String type;
  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final colors = {
      'payment': [const Color(0xFFE1F5EE), const Color(0xFF0F6E56)],
      'security': [const Color(0xFFFCEBEB), const Color(0xFFA32D2D)],
      'order': [const Color(0xFFE6F1FB), const Color(0xFF185FA5)],
      'promo': [const Color(0xFFFAEEDA), const Color(0xFF854F0B)],
    };
    final pair =
        colors[type] ?? [const Color(0xFFF1EFE8), const Color(0xFF5F5E5A)];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: pair[0],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type[0].toUpperCase() + type.substring(1),
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.w500, color: pair[1]),
      ),
    );
  }
}
