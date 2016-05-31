getwd()
setwd('~/desktop/assignment/rprog-data-ProgAssignment3-data/')
data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

########################################################
#1.Plot the 30-day mortality rates for heart attack
########################################################
ncol(data)
names(data)
data[, 11] <- as.numeric(data[, 11])
##get a warning about NAs being introduced; that is okay
hist(data[, 11])

########################################################
#2.Finding the best hospital in a state
########################################################
setwd('~/desktop/assignment/rprog-data-ProgAssignment3-data/')
best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state is valid
    if ((state %in% data[,7]) == FALSE){
        stop('invalid state')
    }
    #find which index column represent to 'heart attack', 'heart failure', and 'pneumonia'
    index_column = which(grepl("^(Hospital.30.Day.Death..Mortality..Rates.from.)", names(data), perl = TRUE)==TRUE)
    if (outcome == 'heart attack'){
        index_outcome = index_column[1]
    } else if (outcome == 'heart failure'){
        index_outcome = index_column[2]
    } else if (outcome == 'pneumonia') {
        index_outcome = index_column[3]
    } else {
        stop('invalid outcome')
    }
    
    ## Return hospital name in that state with lowest 30-day death rate
    #get specific state data
    state_data <- data[which((data[,7] == state) == TRUE),]
    #get which row has lowest rate
    index_lowest = which(state_data[,index_outcome] == sort(na.omit(as.numeric(state_data[,index_outcome])))[1])
    #from row index to get rate
    lowest_death_rate = state_data[,index_outcome][index_lowest]
    #from row index to get hospital name
    hospital = sort(state_data[,2][index_lowest])[1]
    
    return(hospital)
}


########################################################
#3.Ranking hospitals by outcome in a state
########################################################
setwd('~/desktop/assignment/rprog-data-ProgAssignment3-data/')
rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    # Check that state is valid
    if ((state %in% data[,7]) == FALSE){
        stop('invalid state')
    }
    #find which index column represent to 'heart attack', 'heart failure', and 'pneumonia'
    index_column = which(grepl("^(Hospital.30.Day.Death..Mortality..Rates.from.)", names(data), perl = TRUE)==TRUE)
    if (outcome == 'heart attack'){
        index_outcome = index_column[1]
        
    } else if (outcome == 'heart failure'){
        index_outcome = index_column[2]
    } else if (outcome == 'pneumonia') {
        index_outcome = index_column[3]
    } else {
        stop('invalid outcome')
    }
    ## Return hospital name in that state with the given rank 30-day death rate
    #get specific state data
    state_data <- data[which((data[,7] == state) == TRUE),]
    #put hospital name and rate together  
    hospital_rank <- data.frame(state_data[,2],as.numeric(state_data[,index_outcome]))
    colnames(hospital_rank) <- c("Hospital","Rate")
    #get out of NAs and sort
    hospital_rank <- na.omit(hospital_rank)
    #sort the table in order of rate first and then in order of hospital name alphabetically
    hospital_rank <- hospital_rank[order(hospital_rank$Rate, hospital_rank$Hospital),]
    #give the rank to each hospital 
    hospital_rank <- data.frame(hospital_rank,c(1:nrow(hospital_rank)))
    
    if (num == 'best'){
        return(head(hospital_rank, n = 1))
    } else if (num == 'worst'){
        return(tail(hospital_rank,n = 1))
    } else if (num <= nrow(hospital_rank)){
        return(hospital_rank[num,])
    } else {
        return('NA')
    }
    
}


########################################################
#4.Ranking hospitals in all states
########################################################
setwd('~/desktop/assignment/rprog-data-ProgAssignment3-data/')
rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Return a data frame with the hospital names and the (abbreviated) state name
    ## For each state, find the hospital of the given rank
    #find all distinct state
    all_state <- sort(unique(data$State))
    len <- length(all_state)
    all_hospital = data.frame()
    #get all state data 
    for (i in 1:len){
        state <- all_state[i]
        all_hospital = rbind(all_hospital, state_hospitalrank(outcome, state, num))
    }
    return(all_hospital)
}

state_hospitalrank <- function(outcome, state, num){
    
    #find which index column represent to 'heart attack', 'heart failure', and 'pneumonia'
    index_column = which(grepl("^(Hospital.30.Day.Death..Mortality..Rates.from.)", names(data), perl = TRUE)==TRUE)
    if (outcome == 'heart attack'){
        index_outcome = index_column[1]
    } else if (outcome == 'heart failure'){
        index_outcome = index_column[2]
    } else if (outcome == 'pneumonia') {
        index_outcome = index_column[3]
    } else {
        stop('invalid outcome')
    }
    #find the hospital of the given rank for a specific state 
    state_data <- data[data[, 7]== state, ]
    hospital_rank <- data.frame(state_data[,2],as.numeric(state_data[,index_outcome]),state_data[,7])
    colnames(hospital_rank) <- c("Hospital","Rate","State")
    hospital_rank <- na.omit(hospital_rank)
    hospital_rank <- hospital_rank[order(hospital_rank$Rate,hospital_rank$Hospital),]
    result <- data.frame(hospital_rank$Hospital, hospital_rank$State)
    colnames(result) <- c("Hospital","State")
    if (num == 'best'){
        return(head(result, n = 1))
    } else if (num == 'worst'){
        return(tail(result,n = 1))
    } else if (num <= nrow(result)){
        return(result[num,])
    } else {
        return('NA')
    }
}



























