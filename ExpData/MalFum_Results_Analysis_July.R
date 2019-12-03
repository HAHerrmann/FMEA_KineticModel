# Mal Fum Analysis July 2018

library(readxl)
library(Hmisc)
setwd("~/Desktop/Helena/6TempsPaper/ExpData/MetaboData")

dat = read_excel("MalFumResults.xlsx", sheet = 1)
#dat = read_excel("MalFumResults_D7.xlsx", sheet = 1)

conc <- function(A1,A2,con,vol){
  c = (A2-A1)*vol/(6300*1*0.05*con*10^(-3))
  return(c)
}

conc_mal = conc(dat$A1,dat$A2,dat$Concentration,1.21)
conc_fum = conc(dat$A2,dat$A3,dat$Concentration,1.31)

temps = c(5,10,15,20,25,30)

mal_fum <- function(con,geno,temps){
  metabo_BOD = c()
  se_BOD = c()
  metabo_EOD = c()
  se_EOD = c()
  for (t in temps){
    t_conc_metabo = con[which(dat$Genotype == geno & dat$DayTime == 'BOD' & dat$Temperature == t)]
    metabo_BOD = c(metabo_BOD,mean(t_conc_metabo))
    se_BOD = c(se_BOD,sd(t_conc_metabo)/sqrt(length(t_conc_metabo)))
    t_conc_metabo = con[which(dat$Genotype == geno & dat$DayTime == 'EOD' & dat$Temperature == t)]
    metabo_EOD = c(metabo_EOD,mean(t_conc_metabo))
    se_EOD = c(se_EOD,sd(t_conc_metabo)/sqrt(length(t_conc_metabo)))
  }
  return(list('metabo_BOD'=metabo_BOD,'metabo_EOD'=metabo_EOD,
              'se_BOD'=se_BOD,'se_EOD'=se_EOD))
}

ma = max(conc_mal,na.rm = TRUE)
mi = 0

malfum_plot <- function(genotype,concen,temps,title,a){
  amm = mal_fum(concen,genotype,temps)
  data_gen = matrix(rep(NA,8*6),nrow=8,ncol=6)
  colnames(data_gen)=c(5,10,15,20,25,30)
  data_gen[1,] = (amm$metabo_BOD)/4
  data_gen[8,] = (amm$metabo_EOD)/4
  for (i in seq(2,7)){
    data_gen[i,] = data_gen[i-1,] + (data_gen[8,]-data_gen[1,])/7
  }
  #View(data_gen)
  plot(temps,amm$metabo_BOD,type="o", col="blue",main=title,cex=1.5,pch=19,
       xlab='',ylab='',ylim=c(mi,ma),cex.main=1.5,col.axis=cl,col.lab=cl,col.main=cl)
  errbar(temps, amm$metabo_BOD, amm$metabo_BOD+amm$se_BOD, amm$metabo_BOD-amm$se_BOD,
         add=TRUE,col='blue')
  points(temps,amm$metabo_EOD,type="o",pch=19, col="green",cex=1.5)
  title(ylab=expression(paste('mmol/(gDW)')), line=2.2, cex.lab=1.5,col.lab=cl)
  title(xlab=expression(~degree~C), line=2.2, cex.lab=1.5,col.lab=cl)
  errbar(temps, amm$metabo_EOD, amm$metabo_EOD+amm$se_EOD, amm$metabo_EOD-amm$se_EOD,
         add=TRUE,col='green')
  legend("top",legend=c('BOD','EOD'),col=c('blue','green'),pch=c(19,19),cex=1.5,bty = "n")
  legend("topleft", a, bty="n",cex=1.5) 
}


cl = 'black'
par(mfrow=c(2,3),fg=cl) #,bg=NA,fg='white'

malfum_plot('col0',conc_mal,temps,expression('Col-0 Malate'),"(A)")
malfum_plot('fum2',conc_mal,temps,expression(paste(italic('fum2.2'),' Malate')),"(B)")
malfum_plot('c24',conc_mal,temps,expression('C24 Malate'),"(C)")

malfum_plot('col0',conc_fum,temps,expression('Col-0 Fumarate'),"(D)")
malfum_plot('fum2',conc_fum,temps,expression(paste(italic('fum2.2'),' Fumarate')),"(E)")
malfum_plot('c24',conc_fum,temps,expression('C24 Fumarate'),"(F)")
#dev.copy(png,'MalFum.png')
#dev.off()


