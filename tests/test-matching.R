library(testthat)

context("Matching function")

source('R/functions.R')

# Load in data for tests

dataset <- read_csv('Data/deploy_sfr_2016.csv')

characteristics_match <- read_csv("Data/characteristics_match.csv")

# Clean as per server

#Added this in to remove the SUPP measures until we decide what to do with them.
dataset[dataset == 'SUPP'] <- NA
dataset[dataset == "DNS"] <- NA

dataset[11:33] <- lapply(dataset[,11:33], as.numeric)

dataset$ID <- paste(dataset$URN,' - ', dataset$`School Name`, sep = '')

# Run tests

test_that("City of London Primary returns 1 school", {
  
  temp <- fn_match_schools(dataset, 
                           "100000 - Sir John Cass's Foundation Primary School",
                           c("Local Authority"),
                           characteristics_match)
  
  expect_equal(nrow(temp), 1)
  
})


