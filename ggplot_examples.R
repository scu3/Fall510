require(scales)
require(ggplot2)
require(grid)
require(MASS)

data(diamonds)
data(mtcars)

dia <- ggplot(diamonds, aes(x=carat))
dia <- dia + geom_histogram(binwidth=0.5, fill="steelblue")
print(dia)

sleep <- ggplot(msleep, aes(x=sleep_rem/sleep_total, y=awake)) +
  geom_point() + geom_smooth()
print(sleep)

summary(mtcars)
cars <- ggplot(mtcars, aes(mpg, wt, colour=cyl)) +
  geom_point()
print(cars)

mtcars <- transform(mtcars, mpg= mpg) # looking at the square?
cars %+% mtcars # %+% asks gg to replot new data

cars <- ggplot(mtcars, aes(mpg, wt, colour=cyl)) +
  geom_point(size=3) + 
  scale_colour_gradient2(low="red", mid="gray", high="blue", midpoint=6) #4,6,8 cylinders so he picked 6 as the midpoint

print(cars)

###############################################
# Histograms from a stock valuation simulation#
###############################################
MNPV <- mean(TotalNPV[,1])
MNPVLabel = paste("$",format(round(MNPV, digits=0), 
                             big.mark=",", 
                             big.interval=3))

hist_TotalNPV <- ggplot(TotalNPV, aes(x=TotalNPV[,1]))
hist_TotalNPV <- hist_TotalNPV + 
  geom_histogram(colour = 'blue',
                 fill = 'blue',
                 binwidth=50000) +
  labs(x="TotalNPV", y=NULL) +
  # scale_x_continuous(labels = "dollar") +
  geom_vline(xintercept=MNPV, colour='red') +
  annotate("text",x=MNPV,y=10,label=MNPVLabel,hjust=0, colour='white')
print(hist_TotalNPV)

MRatio <- mean(Ratio[,1])
MRLabel = sprintf("%3.2f ", MRatio)
hist_Ratio <- ggplot(Ratio, aes(x=Ratio[,1]))
hist_Ratio <- hist_Ratio + 
  geom_histogram(colour = 'gray',
                 fill = 'gray',
                 binwidth=.005
  ) +
  labs(x="Ratio", y=NULL) +
  geom_vline(xintercept=MRatio, colour='red') +
  annotate("text",x=MRatio,y=10,label=MRLabel,hjust=0) 
print(hist_Ratio)

hist_Year <- ggplot(Year, aes(x=Year[,1]))
hist_Year <- hist_Year + 
  geom_histogram(colour = 'black',
                 fill = 'black',
                 binwidth =.05
  ) +
  labs(x="Year", y=NULL) 
print(hist_Year)

MML <- mean(MaxLoss[,1])
MMLLabel = paste("$",format(round(MML, digits=0), 
                            big.mark=",", 
                            big.interval=3))

hist_MaxLoss <- ggplot(MaxLoss, aes(x=MaxLoss[,1]))
hist_MaxLoss <- hist_MaxLoss + 
  geom_histogram(colour = 'red',
                 fill = 'red',
                 binwidth=2000
  ) +
  labs(x="MaxLoss", y=NULL) + 
  # scale_x_continuous(labels = dollar) +
  geom_vline(xintercept=MML, colour='black') +
  annotate("text",x=MML,y=10,label=MMLLabel,hjust=0)
print(hist_MaxLoss)

MSP <- mean(SharePrice[,1])
MSPLabel = sprintf("$%3.2f ", MSP)
hist_SharePrice <- ggplot(SharePrice, aes(x=SharePrice[,1]))
hist_SharePrice <- hist_SharePrice + 
  geom_histogram(colour = 'green',
                 fill = 'green',
                 binwidth=2.0
  ) +
  labs(x="SharePrice", y=NULL) +
  # scale_x_continuous(labels = dollar) +
  geom_vline(xintercept=MSP, colour='red') +
  annotate("text",x=MSP,y=10,label=MSPLabel,hjust=0)
