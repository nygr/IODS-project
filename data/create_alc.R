#Petra Nygren
#Week 3 exercise R script
#13 November 2023
#This is an R script for analysis and data processing of the "student" dataset

library(dplyr)

#Read in data
mat <-read.table("data/student+performance/student/student-mat.csv",sep=";",header=TRUE)
por <-read.table("data/student+performance/student/student-por.csv",sep=";",header=TRUE)

# Explore the structure and dimensions of the data
str(mat)
#Dataframe 395 obs. of  33 variables containing observations in the forms of "character" and "integer"
dim(mat)
#[1] 395  33

str(por)
#Dataframe 649 obs. of  33 variables: containing observations in the forms of "character" and "integer"
dim(por)
#[1] 649  33

#Merge data
# Get the list of columns to join on
cols_to_join_on <- setdiff(colnames(mat), c("G1", "G2", "G3", "failures", "absences", "paid"))

# Merge the datasets
merged_data <- inner_join(mat, por, by = cols_to_join_on)

#Merge data
merged_data <- na.omit(merged_data)

# Remove duplicate records
merged_data <- merged_data %>% distinct()

#Add average alcohol use column 
merged_data$alc_use <- rowMeans(merged_data[, c("Dalc", "Walc")], na.rm = TRUE)

#Create logical column; TRUE for alc_use >2
merged_data$high_use <- merged_data$alc_use > 2

print(nrow(merged_data)) 
# 370

#Save data to R data folder
setwd("data/")
write.csv(merged_data, "alc_data.csv")


