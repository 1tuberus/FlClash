import 'dart:math' as math;

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// EVO-X Connect capsule: gradient pill + rotating cyan tick-ring + comet sweep +
// pulsing brand glow. Idle = START (Orbitron), running = ticking timer.
// VPN trigger logic (isStartProvider / setupActionProvider) is unchanged.
class StartButton extends ConsumerStatefulWidget {
  const StartButton({super.key});

  @override
  ConsumerState<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends ConsumerState<StartButton>
    with TickerProviderStateMixin {
  late final AnimationController _iconCtrl;
  late final Animation<double> _iconAnim;
  late final AnimationController _ringCtrl;
  late final AnimationController _cometCtrl;
  late final AnimationController _glowCtrl;
  bool isStart = false;

  @override
  void initState() {
    super.initState();
    isStart = ref.read(isStartProvider);
    _iconCtrl = AnimationController(
      vsync: this,
      value: isStart ? 1 : 0,
      duration: const Duration(milliseconds: 220),
    );
    _iconAnim = CurvedAnimation(parent: _iconCtrl, curve: Curves.easeOutBack);
    _ringCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    );
    _cometCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );
    _applyRunning(isStart);
    ref.listenManual(isStartProvider, (prev, next) {
      if (next != isStart) {
        isStart = next;
        _updateIcon();
        _applyRunning(next);
      }
    }, fireImmediately: true);
  }

  void _applyRunning(bool running) {
    if (running) {
      if (!_ringCtrl.isAnimating) _ringCtrl.repeat();
      if (!_cometCtrl.isAnimating) _cometCtrl.repeat();
      if (!_glowCtrl.isAnimating) _glowCtrl.repeat(reverse: true);
    } else {
      _ringCtrl.stop();
      _cometCtrl.stop();
      _glowCtrl.stop();
    }
  }

  void _updateIcon() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (isStart) {
        _iconCtrl.forward();
      } else {
        _iconCtrl.reverse();
      }
    });
  }

  @override
  void dispose() {
    _iconCtrl.dispose();
    _ringCtrl.dispose();
    _cometCtrl.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

  void handleSwitchStart() {
    isStart = !isStart;
    _updateIcon();
    _applyRunning(isStart);
    debouncer.call(FunctionTag.updateStatus, () {
      globalState.container
          .read(setupActionProvider.notifier)
          .updateStatus(isStart, isInit: !ref.read(initProvider));
    }, duration: commonDuration);
  }

  @override
  Widget build(BuildContext context) {
    final hasProfile = ref.watch(
      profilesProvider.select((state) => state.isNotEmpty),
    );
    if (!hasProfile) {
      return Container();
    }
    final running = ref.watch(isStartProvider);
    final suspend = ref.watch(suspendProvider);
    final appLocalizations = context.appLocalizations;

    final Widget label = suspend
        ? Text(
            appLocalizations.suspended,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.white,
            ),
          )
        : (running
              ? Consumer(
                  builder: (_, ref, _) {
                    final runTime = ref.watch(runTimeProvider);
                    return SizedBox(
                      width: 116,
                      child: Text(
                        utils.getTimeText(runTime),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Orbitron',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 0,
                        ),
                      ),
                    );
                  },
                )
              : const Text(
                  'START',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ));

    return RepaintBoundary(
      child: GestureDetector(
        onTap: handleSwitchStart,
        child: AnimatedBuilder(
          animation: _glowCtrl,
          builder: (_, child) {
            final pulse = _glowCtrl.isAnimating ? _glowCtrl.value : 0.0;
            return Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0C18),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: Color.lerp(
                      const Color(0x738B5CF6),
                      const Color(0xCC8B5CF6),
                      pulse,
                    )!,
                    blurRadius: 22 + 18 * pulse,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: const Color(0x4022D3EE),
                    blurRadius: 40 + 20 * pulse,
                  ),
                ],
              ),
              child: child,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rotating cyan tick-ring (bright while running, dim when idle).
                Positioned.fill(
                  child: RotationTransition(
                    turns: _ringCtrl,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: SweepGradient(
                          endAngle: math.pi / 18, // 10° per tick → 36 ticks
                          tileMode: TileMode.repeated,
                          colors: [
                            Color(running ? 0xCC22D3EE : 0x5522D3EE),
                            const Color(0x0022D3EE),
                          ],
                          stops: const [0.14, 0.6],
                        ),
                      ),
                    ),
                  ),
                ),
                // White comet sweep (running only).
                if (running)
                  Positioned.fill(
                    child: RotationTransition(
                      turns: _cometCtrl,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: SweepGradient(
                            colors: [
                              Color(0x00FFFFFF),
                              Color(0x00FFFFFF),
                              Color(0xE6FFFFFF),
                              Color(0x00FFFFFF),
                            ],
                            stops: [0.0, 0.82, 0.95, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                // Inner gradient capsule (brand violet→cyan).
                Container(
                  margin: const EdgeInsets.all(3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF8B5CF6), Color(0xFF22D3EE)],
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _iconAnim,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      label,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
