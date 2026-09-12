PS4 WebKit side - hosting instructions
=====================================
PRIMARY CHAIN: POOPS  (chain_poops.js / run_poops.html)

WHAT THIS FOLDER IS
  The browser-side (WebKit) component. Serve this whole folder over HTTP(S)
  and open the root page on the PS4 browser.

ENTRY POINTS
  index.html ......... launcher. DEFAULT = poops chain.
                       (poops is used for fw >= 12.50; lapse only via ?bug=lapse)
  run_poops.html ..... direct poops entry  (imports ./chain_poops.js?ui=3)
  run_lapse.html ..... direct lapse entry  (imports ./chain_lapse.js?ui=3) - fallback

FILES (all required at these exact relative paths)
  run_lapse.html / run_poops.html ... entry pages
  chain_lapse.js / chain_poops.js ... WebKit chains
  core.js / mem.js / int64.js ....... primitives + heap helpers (poops imports
                                      ./core.js?v=10, ./int64.js, ./mem.js)
  ps4_offsets.js ..................... firmware offset/gadget table (offsetsFor)
  rpc_worker.js ...................... Worker script, must sit next to the chain
  payload.bin ........................ kpayload blob fetched at runtime
  cache.appcache ..................... cache manifest referenced by the HTML
  patches/1100.bin ... 1304.bin ...... kernel patch blobs
  ko-files/kernel_offset_13.04.js .... kernel-side module (separate framework)

HOW TO SERVE (pick one)
  Windows (this machine):
      cd C:\temp\ps4_web && python -m http.server 8080
  then on the PS4 browser open:  http://<PC-IP>:8080/
  (find PC-IP with `ipconfig`; both devices on the same LAN)

  Any static host (GitHub Pages / nginx / Node / hosting): upload the folder
  contents as-is and open the root URL.

FIRMWARE SUPPORT - READ BEFORE RUNNING
  poops chain  = proven on 13.00 ("state=proven step10=32/0-x3 reboot=0 webkit=step7-20/20
                 anchor=findcaller kernel_rvas=verified-on-hardware kpatch=1300.bin
                 -10-sites-verified bug=poops"); offsets table ALSO has 12.50/12.52
                 (12.52 = alias of 12.50, webkit ASSUMED identical) and 11.50/12.00 rows.
  lapse chain  = for 12.02 and below (not the primary).

  13.02 / 13.04 (ADDED - UNTESTED ON HARDWARE)
  ps4_offsets.js now has "13.02" and "13.04" rows. Both are aliases of 13.00
  (alias_of:"13.00") following the same policy as 12.52 -> 12.50: patch-level
  releases carry the same libSceNKWebKit.sprx, and no 13.02/13.04 module dump
  exists to prove otherwise. If the real 13.04 WebKit ever moved an anchor,
  the chain fails loudly and harmlessly at stage 1/7 - it cannot corrupt.
  Kernel side is solid: the rows carry 13.04 kernel RVAs cross-checked against
  kernel_offset_13.04.js (SYSENT_661=0x110a760 JMP_RSI_GADGET=0x47b31
  KL_LOCK=0xe6c20), and patches/1302.bin + patches/1304.bin (byte-identical,
  sha256=76584f8a02be806816aa7987ff6f2aed3a4a7f9494c49643e32f9cb9d75ab71b)
  were generated from the kernel_offset_13.04.js table. They differ from
  patches/1300.bin in exactly 18 bytes (the fw-specific mmap RWX offsets,
  0x1fa78a/0x1fa78d -> 0x1fa79a/0x1fa79d); jmp-site scan on the new blobs
  returns the same 10 sites as 1300.bin with the expected +0x10 shift.
  STATUS: UNTESTED-on-hardware. Validate on a real 13.02/13.04 unit; if
  stage 1/7 fails there, we need a 13.04 libSceNKWebKit.sprx dump to build a
  native row.