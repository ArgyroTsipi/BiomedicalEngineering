################ A MEROS #################
#install.packages("RISmed")
# a.1
library(RISmed)
search_topic<-'e-prescription'
search_query<-EUtilsSummary(search_topic, retmax=50, mindate=2010, maxdate=2010)
summary(search_query)

# a.2
# see the ids of our returned query
QueryId(search_query)
# get actual data from PubMed
records<-EUtilsGet(search_query)
class(records)
# store it
pubmed_data<-data.frame('Title'=ArticleTitle(records))
head(pubmed_data,10)
pubmed_data<-data.frame('Abstract'=AbstractText(records))
tail(pubmed_data,2)

################ B MEROS #################
# get current working directory
#print(getwd())

# b.1
# read & import data from csv file
data<-read.csv("icd10.csv", header = TRUE, sep = ";", stringsAsFactors=FALSE)
# view structure of data
#str(data)

# b.2.a
# T950 (Tsipi, 03119950) doesn't exist, T50 doesn't exist, so i chose one randomly
# In R, indices start at 1 and the first row with the names of the variables is not counted.
a = data[data$code == 'T950', ]
print(a)

a = data[data$code == 'T50', ]
print(a)

a = data[data$code == 'Z91030', ]
print(a)

# b.2.b
# A950 (Argyro, 03119950) 555 Sylvatic yellow fever
# Remember that the first row of the CSV file is not counted as the first row because it has the names of the variables.
a = data[data$code == 'A950', ]
print(a)

# b.2.c
a = data[data$code == 'Z91040', ]
print(a)

# b.3.a
res_a <- EUtilsSummary("Bee allergy status", type="esearch", db="pubmed", datetype='pdat', mindate=2017, maxdate=2022, retmax=500)
QueryCount(res_a)

# b.3.b
res_b <- EUtilsSummary("Sylvatic yellow fever", type="esearch", db="pubmed", datetype='pdat', mindate=2017, maxdate=2022, retmax=500)
QueryCount(res_b)

# b.3.c
res_c <- EUtilsSummary("Latex allergy status", type="esearch", db="pubmed", datetype='pdat', mindate=2017, maxdate=2022, retmax=500)
QueryCount(res_c)

# b.4
#install.packages("ggplot2")
#library(ggplot2)

# finding the no. of articles for each year & each disease (2020-2022)
res_a1 <- EUtilsSummary("Bee allergy status", type="esearch", db="pubmed", datetype='pdat', mindate=2020, maxdate=2020, retmax=500)
QueryCount(res_a1)
res_a2 <- EUtilsSummary("Bee allergy status", type="esearch", db="pubmed", datetype='pdat', mindate=2021, maxdate=2021, retmax=500)
QueryCount(res_a2)
res_a3 <- EUtilsSummary("Bee allergy status", type="esearch", db="pubmed", datetype='pdat', mindate=2022, maxdate=2022, retmax=500)
QueryCount(res_a3)

res_b1 <- EUtilsSummary("Sylvatic yellow fever", type="esearch", db="pubmed", datetype='pdat', mindate=2020, maxdate=2020, retmax=500)
QueryCount(res_b1)
res_b2 <- EUtilsSummary("Sylvatic yellow fever", type="esearch", db="pubmed", datetype='pdat', mindate=2021, maxdate=2021, retmax=500)
QueryCount(res_b2)
res_b3 <- EUtilsSummary("Sylvatic yellow fever", type="esearch", db="pubmed", datetype='pdat', mindate=2022, maxdate=2022, retmax=500)
QueryCount(res_b3)

res_c1 <- EUtilsSummary("Latex allergy status", type="esearch", db="pubmed", datetype='pdat', mindate=2020, maxdate=2020, retmax=500)
QueryCount(res_c)
res_c2 <- EUtilsSummary("Latex allergy status", type="esearch", db="pubmed", datetype='pdat', mindate=2021, maxdate=2021, retmax=500)
QueryCount(res_c)
res_c3 <- EUtilsSummary("Latex allergy status", type="esearch", db="pubmed", datetype='pdat', mindate=2022, maxdate=2022, retmax=500)
QueryCount(res_c)

# placing the no. of articles based on year in arrays
max1.art = c(3, 17, 4)
max2.art = c(2, 12, 4)
max3.art = c(0,8,0)

# creating a data frame with the previous arrays
datafr<- data.frame(max1.art,max2.art, max3.art)  

barplot(as.matrix(datafr), main = "No. of Articles per Year for the Previous 3 Diseases", xlab = "Years", names.arg = c("2020", "2021", "2022"), ylab = "No. of Articles", ylim = c(0,20), col = c("#f7eefb","#dda0dd", "#ba55d3"), border = c("#cea6e1","purple", "#ba55d3"), beside = TRUE)
legend("topleft", 
       c("Bee Allergy Status", "Sylvatic Yellow Fever", "Latex Allergy Status"),
       fill = c("#f7eefb","#dda0dd", "#ba55d3"), 
)

# b.5
#install.packages("treemap")
library(treemap)
group<-c(rep("Bee Allergy Status", 3), rep("Sylvatic Yellow Fever", 3), rep("Latex Allergy Status", 3))
subgroup<-paste("Year", c(2020,2021,2022,2020,2021,2022,2020,2021,2022), sep = "-")
value<- c(3,2,0,17,12,8,4,4,0)
ndatafr<- data.frame(group, subgroup, value)

# basic treemap
p<-treemap(ndatafr, index = c("group", "subgroup"), vSize = "value", type = "index", palette = "Set2", bg.labels = c("white"), align.labels = list(c("center","center"), c("left", "bottom")))

# make it interactive ("rootname" becomes the title of the plot):
inter<- d3tree2(p, rootname="General" )
