df <- mtcars


df$even_gear <- (1 - df$gear%%2)
print(df$even_gear)


print(df$mpg[df$cyl == 4])


print(df[c(3,7,10,12, nrow(df)),])

nrow(df)

df$carb>=4 | df$cyl > 6

new_var <- (df$carb>=4 | df$cyl > 6)*1

print(new_var)

my_vector = c(1:50)

if(mean(my_vector)>20){
  print('My mean is great')
} else{
    print('My mean is not so great')
}





str(AirPassengers) 

lag(AirPassengers,-1)

print (lag(AirPassengers[AirPassengers > lag(AirPassengers, -1)], -1))

print(AirPassengers)




for(i in 2:length(AirPassengers)){
  if(AirPassengers[i] > AirPassengers[i-1]){
    print (AirPassengers[i])
  }
}

AirPassengers[144]

for(i in 10:length(AirPassengers)){
  print(mean(AirPassengers[(i-9):i]))
}


i = 10

print(mean(AirPassengers[i-9:i]))





print(mean(df$qsec[df$cyl!= 1 & df$mpg > 20]))






aggregate(cbind(hp, disp) ~ am, df, sd)


library(psych)


library(ggplot2)

head(df)




descr <- describe(df[,-c(8,9)])




df <- airquality


dfnew <- subset(df, df$Month %in% c(7,8,9))

aggregate(Ozone ~ Month, dfnew, length)


describeBy(airquality, airquality$Month)

head(airquality)





describeBy(iris)


describeBy(iris, iris$Species)


my_vector <- c(1,2,3,4,5,NA,6, 7,NA, 8, 9)

my_vector[is.na(my_vector)] <- mean(my_vector[!is.na(my_vector)])

print(my_vector)




hist(df$mpg, breaks = 20, xlab = 'MPG')


df <- mtcars

head(df)



boxplot(mpg ~ am, df)


plot(df$mpg, df$hp)




ggplot(df, aes(x = mpg))+geom_histogram()


ggplot(iris, aes(Sepal.Length)) + geom_histogram(fill = Species)



ggplot(iris, aes(Sepal.Length)) + geom_histogram(aes(col = Species))


ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_histogram()


ggplot(iris, aes(Sepal.Length)) + geom_histogram(aes(fill = Species))


ggplot(iris, aes(Sepal.Length, col = Species)) + geom_histogram()



ggplot(aes(Sepal.Length, Sepal.Width, col = Species)) +  
  geom_point(iris, size = Petal.Length)



getwd()


boxplot(airquality$Ozone ~ airquality$Month)



ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species, size = iris$Petal.Length)) +  
  geom_dotplot()




plot1 <- ggplot(mtcars, aes(mtcars$mpg, mtcars$disp, col = mtcars$hp))+
  geom_point()

dimnames(HairEyeColor)

print(sum(HairEyeColor[ , 'Green','Female']))

hc <- HairEyeColor[ , ,'Female']

library("ggplot2")
mydata <- as.data.frame(HairEyeColor)
obj <- ggplot(data = subset(mydata, Sex == "Female"), aes(x = Hair, y = Freq, fill = Eye)) + 
  geom_bar(stat="identity", position = "dodge") + 
  scale_fill_manual(values=c("Brown", "Blue", "Darkgrey", "Darkgreen"))


mydata
obj




mydata <- as.data.frame(HairEyeColor)
dt <- subset(subset(mydata, Sex == "Female"), Hair == "Brown")

chisq.test(dt$Freq)

dt

head(diamonds)

tbl = table(diamonds$cut, diamonds$color)


pp <- chisq.test(tbl)

print(pp$statistic)


diamonds$factor_carat <- ifelse(diamonds$carat > mean(diamonds$carat), 1, 0)
diamonds$factor_price <- ifelse(diamonds$price > mean(diamonds$price), 1, 0)

tabb <- table(diamonds$factor_price, diamonds$factor_carat)
chi <- chisq.test(tabb)
print(chi$statistic)




fsh <- fisher.test(mtcars$am, mtcars$vs)
print(fsh$p.value)



str(iris)

df1 <- subset(iris, Species != "setosa")
str(df1)


table(df1$Species)
hist(df1$Sepal.Length)


head(ToothGrowth)

len1 <- subset(ToothGrowth, supp == "OJ" & dose == 0.5)

len2 <- subset(ToothGrowth, supp == "VC" & dose == 2)

ttt <- t.test(len1$len, len2$len)

