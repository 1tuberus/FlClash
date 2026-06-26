import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';

import 'fade_box.dart';
import 'text.dart';

class Info {
  final String label;
  final IconData? iconData;

  /// EVO-X: optional designer SVG glyph (takes precedence over [iconData]).
  final Widget? icon;

  const Info({required this.label, this.iconData, this.icon});
}

class InfoHeader extends StatelessWidget {
  final Info info;
  final List<Widget> actions;
  final EdgeInsets? padding;

  const InfoHeader({
    super.key,
    required this.info,
    this.padding,
    List<Widget>? actions,
  }) : actions = actions ?? const [];

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry nextPadding = (padding ?? baseInfoEdgeInsets);
    if (actions.isNotEmpty) {
      nextPadding = nextPadding.subtract(EdgeInsets.symmetric(vertical: 8.mAp));
    }
    return Padding(
      padding: nextPadding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (info.icon != null) ...[
                  // EVO-X: designer header glyphs are brand accent (#a78bfa).
                  IconTheme.merge(
                    data: const IconThemeData(
                      color: Color(0xFFA78BFA),
                      size: 20,
                    ),
                    child: info.icon!,
                  ),
                  const SizedBox(width: 8),
                ] else if (info.iconData != null) ...[
                  Icon(
                    info.iconData,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  flex: 1,
                  child: TooltipText(
                    text: Text(
                      info.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (actions.isNotEmpty)
            SizedBox(
              height: globalState.measure.titleSmallHeight + 16.ap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [...actions],
              ),
            ),
        ],
      ),
    );
  }
}

class CommonCard extends StatelessWidget {
  const CommonCard({
    super.key,
    bool? isSelected,
    this.type = CommonCardType.plain,
    this.onPressed,
    this.selectWidget,
    this.radius,
    required this.child,
    this.padding,
    this.enterAnimated = false,
    this.info,
    this.onLongPress,
    this.shape,
    this.isError = false,
  }) : isSelected = isSelected ?? false;

  final bool enterAnimated;
  final bool isSelected;
  final bool isError;
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final Widget? selectWidget;
  final Widget child;
  final EdgeInsets? padding;
  final Info? info;
  final CommonCardType type;
  final double? radius;
  final OutlinedBorder? shape;

