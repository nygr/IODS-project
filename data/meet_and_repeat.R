#Petra Nygren
# week 6, 11 Dec 2023
library(dplyr)
library(tidyr)

# Read in data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T)

#Explore the data: check names, structure, summaries
names(BPRS)
# [1] "treatment" "subject"   "week0"     "week1"     "week2"     "week3"     "week4"     "week5"     "week6"     "week7"    
#[11] "week8"  
names(RATS)
# [1] "ID"    "Group" "WD1"   "WD8"   "WD15"  "WD22"  "WD29"  "WD36"  "WD43"  "WD44"  "WD50"  "WD57"  "WD64" 
str(BPRS)
#Data frame 40 obs of 11 variables, integer
str(RATS)
#Data frame:	16 obs. of  13 variables, integer
summary(BPRS)
summary(RATS)


# Convert categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Convert data from wide to long format and add week variable for BPRS and time for RATS
BPRS_long <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  mutate(week = as.integer(substr(weeks, 5, 6))) %>% 
  arrange(weeks) 

RATS_long <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "groups",
                      values_to = "wd") %>% 
  mutate(Time = as.integer(substr(groups, 3, 4))) %>%
  arrange(Time)

# Now we repeat the first steps of exploring the structure with the long format data frames
# Check names, structure and summaries
names(BPRS_long)
#[1] "treatment" "subject"   "weeks"     "bprs"      "week"  
names(RATS_long)
#[1] "ID"     "Group"  "groups" "wd"     "Time" 

str(BPRS_long)
#tibble [360 × 5] (S3: tbl_df/tbl/data.frame)
str(RATS_long)
#tibble [176 × 5] (S3: tbl_df/tbl/data.frame)

summary(BPRS_long)
summary(RATS_long)


# Save data
write.csv(BPRS_long, "/Users/nygrpetr/Desktop/iods/iods_petra/data/bprs_long.csv")
write.csv(RATS_long, "/Users/nygrpetr/Desktop/iods/iods_petra/data/rats_long.csv")
