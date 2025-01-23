#!/bin/bash

# Step 1: Transcription
echo "Running: python3 code/gentleScriptWriter.py --input_file exampleVideo/ev"
python3 code/gentleScriptWriter.py --input_file exampleVideo/ev || {
    echo "Error in transcription script"
    exit 1
}

echo "Running: curl -F 'audio=@exampleVideo/ev.wav' -F 'transcript=@exampleVideo/ev_g.txt' -o exampleVideo/ev.json 'http://localhost:8765/transcriptions?async=false'"
curl -F 'audio=@exampleVideo/ev.wav' -F 'transcript=@exampleVideo/ev_g.txt' -o exampleVideo/ev.json 'http://localhost:8765/transcriptions?async=false' || {
    echo "Error in curl transcription"
    exit 1
}

# Step 2: Schedule creation
echo "Running: python3 code/scheduler.py --input_file exampleVideo/ev"
python3 code/scheduler.py --input_file exampleVideo/ev || {
    echo "Error in scheduler script"
    exit 1
}

# Step 3: Video drawing
echo "Running: python3 code/videoDrawer.py --input_file exampleVideo/ev --use_billboards T --jiggly_transitions F"
python3 code/videoDrawer.py --input_file exampleVideo/ev --use_billboards T --jiggly_transitions F || {
    echo "Error in video drawer script"
    exit 1
}

# Step 4: Video finishing
echo "Running: python3 code/videoFinisher.py --input_file exampleVideo/ev --keep_frames T"
python3 code/videoFinisher.py --input_file exampleVideo/ev --keep_frames T || {
    echo "Error in video finisher script"
    exit 1
}

echo "All commands executed successfully."