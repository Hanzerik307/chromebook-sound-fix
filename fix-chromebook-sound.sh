#!/usr/bin/env bash
# Script to adjust AlsaMixer Settings for Acer Chromebook

set -e

CARD=0

for i in $(seq 1 20); do
  if [ -d /proc/asound/card"$CARD" ]; then
    break
  fi
  sleep 0.5
done
if [ ! -d /proc/asound/card"$CARD" ]; then
  echo "sound card $CARD not present" >&2
  exit 1
fi

# --- machine-level init (matches alsa-ucm-conf-cros init-jsl) ---
amixer -c "$CARD" -q cset "name='DAC1 L Mux'" "IF1 DAC"
amixer -c "$CARD" -q cset "name='DAC1 R Mux'" "IF1 DAC"
amixer -c "$CARD" -q cset "name='DAC1 MIXL DAC1 Switch'" "on"
amixer -c "$CARD" -q cset "name='DAC1 MIXR DAC1 Switch'" "on"
amixer -c "$CARD" -q cset "name='Stereo DAC MIXL DAC L1 Switch'" "on"
amixer -c "$CARD" -q cset "name='Stereo DAC MIXR DAC R1 Switch'" "on"
amixer -c "$CARD" -q cset "name='DAC L2 Mux'" "IF2 DAC"
amixer -c "$CARD" -q cset "name='DAC R2 Mux'" "IF2 DAC"
amixer -c "$CARD" -q cset "name='A DAC2 L Mux'" "Mono DAC Mixer"
amixer -c "$CARD" -q cset "name='A DAC2 R Mux'" "Mono DAC Mixer"
amixer -c "$CARD" -q cset "name='Mono DAC MIXL DAC L2 Switch'" "on"
amixer -c "$CARD" -q cset "name='Mono DAC MIXR DAC R2 Switch'" "on"
amixer -c "$CARD" -q cset "name='DAC2 Playback Switch'" "on,on"

# --- speaker enable seq (matches alsa-ucm-conf-cros Speaker device) ---
amixer -c "$CARD" -q cset "name='SPK MIXL DAC L2 Switch'" "on"
amixer -c "$CARD" -q cset "name='SPK MIXR DAC R2 Switch'" "on"
amixer -c "$CARD" -q cset "name='SPOL MIX SPKVOL L Switch'" "on"
amixer -c "$CARD" -q cset "name='SPOR MIX SPKVOL R Switch'" "on"
amixer -c "$CARD" -q cset "name='SPKVOL L Switch'" "on"
amixer -c "$CARD" -q cset "name='SPKVOL R Switch'" "on"
amixer -c "$CARD" -q cset "name='Speaker Channel Switch'" "on,on"
amixer -c "$CARD" -q cset "name='Left Spk Switch'" "on"
amixer -c "$CARD" -q cset "name='Right Spk Switch'" "on"
amixer -c "$CARD" -q cset "name='Speaker Playback Volume'" "30,30"
amixer -c "$CARD" -q cset "name='Speaker ClassD Playback Volume'" "7"

# --- headphone enable seq; harmless when no jack present ---
amixer -c "$CARD" -q cset "name='Headphone Jack Switch'" "on"
amixer -c "$CARD" -q cset "name='HPOVOL MIXL DAC1 Switch'" "on"
amixer -c "$CARD" -q cset "name='HPOVOL MIXR DAC1 Switch'" "on"
amixer -c "$CARD" -q cset "name='Headphone Channel Switch'" "on,on"
amixer -c "$CARD" -q cset "name='HPO MIX HPVOL Switch'" "on"
amixer -c "$CARD" -q cset "name='HPOVOL L Switch'" "on"
amixer -c "$CARD" -q cset "name='HPOVOL R Switch'" "on"
amixer -c "$CARD" -q cset "name='Headphone Playback Volume'" "22,22"

exit 0
