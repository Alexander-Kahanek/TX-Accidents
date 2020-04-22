## To run, use CTRL+A, then run
##############################
SAVE_DATA = 1 ## 1 = yes, 0 = no, will export data to new csv file
NEW_FILE_NAME = "cleaned-accidents.csv" #Enter the filename you want for the data
##############################
## Enter columns that you want to keep in the df
keep_col <- c("Source", "Severity", "Start_Time",
              "End_Time", "Distance.mi.", "Description", "City",
              "County", "Temperature.F.","Weather_Condition",
              "Crossing", "Give_Way", "Junction", "No_Exit", "Railway",
              "Roundabout", "Station", "Stop", "Sunrise_Sunset",
              "Traffic_Calming", "Traffic_Signal", "Turning_Loop")
##############################
## Example of grabbing a specific date range
#df %>% 
#  subset(Start_Time > parse_date_time("2019-12-31 20:48:01", orders = "ymd HMS"))
##############################

library(dplyr)
library(lubridate)

file <- list.files("raw", full.names = TRUE)

df <- file %>% 
  read.csv()%>% 
  subset(select = keep_col) %>%
  mutate(
    Start_Time = parse_date_time(Start_Time, orders = "ymd HMS"),
    End_Time = parse_date_time(End_Time, orders = "ymd HMS")
  ) %>% 
  subset(!is.na(Severity))


if (SAVE_DATA == 1){
  df %>% 
  write.csv(NEW_FILE_NAME, row.names = FALSE)
}


