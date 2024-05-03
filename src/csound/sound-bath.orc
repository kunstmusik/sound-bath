;; Author: Steven Yi 
;; Date: 2024-05-02
;; Description: Sound Bath using Solfeggio Frequencies

start("ReverbMixer")

xchnset("Reverb.fb", 0.75)

// Root Chakra: 396 Hz
// Sacral Chakra: 417 Hz
// Solar Plexus Chakra: 528 Hz
// Heart Chakra: 639 Hz
// Throat Chakra: 741 Hz
// Third Eye Chakra: 852 Hz
// Crown Chakra: 963 Hz

gifreqs[] = fillarray(396, 417, 528, 639, 741, 852, 963)

rndseed(times:i() % 1)

instr S1
  asig = oscili(1, p4)
  asig += oscili(.25, p4 * .5)
  asig *= ampdbfs(-18)

  asig *= transeg:a(0, .01, 0, 1, p3 - .01, -4.2, 0)

  pan_verb_mix(asig, 0.5, 0.25)
  
endin

instr Main
  ilen = lenarray(gifreqs)

  indx = int(rnd(ilen))
  ifreq = gifreqs[indx]
  schedule("S1", 0, 100, ifreq)

  if(rnd(1) < 0.25) then
    indx2 = int(rnd(ilen))
    while (indx2 == indx) do
      indx2 = int(rnd(ilen))
    od
    
    ifreq = gifreqs[indx2]
    schedule("S1", .5 + rnd(2), 100, ifreq)
  endif
  
  schedule(p1, 5 + rnd(30), 0)
endin

schedule("Main", 0, 0)
