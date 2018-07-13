Biogeographical network analysis of plant species distribution in the Mediterranean region
================================================================================

## Description

The purpose of this work was to develop several tools and metrics to identify and characterize the biogeographical structure of a region. As described in the paper [[1]](https://arxiv.org/abs/1803.05275), we applied the method to unveil multiscale biogeographical structures of plant species distribution in the south of France. We also developed a web interactive application to visualize the results.

## Data

The test-value matrix described in [[1]](https://arxiv.org/abs/1803.05275) is available in the csv file ***rho.csv***. The table contains 11 columns with column names, **the value separator is a semicolon ";"**. Each row represents a plant species.

1.  **ID:** SILENE ID of the plant species
2.  **Name:** Name of the plant species
3.  **Test value bioregion 1:** Contribution of the plant species to cluster "Gulf of Lion coast" 
4.  **Test value bioregion 2:** Contribution of the plant species to cluster "Cork oak zone"
5.  **Test value bioregion 3:** Contribution of the plant species to cluster "Mediterranean lowlands" 
6.  **Test value bioregion 4:** Contribution of the plant species to cluster "Mediterranean borders"
7.  **Test value bioregion 5:** Contribution of the plant species to cluster "Cévennes sensu lato"
8.  **Test value bioregion 6:** Contribution of the plant species to cluster "Subatlantic mountains"
9.  **Test value bioregion 7:** Contribution of the plant species to cluster "Pre-Alps and other medium mountains"
10. **Test value bioregion 8:** Contribution of the plant species to cluster "High mountains"
11. **Species group:** ID of the plant species group the plant species belongs to. 

## Script

The function **biogeonet** (contains in the script **biogeonet.R**) allows the user to compute the matrices **rho** and **lambda** as described in [[1]](https://arxiv.org/abs/1803.05275). The input of the function is a 3 columns data frame where each line gives the presence of a given species in a given cell (and its associated bioregion). An exemple of input **data** is available in the file **test_biogeonet.Rdata**. The first column is the SILENE ID of the plant species, the second column is the ID of the 5x5 km^2 cell where the species is present and the third column represents the bioregion the cell belongs to (obtained with OSLOM).

## Interactive web application

A Shiny application has also been designed by Maxime lenormand and developped by Maxence Soubeyrand to visualize the results. This repository contains all the material (R scripts, Rdata and WWW data folder) needed to run the [app](https://maximelenormand.shinyapps.io/Biogeo/). 

## Citation

If you use this code, please cite:

[1] Lenormand *et al.* (2018) [Biogeographical network analysis of plant species distribution in the Mediterranean region.](https://arxiv.org/abs/1803.05275) arXiv preprint arXiv:1803.05275.

If you need help, find a bug, want to give me advice or feedback, please contact me!
You can reach me at maxime.lenormand[at]irstea.fr
