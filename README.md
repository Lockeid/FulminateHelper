#Overview

FulminateHelper is a way to have an easier time managing your Lightning Shield stack

#Features
- Show the Lightning Shield count on your Earth Shock icons.
- Proc-like glow if your stack gets higher than a threshold

#Changing the threshold

At the top of core.lua file you will see a line `local threshold = -5;`.
That means that if the maximum stacks you can get is 20 (with Improved Lightning Shield), the icon will glow as soon as you get 15 stacks.