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

## Constructing the plot4

# Open png devicce, create plot1.png with required attributes
png("plot4.png",width = 480, height = 480, units = "px",bg="transparent")
# make 2x2 position matrix
par(mfcol=c(2,2))

# plot the 1st plot with required attributes
with(power.data,plot(Time,Global_active_power,type = "l",xlab="",
                      ylab= "Global Active Power"))

# plot the 2nd plot with required attributes
with(power.data,{plot(Time,Sub_metering_1,type = "l", xlab="",ylab = "Energy sub metering") 
        lines(Time,Sub_metering_2,col="red") 
        lines(Time,Sub_metering_3,col="blue")})
legend("topright",lwd=1,bty="n",col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# plot the 3rd plot with required attributes
with(power.data,plot(Time,Voltage,xlab = "datetime",type = "l"))

# plot the 4th plot with required attributes
with(power.data,plot(Time,Global_reactive_power,type = "l",xlab="datetime"))

# close the png device
dev.off()
