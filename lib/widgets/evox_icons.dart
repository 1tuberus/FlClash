import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// EVO-X designer icon set — the exact inline SVG glyphs from the
/// `EVOX App.dc.html` design contract (HUD-outline, 24px viewBox, ~1.8-2px
/// stroke). Rendered via [SvgPicture.string] and tinted with a `srcIn`
/// colour filter so a single line-icon picks up the brand accent (#a78bfa)
/// or, inside a [NavigationBar]/[NavigationRail], the framework's
/// selected/unselected [IconTheme] colour.
class EvoxIcons {
  EvoxIcons._();

  // ── Navigation (sidebar + bottom-nav) ────────────────────────────────
  static const String navDashboard =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="8" height="8" rx="1.6"/><rect x="13" y="3" width="8" height="5" rx="1.6"/><rect x="13" y="11" width="8" height="10" rx="1.6"/><rect x="3" y="14" width="8" height="7" rx="1.6"/></svg>';

  static const String navProxies =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M14 3H7a1 1 0 0 0-1 1v16a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V7z"/><path d="M14 3v4h4"/><path d="M9 13h6M9 16.5h6"/></svg>';

  static const String navProfiles =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M3 7a2 2 0 0 1 2-2h4l2 2h6a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>';

  static const String navRequests =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="4" width="16" height="16" rx="2"/><path d="M8 9h6M8 13h8M8 17h4"/></svg>';

  static const String navConnections =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="7" height="7" rx="1.4"/><path d="M13 5h8M13 9h8M13 15h8M13 19h8"/></svg>';

  static const String navResources =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M4 6h16M4 12h16M4 18h16"/><circle cx="2.5" cy="6" r="1" fill="currentColor" stroke="none"/><circle cx="2.5" cy="12" r="1" fill="currentColor" stroke="none"/><circle cx="2.5" cy="18" r="1" fill="currentColor" stroke="none"/></svg>';

  static const String navLogs =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M7 9l3 3-3 3M13 15h4"/></svg>';

  static const String navTools =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M15 7a4 4 0 0 0-5.2 5.2l-5.4 5.4a1.6 1.6 0 0 0 2.2 2.2l5.4-5.4A4 4 0 0 0 17 9.2l-2.3 2.3-1.4-1.4z"/></svg>';

  // ── Card headers ─────────────────────────────────────────────────────
  /// Скорость сети — clock.
  static const String clock =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 12l4-3"/></svg>';

  /// Режим исходящий — outbound branch.
  static const String branch =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><path d="M5 7h7a4 4 0 0 1 4 4v6"/><path d="M13 5l4 2-4 2"/><circle cx="5" cy="7" r="1.6"/></svg>';

  /// Использование — refresh / round arrow.
  static const String refresh =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12a9 9 0 1 1-3-6.7"/><path d="M21 4v5h-5"/></svg>';

  /// Внутренний — monitor / display.
  static const String monitor =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="5" width="14" height="10" rx="1.5"/><path d="M19 8v9a1.5 1.5 0 0 1-1.5 1.5H8"/></svg>';

  /// Обнаружен (i) — info.
  static const String info =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 11v5"/><circle cx="12" cy="8" r=".9" fill="currentColor" stroke="none"/></svg>';

  /// Память — chip / cpu (designer-style outline).
  static const String chip =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><rect x="6" y="6" width="12" height="12" rx="2"/><rect x="9.5" y="9.5" width="5" height="5" rx="1"/><path d="M9 3v3M15 3v3M9 18v3M15 18v3M3 9h3M3 15h3M18 9h3M18 15h3"/></svg>';

  // ── Traffic arrows ───────────────────────────────────────────────────
  /// Upload — up arrow (designer violet #8B5CF6).
  static const String arrowUp =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M12 19V6M7 11l5-5 5 5"/></svg>';

  /// Download — down arrow (designer green #22D3A3).
  static const String arrowDown =
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M12 5v13M7 13l5 5 5-5"/></svg>';
}

/// EVO-X: tech numeric style — Orbitron (the same font as the connect-pill
/// timer), bold and white by default. Use for every digit value (IPs, speeds,
/// traffic, memory). Orbitron covers Latin + digits only, which is all these
/// values contain.
TextStyle evoxNumberStyle({
  double size = 15,
  FontWeight weight = FontWeight.w700,
  Color color = const Color(0xFFFFFFFF),
}) => TextStyle(
  fontFamily: 'Orbitron',
  fontWeight: weight,
  fontSize: size,
  color: color,
  letterSpacing: 0.2,
);

/// Renders an [EvoxIcons] SVG string at [size], tinted to [color]. When
/// [color] is null it falls back to the ambient [IconTheme] colour (so
/// nav-bar selection states work) and finally to the brand accent.
class EvoxIcon extends StatelessWidget {
  const EvoxIcon(this.svg, {super.key, this.size = 22, this.color});

  final String svg;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint =
        color ?? IconTheme.of(context).color ?? const Color(0xFFA78BFA);
    return SvgPicture.string(
      svg,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
    );
  }
}
