## Input: a 3 columns data frame (Species, Cell and Bioregion). Each line gives the presence of a given species in a given cell (and its associated bioregion)
## Output: the test-value matrix rho and the matrix of bioregion relationships lambda             

biogeonet=function(data){
    
  # Number of cells per bioregions
  clust=data[!duplicated(data[,2]),]
  clust=aggregate(clust[,2],list(clust[,3]), length)
  nclust=dim(clust)[1]
  n=sum(clust[,2])
  
  # Compute nij, ni & nj
  agg=aggregate(data[,2],list(data[,1],data[,3]),length)
  colnames(agg)=c("IDspec","IDclust","nij")
  
  nij=xtabs(nij ~ IDspec + IDclust, data=agg)    # Number of cells in bioregion j where the specie i is present
  ni=replicate(dim(nij)[2], apply(nij, 1, sum))  # Number of cells where the specie i is present
  nj=t(replicate(dim(nij)[1], clust[,2]))        # Number of cells in the bioregion j
  
  # Rhoij
  num=nij-((ni*nj)/n)
  den=sqrt((n-nj)/(n-1)*(1-(nj/n))*((ni*nj)/n))
  rhoij=num/den
  
  # Lambda
  rhoijp=rhoij
  rhoijp[rhoijp<1.96]=NA
  rhoijp=rhoijp/rowSums(rhoijp,na.rm = T)
  
  lambda=NULL
  for(k in 1:nclust){    
    rhoijpk=rhoijp[!is.na(rhoijp[,k]),]  
    lambda=rbind(lambda, apply(rhoijpk, 2, sum, na.rm =T)/dim(rhoijpk)[1])  
  }  
  
  # Save results
  rho=as.data.frame.matrix(rhoij)
  rownames(lambda)=colnames(rho) 
  colnames(lambda)=rownames(lambda)  

  L=list(rho=rho,lambda=lambda)  
  return(L)
  
}
