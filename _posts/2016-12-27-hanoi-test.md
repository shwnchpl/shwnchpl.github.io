---
layout: single
title: Fancy Hanoi Test
use_math: true
syntax_highlighting: true
highlight_style: solarized-light
tags: ["functional programming", "algorithm", "discrete math"]
---

If you're already familiar with the traditional Tower of Hanoi game, you may want to [skip ahead](#fancy_hanoi) to the part where I start talking about Fancy Hanoi.

### What is the Tower of Hanoi?

The [Tower of Hanoi](https://en.wikipedia.org/wiki/Tower_of_Hanoi) is a classic mathematical puzzle/game that was first invented in by French mathematician [Édouard Lucas](https://en.wikipedia.org/wiki/%C3%89douard_Lucas).  The puzzle is comprised of three vertical pegs and several rings.  Oftentimes, physical Tower of Hanoi sets are made of wood like the one pictured below.

![Wooden Hanoi]({{ site.url }}/assets/images/2016-12-27-hanoi/wooden_hanoi.jpg){: width="70%" }
*[A Link](nowhere)* - and explanation
{: .image_caption}

The rules of the puzzle are quite simple: you have several disks stacked increasing in size from large to small on one of three pegs (generally the leftmost) and the goal is to move them all to another of the three pegs (generally the rightmost).  There are two small caveats that make the puzzle interesting rather than just an excuse to fool around with wooden rings.  1) Only one disk may be moved at a time and 2) A larger disk can never be stacked upon a smaller disk.

The least-move solution to the puzzle can be very aptly conceptualized recursively.  In order to move a stack of $n$ disks with bottom disk $d_n$ from any given source peg $S$ to any given destination peg $D$ one must

1. Move the stack of smaller disks on top of $d_n$ to auxiliary peg $A$.
2. Move $d_n$ directly from $S$ to $D$.
3. Move the stack of smaller disks from $A$ to $D$.

In the event that a disk does not have a stack of disks on top of it, of course, it is legal to simply move it onto another peg, provided that peg does not already hold any smaller disks-- in fact, this is the base case of the recursive solution.  For instance, in a game with only one disk, to move from $S$ to $D$ would require only one move.  With two disks, in order to move the stack on $S$ to $D$, first the bottom disk $d_2$ must be exposed by moving all disks on top of it (in this case, just $d_1$) to the auxiliary peg A.  Once the top peg $d_1$ has been moved to $A$, the bottom peg $d_2$ can be moved directly $S$ to $D$.  Finally, $d_1$ can be moved from $A$ directly to D.  This process is illustrated with 4 disks in the animated gif below. 

![Animated Hanoi]({{ site.url }}/assets/images/2016-12-27-hanoi/animated_hanoi.gif){: width="70%" }
*[A Link](nowhere)* - and explanation
{: .image_caption}

For cases with more than two disks, it’s important to note that the peg acting as auxiliary depends on the peg acting as destination.  From now on, let’s refer to the three pegs as $P_1$, $P_2$, and $P_3$.  Say we’re trying to move a stack of three disks from $P_1$ to $P_3$, so we start by trying to move the bottom disk $d_3$.  For the purposes of this move, our source peg $S$ is $P_1$, our auxiliary peg $A$ is $P_2$, and our destination peg $D$ is $P_3$.

This move is, however, itself comprised of several moves.  As discussed above, in order to make the move of the stack of three pegs from $S$ to $D$ we must first move the stack of two pegs on top of the $d_3$ to the auxiliary peg $A$, in this case $P_2$.  For the purposes of moving this stack of two to peg $P_2$, our source $S$ is still $P_1$, but our destination $D$ is now $P_2$, so our auxiliary A is now $P_3$.  After we move the single top disk $d_1$ to $P_3$, move the middle disk $d_2$ to $P_2$, and move smallest disk $d_1$ to $P_2$, we can finally move the largest disk $d_3$ to $P_3$.  We then finish by moving the stack of two disks from $S = P_2$ to $D = P_3$ using $A = P_0$ as an auxiliary.
 
### How many moves does it take to solve the puzzle?

Since we know the least-moves solution to a puzzle conforming to the rules above can be arrived at through the recursive algorithm above, it shouldn't be too difficult to derive a formula for the number of moves necessary to reach a solution in round with $n$ disks.  We’ll call this least possible number of moves $H_n$.

