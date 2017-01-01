BeginPackage["FancyHanoi`"]

(*

The 2-Clause BSD License

Copyright (c) 2016 Shawn M. Chapla (shwnchpl@gmail.com)

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*)

Fancy::usage =
  "A function to recursively generate the complete ternary string
   list solution to the special rules version of the Tower of Hanoi
   known as 'Fancy Hanoi'. Fancy[n] returns the solution for an
   n-disk game."

FancyItr::usage =
  "An iterative function that generates the complete ternary string
  list solution to the 'Fancy Hanoi' problem by taking advantage of
  the pattern associated with how each disk moves. FancyItr[n] returns
  the solution for an n-disk game. Substantially faster than recursive
  Fancy."

Begin["`Private`"]

stayStill[tStr_, count_] := Module[{cur = StringTake[tStr, -1]},
    tStr <> If[Abs[count] > 1, cur <> cur, cur]
]

moveSome[tStr_, count_] := Module[{cur = StringTake[tStr, -1]},
  tStr <> Switch[cur,
    "0", If[count == 1, "1", "12"],
    "1", If[count == 1, "2", "0"],
    "2", If[count == -1, "1", "10"]
  ]
]

fancyHelper[focus_, 0, start_, end_, state_] := Module[{count = end - start},
  MapAt[moveSome[#, count] &,
    MapAt[stayStill[#, count] &, state,
      Map[{#} &, Drop[Range[Length[state]], {focus}]]],
    {focus}]
]

fancyHelper[focus_, stack_, start_,end_, state_] := Module[{nState},
  nState = fancyHelper[focus - 1, stack - 1, start, end, state];
  nState = fancyHelper[focus, 0, start, 1, nState];
  nState = fancyHelper[focus - 1, stack - 1, end, start, nState];
  nState = fancyHelper[focus, 0, 1, end, nState];
  fancyHelper[focus - 1, stack - 1, start, end, nState]
]

Fancy[n_Integer /; n > 0] :=
  fancyHelper[n, n - 1, 0, 2, ConstantArray["0",n]]

FancyItr[n_] :=
  Module[{p, base, result = {}, ind = {"0", "1", "2", "2", "1", "0"}},
    For[i = 0, i < n, ++i,
      For[m = 0; p = 0; base = "", m < 3^n, ++m,
        base = base <>
          If[Mod[m,3^i] == 0,
            ind[[If[Mod[++p,7] == 0, Mod[++p,7], Mod[p,7]]]],
            ind[[Mod[p,7]]]
          ];
      ];
      result = Append[result, base]
    ];
    result
  ]

End[ ]

EndPackage[ ]
