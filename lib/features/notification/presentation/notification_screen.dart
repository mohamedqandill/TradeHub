import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradehub/core/shared_widgets/app_bars/main_layout_app_bar.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationCubit>()
        ..fetchNotifications()
        ..fetchUnreadCount(),
      child: Scaffold(
        appBar: const MainLayoutAppBar(
          title: "Notifications",
          enableLeading: true,
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
          final notificationCubit = context.read<NotificationCubit>();
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

  Color _iconBg(BuildContext context) {
    switch (notification.type) {
      case 'payment':
        return const Color(0xFFE1F5EE);
      case 'security':
        return const Color(0xFFFCEBEB);
      case 'order':
        return const Color(0xFFE6F1FB);
      case 'promo':
        return const Color(0xFFFAEEDA);
      default:
        return const Color(0xFFF1EFE8);
    }
  }

  Color _iconColor() {
    switch (notification.type) {
      case 'payment':
        return const Color(0xFF0F6E56);
      case 'security':
        return const Color(0xFFA32D2D);
      case 'order':
        return const Color(0xFF185FA5);
      case 'promo':
        return const Color(0xFF854F0B);
      default:
        return const Color(0xFF5F5E5A);
    }
  }

  IconData _icon() {
    switch (notification.type) {
      case 'payment':
        return Icons.credit_card_rounded;
      case 'security':
        return Icons.shield_rounded;
      case 'order':
        return Icons.inventory_2_rounded;
      case 'promo':
        return Icons.local_offer_rounded;
      default:
        return Icons.settings_rounded;
    }
  }

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
        color: Colors.white,
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
                    color: _iconBg(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(_icon(), color: _iconColor(), size: 20),
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

                          // 👇 Mark as read button — only shows when unread
                          if (!notification.isRead && onMarkAsRead != null)
                            GestureDetector(
                              onTap: onMarkAsRead,
                              child: Container(
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
