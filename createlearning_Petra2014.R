### Petra Nygren
#### 9 November 2023
##### R script week 2 - create learning Petra
library(dplyr)
learning_dataset <-read.table("/Users/nygrpetr/Desktop/iods/iods_petra/data/JYTOPKYS3-data.txt.crdownload",header=T)
print(learning_dataset) 

dim(learning_dataset)
#[1] 183  60 : data has 183 rows and 60 columns

str(learning_dataset)
#dataframe of dim 183  60, with variables both integer and character formats. 


 #Create an analysis learning_datasetset with the variables gender, age, attitude, deep, stra, surf and points 
#by combining questions in the learning2014 learning_dataset, as defined in the Exercise Set and also on the bottom part of the following page 
#(only the top part of the page is in



#get col names
colnames(learning_dataset)

# [1] "Aa"       "Ab"       "Ac"       "Ad"       "Ae"       "Af"       "ST01"     "SU02"     "D03"      "ST04"     "SU05"     "D06"      "D07"     
#[14] "SU08"     "ST09"     "SU10"     "D11"      "ST12"     "SU13"     "D14"      "D15"      "SU16"     "ST17"     "SU18"     "D19"      "ST20"    
#[27] "SU21"     "D22"      "D23"      "SU24"     "ST25"     "SU26"     "D27"      "ST28"     "SU29"     "D30"      "D31"      "SU32"     "Ca"      
#[40] "Cb"       "Cc"       "Cd"       "Ce"       "Cf"       "Cg"       "Ch"       "Da"       "Db"       "Dc"       "Dd"       "De"       "Df"      
#[53] "Dg"       "Dh"       "Di"       "Dj"       "Age"      "Attitude" "Points"   "gender"  



# get deep, strategic and surface questions from learning_dataset file
deep_original <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_original <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_original <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")


# select columns based on the previous vectors and create new scaled columns containing means
deep_col <- select(learning_dataset, one_of(deep_original))
learning_dataset$deep <- rowMeans(deep_col)

surface_col <- select(learning_dataset, one_of(surface_original))
learning_dataset$surface <- rowMeans(surface_col)

strategic_col<- select(learning_dataset, one_of(strategic_original))
learning_dataset$strategic <- rowMeans(strategic_col)

colnames(learning_dataset)

# select columns and rename
learning_dataset_sel <- select(learning_dataset, gender, age = Age, attitude = Attitude, deep, surface, strategic, points = Points)


colnames(learning_dataset_sel)
#[1] "gender"    "age"       "attitude"  "deep"      "surface"   "strategic" "points"   

#chcek if there are zeros
print(learning_dataset_sel$points) 
#[1] 25 12 24 10 22 21 21 31 24 26 31 31 23 25 21  0 31 20 22  9 24 28 30 24  9 26 32 32  0 33 29 30 19 23 19 12 10 11 20 26 31 20 23 12 24 17 29 23 28 31
#[51] 23 25 18 19 22 25 21  9 28 25 29 33 33 25 18 22 17 25  0 28 22 26 11 29 22  0 21 28 33 16 31 22 31 23 26 12 26 31 19  0 30 12 17  0 18 19 21 24 28 17
#[101] 18  0 17  0 23  0 26 28 31 27 25 23 21 27 28 23 21 25 11 19 24 28 21 24 24  0  0 20 19 30 22 16 16 19  0 30 23 19 18 28 21 19 27  0  0 24 21 20 28 12
#[151] 21 28 31 18 25 19 21 16  7 21 17 22 18 25 24 23  0 23 26 12  0 32 22  0 20 21 23 20 28 31 18 30 19

# exclude observations where the exam points variable is zero
learning_dataset_filtered <- filter(learning_dataset_sel, points != 0)

# see outcome
print(learning_dataset_filtered$points)  
# no more 0's

dim(learning_dataset_filtered)
# learning_dataset has 166 rows and 7 columns

### Task 4. ###

# Set the working directory of your R session to the IODS Project folder (study how to do this with RStudio). 
# Save the analysis dataset to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). 
# You can name the learning_dataset set for example as learning2014.csv. See ?write_csv for help or search the web for pointers and examples. 
# Demonstrate that you can also read the learning_dataset again by using read_csv(). (Use `str()` and `head()` to make sure that the structure of the learning_dataset is correct). 


# set wd and save as csv
setwd("/Users/nygrpetr/Desktop/iods/iods_petra/data")
write.csv(learning_dataset_filtered, "learning2014.csv")


# read in the saved data
my_dataset <- read.csv("learning2014.csv")

dim(my_dataset)
#[1] 166   8
head(my_dataset)
#X gender age attitude     deep  surface strategic points
#1 1      F  53       37 3.583333 2.583333     3.375     25
#2 2      M  55       31 2.916667 3.166667     2.750     12
#3 3      F  49       25 3.500000 2.250000     3.625     24
#4 4      M  53       35 3.500000 2.250000     3.125     10
#5 5      M  49       37 3.666667 2.833333     3.625     22
#6 6      F  38       38 4.750000 2.416667     3.625     21
#One additional X column for row ID was automatically added but easy to remove that
my_dataset$X <- NULL
head(my_dataset)
# gender age attitude     deep  surface strategic points
# 1      F  53       37 3.583333 2.583333     3.375     25
# 2      M  55       31 2.916667 3.166667     2.750     12
# 3      F  49       25 3.500000 2.250000     3.625     24
# 4      M  53       35 3.500000 2.250000     3.125     10
# 5      M  49       37 3.666667 2.833333     3.625     22
# 6      F  38       38 4.750000 2.416667     3.625     21
#now its good