We know that $H_1 = 1$ because it only takes one move to move a single disk from some source $S$ to some destination $D$.  We also know that for all other $n$ numbers of pegs, in order to move a stack with bottom peg $d_n$ first we have to move the stack on top of it with bottom peg $d_{n-1}$ to the auxiliary peg $A$, then we have to move the bottom peg $d_n$ to the destination peg $D$, and finally we have to move the stack of smaller pegs from $A$ to $D$.  This means we first have to make $H_{n-1}$ moves, then 1 move, then $H_{n-1}$ moves again.  This gives us

$$
  H_n = 2 H_{n-1} + 1
$$

So far so good.  All we need now is a bit of algebraic manipulation to express $H_n$ in closed form.  Since $H_n = 2H_{n-1} + 1$ we can say that

$$
  H_n + 1 = 2H_{n-1} + 2 = 2(H_{n-1} + 1)
$$

If we let $X_n = H_n + 1$ then we have 

$$
  X_n = 2X_{n-1}
$$

which is a linear homogeneous recurrence relation with the characteristic equation $x = 2$.

Since $X_n$ is a linear homogeneous recurrence relation, we know that $X_n = X_0 (2)^n$.  Also, since $X_0 = H_0 + 1$ and $H_0 = 0$ (because it takes zero moves to move no disk), we can say

$$
  X_n = (1)2^n = 2^n \\\\
  H_n = X_n - 1 = 2^n - 1
$$

### <a name="fancy_hanoi"></a>So what's this Fancy Hanoi business all about?

One nice thing about the traditional Tower of Hanoi puzzle is that you can move a disk over a peg if need be— that is, it is legal to move from $P_1$ to $P_3$ and visa versa.  One varient of the puzzle we could define— a varient I've heard called "Fancy Hanoi"— would have all the same rules as traditional Hanoi, except instead of being able to jump over a peg in a move, it would only be legal to move a disk to an adjacent peg.  For instance, a disk on $P_1$ could only legally be moved to $P_2$.

Although we can still solve the puzzle recursively much in the same way as before, there are a few extra steps that must be taken.  The least-move solution to the puzzle can be conceptualized recursively as follows.  In order to move a stack of $n$ disks with bottom disk $d_n$ from any given source peg $S$ to any given destination peg $D$ one must

1. Move the stack of smaller disks on top of $d_n$ to destination peg $D$,
2. Move the bottom peg $d_n$ to the auxiliary peg $A$.
3. Move the stack of smaller disks from destination peg $D$ to source peg $S$.
4. Move the bottom peg $d_n$ from auxiliary peg $A$ to destination peg $D$.
5. Move the stack of smaller disks from source peg $S$ to destination peg $D$.

Here's an animated gif I made of me playing through a 3 disk round of Hanoi while holding myself to the "Fancy Hanoi" rules.

![Animated Fancy Hanoi]({{ site.url }}/assets/images/2016-12-27-hanoi/animated_fancy_hanoi.gif){: width="70%" }
*[A Link](nowhere)* - and explanation
{: .image_caption}

It turns out calculating the minimal number of moves $F_n$ necessary to solve a game of Fancy Hanoi with $n$ pegs isn't much more complicated than calculating the minimal number of moves necessary to solve a game of traditional Hanoi.  To start out, we know $F_1 = 2$ because it takes two moves to move a single peg from $P_1$ to $P_3$.  As illustrated in the above animation, moving $n$ pegs requires

1. $F_{n-1}$ moves to move the stack of smaller disks on top of bottom disk $d_n$ from source peg $S$ to destination peg $D$.
2. 1 move to move the bottom peg $d_n$ from $S$ to the auxiliary peg $A$.
3. $F_{n-1}$ moves to move the stack of smaller disks from $D$ to $S$.
4. 1 move to move the bottom peg $d_n$ from $A$ to $D$.
5. $F_{n-1}$ moves to move the stack of smaller disks from $S$ to $D$.

Adding all of these moves together gives us

$$
  F_n = 3F_{n-1} + 2
$$

This can be algebraically manipulated into a solvable linear homogeneous recurrence relation and solved much in the same way as the recurrence relation for traditional Hanoi. 

First we use the same trick as before to make it easy to put into closed form.

$$
  F_n = 3F_{n-1} + 2 \\\\
  F_n + 1 = 3F_{n-1} + 3 = 3(F_{n-1} + 1) \\\\
  X_n = F_n + 1 = 3X_{n-1}