print(ttt$statistic)

tblo <- read.csv("C:\\1\\r\\lekarstva.csv")

head(tblo)

t.test(tblo$Pressure_before, tblo$Pressure_after, paired = T)


str(tblo)



tbll <- read.table("C:\\Users\\User\\Downloads\\dataset_11504_15 (7).txt")
head(tbll)
bartlett.test(tbll$V1, tbll$V2)
t.test(tbll$V1, tbll$V2, var.equal = TRUE)
t.test(tbll$V1~tbll$V2, var.equal = TRUE)
wilcox.test(tbll$V1 ~ tbll$V2)






tblas <- read.table("C:\\Users\\User\\Downloads\\dataset_11504_16 (1).txt")
head(tblas)
t.test(tblas$V1,tblas$V2, var.equal = FALSE)
m




head(npk)
kk <- aov(yield~N+P+K, data = npk)

summary(kk)



bzbz<-aov(Sepal.Width~Species, data = iris)
summary(bzbz)
TukeyHSD(bzbz)




pil<- read.csv("C:\\Users\\User\\Downloads\\Pillulkin.csv")

head(pil)

pil$patient <- as.factor(pil$patient)

qwe<-aov(temperature ~ pill + Error(patient/(pill)), data = pil)
summary(qwe)


kiuu<- aov(temperature ~ doctor*pill + Error(patient/(pill*doctor)), data = pil)
summary(kiuu)






library(ggplot2)
obj <- ggplot(ToothGrowth, aes(x = as.factor(dose), y = len, col = supp, group = supp))+
  stat_summary(fun.data = mean_cl_boot, geom = 'errorbar', width = 0.1, position = position_dodge(0.2))+
  stat_summary(fun.data = mean_cl_boot, geom = 'point', size = 3, position = position_dodge(0.2))+
  stat_summary(fun.data = mean_cl_boot, geom = 'line', size = 1.5, position = position_dodge(0.2))+
  theme_bw()


obj

head(ToothGrowth)

install.packages("Hmisc")





NA.position <- function(x){
  # put your code here  
  l = length(x)
  cc <- 1:l
  pp <- cc[is.na(x)]
  return (pp)
}

my_vector <- c(1, 2, 3, NA, NA)
NA.position(my_vector)


l = length(x)
cc <- 1:l
cc[is.na(x)]
x


NA.counter <- function(x){
  # put your code here  
  l = length(x[is.na(x)])
  return(l)
}

my_vector <- c(1, 2, 3, NA, NA)
NA.counter(my_vector)


dir()



filtered.sum <- function(x){
  zz <- x[!is.na(x)]
  cc <- zz[zz>0]
  s = sum(cc)
  return (s)
}

my_vector <- c(-1, 2, 3, NA, NA)
filtered.sum(my_vector)





outliers.rm <- function(x){
  quan <- quantile(x, probs = c(0.25, 0.75))
  ii <- IQR(x)
  newx <- x[(x>quan[1] - 1.5*ii) & (x < quan[2] + 1.5*ii)]
  return (newx)
}

outliers.rm(cc)

library(psych)

k <- mtcars[, c(1,5)]
k[2]

corr.test(k[1], k[2])
pp <- corr.test(k[1], k[2])

pp$p


corr.calc <- function(x){
  # put your code here  
  cor <- corr.test(x[1], x[2])
  return (c(cor$r, cor$p))
  
}

corr.calc( mtcars[, c(1,5)] )

corr.calc( iris[,1:2] )

cor.test(k[1], k[2])

zz <- corr.test(mtcars)


gg <- str(iris[1])

gg

gg <- sapply(iris, class)

iris[gg == "numeric"]

filtered.cor <- function(x){
  xclass <- sapply(x, class)
  xnumeric <- x[xclass == "numeric"]
  xtest <- corr.test(xnumeric)
  xcor <- xtest$r
  xc <- c(xcor)
  xc <- xc[xc!=1]
  maxabs <- max(abs(xc))
  xfitered <- xc[abs(xc)==maxabs]
  return (xfitered[1])
  
}

xx<-filtered.cor(iris)

xx
iris$Petal.Length <- -iris$Petal.Length # сделаем отрицательной максимальную по модулю коррел€цию
 filtered.cor(iris)


vec1 <- c(1,2,3)
vec2 <- c(3,4,5)

sht1 <- shapiro.test(vec1)
sht2 <- shapiro.test(vec2)



