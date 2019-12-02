# Failure Mode and Effect Analysis 

We used an [existing metabolic model](https://www.ncbi.nlm.nih.gov/pubmed/24808102) to construct a metabolite-metabolite graph.

All non-carbon compounds and small molecules and cofactors were removed from the graph. 

The probability of failure (P) and the severity of failure (S) was calculated for each carbon metabolite downstream of Rubisco. 
Each metabolite was then assigned a risk score (R) such that R = P x S. 
