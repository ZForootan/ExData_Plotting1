## Read the relevant Data (from 2007-02-01 00:00:00 to 2007-02-02 23:59:00)
# Read the Column names
colnames<-read.table("household_power_consumption.txt",sep = ";",header=F,
                     nrow=1,colClasses = rep("character",9))
# read the relavant data by skipping some rows
power.data<-read.table("household_power_consumption.txt",sep = ";",header =T, 
                       skip=66636,nrow= (69516-66637+1),
                       col.names = as.vector(colnames),
                       colClasses = c("character","character","numeric",
                                      "numeric","numeric","numeric","numeric"
                                      ,"numeric","numeric"),na.strings = "?")      
# change the first two coumns type to Date and Time
power.data<-transform(power.data,Date=as.Date(Date,format="%d/%m/%Y"),
                      Time=strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S"))

## Constructing the plot2

# Open png devicce, create plot1.png with required attributes
png("plot2.png",width = 480, height = 480, units = "px",bg="transparent")

# plot the plot2 with required attributes
with(power.data,plot(Time,Global_active_power,type = "l",lwd=1,xlab="",
                     ylab= "Global Active Power (kilowatts)"))
# close the png device
dev.off()