  BorderSide _buildBorderSide(BuildContext context, Set<WidgetState> states) {
    final colorScheme = context.colorScheme;
    if (isError) {
      if (type == CommonCardType.filled) {
        return BorderSide(color: colorScheme.error);
      }
      final hoverColor = isSelected
          ? colorScheme.error.opacity80
          : colorScheme.error.opacity38;
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.focused) ||
          states.contains(WidgetState.pressed)) {
        return BorderSide(color: hoverColor);
      }
      return BorderSide(
        color: isSelected
            ? colorScheme.error.opacity60
            : colorScheme.error.opacity30,
      );
    }
    if (type == CommonCardType.filled) {
      return BorderSide.none;
    }
    // EVO-X: brand neon border (hardcoded #8B5CF6 — Material3 remaps primary to a pale tint).
    if (states.contains(WidgetState.hovered) ||
        states.contains(WidgetState.focused) ||
        states.contains(WidgetState.pressed)) {
      return const BorderSide(width: 1.4, color: Color(0xCC8B5CF6));
    }
    return BorderSide(
      width: isSelected ? 1.6 : 1.0,
      color: isSelected ? const Color(0xE6A78BFA) : const Color(0x298B5CF6),
    );
  }

  // EVO-X: selected proxy/profile card gradient (design linear-gradient(145deg,
  // #6d54c8, #4b3a96)) — painted by the wrapper DecoratedBox in [build].
  static const _selectedGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6D54C8), Color(0xFF4B3A96)],
  );

  Color? _buildBackgroundColor(BuildContext context) {
    final colorScheme = context.colorScheme;
    // Selected (non-error) → transparent so the gradient wrapper shows through.
    if (isSelected && !isError) {
      return Colors.transparent;
    }
    // if (isError) {
    //   if (type == CommonCardType.filled) {
    //     return isSelected
    //         ? colorScheme.errorContainer.opacity80
    //         : colorScheme.errorContainer;
    //   }
    //   return isSelected
    //       ? colorScheme.errorContainer.opacity60
    //       : colorScheme.errorContainer.opacity12;
    // }
    if (type == CommonCardType.filled) {
      if (isSelected) {
        return colorScheme.secondaryContainer.opacity80;
      }
      return colorScheme.surfaceContainerHigh;
    }
    // EVO-X: glassy dark navy surface (design rgba(17,24,39,.55)); selected = deep violet.
    if (isSelected) {
      return const Color(0xE64B3A96);
    }
    return const Color(0x8C111827);
  }

  Color? _buildForegroundColor(BuildContext context) {
    final colorScheme = context.colorScheme;
    if (isError) {
      return colorScheme.error;
    }
    if (type == CommonCardType.filled) {
      if (isSelected) {
        return colorScheme.onSecondaryContainer;
      }
      return colorScheme.onSurfaceVariant;
    }
    if (isSelected) {
      return colorScheme.onSecondaryContainer;
    }
    return colorScheme.onSurfaceVariant;
  }

  Color? _buildIconColor(BuildContext context) {
    final colorScheme = context.colorScheme;
    if (isError) {
      return colorScheme.error;
    }
    return colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    var childWidget = child;

    if (info != null) {
      childWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InfoHeader(
            padding: baseInfoEdgeInsets.copyWith(bottom: 0),
            info: info!,
          ),
          Flexible(flex: 1, child: child),
        ],
      );
    }

    if (selectWidget != null && isSelected) {
      final List<Widget> children = [];
      children.add(childWidget);
      children.add(Positioned.fill(child: selectWidget!));
      childWidget = Stack(children: children);
    }

    final card = switch (type == CommonCardType.filled) {
      true => FilledButton(
        onLongPress: onLongPress,
        clipBehavior: Clip.antiAlias,
        style:
            FilledButton.styleFrom(
              padding: padding ?? EdgeInsets.zero,
              shape:
                  shape ??
                  RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(radius ?? 16),
                  ),
              iconSize: 20,
              iconColor: _buildIconColor(context),
              foregroundColor: _buildForegroundColor(context),
              side: BorderSide.none,
              elevation: 0,
            ).copyWith(
              backgroundColor: WidgetStatePropertyAll(
                _buildBackgroundColor(context),
              ),
              side: WidgetStateProperty.resolveWith(
                (states) => _buildBorderSide(context, states),
              ),
            ),
        onPressed: onPressed,
        child: childWidget,
      ),
      false => OutlinedButton(
        onLongPress: onLongPress,
        clipBehavior: Clip.antiAlias,
        style:
            OutlinedButton.styleFrom(
              padding: padding ?? EdgeInsets.zero,
              shape:
                  shape ??
                  RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(radius ?? 16),
                  ),
              iconSize: 20,
              iconColor: _buildIconColor(context),
              backgroundColor: _buildBackgroundColor(context),
              foregroundColor: _buildForegroundColor(context),
              elevation: 0,
            ).copyWith(
              side: WidgetStateProperty.resolveWith(
                (states) => _buildBorderSide(context, states),
              ),
            ),
        onPressed: onPressed,
        child: childWidget,
      ),
    };

    // EVO-X: selected cards get the violet gradient + stronger halo; plain
    // unselected cards get a subtle neon halo; filled unselected stay flat.
    final Widget glowed;
    if (isSelected && !isError) {
      glowed = DecoratedBox(
        decoration: BoxDecoration(
          gradient: _selectedGradient,
          borderRadius: BorderRadius.circular(radius ?? 16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4D8B5CF6),
              blurRadius: 24,
              spreadRadius: -2,
            ),
          ],
        ),
        child: card,
      );
    } else if (type == CommonCardType.filled) {
      glowed = card;
    } else {
      glowed = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F8B5CF6),
              blurRadius: 18,
              spreadRadius: -3,
            ),
          ],
        ),
        child: card,
      );
    }

    return switch (enterAnimated) {
      true => FadeScaleEnterBox(child: glowed),
      false => glowed,
    };
  }
}

class SelectIcon extends StatelessWidget {
  const SelectIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.inversePrimary,
      shape: const CircleBorder(),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: const Icon(Icons.check, size: 16),
      ),
    );
  }
}

class SettingsBlock extends StatelessWidget {
  final String title;
  final List<Widget> settings;

  const SettingsBlock({super.key, required this.title, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          InfoHeader(info: Info(label: title)),
          Card(
            color: context.colorScheme.surfaceContainer,
            child: Column(children: settings),
          ),
        ],
      ),
    );
  }
}
