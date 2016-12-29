---
layout: single
title: Fancy Hanoi Test
use_math: true
syntax_highlighting: true
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

### <a name="hanoi"></a>Hanoi

Lorem ipsum.

```cpp
printf("Hello, World!\n");
```

```mathematica
(* This is a comment test *)
stayStill[xs_String, count_] := Module[{cur = StringTake[xs, -1]},
  xs <> If[Abs[count] > 1, cur <> cur, cur]
]
```