print(hist_SharePrice)

###############################################
# Some education data                         #
###############################################
data(Boston, package="MASS") 
pairs(Boston[,c(1,2:7)])

crim_range_v <- range(Boston$crim)
crim_range <- crim_range_v[2] - crim_range_v[1]

crim_Hist <- ggplot(Boston, aes(x=Boston$crim)) +
  geom_histogram(colour = 'blue',
                 fill = 'blue',
                 binwidth = crim_range/50)
print(crim_Hist)

BostonLow <- Boston[which(Boston$crim <= 1),]
crim_Hist_low <- ggplot(BostonLow, aes(x=BostonLow$crim)) +
  geom_histogram(colour = 'blue',
                 fill = 'blue')
print(crim_Hist_low)

###############################################
# Combining some plots                        #
###############################################
depth_dist <- ggplot(diamonds, aes(depth)) + xlim(58, 68)
# Use facets to plot histograms of each distribution of cut
depth_dist + geom_histogram( 
  binwidth = 0.2) + facet_grid(cut ~ .)

# Represent the same as density plots
depth_dist + geom_histogram(aes(y = ..density..), 
                            binwidth = 0.1) + facet_grid(cut ~ .)
# A different view of a density plot
depth_dist + geom_histogram(aes(fill=cut), binwidth = 0.1,
                            position = "fill")
# Yet another view of the same data
depth_dist + geom_freqpoly(aes(y = ..density.., color = cut, 
                               binwidth = 0.1))

# Plot relationship of carat on price by color
carat_prc <- ggplot(diamonds, aes(x=carat,y=price))
carat_prc + labs(title="Diamonds - Weight to Price by Color") +
  theme(plot.title = element_text(size = rel(2), colour = "blue")) +
  labs(x="Weight", y="Price") + 
  geom_point(aes(color = factor(color)))

# Remove the non-linearity of the relationship
diamonds$logprice <- log(diamonds$price)
diamonds$logcarat <- log(diamonds$carat)
lcarat_prc <- ggplot(diamonds, aes(x=logcarat,y=logprice))
lcarat_prc + labs(title="Diamonds - Weight to Price (Linear)") +
  theme(plot.title = element_text(size = rel(2), colour = "blue")) +
  labs(x="log Weight", y="log Price") + 
  geom_point(aes(color = factor(color)))

# Remove the trend by plotting the residuals
detrend <- lm(logprice ~ logcarat, data=diamonds)
diamonds$presids <- resid(detrend)
dtcarat_prc <- ggplot(diamonds, aes(x=logcarat,y=presids))
dtcarat_prc <- dtcarat_prc + 
  labs(title="Diamonds - Weight to Price by Color") +
  theme(plot.title = element_text(size = rel(2), colour = "blue")) +
  labs(x="Weight", y="Price Residuals") +
  geom_point(aes(color = factor(color))) +
  theme(legend.position="top")
print(dtcarat_prc)

# Create a density histogram of the price
# factor(color)
hist_price <- ggplot(diamonds, aes(x=price))
hist_price <- hist_price + geom_histogram(
  aes(colour=factor(color), y=..density..), 
  binwidth = 100,
  position = "stack") + theme_gray(9) + 
  labs(x=NULL, y=NULL) +
  theme(plot.margin = unit(rep(0,4), "lines")) +
  theme(legend.position = "none")

# Create a density histogram of the weight (carat)
hist_carat <- ggplot(diamonds, aes(x=carat))
hist_carat <- hist_carat + geom_histogram(
  aes(colour=factor(color), y=..density..), 
  binwidth = 0.05,
  position = "stack") + theme_gray(9) + 
  labs(x=NULL, y=NULL) +
  theme(plot.margin = unit(rep(0,4), "lines")) +
  theme(legend.position = "none")

