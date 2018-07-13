function(){
	tabPanel(strong("About"),
	         
		HTML('
      
      <div style="display:inline;float:right;margin:0px 0px 5px 20px">
        <img src="Logo.png" border="0" width="300" style="margin:0px">
      </div>

      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify">
          This interactive web application has been designed to provide an easy-to-use interface to visualize 
          multiscale biogeographical structures of plant species distribution in the south of France. 
          It was developed as part of a research project funded 
          by the <a href="http://www.agence-nationale-recherche.fr/en/" target=_blank>French National Research Agency</a> through the 
          <a href="https://netcost.gitlab.io/" target=_blank>Netcost Young Researchers project</a> and by the 
          <a href="https://www.ecologique-solidaire.gouv.fr" target=_blank> French Ministry for an Ecological and Solidary Transition</a>. 
        </p>
      </div>   

      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify">
          The first tab presents the dataset used to perform the analysis and the spatial distribution of plant species. 
          The second tab displays a map of the bioregions identified with different methods. 
          Other historical biogeographical delineation, such as the one proposed by Lamarck & De Candolle in 1805, are also available. 
          The third tab presents the specificity of the bioregions and the relationship between them. 
          The results are available at two different scales with grid cells of 5x5 and 10x10 km<SUP>2</SUP> and 
          several aggregation methods and similarity metrics have been tested (more details given below). 
        </p>
      </div> 

      <br>

      <span style="font-size:120%;color:#64645F;font-weight:bold;">Aggregation methods</span>
      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify;">
          Two clustering technics have been applied to identify biogeographical regions according to similarities 
          of species composition between grid cells.
        </p>
        <ul style="font-size:120%;text-align:justify;">
          <li><a href="http://www.oslom.org/" target=_blank>OSLOM</a> is a clustering algorithm designed to detect network communities</li>
          <li><a href="https://en.wikipedia.org/wiki/Ward%27s_method" target=_blank>Ward&#39;s method</a> is a criterion applied in hierarchical cluster analysis</li>
        </ul> 
      </div>  

      <br>

      <span style="font-size:120%;color:#64645F;font-weight:bold;">Similarity metrics</span>
      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify;">
          In this first version of the app, the (dis)similarity of species composition between grid cells has only been measured 
          with the <a href="https://en.wikipedia.org/wiki/Jaccard_index" target=_blank> Jaccard similarity coefficient</a>.
        </p>
      </div>  




      <hr width="1000", align="left" style="height:0.5px;border:none;color:#A0A5A8;background-color:#A0A5A8;" />
  
		  

      <span style="color:#64645F;font-weight:bold;">Reference</span>
		  <div style="max-width:1000px; word-wrap:break-word;">
		     <p style="text-align:justify;">
		     
		     Lenormand <i>et al.</i> (2018) <a href="https://arxiv.org/abs/1803.05275" target=_blank>Biogeographical network analysis of plant species distribution in the Mediterranean region</a> <i>arXiv preprint</i> 1803.05275.
		     
		     </p>
		  </div>  

		  <span style="color:#64645F;font-weight: bold;">Author</span>
		  <div style="max-width:1000px; word-wrap:break-word;">
		     <p style="text-align:justify">
		        Maxence Soubeyrand & <a href="http://www.maximelenormand.com" target=_blank>Maxime Lenormand</a>
		     </p>
		  </div>  

		  <span style="color:#64645F;font-weight:bold;">Code</span>
		  <div style="max-width:1000px; word-wrap:break-word;">
		     <p style="text-align:justify;">
		        Source code available <a href=" http://www.maximelenormand.com/Codes" target=_blank>here</a>
		     </p>
		  </div> 

		  <span style="color:#64645F;font-weight:bold;">License</span>
		  <div style="max-width:1000px; word-wrap:break-word;">
		     <p style="text-align:justify;">
		        Coded under License GPLv3
		     </p>
		  </div> 

		'),
		
		value="about"
	)
}
