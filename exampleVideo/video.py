import subprocess

def run_command(command):
    """Helper function to run a shell command."""
    try:
        result = subprocess.run(command, shell=True, check=True, capture_output=True, text=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while executing command: {command}")
        print(e.output)

def main():
    # Step 1: Transcription
    command_transcription = (
        "curl -F 'audio=@exampleVideo/ev.wav' "
        "-F 'transcript=@exampleVideo/ev_g.txt' "
        "-o exampleVideo/ev.json "
        "'http://localhost:8765/transcriptions?async=false'"
    )
    run_command(command_transcription)

    # Step 2: Schedule creation
    command_scheduler = "python3 code/scheduler.py --input_file exampleVideo/ev"
    run_command(command_scheduler)

    # Step 3: Video drawing
    command_video_drawer = (
        "python3 code/videoDrawer.py --input_file exampleVideo/ev "
        "--use_billboards F --jiggly_transitions T"
    )
    run_command(command_video_drawer)

    # Step 4: Video finishing
    command_video_finisher = (
        "python3 code/videoFinisher.py --input_file exampleVideo/ev --keep_frames F"
    )
    run_command(command_video_finisher)

if __name__ == "__main__":
    main()