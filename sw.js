if(!self.define){let e,i={};const n=(n,s)=>(n=new URL(n+".js",s).href,i[n]||new Promise((i=>{if("document"in self){const e=document.createElement("script");e.src=n,e.onload=i,document.head.appendChild(e)}else e=n,importScripts(n),i()})).then((()=>{let e=i[n];if(!e)throw new Error(`Module ${n} didn’t register its module`);return e})));self.define=(s,r)=>{const o=e||("document"in self?document.currentScript.src:"")||location.href;if(i[o])return;let c={};const t=e=>n(e,o),b={module:{uri:o},exports:c,require:t};i[o]=Promise.all(s.map((e=>b[e]||t(e)))).then((e=>(r(...e),c)))}}define(["./workbox-3e911b1d"],(function(e){"use strict";self.skipWaiting(),e.clientsClaim(),e.precacheAndRoute([{url:"assets/index-CSCLnvvR.js",revision:null},{url:"assets/index-D6PjhfOF.css",revision:null},{url:"icons/icon-192x192.png",revision:"20cde691fa25b6b51e8ffadad14e6413"},{url:"icons/icon-512x512.png",revision:"0b381f2bcb35ffb86003eba0618a5bb2"},{url:"index.html",revision:"5e3ac22eac6ad5b709623e1ad2c3556d"},{url:"orange-circle.svg",revision:"17520d54c65ec6ace23919b2c9b14207"},{url:"registerSW.js",revision:"402b66900e731ca748771b6fc5e7a068"},{url:"./icons/icon-192x192.png",revision:"20cde691fa25b6b51e8ffadad14e6413"},{url:"./icons/icon-512x512.png",revision:"0b381f2bcb35ffb86003eba0618a5bb2"},{url:"manifest.webmanifest",revision:"76a68b7e9e7b0cc77db56fdb25521107"}],{}),e.cleanupOutdatedCaches(),e.registerRoute(new e.NavigationRoute(e.createHandlerBoundToURL("index.html")))}));
