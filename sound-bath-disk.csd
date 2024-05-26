<CsoundSynthesizer>
<CsOptions>
-Wdo sound-bath.wav 
</CsOptions>
<CsInstruments>

sr	= 44100	
ksmps	= 64	
nchnls	=	2
0dbfs	=	1

#include "src/csound/utils.orc"
#include "src/csound/sound-bath.orc"

event_i("e", 0, 60 * 60 * 4)

</CsInstruments>
</CsoundSynthesizer>

