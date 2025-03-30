import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dumble/dumble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opus_dart/opus_dart.dart';
import 'package:opus_flutter/opus_flutter.dart' as opus_flutter;

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key, required this.title});

  final String title;

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  String _username = '';
  String _password = '';
  String _host = '';
  int _port = 64738;

  void setUsername(String username) {
    setState(() {
      _username = username;
    });
  }

  void setPassword(String password) {
    setState(() {
      _password = password;
    });
  }

  void setHost(String host) {
    setState(() {
      _host = host;
    });
  }

  void setPort(String port) {
    print('parsing $port');
    final parsedPort = int.parse(port);
    setState(() {
      _port = parsedPort;
    });
  }

  Future<void> handleButtonClick() async {
    final ConnectionOptions defaultConnectionOptions = ConnectionOptions(
      host: _host,
      port: _port,
      name: _username,
      password: _password,
      pingTimeout: const Duration(seconds: 5),
    );

    print('connecting to $_host:$_port with $_username and $_password...');

    MumbleClient client = await MumbleClient.connect(
      options: defaultConnectionOptions,
      onBadCertificate: (X509Certificate certificate) {
        //Accept every certificate
        return true;
      },
    );
    client.self.add(_SelfCallback(client.self.session));
    client.add(_MumbleClientCallback());
    client.self.registerUser();

    initOpus(await opus_flutter.load());
    client.audio.add(SaveToFileAudioListener());
    await Future.delayed(
      const Duration(seconds: 5),
    ); // Wait a few seconds before we start talking
    StreamOpusEncoder<int> encoder = StreamOpusEncoder.bytes(
      frameTime: frameTime,
      floatInput: false,
      sampleRate: inputSampleRate,
      channels: channels,
      application: Application.voip,
    );
    AudioFrameSink audioOutput = client.audio.sendAudio(codec: AudioCodec.opus);
    await simulateAudioRecording() // This simulates recording by reading from a file
        .asyncMap((List<int> bytes) async {
          // We need to wait a bit since reading from a file is "faster than realtime".
          // Usually we would wait frameTimeMs, but since encoding with opus takes about abit
          // (we assume 17ms here), we wait less.
          // In an actual live recording, you dont need this artificial waiting.
          await Future.delayed(const Duration(milliseconds: frameTimeMs - 17));
          return bytes;
        })
        .transform(encoder)
        .map((Uint8List audioBytes) => AudioFrame.outgoing(frame: audioBytes))
        .pipe(audioOutput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Connect to server', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Host',
                        label: Text('Host'),
                      ),
                      onChanged: setHost,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: "64738"),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Port',
                        label: Text('Port'),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: setPort,
                      enabled: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                  label: Text('Username'),
                ),
                onChanged: setUsername,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  label: Text('Password'),
                ),
                onChanged: setPassword,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: handleButtonClick,
                child: const Text('CONNECT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelfCallback with UserListener {
  final int session;

  _SelfCallback(this.session);

  @override
  void onUserChanged(User user, User? actor, UserChanges changes) {
    if (user.session == session && changes.userId) {
      // We are the changed user and our id changed
      // What means that we are now registered
      print('Registered with id ${user.userId}');
    }
  }

  @override
  void onUserRemoved(User user, User? actor, String? reason, bool? ban) {}

  @override
  void onUserStats(User user, UserStats stats) {}
}

class _MumbleClientCallback with MumbleClientListener {
  @override
  void onBanListReceived(List<BanEntry> bans) {
    // TODO: implement onBanListReceived
  }

  @override
  void onChannelAdded(Channel channel) {
    // TODO: implement onChannelAdded
  }

  @override
  void onCryptStateChanged() {
    // TODO: implement onCryptStateChanged
  }

  @override
  void onDone() {
    // TODO: implement onDone
  }

  @override
  void onDropAllChannelPermissions() {
    // TODO: implement onDropAllChannelPermissions
  }

  @override
  void onError(Object error, [StackTrace? stackTrace]) {
    // TODO: implement onError
    print('ERROR:$error$stackTrace');
  }

  @override
  void onPermissionDenied(PermissionDeniedException e) {
    // TODO: implement onPermissionDenied
  }

  @override
  void onQueryUsersResult(Map<int, String> idToName) {
    // TODO: implement onQueryUsersResult
  }

  @override
  void onTextMessage(IncomingTextMessage message) {
    // TODO: implement onTextMessage
  }

  @override
  void onUserAdded(User user) {
    // TODO: implement onUserAdded
  }

  @override
  void onUserListReceived(List<RegisteredUser> users) {
    // TODO: implement onUserListReceived
  }
}

