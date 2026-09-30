import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Brand line drawings on a shared 24-unit grid. Material keys preserve the
/// existing presentation models while all app-owned icons share one stroke.
class CanguruuIcon extends StatelessWidget {
  const CanguruuIcon(this.icon, {super.key, this.size, this.color});
  final IconData icon;
  final double? size;
  final Color? color;
  static final _paths = <IconData, String>{
    Icons.space_dashboard_outlined: 'M3 10 12 3l9 7M5 9v12h5v-7h4v7h5V9',
    Icons.account_balance_wallet_outlined:
        'M20 8H5a2 2 0 0 1 0-4h13v4M3 6v13a2 2 0 0 0 2 2h15V8M20 12h-5v5h5M17 14.5h.01',
    Icons.wallet_outlined:
        'M20 8H5a2 2 0 0 1 0-4h13v4M3 6v13a2 2 0 0 0 2 2h15V8M20 12h-5v5h5M17 14.5h.01',
    Icons.account_balance_outlined:
        'M3 8h18L12 3 3 8Zm2 4v6m5-6v6m4-6v6m5-6v6M3 21h18',
    Icons.credit_card_outlined:
        'M5 5h14a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2ZM3 10h18M6 15h4',
    Icons.credit_card_rounded:
        'M5 5h14a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2ZM3 10h18M6 15h4',
    Icons.event_note_outlined:
        'M6 5h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2ZM4 10h16M8 3v4m8-4v4M8 14h2m4 0h2m-8 3h2',
    Icons.calendar_today_outlined:
        'M6 5h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2ZM4 10h16M8 3v4m8-4v4M8 14h2m4 0h2m-8 3h2',
    Icons.event_available_outlined:
        'M6 5h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2ZM4 10h16M8 3v4m8-4v4M8 14h2m4 0h2m-8 3h2',
    Icons.swap_vert_rounded: 'M8 3v18m-4-4 4 4 4-4M16 21V3m-4 4 4-4 4 4',
    Icons.grid_view_outlined:
        'M3 3h7v7H3V3Zm11 0h7v7h-7V3ZM3 14h7v7H3v-7Zm11 0h7v7h-7v-7Z',
    Icons.tune_rounded: 'M4 7h16M4 17h16M8 4v6m8 4v6',
    Icons.lock_outline_rounded:
        'M5 10h14v11H5V10Zm3 0V6a4 4 0 0 1 8 0v4m-4 5v2',
    Icons.add: 'M12 5v14M5 12h14',
    Icons.close: 'm6 6 12 12M6 18 18 6',
    Icons.chevron_right: 'm9 5 7 7-7 7',
    Icons.chevron_left: 'm15 5-7 7 7 7',
    Icons.south_west: 'M18 6 6 18M6 7v11h11',
    Icons.south_west_rounded: 'M18 6 6 18M6 7v11h11',
    Icons.north_east: 'M6 18 18 6M7 6h11v11',
    Icons.north_east_rounded: 'M6 18 18 6M7 6h11v11',
    Icons.swap_horiz: 'M3 8h18l-4-4M21 16H3l4 4',
    Icons.swap_horiz_rounded: 'M3 8h18l-4-4M21 16H3l4 4',
    Icons.receipt_long_outlined:
        'M5 3 8 5l4-2 4 2 3-2v18l-3-2-4 2-4-2-3 2V3Zm3 6h8m-8 4h8m-8 4h4',
    Icons.search: 'M10.5 3a7.5 7.5 0 1 0 0 15 7.5 7.5 0 0 0 0-15Zm5.5 13 5 5',
    Icons.check_rounded: 'm4 12 5 5L20 6',
    Icons.check_circle: 'M21 11v1a9 9 0 1 1-5.3-8.2M8 11l4 4 9-10',
    Icons.repeat_rounded:
        'm17 2 4 4-4 4M3 11V8a2 2 0 0 1 2-2h16M7 22l-4-4 4-4m14-1v3a2 2 0 0 1-2 2H3',
    Icons.pause_rounded: 'M8 5v14M16 5v14',
    Icons.play_arrow_rounded: 'm7 3 14 9-14 9V3Z',
    Icons.edit_outlined: 'm15 4 5 5M3 21l5-1L21 7l-5-5L3 15v6Z',
    Icons.block_rounded: 'M12 3a9 9 0 1 0 0 18 9 9 0 0 0 0-18Zm-6.5 2.5 13 13',
    Icons.update_rounded: 'M3 4v5h5M3 9a9 9 0 1 1 1 9m8-12v6l4 2',
    Icons.restore_rounded: 'M3 4v5h5M3 9a9 9 0 1 1 1 9m8-12v6l4 2',
    Icons.download_outlined: 'M12 3v12m-4-4 4 4 4-4M4 16v5h16v-5',
    Icons.folder_copy_outlined: 'M3 5h7l2 3h9v13H3V5ZM7 2h6l2 3h6',
    Icons.undo_rounded: 'M3 8h11a6 6 0 0 1 0 12M3 8l5-5m-5 5 5 5',
    Icons.subdirectory_arrow_right: 'M5 3v10h15m-5-5 5 5-5 5',
    Icons.storage_rounded:
        'M3 3h18v7H3V3Zm0 11h18v7H3v-7ZM7 6.5h.01M7 17.5h.01',
    Icons.add_shopping_cart_outlined:
        'M2 3h3l3 12h11l3-8H7M9 19h.01M18 19h.01M14 2v8m-4-4h8',
    Icons.visibility_outlined:
        'M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Zm10-3a3 3 0 1 0 0 6 3 3 0 0 0 0-6Z',
    Icons.visibility_off_outlined:
        'm3 3 18 18M10 5a12 12 0 0 1 12 7s-1 3-4 5M6 6c-3 2-4 6-4 6s3 7 10 7c2 0 3 0 4-1M10 10a3 3 0 0 0 4 4',
  };
  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    final edge = size ?? theme.size ?? 24;
    final stroke =
        color ?? theme.color ?? Theme.of(context).colorScheme.onSurface;
    final path = _paths[icon];
    if (path == null) return Icon(icon, size: edge, color: stroke);
    return Center(
      widthFactor: 1,
      heightFactor: 1,
      child: SvgPicture.string(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="$path" fill="none" stroke="#000" stroke-width="1.65" stroke-linecap="round" stroke-linejoin="round"/></svg>',
        width: edge,
        height: edge,
        excludeFromSemantics: true,
        colorFilter: ColorFilter.mode(stroke, BlendMode.srcIn),
      ),
    );
  }
}
