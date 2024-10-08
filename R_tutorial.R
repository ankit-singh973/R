library(tidyverse)

# get current working directory
getwd()

# Load data
var <- read.csv("Data/variants_long_table.csv")
head(var)

# dimension of data
dim(var)

# Display the structure of R object
str(var)

# summary statistics
summary(var)

# summary stats for specific columns
# $ --> specifies individual column name
summary(var$SAMPLE)
summary(var$DP)

# Check the class of data

class(var)

# Check class of an object
class(var$CHROM)

# Preview the data using a spreadsheet-style data viewer
View(var)

# Check columns name
colnames(var)

# select column 1, 4, and 5
var[, c(1, 4, 5)]

select(var, SAMPLE, REF, ALT)

# Select all columns except the column “CALLER” with selected display
select(var, -CALLER) %>% head(3)

# Transform the data frame into a tibble
var_tb <- as_tibble(var)

select(var_tb, SAMPLE, REF, ALT) %>% head(3)

# Select rows with selected display using base R code
var_tb[var_tb$SAMPLE == "SRR13500958",]

# Select rows with selected display using dplyr functions
filter(var_tb, SAMPLE == "SRR13500958") %>% head(3)

# Select sample type (rows) and variables (columns) with selected display
var_tb %>% filter(SAMPLE == "SRR13500958") %>% select(CHROM, POS, REF, ALT) %>% head(3)

# To select only values for which DP>=500 for the same sample
var_tb %>% filter(SAMPLE == "SRR13500958" & DP>=500) %>% select(CHROM, POS, REF, ALT, DP)

# To select only values for which DP>=1000 for the same sample
var_tb %>% filter(SAMPLE == "SRR13500958" & DP>=1000) %>% select(CHROM, POS, REF, ALT, DP)

# Count how many rows associated with eah sample id
var_tb %>% count(SAMPLE, sort = TRUE)

var_tb %>% count(SAMPLE, GENE, sort = TRUE) %>% head()

# Maximum value of column DP
max(var_tb$DP)

# Minimum value of column DP
min(var_tb$DP)

# Mean value of column DP
mean(var_tb$DP)

# Compute a LOG2 transformation on the DP values
var_tb_log <- var_tb %>% mutate(DP_log2 = log2(DP))
head(var_tb_log)

# View a selected content including the new column
select(var_tb_log, SAMPLE, REF, ALT, DP, DP_log2) %>% head()

# Show the maximum value of DP for each sample
var_tb %>% group_by(SAMPLE) %>% summarize(max(DP))

# with min DP
var_tb %>% group_by(SAMPLE) %>% summarize(min(DP))
