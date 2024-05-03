import { Csound, CsoundObj } from "@csound/browser";
import liveCodeOrc from "./csound/livecode.orc?raw";
import soundBathOrc from "./csound/sound-bath.orc?raw";
import { useState } from "react";

const startCsound = async (csound: CsoundObj) => {
  console.log("Starting Csound...");
  await csound.setOption("-odac");
  await csound.setOption("--ksmps=64");
  await csound.setOption("--nchnls=2");
  await csound.setOption("--0dbfs=1");
  await csound.setOption("-m0");

  await csound.compileOrc(liveCodeOrc);
  await csound.start();
  await csound.compileOrc(soundBathOrc);

  const context = await csound.getAudioContext();
  if (context) {
    context.resume();
  }
};

const App = () => {
  const [csound, setCsound] = useState<CsoundObj>();

  const startSoundBath = async () => {
    if (!csound) {
      const cs = await Csound();
      setCsound(cs);

      if (cs) {
        await startCsound(cs);
      } else {
        console.error("Could not create Csound object");
      }
    }
  };

  return (
    <div className="flex h-screen w-screen justify-center items-center bg-orange-200">
      <div className="justify-center text-center">
        <div className="text-3xl">Sound Bath (2024)</div>
        <div className="text-md">Steven Yi &lt;stevenyi@gmail.com&gt;</div>
        <p className="mt-4">
          A meditative sound bath using the Solfeggio Frequencies.
        </p>
        <div className="flex mt-4">
          <div className="grow" />
          <ul className="list-disc text-left w-fit">
            <li>Root Chakra: 396 Hz</li>
            <li>Sacral Chakra: 417 Hz </li>
            <li>Solar Plexus Chakra: 528 Hz </li>
            <li>Heart Chakra: 639 Hz </li>
            <li>Throat Chakra: 741 Hz </li>
            <li>Third Eye Chakra: 852 Hz </li>
            <li>Crown Chakra: 963 Hz </li>
          </ul>
          <div className="grow" />
        </div>
        {!csound && (
          <div className="my-8">
            <button
              className="bg-orange-500 hover:bg-orange-600 text-white font-bold py-2 px-4 rounded"
              onClick={startSoundBath}
            >
              Start Sound Bath
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default App;
