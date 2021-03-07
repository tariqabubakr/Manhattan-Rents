library(sqldf)
library(dplyr)
library(ggplot2)

avg_rent <- sqldf("SELECT  neighborhood,
                  AVG(rent) AS average_rent
                  FROM manhattan 
                  GROUP BY neighborhood
                  ORDER BY rent DESC")

subway_distance <- sqldf("SELECT neighborhood,
                     AVG(min_to_subway) AS subway_distance
                     FROM manhattan WHERE neighborhood NOT IN ('Roosevelt Island','Long Island City')
                     GROUP BY neighborhood
                     ORDER BY min_to_subway 
                     ")

most_convenience <- sqldf("SELECT neighborhood,
                     AVG(min_to_subway) AS subway_distance
                     FROM manhattan
                     GROUP BY neighborhood
                     ORDER BY min_to_subway ASC LIMIT 5
                     ")

least_convenient <- sqldf("SELECT neighborhood,
                     AVG(min_to_subway) AS subway_distance
                     FROM manhattan 
                     WHERE neighborhood NOT IN ('Roosevelt Island')
                     GROUP BY neighborhood
                     ORDER BY min_to_subway DESC LIMIT 5
                     ")

top_5 <- sqldf("SELECT neighborhood,
                  AVG(rent) AS average_rent
                  FROM manhattan 
                  GROUP BY neighborhood
                  ORDER BY rent DESC LIMIT 5")

g <- ggplot(top_5, aes(x=reorder(neighborhood,-average_rent),average_rent)) + geom_bar(stat="identity",fill="navy") + xlab("Neighborhood") + ylab("Average Rent") + theme_minimal()

subway_plot <- ggplot(subway_distance, aes(x=reorder(neighborhood,subway_distance),subway_distance)) + geom_bar(stat="identity",fill="navy") + ylab("Distance to Subway (Minutes)") + xlab("Neighborhood") + coord_flip() + theme_classic()