$$

Then we simply solve the recurrence relation.

$$
  X_n = X_0 3^n = (F_0 + 1) 3^n = (1)3^n \\\\
  F_n = X_n - 1 = 3^n -1
$$

Interestingly, while an $n$ disk game of traditional Hanoi takes a minimum of $2^n - 1$ moves to solve, a $n$ disk game of Fancy Hanoi takes a minimum of $3^n - 1$ moves to solve.

### Writing a Recursive Fancy Hanoi Solver in the Wolfram Language

It’s all fine and good to know the minimum number of moves necessary to solve a Fancy Hanoi puzzle, but it might also be nice to know exactly what the state of the game might be at any given move.

Let's say we want to represent the positions of a disk at any given move as a ternary [ternary](https://en.wikipedia.org/wiki/Ternary_numeral_system) string.  The string “01210” would indicate a disk was on $P_1$ at move 0, $P_2$ on move 1, $P_3$ on move 2, $P_2$ on move 3, and $P_1$ on move 4.  In effect, the $i$-th character in the string would be the location of the disk at move $i$.  The complete solution to a game with $n$ pegs could then be expressed as an $n$-length list of $3^n$-length ternary strings ($3^n - 1$ characters for each move and 1 character for the initial position). 

For example, the ternary string list solution to a 1 disk round of Fancy Hanoi would be

```
{"012"}
```

And the ternary string list solution to a 3-disk round of Fancy Hanoi would be

```
{"012210012210012210012210012",
 "000111222222111000000111222",
 "000000000111111111222222222"}
```

