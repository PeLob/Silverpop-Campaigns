#' Sample skeleton for custom science - Main application function
#'
#' @import keboola.r.docker.application
#' @export
#' @param datadir Path to data directory.
doSomething <- function(datadir) {
 # read input
# Get the file from FTP

	# do something
	app <- DockerApplication$new(datadir)
	app$readConfig()
	
	UserName <- app$getParameters()$UserName
	PassWord <- app$getParameters()$PassWord
	
	url <- "sftp://transfer6.silverpop.com/download/"
	userpwd <- paste0(UserName,":",PassWord)
	
	last_file_df <- read.csv("in/tables/last_file.csv")
	last_file <- last_file_df[1,1]
	#last_file<-"Zindulka_CRMi_SalesForce - All - Mar 20 2017 04-03-34 PM.CSV"
	
	library(RCurl)
	data_01<-getURL(paste(url,last_file,sep=""), userpwd = userpwd)
	data <- read.csv(textConnection(data_01))
	
	write.csv(data, file = file.path(datadir, "out/tables/CRMi.csv"), row.names = FALSE)
	
}
