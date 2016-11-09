# MATLAB Fall 2016 – Research Plan

> * Group Name: The central authority
> * Group participants names: Brunner Georg, D'Errico Cecilia
> * Project Title: Agent based simulation of a rebellion's dynamics

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
H=Hmax*CI

- L: Agent's perceived legitimacy of government
L = [0%,100%]
	L=Lmax*PI

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

- Agent state transition rule:	if (G-N) > Treshold be active, otherwise be quiet

- Cop's arresting rule:		inspect all sites within vision (N, S, E, W)
				and arrent one active agent randomly with 
				probability P=CI*Pmax

- Cop's arresting probability:	P = [0%,100%]

- Jail time:			J = [0, Jmax]

_______________________________________________________________
The government parameters:

1. GOVERNMENT PARAMETERS

- propaganda investment:	PI = [0%,100%]

- cops investment  :        CI = [0%,100%]

- general investment:       (GI) Investment for the development for the country
                            GI+CI+HI=1

2. GOVERNMENT DECISION

- an great number of active rebels will eventually result in a separation from the
  government

- government must decide how much of its total income to invest in propaganda and cops, in order to avoid rebellions. However the governments wants the general investment to be maximized, as long as it doesn't result in the opening of a possibility of a destabilization through rebellion.

## Fundamental Questions

Within our work we want to find the optimum investments - PI, CI, GI - such that:

- There's no rebellion, that will end the state

- PI & CI are minimized

## Expected Results

We expect a model showing interesting rebellion dynamics.

## References 

- Epstein, Joshua, Modeling civil violence. An agent-based computational approach, 2002
- Alesina, Alberto, Reich, Bryony, Nation building, 2012

## Research Methods

For our realization of the model we chose an agent based model, pretty similar to the one implemented by Epstein's work "Modeling civil violence".

## Other

-
