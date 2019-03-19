# Import libraries
library(shiny)
library(leaflet)
library(shinythemes)
library(shinyjs)


tabPanelAbout=source("About.R")$value


# UI
navbarPage(title = div(
                HTML('<span style="font-size:120%;color:white;font-weight:bold;"> Plant species distribution in the Mediterranean region&nbsp;&nbsp;</span></a>'),
#add the french flag with the link for a french version on this app  
                tags$script(HTML("var header = $('.navbar > .container-fluid');
                header.append('<div style=\"float:right\"><a href=\"https://maximelenormand.shinyapps.io/Biogeo_FR/\"><img src=\"french_flag.png\" alt=\"alt\" style=\"float:right; width:50px;height:40px;padding-top:10px;\"> </a></div>');console.log(header)"))
                ),
        theme = shinytheme("united"),
        windowTitle = "Bioregion",
        header = "",
#######################################Data#######################################
        tabPanel(strong("Data"),
                div(class="outer",  
               # Include custom CSS  
                        tags$head(
                                includeCSS("styles.css"),
                                tags$link(rel = "icon", type = "image/png", href = "Logo_bioregion.png") #icon for the web page
                        ),
               # Map
                      leafletOutput("map", width = "100%", height = "100%"),
               
               # Panel
                      absolutePanel(id = "control1", class = "panel panel-default", fixed = TRUE,
                              draggable = TRUE, top = 80, left = "auto", right = 20, bottom = "auto",
                              width = 330, height = "auto",
                             
                              h2("Spatial distribution"),
                  
                              selectInput("cell_size", 
                                      label=strong("Scale"), 
                                      choices=list("5 km" = 5,
                                      "10 km" = 10),
                                      selected=5),
                      
                             #details and source on the panel
                              HTML('<div align="justified">Click to display the number of species in the cell.</div>  <br/>'),
                              HTML('<div align="justified"><strong>Source</strong></div> '),
                              HTML('<div align="justified">Conservatoire Botanique National Méditerranéen & Conservatoire Botanique National Alpin (<a href="http://flore.silene.eu" target=_blank>http://flore.silene.eu</a>).</div> ')
                        )
                )
        ),
#######################################Bioregions#######################################
        tabPanel(strong("Bioregions"),
                    #####Les polygones fusionnés
                div(class="outer",
                        # Map
                        leafletOutput("map2", width = "100%", height = "100%"),
                        # Panel
                        absolutePanel(id = "control1", class = "panel panel-default", fixed = TRUE,
                                draggable = TRUE, top = 80, left = "auto", right = 20, bottom = "auto",
                                width = 330, height = "auto",

                                h2("Bioregionalization"),

                                selectInput("Method2",
                                        label=strong("Aggregation method"),
                                        choices=list("Oslom" = 1,
                                                     "Ward" = 2),
                                        selected=1),
                                      
                                selectInput("Sim_met2",
                                        label=strong("Similarity metric"),
                                        choices=list("Jaccard" = 1,
                                                     "Simpson" = 2),
                                        selected=1),

                                selectInput("cell_size2",
                                        label=strong("Scale"),
                                        choices=list("5 km" = 5,
                                                     "10 km" = 10),
                                        selected=5),
                                selectInput("oth_bio2",
                                        label=strong("Other bioregionalization"),
                                        choices=list("None"=0,
                                                     "Lamarck (1805)"=1,
                                                     "Flahaut (1887)"=2,
                                                     "Ozenda (1994)"=3,
                                                     "Julve (1999)"=4,
                                                     "Bohn (2000)"=5,
                                                     "Rivas (2004) – thermoclimat"=6,
                                                     "Rivas (2004) – biogeo"=7,
                                                     "CEC (2006)"=8),
                                        selected=0),
                                HTML('<div align="justified">Click to display the ten species that contribute the most to the bioregion.
                                       Among the species that contribute to the bioregion, the sum of the contribution of all the plants is 100% .</div> ')
                                      
                        )

                ),
                    #for the panel of bioregion line
                tags$div(id = 'placeholder') 
        ),
           
           
##################INTERACTIONS#########################

        tabPanel(strong("Interactions"),
                    
                imageOutput("image1"),
                tags$style(type="text/css",
                               "#image1 img{display:block;margin-top:0%;margin-bottom:auto;margin-left:5%;margin-right:auto;}"),

                        # Panel
                absolutePanel(id = "control1", class = "panel panel-default", fixed = TRUE,
                        draggable = TRUE, top = 80, left = "auto", right = 20, bottom = "auto",
                        width = 390, height = "auto",
                                      
                        h2("Bioregions' relationships"),
                                      
                        selectInput("Method3",
                                label=strong("Aggregation method"),
                                choices=list("Oslom" = 1,
                                             "Ward" = 2),
                                selected=1),
                                      
                        selectInput("Sim_met3",
                                label=strong("Similarity metric"),
                                choices=list("Jaccard" = 1,
                                             "Simpson" = 2),
                                selected=1),
                                      
                                      
                        selectInput("cell_size3",
                                label=strong("Scale"),
                                choices=list("5 km" = 5,
                                             "10 km" = 10),
                                selected=5),
                        p(strong("Network of interactions between bioregions")),
                        HTML('For a given bioregion, the values (expressed here in percentage) show how the contribution of species that contribute 
                                        significantly to this bioregion is distributed across bioregions (including itself). Only links with values higher than 10% are shown. 
                                        More details available in <a href="https://arxiv.org/abs/1803.05275" target=_blank>the paper</a>.')
                )
     
        ),
           ##### About ####################################################################################
        tabPanelAbout()
)