# MATLAB Fall 2016 – Research Plan

> * Group Name: 
> * Group participants names: Brunner Georg, D'Errico Cecilia
> * Project Title: 

## General Introduction

In our project we want to model the stability of an existing state, given a specific level of 

This project deals with the stability of an existing state. In partiuclar we want to model the dynamics that arise from the coexisting of two actors. The central government on the one hand, and on the other its civils.
While the government is responsible for building and maintaining infrastructure

One of the key tasks for a government, when maintaining the stability of a state 

## The Model

The dynamical agent-based model:

1) ACTORS

there are two kind of actors: agents (citizens) and forces of central authority (cops)

2) PARAMETERS

- H:	agent perceived hardship from government
	H = [0%,100%]

- L:	agent perceived legitimacy of government
	L = [0%,100%]
	L proportional to I

- G:	agent's level of grievance (sense of injustice)
	G = [0%,100%]
	G=H(1-L)

- R:	agent's level of risk aversion
	R = [0%,100%]

- N:	agent's net risk
	N = [0%,100%]
	N = RP

- V:	agent's age
	V = [0, 80]

3) DYNAMICS

- Actors dynamics:		not moving or moving randomly between the 4 spaces 
				(N, S, E, W) near them

- Agent's states:		either Q (quiet, meaning inactive)
				or A (active, meaning rebelling)

- Agent state transition rule:	if (G-N) > T be active, otherwise be quiet

- Cop's arresting rule:		inspect all sites within vision (N, S, E, W)
				and arrent one active agent randomly with 
				probability P

- Cop's arresting probability:	P = [0%,100%]

- Jail time:			J = [0, Jmax]

_______________________________________________________________
The government parameters:

1) GOVERNMENT PARAMETERS

- total taxes income: 		T proportional to number of citizens

- homogenization investment:	I = [0%,100%]

- homogenization cost:		C : [min%,100%] -> [min, T]
				strictly growing function, as defined in paper A)
				min proportional to the number of cops (salary)

- homogenization effort:	E = [C(0), C(100%)]

2) GOVERNMENT DECISION

- an great number of active rebels will eventually result in a separation from the
  government

- government must decide how much of its total income to invest in homogenization 
  processes: a big investment will increase the perceived legitimacy of the government.



## Fundamental Questions


## Expected Results



## References 

* Epstein, Joshua, Modeling civil violence. An agent-based computational approach, 2002
* Alesina, Alberto, Reich, Bryony, Nation building, 2012

## Research Methods


## Other

-
