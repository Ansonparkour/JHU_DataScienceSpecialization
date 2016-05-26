#########################
#Getting and Cleaning Data
#Week2 Quiz
#########################

#question1
#homepage URL: http://github.com 
#the callback url: http://localhost:1410  
#API: https://api.github.com/users/jtleek/repos
#useful link: https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

#library 
library(httr)
#Find OAuth settings for github: http://developer.github.com/v3/oauth/
oauth_endpoints("github")

#your key and secret below
myapp <- oauth_app("github", 
                   "beaad6d9a633c7a813fc", 
                   "92ce84b23a15bb9972bed3cad51b023fb08074dc")

#Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

#Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

BROWSE("https://api.github.com/users/jtleek/repos",authenticate("Access Token","x-oauth-basic","basic"))


#question2
library(sqldf)
getwd()
acs <- read.csv("getdata-data-ss06pid.csv", header=T, sep=",")
head(acs)
sqldf("select pwgtp1 from acs where AGEP < 50")


#question3
nrow(sqldf("select distinct AGEP from acs")) == length(unique(acs$AGEP))

#question4 
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
sapply(htmlCode[c(10, 20, 30, 100)], nchar)
       

#question5
#Read fixed width text file
file_name <- "getdata-wksst8110.for"
data <- read.fwf(file=file_name,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
head(data)
sum(data$V4)