Ideally, it would be nice to have a function $Fancy: n \to L$ where $n \in \mathbb{N}$ and $L$ is a $n$-length list of $3^n$-length ternary strings denoting all states of the game from start to finish.  The time complexity of any algorithm to implement this function will be $\Omega(n \cdot 3^n)$ because the generation of each string character will require a constant number of computations and there are $n \cdot 3^n$ characters to generate.  Although there is a very nifty iterative solution to this problem (which I'll talk about [below](#fancy_iter)), first I'd like to demonstrate a relatively concise recursive solution that follows functional programming idioms.  The solution I'll present is written in the [Wolfram Language](https://en.wikipedia.org/wiki/Wolfram_Language) (the programming language used in Mathematica), but there's no reason why a similar solution couldn't be implemented in Haskell, ML, LISP, or any other functional programming language.

First of all, even if we want to be able to call a function `` Fancy[n_Integer /; n > 0] `` and have it return a ternary string list, such a function certainly is not alone sufficient to recurse upon.  `` Fancy `` is going to need some kind of helper function that actually is recursive and this function is going to have to accept several arguments— namely, the bottom disk $d_n$ to be moved (which I'll also refer to as the "focus"), the size of the stack on top of $d_n$, the current source peg $S$ that $d_n$ is being moved from, the current destination peg $D$ that $d_n$ is being moved to, and finally the current state of the game.

With these considerations in mind, we can write `` Fancy `` as follows:

``` mathematica
fancyHelper[focus_, stack_, start_,end_, state_] := Module[{nState},
  nState = fancyHelper[focus - 1, stack - 1, start, end, state];
  nState = fancyHelper[focus, 0, start, 1, nState];
  nState = fancyHelper[focus - 1, stack - 1, end, start, nState];
  nState = fancyHelper[focus, 0, 1, end, nState];
  fancyHelper[focus - 1, stack - 1, start, end, nState]
]

Fancy[n_Integer /; n > 0] :=
  fancyHelper[n, n - 1, 0, 2, ConstantArray["0",n]]
```

Calling `` Fancy `` with a single natural number argument makes a call to fancyHelper which accepts sufficient arguments to recursively solve the accepts sufficient arguments to recursively solve the problem.  Initially, we are trying to move the entire stack so the focus (that is, $d_n$) is the $n$-th disk.  There are $n-1$ disks on top of the $n$-th disk, so the stack is $n-1$.  The start peg is $P_1$ (here denoted by 0) and the end peg is $P_3$ (here denoted by 2).  Each disk begins on $P_1$, so the initially state is simply a list of strings containing “0”.  This is generated with a call to `` ConstantArray[“0”, n] ``.

The content of `` fancyHelper `` is relatively straightforward.  We'll address the base case in which `` stack == 0 `` in a moment with a separate definition of `` fancyHelper ``, so we can rest assured that the code above will only ever be evaluated when `` stack >= 1 ``.  In this case, we need to first move the stack above the disk that is currently in focus, which we can do by calling `` fancyHelper[focus - 1, stack - 1, start, end, state] ``.  The modified state that is returned from this function call is stored in `` nState `` so that it can be used.  Next, we need to move the disk that we were originally trying to move (the "focus") from the "start" (that is, surce peg $S$) to the middle.  This is done with a call to `` fancyHelper[focus, 0, start, 1, nState] ``.  We are able to make this call because we know that the stack above the current "focus" has already been moved and is currently on the destination peg $D$ as a result of the previous call to `` fancyHelper ``.  Again, we store the result of this function call in `` nState ``.  We go on like this, completing each of the five steps in the recursive Fancy Hanoi algorithm discussed above, storing the new state the first four times so that it can be passed along to the next recursive call, and finally, after the fifth recursive call, returning the state of the game after the move initially requested has been completed.

So far so good.  Now we need to handle the base case in which `` stack == 0 `` and we can actually move a disk.  Any time a move is being made, we're going to want to be able to have a disk either "stay still" (if it is not the current "focus") or "move" (if it is).  For instance, in a game with two disks,

```
{"0","0"} -> {"01","00"}
```

would indicate that the top (smallest) disk moved from $P_1$ to $P_2$ while the bottom (largest) disk stayed still on $P_1$.  If we want to move over more than one peg, that needs to happen in two separate moves.  So

``` mathematica
Fancy[1, 0, 0, 2, {"0","0","0"}]
```

should return

```
{"012","000","000"}
```

We can code up a few helper functions to take care of moving and staying still.  Let's assume that rather than passing these functions a source peg and a destination peg (which might become overly complicated), we'll just pass them a count of how many pegs over to move.  In the case of staying still, we can simply treat this count as an indication of how many times to update.  Let's further assume that we'll calculate this count so that a move to the left is negative and a move to the right is positive.  This will mean that, for example, if we were moving a disk from $P_3$ to $P_1$ the count would be -2 and if we were moving a disk from $P_1$ to $P_2$ the count would be one.  With all of this in mind, we can write `` stayStill `` like this

``` mathematica
stayStill[tStr_, count_] := Module[{cur = StringTake[tStr, -1]},
    tStr <> If[Abs[count] > 1, cur <> cur, cur]
]
```

The idea here is to simply take the last character of the ternary string `` tStr ``, which is equal to the current position, and append it to the end of `` tStr `` either once or twice depending on the count.  If the count is 2 or -2 then the disk that's actually in focus is going to be moving twice, so we need to "stay still" twice.  Otherwise, we only need to "stay still" once.  Let's test it out!

```
> stayStill["1",-2]
"111"

> stayStill["0",-1]
"00"

> stayStill["012",2]
"01222"
```

It seems to work fine!  `` moveSome `` can be handled similarly— the only difference is that rather than just reading the current position from the last character in the string and appending it a certain number of times depending on the count, we have to actually append a new character or two depending on the count and the current position.  Much like in `` stayStill ``, the first thing we need to do is check the last character of the ternary string to get the current position.  Once we have this character, we can take advantage of the fact that there are very few legal moves to append the correct characters to the end of the string using a minimal number of comparisons.

For example, we know that any move starting from $P_1$ is not going to have a negative count while any move starting from $P_3$ is not going to have a positive count.  We also know that while a move starting from $P_2$ may have either a negative or positive count, the absolute value of its count will always be equal to one.  Because of this, we can cover all possible moves with a function written as follows.

``` mathematica
moveSome[tStr_, count_] := Module[{cur = StringTake[tStr, -1]},
  tStr <> Switch[cur,
    "0", If[count == 1, "1", "12"],
    "1", If[count == 1, "2", "0"],
    "2", If[count == -1, "1", "10"]
  ]
]
```

Testing this out with some valid inputs yields the expected results.

```
> moveSome["012",-2]
"01210"

> moveSome["0111",-1]
"01110"

> moveSome["0",2]
“012”
```

Now all that’s left to do is write a function that calculates the count and then applies `` moveSome `` to the ternary string corresponding to the disk that's in focus and `` stayStill `` to all other strings.  It’s easy enough to calculate the count— all we have to do is subtract the end peg from the start peg.  As far as applying the functions goes, although it could certainly be achieved with some sort of loop that checked every iteration to see whether the current iteration index $i$ were equal to the focus, iterative rebuilding the entire state, this might end up becoming rather complicated and it wouldn't be very good functional programming style.  Fortunately, there's a far better tool for this job: MapAt.

[MapAt](http://reference.wolfram.com/language/ref/MapAt.html) is a very nifty function that takes a function, an expression, and a list of parts of the expression to which the function should be applied.  As an example, consider the anonymous function `` # + 1 & `` which adds 1 to watever it is passed as an argument and returns the result.  We can use MapAt to apply it to parts of a list as follows.

``` {% raw %}
> MapAt[# + 1 &, {0,0,0},{2}]
{0, 1, 0}

> MapAt[# + 1 &, {0,0,0,0,0,0,0}, {{2}, {4}, {6}}]
{0, 1, 0, 1, 0, 1, 0} {% endraw %}
```

Let’s say we want to apply a certain function to every element of a list but one (because we do).  If we want to use MapAt to do this, for the list of element parts the function should be applied to, we need to pass it something like this

{% raw %}
$$ 
  \{\{1\},\{2\},...,\{n\}\} - \{d_f\} 
$$ 
{% endraw %}

where $n$ is the length of our list of ternary strings and $d_f$ is the index of the ternary string corresponding to the disk that is currently in focus.  If we call `` Map[{#} &, Range[n]] `` that will give us a list {% raw %} $$\{\{1\},\{2\},...,\{n\}\}$$ {% endraw %}.  This is pretty good, but it still contains the singleton containing the index of the focus $d_f$.  What we really need is to drop the index of the focus $d_f$ from the list returned from Range before we encapsulate each element of this list as a singleton.

We can do this with the [Drop](http://reference.wolfram.com/language/ref/Drop.html) function which is able to accept a list of specific indicies to drop as a second argument.  Putting it all together, we get something like this.

``` mathematica
Map[{#} &, Drop[Range[Length[state]], {focus}]]
```

We can test this out to see that it does indeed work the way we would like.

``` {% raw %}
> Map[{#} &, Drop[Range[5], {4}]]
{{1}, {2}, {3}, {5}}

> Map[{#} &, Drop[Range[7], {3}]]
{{1}, {2}, {4}, {5}, {6}, {7}} {% endraw %}
```

Excellent, this means we can directly call

``` mathematica
MapAt[stayStill[#, count] &, state,
  Map[{#} &, Drop[Range[Length[state]], {focus}]]]
```

and this will return a state modified such that each disk not in focus has stayed still the required number of times.  Now all that's left is to call `` MapAt[moveSome[#, count], ..., {focus}] `` on the result of this to move the disk that is currently in focus as required.  Here's a listing of the completed function.

``` mathematica
FancyHelper[focus_, 0, start_, end_, state_] := Module[{count = end - start},
  MapAt[moveSome[#, count] &,
    MapAt[stayStill[#, count] &, state,
      Map[{#} &, Drop[Range[Length[state]], {focus}]]],
    {focus}]
]
```

And there you have it— this is all we need!  Let's take the whole thing for a spin.

```
> Fancy[1]
{"012"}

> Fancy[2]
{"012210012", "000111222"}

> Fancy[3]
{"012210012210012210012210012",
 "000111222222111000000111222",
 "000000000111111111222222222"}

> Fancy[4]
{"012210012210012210012210012210012210012210012210012210012210012210012210012210012",
 "000111222222111000000111222222111000000111222222111000000111222222111000000111222",
 "000000000111111111222222222222222222111111111000000000000000000111111111222222222",
 "000000000000000000000000000111111111111111111111111111222222222222222222222222222"}
```

We can even write a quick tester function to verify that the length of each ternary string is indeed $3^n$ for any $n$ we might pass (provided our computer can compute the result).

``` mathematica
TesterFunc[n_] := Fold[#1 && #2 &, True, Map[StringLength[#] == 3^n &, Fancy[n]]]
```

Running this little guy confirms (at least somewhat) that everything has indeed gone according to plan.

```
> TesterFunc[5]
True

> TesterFunc[8]
True
```

### <a name="fancy_iter"></a>Bonus: A more iterative approach
