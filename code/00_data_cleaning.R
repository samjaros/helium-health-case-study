library(tidyverse)

# Import =======================================================================
raw_data <- read_csv("data/HeliumHealth_EMR_SampleDataset.csv")

# Processing ===================================================================
# Data checks ------------------------------------------------------------------
summary(raw_data)
str(raw_data)

length(unique(raw_data$Patient_ID)) # 1 row/patient
distinct(raw_data, Country, Region) # 3 countries & 3 regions per country

# Data cleaning ----------------------------------------------------------------
# Data already in row-patient form with identifiers
# Columns clearly labelled
# Values in appropriate range

# Flip so lab values are in columns for easier comparison
clean_data <- raw_data %>%
  rename(val = Result_Value, flag = Result_Flag) %>%
  mutate(Lab_Test_Name = str_replace_all(Lab_Test_Name, " ", "")) %>%
  pivot_wider(names_from = Lab_Test_Name,
              values_from = c(val, flag),
              names_glue = "{Lab_Test_Name}_{.value}")

# Study data -------------------------------------------------------------------
# Study only uses antenatal visits to check for associations with postpartum
#   hemorrhage (PPH)
# Eligibility criteria:
#   - At least 1 antenatal visit or OB-GYN visit
#   - Birth record in data set (not available in sample data)
# Exclusion criteria:
#   - Under 18 or over 50
study_data <- clean_data %>%
  filter(Visit_Reason == "Antenatal" | Department == "OB-GYN") %>%
  filter(Age >= 18 & Age <= 50) %>%
  # Since this is simulated data, add a simulated outcome column where likelihood
  #   of PPH is related to age
  mutate(pph_status = if_else(runif(n()) < (Age-18)/(max(Age)-18),
                              "PPH",
                              "No PPH"))

# Export =======================================================================
saveRDS(clean_data, "data/clean_data.rds")
saveRDS(study_data, "data/study_data.rds")

