/*
  utils.orc (based on Live Coding Functions from csound-live-code)
  Author: Steven Yi
*/ 

ga1 init 0
ga2 init 0
ga3 init 0
ga4 init 0

;; MIXER
instr ReverbMixer
  ;; dry and reverb send signals
  a1 = ga1
  a2 = ga2
  a3 = ga3
  a4 = ga4 
  
  al, ar reverbsc a3, a4, .75, 12000
  
  a1 = tanh(a1 + al)
  a2 = tanh(a2 + ar) 
  
  out(a1, a2)

  clear ga1, ga2, ga3, ga4  
endin

/** Utility opcode to pan signal, send dry to mixer, and send amount 
    of signal to reverb. */
opcode pan_verb_mix, 0,akk
  asig, ipan, irvb xin
   ;; Panning and send to mixer
  al, ar pan2 asig, ipan
 
  ga1 += al
  ga2 += ar
  ga3 += al * irvb
  ga4 += al * irvb
endop
