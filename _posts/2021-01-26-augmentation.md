---
layout: post
title: Overview
---

Like many, my journey into creative coding was guided by Daniel Shiffman’s Nature of Code. When it first came out in 2012, it was one of the few resources which explained the core concepts of coding in an easy to understand manner. At the end of a chapter, Daniel urged the reader to implement the concepts by creating a ‘pond’, an ecosystem with intelligent agents which would act of their own accord, and employ a genetic system, much like real life. I never got around to actually creating this ecosystem, partly because it was a difficult undertaking. 

![pond-proto](/pond/media/pond-proto.png)

I tried to create a few variations, but never managed to figure out how to create intelligent agents capable of interacting with each other. My interest in creating an artificial ecosystem didn’t fade, and I finally decided to create one, but with a unique tweak. Most Artificial Life (AL) systems replicated reality, or at the very least, followed the same rules of predation, and natural selection. I wanted to explore alternative metrics of natural selection. Would being nice to each other help the species as a whole thrive? Or is the idea of the selfish gene far too efficient? My intent with the AL system was to create an homeostatic system which would then be induced with behaviours such as sharing, community, and respect for the environment, with the hopes of comparing the tweaked systems with the baseline to observe if there were any changes, if at all.



## Iteration 1

![SL1](/pond/media/sl1.png)

