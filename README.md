# MATLAB Fall 2016 – Research Plan

> * Group Name: 
> * Group participants names: Brunner Georg, D'Errico Cecilia
> * Project Title: 

## General Introduction

When delving among some history books, one certainly comes across uncountable pages about revolutions. In the case of many of them a precursor was some kind of civil resistance against the prevailing authority - a rebellion. Within this project we want to investigate the dynamics of such a rebellion, which, besides some factors like for instance spill-over effects, when there's a rebellion in neighbor countries, mainly depends on the interaction of two actors. On the one hand the authority itself, represented by a number of institutions, which we will narrow down to one - the police - while on the other hand there are the citizens.

Building on models that implemented just that we want to extend this simulation, by giving the authority more options of interaction, i.e. the citizens grievance apparently depends on the distance - in a sense of preferences (Alesina, Reich) - between citizen and government. That distance can be reduced by an act of homogenization, as it can be achieved by investing in infrastruture.

## The Model

1. ACTORS

There are two kind of actors
- Agents (citizens)
- Forces of central authority (cops)

2. PARAMETERS

- H: Agent's perceived hardship from government
H = [0%,100%]

- L: Agent's perceived legitimacy of government
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

3. DYNAMICS

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

1. GOVERNMENT PARAMETERS

- total taxes income: 		T proportional to number of citizens

- homogenization investment:	I = [0%,100%]

- homogenization cost:		C : [min%,100%] -> [min, T]
				strictly growing function, as defined in paper A)
				min proportional to the number of cops (salary)

- homogenization effort:	E = [C(0), C(100%)]

2. GOVERNMENT DECISION

- an great number of active rebels will eventually result in a separation from the
  government

- government must decide how much of its total income to invest in homogenization 
  processes: a big investment will increase the perceived legitimacy of the government.



## Fundamental Questions

Within our work we want wo find an optimum between exacted taxes and expenses for homogenization.

## Expected Results

## References 

- Epstein, Joshua, Modeling civil violence. An agent-based computational approach, 2002
- Alesina, Alberto, Reich, Bryony, Nation building, 2012

## Research Methods

For our realization of the model we chose an agent based model, pretty similar to the one implemented by Epstein's work "Modeling civil violence".

## Other

-
