doors <- c("A", "B", "C")
xdata = c()
for (i in 1:1000) {
  prize <- sample(doors, 1)
  pick <- sample(doors, 1)
  open <- sample(doors[which(doors != pick & doors != prize)], 1)
  
  switchyes <- doors[which (doors != pick & doors != open)]
  if (pick == prize) {
    xdata = c(xdata, "noswitchwin")
  }
  if (switchyes == prize) {
    xdata = c(xdata, "switchwin")
  }
  
}
length(which (xdata == "switchwin"))
length(which(xdata == "noswitchwin"))