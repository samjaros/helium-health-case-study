library(table1)

clean_data <- readRDS("data/clean_data.rds")

# Hospital ---------------------------------------------------------------------
table1(~ Country + Region + Facility_Type + Ownership,
       data = clean_data)

# Patient ----------------------------------------------------------------------
table1(~ Gender + Age + Occupation + Insurance_Status + Visit_Reason + 
         Department + Diagnosis_Description + Length_Of_Stay + 
         Procedure_Description + Medication + BMI + Systolic_BP + Diastolic_BP +
         Temperature_C + FBC_val + UrineTest_val + LipidProfile_val + HbA1C_val +
         MalariaParasite_val + FBC_flag + UrineTest_flag + LipidProfile_flag + 
         HbA1C_flag + MalariaParasite_val,
       data = clean_data)
