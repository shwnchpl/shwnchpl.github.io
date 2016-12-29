---
layout: single
title: Fancy Hanoi Test
use_math: true
tags: ["functional programming", "algorithm", "discrete math"]
---

You may want to [skip ahead](#hanoi).

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
 

### <a name="hanoi"></a>Hanoi

Lorem ipsum.
