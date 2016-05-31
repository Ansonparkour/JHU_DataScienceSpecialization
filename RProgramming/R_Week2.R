setwd("~/Desktop/")

######################
#R Programming 
#Week_2 Assignment 
#Part_1
######################
pollutantmean <- function(directory, pollutant, id){
    
    #set up each files directory
    csv_path <- paste('./', directory, '/', sep="")
    files_name <- as.character( list.files(csv_path) )
    files_directory <- paste(csv_path, files_name, sep="")
    
    
    #read each file
    num_not_na = 0 
    summation = 0
    for (i in id){
        each_file <- read.csv(files_directory[i], header=T, sep=",")
        summation = summation + sum(each_file[,pollutant], na.rm = TRUE)
        num_not_na = num_not_na + sum(!is.na(each_file[,pollutant])==TRUE)
    }
    
    #get mean
    result <- round(summation/num_not_na,3)
    
    return (result)
}

# tests
pollutantmean("specdata", "sulfate", 1:10) == 4.064


######################
#R Programming 
#Week_2 Assignment 
#Part_2
######################
complete <- function(directory, id = 1:332){
    
    #set up each files directory
    csv_path <- paste('./', directory, '/', sep="")
    files_name <- as.character( list.files(csv_path) )
    files_directory <- paste(csv_path, files_name, sep="")
    
    #read each file and find completed case 
    completed_case <- rep(0,length(id))
    j = 1
    for (i in id){
        each_file <- read.csv(files_directory[i], header=T, sep=",")
        completed_case[j] = sum(!is.na(each_file[,'Date'])==TRUE 
                                & !is.na(each_file[,'sulfate'])==TRUE 
                                & !is.na(each_file[,'nitrate'])==TRUE)
        j = j + 1 
        
        #the alterntive way is using function: completed.cases
        #completed_case_new <- sum(complete.cases(each_file))
        
        result <- data.frame(id = id, nobs = completed_case)
    }
    
    
    return( result)
}

#test
complete("specdata", 1:2)



######################
#R Programming 
#Week_2 Assignment 
#Part_make_up: correlation for all the !NA(complete) data
######################

corr <- function(directory, threshold){
    #set up each files directory
    csv_path <- paste('./', directory, '/', sep="")
    files_name <- as.character( list.files(csv_path) )
    files_directory <- paste(csv_path, files_name, sep="")
    
    
    #find completed case over threshold
    completed_case_table <- complete("specdata", id = 1:332)
    nobs = completed_case_table$nobs
    id_over_threshold <- completed_case_table$id[nobs>threshold]
    
    #calculate correlation
    correlation <- 0
    all_correlation <- c()
    for (i in id_over_threshold){
        each_file <- read.csv(files_directory[i], header=T, sep=",")
        correlation <- cor(each_file$sulfate, each_file$nitrate, use="complete.obs")
        all_correlation <- c(all_correlation, correlation)
    }
    
    return (round(all_correlation,5))
}

#test
head(corr("specdata", 150)) == c(-0.01896, -0.14051, -0.04390, -0.06816, -0.12351, -0.07589)




##########################################################
#R Programming 
#Week_2 Assignment 
#Part_make_up: correlation for all the !NA(complete) data
##########################################################

corr <- function(directory, threshold){
    #set up each files directory
    csv_path <- paste('./', directory, '/', sep="")
    files_name <- as.character( list.files(csv_path) )
    files_directory <- paste(csv_path, files_name, sep="")
    
    
    all_completed_sulfate <- c()
    all_completed_nitrate <- c()
    for (i in 1:332){
        each_file <- read.csv(files_directory[i], header=T, sep=",")
        if (sum(complete.cases(each_file)) > threshold){
            vector_sulfate <- each_file[which(complete.cases(each_file)),]$sulfate
            vector_nitrate <- each_file[which(complete.cases(each_file)),]$nitrate
        }
        
        #using c(x,y) as append function in python 
        all_completed_sulfate = c(all_completed_sulfate, vector_sulfate)
        all_completed_nitrate = c(all_completed_nitrate, vector_nitrate)
    }
    
    all_completed <- data.frame(sulfate = all_completed_sulfate, nitrate = all_completed_nitrate)
    
    #calculate correlation
    correlation <- cor(all_completed$sulfate, all_completed$nitrate)
    return (correlation)
}

#test
corr("specdata", 0)

