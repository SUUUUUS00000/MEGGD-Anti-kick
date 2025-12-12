<div align="center">
  <img src="https://ibb.co/9kVKjNcY" alt="Adonis Logo" width="300" />

  # Anti-Kick & Adonis Bypass

  Powerful script to bypass the Adonis admin system and prevent client-side kick.
</div>

---

##  Description
This project is a Lua script for Roblox developed to neutralize detection and punishment methods used by the popular Adonis administration system. The script intercepts network calls and internal functions, preventing the player from being disconnected from the server.

##  How it works
The code uses several layers of protection to bypass Adonis mechanisms:

### 1. RemoteEvent Interception
The script sets a hook on `Instance.new("RemoteEvent").FireServer`. 
* It analyzes arguments passed to the server. 
* If a string containing the word `"kick"` is found in the arguments, the request is blocked and not sent to the server. 
* The script also identifies specific Adonis UUID remote names (36 characters) to ignore them.

### 2. Blocking local kick
Adonis also kicks the player locally.
* **Metamethod Hook:** Intercepts the `__namecall` method. If the `Kick` method is called for `LocalPlayer`, the script returns `nil`, preventing disconnection.
* **Direct Function Hook:** Directly swaps the `LocalPlayer.Kick` function, making it non-functional for game scripts.

### 3. Cleaning detectors via getgc
The script scans the Lua environment (**Garbage Collector**) in search of internal Adonis tables:
* It looks for functions and tables containing keys `namecallInstance` or `indexInstance` (used in Adonis anti-cheat metatables).
* Upon detection, these values are replaced with empty tables.

### 4. Neutralizing internal Adonis signals
The script finds the internal `Remote` table of the Adonis module (via `getgc(true)`). 
* It sets a hook on the internal data sending function `v.Remote.Send`.
* Any data packets containing keywords `"detect"` (detection) or `"kick"` are blocked before being sent to the server.
