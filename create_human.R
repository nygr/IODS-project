setwd("/Users/nygrpetr/Desktop/iods/iods_petra/data/")
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


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