I took an iterative approach toward creating the AL ecosystem, adding features and behaviours to the system layer by layer. The first iteration consisted of two types of entities, an agent (square) and a food particle (circle. The food particles are randomly distributed across the canvas, with the agents moving around the space hunting for food with the help of a simple physics engine. Each agent had a hunger threshold, and would lose hunger every second. In order to regain their hunger, they would need to eat food. The agents use a simple vector based targeting system to lock on to the position of the nearest food particle in order to locomote towards it. The colour of the agent would change depending on how much hunger they had remaining. The scenario would start with all agents having low hunger, denoted by them being coloured black, and once they eat food and cross a certain hunger threshold, their colour would switch to white. The system worked well, with the agents chasing after all the food particles in the space, and the colour system denoted their hunger. However, at this stage, the agents didn’t have any intelligence of their own. They were simply programmed to look for food, and change colour when their individual hunger crossed a certain threshold. They could do nothing else.


## Iteration 2

![SL2](/pond/media/sl2.png)

The next iteration added the first sign of real intelligence to the agents. The agents, now in the shape of triangles to denote their direction, had two states. They would either roam around the canvas using perlin noise to define their direction, or they would hunt for food. If they were hungry, they would hunt for the closest food particle, and once their hunger was above a certain threshold, they would roam around at random. Intelligence at its very essence, is to make a choice. The agents would make this decision based on how hungry they were. The colour system is the same as before, denoting the agent’s hunger levels.


## Iteration 3

![SL3](/pond/media/sl3.png)

The first aspects of plant intelligence have been included. Plants can now regenerate and repopulate the space. It’s a rudimentary system, with plants being added to a random location if the plant population dips below a certain threshold. A lot of work went into refactoring the code. The development started to resemble a tick-tock cycle, with features being added on each ‘tick’, and code being cleaned up and refactored on every ‘tock’. This project is to be shared, and hence needs to be accessible. The refactoring of code also allows for the creation of a modular design, which makes it easy to add additional features in subsequent iterations, through the use of aptly named global variables, and making features accessible via functions.


## Iteration 4

![SL4_2](/pond/media/sl4_2.png)

The agents now have a better sense of their surroundings, along with the ability to switch between activities. They have an awareness of food in the space, albeit not the geographically closest food. They go hunting for food in the order it has been listed in the food array. It’s a challenge to have them understand their immediate surroundings and figure out the closest food to each individual agent. The agents have 3 states they can switch between–hunting for food, looking for a mate, or just moving around with no particular objective. Their active state is a function of how much hunger they have, i.e how much food they have eaten. The genes of the offspring are not yet linked to parents, and are randomly generated. The genes only define the maximum speed of the agents and their visual colour. The agents now have a randomly set lifespan, and will die after 16-33 seconds. 


## Iteration 5

![SL4_3](/pond/media/sl4_3.png)

The agents now have an understanding of their immediate surroundings and can find the closest food particle to them. The genes of the offspring are now directly influenced by the parents, with subsequent generations reflecting the genes of those agents which successfully find food and mate. The agents are now a little more unique, with each of them having randomised maximum speed, lifespan, and the food needed till they could mate. The last characteristic will become far more interesting in subsequent generations, with the addition of predators. At this point, the need for telemetry started to become apparent, as it was difficult to understand the overall health of the system without any numbers. As it became increasingly difficult to define, or ‘control’ the characteristics of the agents as they mated and underwent genetic mutation, a simple logging system was set up to track the average maximum speed, and the food needed to reach mating state. This was interesting to see, as agents with the faster maximum speed beat their slower counterparts to food, hence eating more food, and depriving others. This would lead to them mating sooner and replicating their characteristics to subsequent generations. Agents which needed less food to mate were also more likely to succeed as they could mate quicker than others. Although this may seem obvious, the fact that the system confirmed the hypothesis meant that the agents were behaving as they should. 


## Iteration 6

![SL4](/pond/media/sl4_4.png)

Now, with predators the ecosystem becomes even more interesting. The predators are very similar to the agents, but the difference being that they hunt the agents and not plants. Although it doesn’t seem like a big change, the ecosystem becomes quite complex to manage, given the code and the increased variables. Most of the work has gone into making sure that the entities co-exist successfully and that there are no gaping logical errors. To get the agents to detect other entities in the space around them can get quite complicated, requiring the use of multiple databases.


## Iteration 7

![SL5_1](/pond/media/sl5_1.png)

This particular iteration adds a fair few features to the system. The first thing you notice are the infographics on the bottom of the screen, which provides live telemetry on the two kinds of agents. The agents themselves now have names! Salvaged from music albums, the names help keep track of the different entities on screen, and in a way, also provide some character. The Opus (plural: Opii) is the second in the food chain–they eat the plants and get eaten by Hachi, the predators. The telemetry provides information on the average statistics of both species. Both entities also have far more variables attached to their genes, in addition to their maximum speed and food needed to reproduce, the DNA also contains their field of vision, their age, and how much food they are born with. 

The ecosystem is now quite complex, with any changes to the parameters or the code not resulting in direct, corresponding changes. This makes it difficult to truly understand how changes affect the individual entities or the system as a whole. The telemetry does help as it allows the viewer to spot larger trends, but it’s not enough to pinpoint the effects of any particular changes. The biggest challenge now is to achieve homeostasis. The system currently is far too chaotic, with widely varying outcomes. In certain simulations, the Opii go extinct, and sometimes the Hachi go extinct. In some cases, they achieve a level of homeostasis for a few minutes before a certain species gets wiped out. One of the reasons for the extremely fast paced nature of the entities, and the interactions of the system is to accelerate the temporality of the ecosystem in order to observe the behaviours in a shorter (real) time span. The faster the entities, and quicker the interactions, the easier it is to run multiple simulations and understand the behaviour of the ecosystem as a whole.

Subsequent iterations focus exclusively on trying to achieve homeostasis, and it’s in this effort that many weaknesses and issues with the system are exposed. For example, the plant generation system was quite rudimentary, with plants appearing at random across the space. For better or for worse, this behaviour put the Opus at a disadvantage early on the simulation, with plants being spread out over the entire canvas. There was a tendency for the Opus to lose a substantial amount of initially seeded entities in the first 10 seconds or so. This required a complete reworking of the plant generation system, and additionally, the amount of nutrition they provide to the Opus. The plant generation developed into a cluster based system, with plants generating new plants next to them once they reach a certain state of maturity. The size of the plants provide proportional nutritional value, so the Opii gain less nutrition by eating smaller, younger plants, and far more if they eat mature, older plants. 