Future<void> main() async {
  // We are going to use opus_dart so init it
  // Put in your own opus path here
  // Quick note on casting to dynamic: since opus_dart supports web as of version
  // 3.0.0, this cast may be necessary if your IDE analyzer gives a warning.
  // At runtime, types will match.
}

const int inputSampleRate = 8000;
const int frameTimeMs = 40; // use frames of 40ms
const FrameTime frameTime = FrameTime.ms40;
const int outputSampleRate = 48000;
const int channels = 1;

Stream<List<int>> simulateAudioRecording() async* {
  // 0_8000_1_s16le contains pcm audio with a sample rate of 8000hz, one channel, in s16le format.
  // We will now simulate audio recording by reading this file and split it into audio frames of frameTimeMs.
  int frameByteSize =
      (inputSampleRate ~/ 1000) *
      frameTimeMs *
      channels *
      2; //2 because s16le takes two bytes per sample
  Uint8List? buffer;
  int bufferIndex = 0;
  await for (Uint8List bytes
      in File('./assets/0_8000_1_s16le.raw').openRead().cast<Uint8List>()) {
    int consumed = 0;
    while (consumed < bytes.length) {
      if (buffer == null && frameByteSize <= (bytes.length - consumed)) {
        yield bytes.buffer.asUint8List(consumed, frameByteSize);
        consumed += frameByteSize;
      } else if (buffer == null) {
        buffer = Uint8List(frameByteSize);
        bufferIndex = 0;
      } else {
        int read = min(frameByteSize - bufferIndex, bytes.length - consumed);
        buffer.setRange(bufferIndex, bufferIndex + read, bytes, consumed);
        consumed += read;
        bufferIndex += read;
        if (bufferIndex == frameByteSize) {
          yield buffer;
          buffer = null;
        }
      }
    }
  }
}

class SaveToFileAudioListener with AudioListener {
  SaveToFileAudioListener() {
    Directory('./recordings').createSync(recursive: true);
  }

  @override
  void onAudioReceived(
    Stream<AudioFrame> voiceData,
    AudioCodec codec,
    User? speaker,
    TalkMode talkMode,
  ) {
    String target =
        talkMode == TalkMode.normal
            ? 'talking to ${speaker?.channel.channelId}'
            : ' whispering';
    print('${speaker?.name} started $target.');
    if (codec == AudioCodec.opus) {
      File targetFile = File(
        './recordings/${speaker?.name}_${DateTime.now().millisecondsSinceEpoch}_.wav',
      );
      IOSink output = targetFile.openWrite();
      output.write(Uint8List(wavHeaderSize)); // Reserve space for a wav header
      // Create an opus stream decoder
      StreamOpusDecoder decoder = StreamOpusDecoder.bytes(
        floatOutput: false,
        sampleRate: outputSampleRate,
        channels: channels,
      );
      voiceData
          .map<Uint8List>(
            (AudioFrame frame) => frame.frame,
          ) //we are only interested in the bytes
          .cast<Uint8List?>()
          .transform(decoder)
          .cast<List<int>>()
          .pipe(output)
          .then((_) async {
            await output.close();
            await writeWavHeader(targetFile);
            print('${speaker?.name} stopped $target.');
          });
    } else {
      print('But we don\'t know how do decode $codec');
    }
  }
}

const int wavHeaderSize = 44;

Future<void> writeWavHeader(File file) async {
  RandomAccessFile r = await file.open(mode: FileMode.append);
  await r.setPosition(0);
  await r.writeFrom(
    wavHeader(
      channels: channels,
      sampleRate: outputSampleRate,
      fileSize: await file.length(),
    ),
  );
}

Uint8List wavHeader({
  required int sampleRate,
  required int channels,
  required int fileSize,
}) {
  const int sampleBits = 16; //We know this since we used opus
  const Endian endian = Endian.little;
  final int frameSize = ((sampleBits + 7) ~/ 8) * channels;
  ByteData data = ByteData(wavHeaderSize);
  data.setUint32(4, fileSize - 4, endian);
  data.setUint32(16, 16, endian);
  data.setUint16(20, 1, endian);
  data.setUint16(22, channels, endian);
  data.setUint32(24, sampleRate, endian);
  data.setUint32(28, sampleRate * frameSize, endian);
  data.setUint16(30, frameSize, endian);
  data.setUint16(34, sampleBits, endian);
  data.setUint32(40, fileSize - 44, endian);
  Uint8List bytes = data.buffer.asUint8List();
  bytes.setAll(0, ascii.encode('RIFF'));
  bytes.setAll(8, ascii.encode('WAVE'));
  bytes.setAll(12, ascii.encode('fmt '));
  bytes.setAll(36, ascii.encode('data'));
  return bytes;
}