if(sht1$p.value < 0.05 | sht2$p.value < 0.05){
  print(cor(vec1, vec2, method = "spearman"))
} else{
  print(cor(vec1, vec2, method = "pearson"))
}


qq <- lm(mtcars$mpg ~ mtcars$cyl)
qq


dta <- read.table("C:\\Users\\User\\Downloads\\dataset_11508_12.txt")

head(dta)

lm(V1~V2, data = dta)


library(ggplot2)


bril <- subset(diamonds, cut == "Ideal" & carat == 0.46)

reg <- lm(price~depth, bril)
print(reg$coefficients)

x = iris[,1:2]
x[[1]]
cort <- cor.test(x[[1]], x[[2]])
cort$p.value
fit <- lm(x[[1]]~ x[[2]])
fit$fitted.values
dframe <- rbind(iris[,1:2]  fit$fitted.values)
dframe


regr.calc <- function(x){
  # put your code here  
  cort <- cor.test(x[[1]], x[[2]], method = "pearson")
  if(cort$p.value < 0.05){
    fit <- lm(x[[1]] ~ x[[2]])
    x$fit <- fit$fitted.values
    return(x)
  } else{
    print( "There is no sense in prediction")
  }
}

regr.calc(iris[,1:2])

my_df = iris[,c(1,4)]
regr.calc(my_df)





scplot <- ggplot(iris, aes(x = Sepal.Width, y = Petal.Width, col = Species))+
  geom_point()+
  geom_smooth()

scplot



x1 <- rnorm(50) # создадим случайную выборку из 50 элементов
x2 <- rnorm(50) # создадим случайную выборку из 50 элементов
y <- rnorm(50) # создадим случайную выборку из 50 элементов
na_index <- sample(1:30, runif(1,5,15)) # случайно сгенерируем количество и позиции NA в векторе y
y[na_index] <- NA # создадим NA в векторе y
my_df <- data.frame(x_1 = x1, x_2 = x2, y = y) # создадим dataframe 

ftt <- lm(y ~ x1 + x2, data = my_df)
pred <- predict(ftt, newdata = my_df)
my_df$y_full <- my_df$y
my_df$y_full[is.na(my_df$y_full)] <- pred[is.na(my_df$y)] 

my_df

head(mtcars)

df <- mtcars

mpg + disp - 0.8242
mpg + drat - 0.7652
mpg + hp- 0.7364
disp + drat -  0.7883
disp + hp - 0.7793
drat + hp - 0.6275
mpg + disp + drat - 0.8236
mpg + drat + hp - 0.7568 
mpg + disp + hp - 0.8428
disp + drat + hp - 0.7828

model <- lm(wt~ mpg + disp + hp, data = df )

summary(pppp)

fff <- lm(rating ~ complaints*critical, attitude)
summary(fff)



mtcars$am <- factor(mtcars$am, labels = c('Automatic', 'Manual'))
pysh <-lm(mpg ~ wt*am, data = mtcars)
summary(pysh)



my_plot <- ggplot(mtcars, aes(x = wt, y = mpg, col = am))+
  geom_smooth(method = "lm")
    

my_plot


model_full <- lm(rating ~ ., data = attitude) 

model_null <- lm(rating ~ 1, data = attitude)

scope = list(lower = model_null, upper = model_full)

ideal_model <- step(model_full, direction = "backward")

anova(model_full, ideal_model)


?lm

model <- lm(sr~(pop15 + pop75 + dpi + ddpi)^2, data =LifeCycleSavings )

head(LifeCycleSavings)


my_vector <- c(0.027, 0.079, 0.307, 0.098, 0.021, 0.091, 0.322, 0.211, 0.069, 0.261, 0.241, 0.166, 0.283, 0.041, 0.369, 0.167, 0.001, 0.053, 0.262, 0.033, 0.457, 0.166, 0.344, 0.139, 0.162, 0.152, 0.107, 0.255, 0.037, 0.005, 0.042, 0.220, 0.283, 0.050, 0.194, 0.018, 0.291, 0.037, 0.085, 0.004, 0.265, 0.218, 0.071, 0.213, 0.232, 0.024, 0.049, 0.431, 0.061, 0.523)

nrm <- shapiro.test(log(my_vector))



rrr <- mtcars[,c(1,3)]

sss<-scale(mtcars[,c(1,3)])
sss[,2]

ll <- lm(sss[,1]~sss[,2])
ll$coefficients


beta.coef <- function(x){
  sc <- scale(x)
  ll <- lm(sc[,1]~sc[,2])
  return(ll$coefficients)
  
}

