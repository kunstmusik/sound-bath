;; Author: Steven Yi 
;; Date: 2024-05-02
;; Description: Sound Bath using Solfeggio Frequencies

schedule("ReverbMixer", 0, -1)

// Root Chakra: 396 Hz
// Sacral Chakra: 417 Hz
// Solar Plexus Chakra: 528 Hz
// Heart Chakra: 639 Hz
// Throat Chakra: 741 Hz
// Third Eye Chakra: 852 Hz
// Crown Chakra: 963 Hz

gifreqs[] = fillarray(396, 417, 528, 639, 741, 852, 963)
gilen = lenarray(gifreqs)

seed(0)

instr S1
  asig = oscili(1, p4)
  asig += oscili(.25, p4 * .5)
  asig *= ampdbfs(-12)

  asig *= transeg:a(0, .01, 0, 1, p3 - .01, -4.2, 0)

  pan_verb_mix(asig, 0.5, 0.25)
endin

instr Main
  indx = int(random:i(0, gilen))
  ifreq = gifreqs[indx]
  schedule("S1", 0, 100, ifreq)

  if(random:i(0, 1) < 0.25) then
    indx2 = int(random:i(0, gilen))
    while (indx2 == indx) do
      indx2 = int(random:i(0, gilen))
    od
    
    ifreq = gifreqs[indx2]
    schedule("S1", .5 + random:i(0, 2), 100, ifreq)
  endif
  
  schedule(p1, 5 + random:i(0, 30), 0)
endin

schedule("Main", 0, 0)
