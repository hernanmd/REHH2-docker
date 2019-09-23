# print(list.files("/usr/local/lib/R/site-library"))
# print(list.files("/usr/local/lib/R/library"))

library(rehh)
print(sessionInfo())

g <- c(2,3)
# write.table(g,file = "/rehhfiles/a.txt")

write.table(g,file = "a.txt")