beta.coef(mtcars[,c(1,3)])
beta.coef(swiss[,c(1,4)])


x <- mtcars[,1:6]

pvalues <- 1:length(x)
for(i in 1:length(x)){
  sht <- shapiro.test(x[,i])
  pv <- sht$p.value
  pvalues[i] <- pv
}
names(pvalues) <- names(x)cr[cr == mx]

shapiro.test(pp[,1])

normality.test  <- function(x){
  pvalues <- 1:length(x)
  for(i in 1:length(x)){
    sht <- shapiro.test(x[,i])
    pv <- sht$p.value
    pvalues[i] <- pv
  }
  names(pvalues) <- names(x)
  return(pvalues)
}


normality.test(mtcars[,1:6])
normality.test(iris[,-5])


library(gvlma)

hmsc <- read.csv("C:\\1\\r\\homosc.csv")

ggvv <- gvlma(DV~IV, data = hmsc)

summary(ggvv)

fit <- lm(mpg ~ disp, mtcars)

df$count <- data.frame(fit$fitted.values)
df$fit.residuals <- data.frame(fit$residuals)

ggplot(df, aes(x = fit$residuals))+
  geom_histogram(fill="green")

sht <- shapiro.test(fit$residuals)

resid.norm <- function(fit){
  # put your code here  
  sht <- shapiro.test(fit$residuals)
  
  df <- data.frame(fit$residuals)
  
  if(sht$p.value < 0.05){
    gp <- ggplot(df, aes(x = fit$residuals))+
      geom_histogram(fill="red")
    return (gp)
  }else{
    gp <- ggplot(df, aes(x = fit$residuals))+
      geom_histogram(fill="green")
    return (gp)    
  }  
}

fit <- lm(mpg ~ disp, mtcars)
my_plot <- resid.norm(fit)
my_plot

fit <- lm(mpg ~ wt, mtcars)
my_plot <- resid.norm(fit)
my_plot




cr <- cor(iris[,-5])
diag(cr) <- NA
mx <- max(abs(cr[!is.na(cr)]))
num <- min(which(abs(cr) == mx))
l <- nrow(cr)
cl <- num%%l
if(cl == 0) {cl <- l}
rw <- floor(num/l) + 1
colnms <- colnames(cr)
rownms <- rownames(cr)
names <- c(rownms[rw], colnms[cl])

high.corr <- function(x){
  # put your code here  
  
  cr <- cor(x)
  diag(cr) <- NA
  mx <- max(abs(cr[!is.na(cr)]))
  num <- min(which(abs(cr) == mx))
  
  l <- nrow(cr)
  cl <- num%%l  
  rw <- floor(num/l) + 1
  
  if(cl == 0) {
    cl <- l
  rw <- rw - 1
  }
  colnms <- colnames(cr)
  rownms <- rownames(cr)
  names <- c(rownms[rw], colnms[cl])
  return (names)
  
}

high.corr(swiss)

high.corr(iris[,-5])

x1 <- rnorm(30) # создадим случайную выборку
x2 <- rnorm(30) # создадим случайную выборку
x3  <- x1 + 5 # теперь коэффициент коррел€ции x1 и x3 равен единице
my_df <- data.frame(var1 = x1, var2 = x2, var3 = x3)
high.corr(my_df)




fit <- glm(am ~ disp + vs + mpg, mtcars, family = "binomial")
print(fit$coefficients)







library("ggplot2")

ToothGrowth

obj <- ggplot(data = ToothGrowth, aes(x = supp, y = len, fill = as.factor(dose)))+
  geom_boxplot()
obj


dtdt <- read.csv("C:\\Users\\User\\Downloads\\data.csv")

head(dtdt)


install.packages(ROCR)
library(ROCR)

predlm <- glm(admit ~ gpa + rank, dtdt, family = "binomial", na.action = na.omit)

dtdt$prdd <- predict.glm(object = predlm, newdata = type = "response", na.action = na.omit)

testdf <- data.frame(dtdt$admit[is.na(dtdt$admit)], dtdt$gre[is.na(dtdt$admit)], dtdt$gpa[is.na(dtdt$admit)], dtdt$rank[is.na(dtdt$admit)])

head(testdf)

names(testdf) <- c("admit", "gre", "gpa", "rank")

testdf$newdt <- predict(predlm, newdata = testdf, type = "response")

length(testdf$newdt[testdf$newdt > 0.4])
