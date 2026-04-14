# Basketball-ML-Project

## Group Members
- Aguilar, Dante 
- Grossman, Charlie
- Jin, Hannah

## Abstract 
We will be addressing the problem of better understanding the factors that influence Middlebury Men's Basketball effective field goal percentage. Using both box scores and parsed play by play data, we will construct 2 different models that a) classify the most optimal lineups for effective feild goal percentage b) create a regression model (with lasso regularization) to identify the most influential features in terms of efective field goal percentage. For evaluating the classifier, we will have a randomly grouped lineup baseline. For the regression model we will split the data into training (70%) and testing (30%) and evaluating using visualizations and accuracy. 


## Motivation 
This topic is exciting because it combines a real interest in basketball with practical machine learning methods. Basketball generates rich structured data, and some of us already have some familiarity with the sport and its analytics, which makes it easier to ask meaningful questions and interpret results. We are especially motivated by the possibility of producing something that could actually be useful to the Middlebury coaching staff, rather than building a model that exists only for class. Our goal is not just to make accurate predictions, but to create an analysis pipeline that could support real scouting and game preparation.

## Planned Deliverables
Our planned deliverables will be similar to most projects:
- A python package containing the code for both i) the two models mentioned in the abstract and ii) the code for the subsequent analysis of those models. 
- An jupyter notebook file that demonstrates the use of these models on Middlebury Men’s basketball data/NESCAQ basketball data. 
- We will share the data we gather from the internet. Code that cleans our data will also be provided in a separate jupyter notebook with text explaining out methods. 

## Resources Required 
We expect to use a combination of the following data sources:
- Middlebury and NESCAC / Division III game data, including box scores and, where available, play-by-play logs from DIII athletics websites.
- Lineup-structured data, including possessions, points scored, points allowed, and plus/minus by lineup.
- Opponent season statistics, including individual player averages, usage, efficiency, minutes, and recent form.

Dante has already started building a lineup analysis tool and database that reorganizes athletics-site data by lineup. This is a major advantage for the project because it gives us a 
more detailed and basketball-relevant representation than standard box scores alone.

## Risk Statement 
Division III basketball play-by-play data is manually recorded, making it prone to inconsistencies despite standardized procedures. These variations present significant parsing challenges that have, in the past, created challenges in extracting consistent insights from the play-by-play data. While the data is easily accessible, developing an efficient pipeline to collect and format it for machine learning remains our primary hurdle.

## Planned Deliverables: 
Our planned deliverables will be similar to most projects:
- A python package containing the code for both i) the two models mentioned in the abstract and ii) the code for the subsequent analysis of those models. 
- An jupyter notebook file that demonstrates the use of these models on Middlebury Men’s basketball data/NESCAQ basketball data. 
- I would also like to mention that we will share the data we gather from the internet. Code that cleans our data will also be provided in a separate jupyter notebook with text explaining out methods. 

## Tentative Timeline: 
By the week ten check in we want to be done with the problem of data and starting to explore models. By the week twelve check in we should have working models, be analyzing them, and essentially just tightening up the deliverables as a whole. 

*Also:* See attached folder, "schedulingMaterials". It is has when2meet data and an initial schedule. The schedule principally consists of checking in on Thursdays, Fridays, and Sundays, though is subject to change. Finals week scheduling is dependent on where we are at with our deliverables. 



