library(ggplot2)
ggplot2::mpg

#3.2.4----------------------------------------

#Run ggplot(data = mpg). 
ggplot(data = mpg)
#What do you see? An empty plot

#How many rows are in mpg?
nrow(mpg)
#How many columns?
ncol(mpg)

#What does the drv variable describe?
#the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd
#Read the help for ?mpg to find out.
?mpg

#Make a scatterplot of hwy vs cyl
ggplot(mpg, aes(x = cyl, y = hwy)) +
  geom_point()

#What happens if you make a scatterplot of class vs drv? 
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
#Why is the plot not useful?
# because both drv and class are categorical variables. Since categorical variables typically take a small number of values, there are a limited number of unique combinations of (x, y) values that can be displayed.

#3.3.1-------------------------------------------

#What’s gone wrong with this code? Why are the points not blue?
#the argumentcolour = blue is included within the mapping argument . .

#Which variables in mpg are categorical? 
#manufacturer,model,trans,drv,fl and class
#Which variables are continuous? 
#displ,year,cyl,cty and hwy
#How can you see this information when you run mpg?
#the columns with <chr> above their are categorical, and the columns with <dbl> or <int> are continuous.

#Map a continuous variable to color, size, and shape. How do these aesthetics behave differently for categorical vs. continuous variables?
ggplot(mpg, aes(x = displ, y = hwy, size = cty)) +
  geom_point()
#When mapped to size, the sizes of the points vary continuously as a function of their size.

#What happens if you map the same variable to multiple aesthetics?
ggplot(mpg, aes(x = displ, y = hwy, colour = hwy, size = displ)) +
  geom_point()
#hwy is mapped to both location on the y-axis and color, and displ is mapped to both location on the x-axis and size. 

#What does the stroke aesthetic do? What shapes does it work with? 
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 25, colour = "black", fill = "white", size = 5, stroke = 5)
#Stroke changes the size of the border for shapes (21-25). These are filled shapes in which the color and size of the border can differ from that of the filled interior of the shape.

#What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)? 
ggplot(mpg, aes(x = displ, y = hwy, colour = displ < 5)) +
  geom_point()
#the result of displ < 5 is a logical variable which takes values of TRUE or FALSE.

#3.5.1--------------------------------------------------

#What happens if you facet on a continuous variable?
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(. ~ cty)
#The continuous variable is converted to a categorical variable

#What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
#The empty cells (facets) in this plot are combinations of drv and cyl that have no observations.

#What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
#will facet by values of cyl on the x-axis.

#Take the first faceted plot in this section:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#What are the advantages to using faceting instead of the colour aesthetic?
#the ability to encode more distinct categories. 
#What are the disadvantages?
#difficulty of comparing the values of observations between categories since the observations for each category are on different plots.
#How might the balance change if you had a larger dataset?
#if the number of categories increases, the difference between colors decreases

#Read ?facet_wrap. What does nrow do? What does ncol do? 
#determines the number of rows & columns
#What other options control the layout of the individual panels? 
facet_wrap() 
#Why doesn’t facet_grid() have nrow and ncol arguments?
#since the number of unique values of the variables specified in the function determines the number of rows and columns.

#When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?  
#There will be more space for columns if the plot is laid out horizontally (landscape).

#3.6.1---------------------------------------------------

#What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
#line chart: geom_line(),boxplot: geom_boxplot(),histogram: geom_histogram(),area chart: geom_area()

#Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
#this code produces a scatter plot with displ on the x-axis, hwy on the y-axis

#What does show.legend = FALSE do?
#hides the legend box.
#What happens if you remove it?
#will result in the plot having a legend displaying the mapping between colors.
#Why do you think I used it earlier in the chapter?
#because with three plots, adding a legend to only the last plot would make the sizes of plots different.

#What does the se argument to geom_smooth() do?
#It adds standard error bands to the lines.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = TRUE)

#Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#no because both geom_point() and geom_smooth() will use the same data and mappings. They will inherit those options from the ggplot() 

#Recreate the R code necessary to generate the following graphs.
#1
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)
#2
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(group = drv), se = FALSE) +
  geom_point()
#3
ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
#4
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(se = FALSE)
#5
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)
#6
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") +
  geom_point(aes(colour = drv))

#3.7.1-----------------------------------------------

#What is the default geom associated with stat_summary()? 
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )
#How could you rewrite the previous plot to use that geom function instead of the stat function?
ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary",
    fun.min = min,
    fun.max = max,
    fun = median
  )

#What does geom_col() do?
#expects that the data contains x values and y values which represent the bar height.
#How is it different to geom_bar()?
#The geom_bar() function only expects an x variable. The stat, stat_count(), preprocesses input data by counting the number of observations for each value of x

#Most geoms and stats come in pairs that are almost always used in concert. Read through the documentation and make a list of all the pairs. What do they have in common?
#geom_bin2d()	stat_bin_2d() ,geom_boxplot(),geom_count()	stat_sum(),geom_function()	stat_function()	
#their have names in common,  and be documented on the same help page.

#What variables does stat_smooth() compute?
y: #predicted value
  ymin: #lower value of the confidence interval
  ymax: #upper value of the confidence interval
  se: #standard error
  #What parameters control its behaviour ?
  method:# this is the method used to compute the smoothing line.
  formula:# When providing a custom method argument, the formula to use.
  method.arg(): #Arguments other than than the formula, which is already specified in the formula argument 
  
  #In our proportion bar chart, we need to set group = 1. Why? 
  ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop)))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop
#if group = 1 is not included, then all the bars in the plot will have the same height
#In other words what is the problem with these two graphs?
#the proportions are calculated within the groups.
                                                               
#3.8.1------------------------------------------------------------------------------------------------
                                                               
#What is the problem with this plot? 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
geom_point() 
#there is overplotting because there are multiple observations for each combination of cty and hwy values.
#How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
geom_point(position = "jitter")
#The relationship between cty and hwy is clear even without jittering the points
                                                               
#What parameters to geom_jitter() control the amount of jittering?
#width controls the amount of horizontal displacement & height controls the amount of vertical displacement.
                                                               
#Compare and contrast geom_jitter() with geom_count().
geom_jitter() #adds random variation to the locations points of the graph.
geom_count() #sizes the points relative to the number of observations.
                                                               
#What’s the default position adjustment for geom_boxplot()?
dodge2s
 #Create a visualization of the mpg dataset that demonstrates it.
 ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) +
 geom_boxplot()