library(tidyverse)

# Import =======================================================================
study_data <- readRDS("data/study_data.rds")

# Check shape of data ==========================================================
hist(study_data$Age) # Slight left skew, but mostly uniform. OK to use mean & SD
hist(study_data$HbA1C_val)