# Use grid viewports to create a plot with overlaid subplots
subvp1 <- viewport(width=0.4, height=0.2, 
                   x=0.2775, y=0.20)
subvp2 <- viewport(width=0.4, height=0.2,
                   x=0.775, y=0.675)
dtcarat_prc
print(hist_price, vp=subvp1)
print(hist_carat, vp=subvp2)

# Use grid layout to create a scatterhist plot similar
# to MatLab
grid.newpage()
pushViewport(viewport(layout=grid.layout(10,10)))
vplayout <- function(x,y,a) 
  viewport(layout.pos.row = x,
           layout.pos.col = y,
           angle = a)
vp3=vplayout(1:8,3:10,0)
vp4=vplayout(7:8,3:7,90)
vp5=vplayout(9:10,4:9,0)
print(dtcarat_prc, vp=vp3)
print(hist_price, vp=vp4)
print(hist_carat, vp=vp5)

# ggplot oxboys data
require(nlme, quiet = TRUE, warn.conflicts = FALSE)
data(Oxboys)
# Leave out the grouping variable
p4 <- ggplot(Oxboys, aes(age, height))
p4 + geom_line()
# Now properly group
p4 <- ggplot(Oxboys, aes(age, height, group = Subject))
p4 + geom_line()
p4 + geom_smooth(aes(group = Subject), method = "lm", se = F)

# Added a smooth line for each subject, wanted a smooth line
# for the entire data
p4 <- ggplot(Oxboys, aes(age, height, group = Subject))
p4 <- p4 + geom_line()
p4 + geom_smooth(aes(group = 1), method = "lm", size = 2, se = F)

#Let's look at box plots
p5 <- ggplot(Oxboys, aes(Occasion, height))
p5 <- p5 + geom_boxplot()
print(p5)
p5 <- p5 + geom_line(aes(group = Subject), color="red")
print(p5)

# Plotting different data sets on different layers
# In the plots above, fitted lines for individuals doesn't
# use information about typical growth patterns and group
# fit ignores with-in subject correlation.
# We can try a mixed model using the nlme package
model <- lme(height ~ age, data = Oxboys, 
             random = ~ 1 + age | Subject)
str(model)
# Create base spaghetti plot
p6 <- ggplot(Oxboys, aes(age, height, group = Subject))
p6 <- p6 + geom_line()
print(p6)

# Get the predictions into a new data set
age_grid <- seq(-1, 1, length = 10)
subjects <- unique(Oxboys$Subject)
preds <- expand.grid(age = age_grid, Subject = subjects)
preds$height <- predict(model, preds)

# Add the prediction layer from the new data set on
# a new layer
p6 <- p6 + geom_line(data = preds, color = "blue", 
                     size = 0.4)
print(p6)

# Now lets look at the residuals
# Add predictions to the original data
Oxboys$fitted <- predict(model)
# Now calculate the residuals
Oxboys$resid <- with(Oxboys, fitted - height)
str(Oxboys)

# Now create the residuals plot
p7 <- ggplot(Oxboys, aes(age, resid, group = Subject))
p7 + geom_line() + geom_smooth(aes(group=1))

# Looks like the residuals are not random indicating some
# signal that hasn't been captured in the model.
model2 <- update(model, height ~ age + I(age^2))
Oxboys$fitted2 <- predict(model2)
Oxboys$resid2 <- with(Oxboys, fitted2 - height)

# Now "refresh" the data in the base plot and re-plot
p7 %+% Oxboys + aes(y=resid2) + geom_line() + geom_smooth(aes(group=1))






for (i in seq_along(names(testDF)){
  print(testDF[i])
}

b<-paste(names(testDF[1]),names(testDF[2]),sep="-")

for (i in seq_len(nrow(x))){
  for (j in seq_len(ncol(x))){
    print(x[i,j])
  }
}

for (i in names(x)){
  d<-c(paste(names(x[i]),names(x[i]),sep="-"))
}


