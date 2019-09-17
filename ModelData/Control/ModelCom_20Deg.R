library(Hmisc)

# # Basic Model
# mal_Model20 = c(0.002768,0.01223,0.003304,0.01804,0.002143,0.01268) # BOD/EOD Col0/Fum2/C24
# fum_Model20 = c(0.004002,0.01045,0.0001,0.0001,0.003036,0.008393) # BOD/EOD Col0/Fum2/C24

# Model with Activation and Inhibition
mal_Model20 = c(0.0024,0.0122,0.0037,0.017,0.004,0.013) # BOD/EOD Col0/Fum2/C24
fum_Model20 = c(0.0029,0.0099,0.0001,0.0001,0.0025,0.0079) # BOD/EOD Col0/Fum2/C24

mal_exp20 = c(0.00980236,0.05274206,0.01353543,0.07281972,0.01284029,0.05091889)
mal_exp20_se = c(0.002144948,0.003676404,0.004534005,0.007957132,0.008760525,0.006480968)
fum_exp20 = c(0.01388528,0.04242368,0.002,0.002,0.01188564,0.0299785)
fum_exp20_se = c(0.001917527,0.008595089,0.001,0.002,0.005142021,0.004259989)

# Plotting Bar Graphs
par(mfrow=c(1,2),mgp=c(1.8,0.5,0))

# Comparing Malate Concentrations 
d =matrix(mal_exp20,nrow=2,ncol=3)
rownames(d) = c("BOD","EOD")
colnames(d) = c("Col0","Fum2","C24")
barplot(d, main="Malate Concentration in Control Conditions",
        ylab=expression(paste(mu,'mol/(gDW)')), col=c(adjustcolor("gray",0.2),"darkgray"),
        legend = rownames(d), beside=TRUE, ylim=c(0,0.1),cex.lab=1.5,cex.axis=1.5,cex.names=1.5)
errbar(c(1.5,2.5,4.5,5.5,7.5,8.5), mal_exp20, mal_exp20+mal_exp20_se, mal_exp20-mal_exp20_se,add=TRUE)
box()
points(c(1.5,2.5,4.5,5.5,7.5,8.5),mal_Model20*4,col="red",pch=8,cex=2)

# Comparing Fumarate Concentrations 
d =matrix(fum_exp20,nrow=2,ncol=3)
rownames(d) = c("BOD","EOD")
colnames(d) = c("Col0","Fum2","C24")
barplot(d, main="Fumarate Concentration in Control Conditions",
        ylab=expression(paste(mu,'mol/(gDW)')), col=c(adjustcolor("gray",0.2),"darkgray"),
        legend = rownames(d), beside=TRUE, ylim=c(0,0.1),cex.lab=1.5,cex.axis=1.5,cex.names=1.5)
errbar(c(1.5,2.5,4.5,5.5,7.5,8.5), fum_exp20, fum_exp20+fum_exp20_se, fum_exp20-fum_exp20_se,add=TRUE)
box()
points(c(1.5,2.5,4.5,5.5,7.5,8.5),fum_Model20*4,col="red",pch=8,cex=2)
