import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class RingManager {
  static late AudioSession session;

  static Soundpool pool = Soundpool.fromOptions(
      options: const SoundpoolOptions(streamType: StreamType.music));

  static const ring =
      'packages/stopwatch_lafay/assets/audio/mixkit-plastic-bubble-click-1124-short.wav';
  static int soundId = 0;

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
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
      androidWillPauseWhenDucked: true,
    ));
    return session;
  }

  // pre-load audio file to avoid getting a delay when playing it
  static void loadRing() async {
    soundId = await rootBundle.load(ring).then((ByteData soundData) {
      return pool.load(soundData);
    });
  }
}
