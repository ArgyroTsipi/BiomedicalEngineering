#install.packages("UsingR")
library('UsingR')
data(wellbeing)
View(wellbeing)
# AM: 031 19950
# 0 -> x = GDP
x = wellbeing$GDP
#1: mesos oros x
mean(x)
#2: country with max x
wellbeing[x == max(x),]$Country

#3: classify with decreasing order based on variable & put it in a new data frame wellbeing2
wellbeing2 = wellbeing[order(-x),]
View(wellbeing2)
#4: show the names of the first 3 countries in wellbeing2
wellbeing2[1:3,1:1]

#5: graph for x = well.being & y = x of wellbeing data frame
#install.packages("ggplot2")
library(ggplot2)

ggplot(wellbeing, aes(x = Well.being, y = x)) +geom_point() + geom_smooth(method = lm, color = "magenta")

ggplot(wellbeing, aes(x = Well.being, y = x))  + geom_smooth(color = "magenta")

#6 find the countries with x > mean(x) & put the results in a new data frame wellbeing3  
wellbeing3 = wellbeing[x>mean(x),]
View(wellbeing3)

#7 graph for Well.being with histogram
# i created a new data frame where Well.being is in a descending order and i used barplot to plot the descending diagram, where y = Well.being & x = Countries
wellbeing4 = wellbeing3 [order(- wellbeing3$Well.being),]
#View(wellbeing4)
barplot(wellbeing4$Well.being, main = "Well.being in descending order", xlab = "countries" , ylab = "Wellbeing",names.arg= wellbeing4$Country )
