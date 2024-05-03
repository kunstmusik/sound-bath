/*
  Live Coding Functions
  Author: Steven Yi
*/ 

;; Channel Helper

/** Sets i-rate value into channel and sets initialization to true. Works together 
  with xchan */
opcode xchnset, 0, Si
  SchanName, ival xin
  Sinit = sprintf("%s_initialized", SchanName)
  chnset(1, Sinit)
  chnset(ival, SchanName)
endop

/** xchan 
  Initializes a channel with initial value if channel has default value of 0 and
  then returns the current value from the channel. Useful in live coding to define
  a dynamic point that will be automated or set outside of the instrument that is
  using the channel. 

  Opcode is overloaded to return i- or k- value. Be sure to use xchan:i or xchan:k
  to specify which value to use. 
*/
opcode xchan, i,Si
  SchanName, initVal xin
   
  Sinit = sprintf("%s_initialized", SchanName)
  if(chnget:i(Sinit) == 0) then
    chnset(1, Sinit)
    chnset(initVal, SchanName)
  endif
  xout chnget:i(SchanName)
endop

/** xchan 
  Initializes a channel with initial value if channel has default value of 0 and
  then returns the current value from the channel. Useful in live coding to define
  a dynamic point that will be automated or set outside of the instrument that is
  using the channel. 

  Opcode is overloaded to return i- or k- value. Be sure to use xchan:i or xchan:k
  to specify which value to use. 
*/
opcode xchan, k,Si
  SchanName, initVal xin
    
  Sinit = sprintf("%s_initialized", SchanName)
  if(chnget:i(SchanName) == 0) then
    chnset(1, Sinit)
    chnset(initVal, SchanName)
  endif
  xout chnget:k(SchanName)
endop



;; Stereo Audio Bus

ga_sbus[] init 16, 2

/** Write two audio signals into stereo bus at given index */
opcode sbus_write, 0,iaa
  ibus, al, ar xin
  ga_sbus[ibus][0] = al
  ga_sbus[ibus][1] = ar
endop

/** Mix two audio signals into stereo bus at given index */
opcode sbus_mix, 0,iaa
  ibus, al, ar xin
  ga_sbus[ibus][0] = ga_sbus[ibus][0] + al
  ga_sbus[ibus][1] = ga_sbus[ibus][1] + ar
endop

/** Clear audio signals from bus channel */
opcode sbus_clear, 0, i
  ibus xin
  aclear init 0
  ga_sbus[ibus][0] = aclear
  ga_sbus[ibus][1] = aclear
endop

/** Read audio signals from bus channel */
opcode sbus_read, aa, i
  ibus xin
  aclear init 0
  al = ga_sbus[ibus][0] 
  ar = ga_sbus[ibus][1] 
  xout al, ar
endop

;; KILLING INSTANCES

instr KillImpl
  Sinstr = p4 
  if (nstrnum(Sinstr) > 0) then
    turnoff2(Sinstr, 0, 0)
  endif
  turnoff
endin

/** Turns off running instances of named instruments.  Useful when livecoding
  audio and control signal process instruments. May not be effective if for
  temporal recursion instruments as they may be non-running but scheduled in the
  event system. In those situations, try using clear_instr to overwrite the
  instrument definition. */
opcode kill, 0,S
  Sinstr xin
  schedule("KillImpl", 0, 0.01, Sinstr)
endop


/** Starts running a named instrument for indefinite time using p2=0 and p3=-1. 
  Will first turnoff any instances of existing named instrument first.  Useful
  when livecoding always-on audio and control signal process instruments. */
opcode start, 0,S
  Sinstr xin

  if (nstrnum(Sinstr) > 0) then
    kill(Sinstr)
    schedule(Sinstr, ksmps / sr,-1)
  endif
endop

;; MIXER

gi_reverb_mixer_on init 0

/** Always-on Mixer instrument with Reverb send channel. Use start("ReverbMixer") to run. Designed 
    for use with pan_verb_mix to simplify signal-based live coding. */
instr ReverbMixer

  gi_reverb_mixer_on init 1

  ;; dry and reverb send signals
  a1, a2 sbus_read 0
  a3, a4 sbus_read 1
  
  al, ar reverbsc a3, a4, xchan:k("Reverb.fb", 0.7), xchan:k("Reverb.cut", 12000)
  
  kamp = xchan:k("Mix.amp", 1.0)
  
  a1 = tanh(a1 + al) * kamp
  a2 = tanh(a2 + ar) * kamp
  
  out(a1, a2)
  
  sbus_clear(0)
  sbus_clear(1)
endin

/** Utility opcode to pan signal, send dry to mixer, and send amount 
    of signal to reverb. If ReverbMixer is not on, will output just 
    panned signal using out opcode. */
opcode pan_verb_mix, 0,akk
  asig, kpan, krvb xin
   ;; Panning and send to mixer
  al, ar pan2 asig, kpan
 
  if(gi_reverb_mixer_on == 1) then
    sbus_mix(0, al, ar)
    sbus_mix(1, al * krvb, ar * krvb)
  else 
    out(al, ar)
  endif
endop


