setwd("/Users/nygrpetr/Desktop/iods/iods_petra/data/")
library(readr)
library(dplyr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

### NOTE: Week 5 data wrangling continues from line 58 #####


#Explore datasets
#Human development index data
dim(hd)
##[1] 195   8
str(hd)
summary(hd)

#Gender inequality index data
dim(gii)
##[1] 195  10
str(gii)
summary(gii)

#Check current colnames
colnames(hd)
colnames(gii)

#Rename variables
hd <- rename(hd, 
             "hdi_rank" = "HDI Rank", 
             "country" = "Country", 
             "hdi" ="Human Development Index (HDI)",
             "life_exp" ="Life Expectancy at Birth",
             "expected_edu" = "Expected Years of Education",
             "mean_edu" = "Mean Years of Education", 
             "gni" = "Gross National Income (GNI) per Capita",
             "gni_minus_hdi" = "GNI per Capita Rank Minus HDI Rank")

gii <- rename(gii, 
              "gii_rank" = "GII Rank",
              "country" = "Country",
              "gii" = "Gender Inequality Index (GII)",
              "maternal_mortality" = "Maternal Mortality Ratio" ,
              "adolesc_birth" ="Adolescent Birth Rate",
              "repr_parl" ="Percent Representation in Parliament",
              "edu_f"="Population with Secondary Education (Female)",
              "edu_m" = "Population with Secondary Education (Male)",
              "labour_f" ="Labour Force Participation Rate (Female)",
              "labour_m" ="Labour Force Participation Rate (Male)")


#Add two new columns, one for ratio of f:m with secondary eduaction and one for ratio f:m labour force
gii <- mutate(gii, f_m_edu =edu_f/edu_m, f_m_labour = labour_f/labour_m) 

#Join datasets
human <- inner_join(gii, hd, by="country")
# has 195 rows and 19 columns so seems to be correct

#Save data
write.csv(human, "human.csv")

########## WEEK 5

human <- read.csv("data/human.csv")

#Human dataset contains data on human development index, giving us information about human development in different countries
#There is an extra column for row number "X" so lets remove that
human$X <- NULL
dim(human)
#[1] 195  19
str(human)
# Data frame containing numeric, character and integer variables

#Remove unneeded variables and keep only the following: 
# "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" 
keep <- c("country", "f_m_edu", "f_m_labour", "expected_edu", "life_exp", "gni", "maternal_mortality", "adolesc_birth", "repr_parl")
human <- select(human, one_of(keep))

# Remove  rows with missing values.
library(data.table)
human <- na.omit(human)
dim(human)
#[1] 162   9

#Remove regions
regions <- c("Europe and Central Asia", "East Asia and the Pacific", "Latin America and the Caribbean","Sub-Saharan Africa", "Arab States", "World", "South Asia")
human_filtered <- human[!human$country %in% regions,]
dim(human_filtered)
#[1] 155   9

#Save
## I didnt want to overwrite in case I made some mistake
write.csv(human_filtered, "human_filtered.csv")

