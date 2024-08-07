import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class RingManager {
  static late AudioSession session;

  static Soundpool pool = Soundpool.fromOptions(
      options: const SoundpoolOptions(streamType: StreamType.ring));

  // Store the vibration status
  static bool isDuckingActive = false;

  static const ring =
      'packages/timer_lafay/assets/audio/mixkit-plastic-bubble-click-1124-short.wav';
  static int ringId = 0;

  static const gong = 'packages/timer_lafay/assets/audio/gong-end-rest.wav';
  static int gongId = 0;

  static Future<AudioSession> configureAudioSession() async {
    session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        flags: AndroidAudioFlags.audibilityEnforced,
        usage: AndroidAudioUsage.notificationRingtone,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
      androidWillPauseWhenDucked: false,
    ));
    return session;
  }

  // Pre-load countdown audio file to avoid getting a delay when playing it
  static void loadRing() async {
    ringId = await rootBundle.load(ring).then((ByteData soundData) {
      return pool.load(soundData);
    });
    gongId = await rootBundle.load(gong).then((ByteData soundData) {
      return pool.load(soundData);
    });
  }
}
