import wave

def read_wav_file(file_path):
    try:
        with wave.open(file_path, 'rb') as wav_file:
            num_channels = wav_file.getnchannels()
            sample_width = wav_file.getsampwidth()
            frame_rate = wav_file.getframerate()
            num_frames = wav_file.getnframes()
            raw_data = wav_file.readframes(num_frames)
        return raw_data, num_frames, frame_rate
    except:
        raise Exception("cannot read: "+str(file_path))

