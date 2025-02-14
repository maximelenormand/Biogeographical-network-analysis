# Import libraries
library(fmsb)
library(scales)
library(png)


shinyServer(function(input, output, session) {
  
##### DATA ##########################################################################
  
  #load Rdata according the celle_size choosen in the input for the leafletproxy map
        shpi=reactive({
                load(paste("Bioregions_",as.character(input$cell_size),".Rdata",sep=""))
                shpi=shp
                shpi
        })
  
  #load Rdata for the first map
        shp1=reactive({
                load("Bioregions_5.Rdata")
                shp1=shp
                shp1
        })
  

        output$map=renderLeaflet({
    #For the first map
                shp1=shp1()
                bins <- c(0, 50, 100, 200, 400, 600,800,1000,1250) #The value for the legend
                binpal <- colorBin("YlOrRd", domain = shp1$richesse, bins = bins) #Colors according the value
                popup=paste0("<span style='color: #7f0000'><strong>Number of species: </strong></span>",shp1@data$richesse) 
    
    
    # Firt map
                leaflet() %>%
                clearTiles() %>%
                addProviderTiles("CartoDB.Positron", options = providerTileOptions(noWrap = TRUE)) %>%
                fitBounds(1.68822,42.29971,7.736292,45.13382) %>% 
                addPolygons(layerId=as.character(1:dim(shp1)[1]), data=shp1, weight = 2, smoothFactor = 0.5,
                        color = ~binpal(as.numeric(as.character(shp1@data$richesse))),
                        fillColor=~binpal(as.numeric(as.character(shp1@data$richesse))),
                        opacity = 0.7, fillOpacity = 0.7, popup=popup, highlightOptions = highlightOptions(color = "white",
                                                                                                   weight = 2,bringToFront = TRUE),stroke=F)%>%
                addLegend(pal = binpal, values = as.numeric(as.character(shp1$richesse)), opacity = 0.7, title = "#species",position = "bottomright")
        })
        observe({ #map according the input 
                shpi=shpi()
                bins <- c(0, 50, 100, 200, 400, 600,800,1000,1250)
                binpal <- colorBin("YlOrRd", domain = shpi$richesse, bins = bins)
                popup=paste0("<span style='color: #7f0000'><strong>Number of species: </strong></span>",shpi@data$richesse)

                leafletProxy("map") %>%
                clearShapes() %>%
                clearMarkers() %>%
                clearControls() %>%
 

                addPolygons(layerId=as.character(1:dim(shpi)[1]), data=shpi, weight = 2, smoothFactor = 0.5,
                        color = ~binpal(as.numeric(as.character(shpi@data$richesse))),
                        fillColor=~binpal(as.numeric(as.character(shpi@data$richesse))),
                        opacity = 0.7, fillOpacity = 0.7, popup=popup, highlightOptions = highlightOptions(color = "white",
                        weight = 2,bringToFront = TRUE),stroke=F)%>%
                addLegend(pal = binpal, values = as.numeric(as.character(shpi$richesse)), opacity = 0.7, title = "#species",position = "bottomright")
                
        })
  
#####Bioregions############################################################################################
        #The different method, similarity metric and cell size are in one files : shp_all. 
        param=reactive({
                load("shp_all.Rdata")
                #Take the line on the shape file, the color and the legend according to the input
                shpi2=subset(shp, shp@data[,1]==paste(as.character(input$Sim_met2),as.character(input$Method2),as.character(input$cell_size2),sep=""))
                load("colo.Rdata")
                colo=subset(colo,colo[,1]==paste(as.character(input$Sim_met2),as.character(input$Method2),as.character(input$cell_size2),sep=""))[1,2:11]
                load("legend.Rdata")
                legend=subset(legend,legend[,1]==paste(as.character(input$Sim_met2),as.character(input$Method2),as.character(input$cell_size2),sep=""))[1,2:11]
                param=list(shpi2=shpi2,legend=legend,colo=colo)
        })
      
        #For the first map
        shp115=reactive({
                load(paste("shp_all.Rdata",sep=""))
                shp115=subset(shp, shp@data[,1]==115)
                shp115
      })
      
        #Load the bioregion line according to the input if different of none
        bioregion_line=reactive({
              if(input$oth_bio2!=0){   
                      load("lines.Rdata")
                      line = shp[as.numeric(as.character(input$oth_bio2)),]
                      line
              }
        })
  
        #insert a panel according to the input (bioregion line)
        inserted <- c()
  
        #remove the panel if there are one
        observeEvent(input$oth_bio2, { 
                line=bioregion_line()
                removeUI(
                selector =  paste0('#', inserted), multiple=T
        )
        inserted <<- c()
        })
        
  
        #Add the panel
        observeEvent(input$oth_bio2, {
                if(input$oth_bio2!=0){
                        btn <- input$oth_bio2
                        id <- paste0('txt', btn)
                        line=bioregion_line()
                        insertUI(
                                selector = '#placeholder',
                                ui = absolutePanel(draggable = TRUE,id=id, class = "panel panel-default", fixed = FALSE,
                                        top = "auto",left=80,
                                        width = 440, height = "auto",
                         
                                        div(h2(paste(line@data[1,1])), #display the details for the bioregion line selected
                                        p(paste0(line@data[1,4]),align="justify"),
                                        p(paste(line@data[1,2]),align="justify", style= "font-size: 11px"))
                                )               
                        )
                        inserted <<- c(id, inserted)
                }
        })
        
        
        output$map2=renderLeaflet({
                #For the firt map
                shp115=shp115()
                #popup table contribution 
                popup1=paste0("<table> 
                        <tr><th>Species</th><th>Contribution (%)</th>
                        </tr><tr><td>",shp115@data$X1,HTML('&nbsp;'),"</td><td>",shp115@data$X2 ,"</td>
                        </tr><tr><td>",shp115@data$X3 ,HTML('&nbsp;'),"</td><td>",shp115@data$X4 ,"</td>
                        </tr><tr><td>",shp115@data$X5 ,HTML('&nbsp;'),"</td><td>",shp115@data$X6 ,"</td>
                        </tr><tr><td>",shp115@data$X7 ,HTML('&nbsp;'),"</td><td>",shp115@data$X8 ,"</td>
                        </tr><tr><td>",shp115@data$X9 ,HTML('&nbsp;'),"</td><td>",shp115@data$X10 ,"</td>
                        </tr><tr><td>",shp115@data$X11 ,HTML('&nbsp;'),"</td><td>",shp115@data$X12 ,"</td>
                        </tr><tr><td>",shp115@data$X13 ,HTML('&nbsp;'),"</td><td>",shp115@data$X14 ,"</td>
                        </tr><tr><td>",shp115@data$X15 ,HTML('&nbsp;'),"</td><td>",shp115@data$X16 ,"</td>
                        </tr><tr><td>",shp115@data$X17 ,HTML('&nbsp;'),"</td><td>",shp115@data$X18 ,"</td>
                        </tr><tr><td>",shp115@data$X19 ,HTML('&nbsp;'),"</td><td>",shp115@data$X20 ,"</td>
                        </tr>
                        </table>")
                # Map
                leaflet() %>%
                clearTiles() %>%
                clearControls() %>%
                addProviderTiles("CartoDB.Positron", options = providerTileOptions(noWrap = TRUE)) %>% 
                fitBounds(1.68822,42.29971,7.736292,45.13382) %>%
                addPolygons(layerId=as.character(1:dim(shp115)[1]), data=shp115,
                        color = c("#FB8072","#FDB462","#A6D854","#66C2A5","#8DA0CB","#E78AC3","#FFD92F","#E5C494"),
                        weight = 2, smoothFactor = 0.5,
                        opacity = 0.7, fillOpacity = 0.7,
                        fillColor = c("#FB8072","#FDB462","#A6D854","#66C2A5","#8DA0CB","#E78AC3","#FFD92F","#E5C494"),
                        popup=popup1,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))  %>%

                addLegend(layerId="leg1",position = 'bottomright', ## choose bottomleft, bottomright, topleft or topright
                        colors = c("#FB8072","#FDB462","#A6D854","#66C2A5","#8DA0CB","#E78AC3","#FFD92F","#E5C494"),
                        labels = c("Gulf of Lion coast","Cork oak zone","Mediterranean lowlands","Mediterranean border",
                           "Cevennes sensu lato","Subatlantic mountains","Pre-Alpes","High mountains"),  ## legend labels (only min and max)
                        opacity = 1,      ##transparency
                        title = "Bioregions")
        })
  
        observe({
                #Map acording the input
                line=bioregion_line()
                param=param()
                shpi2=param$shpi2
                color2=param$colo
                legend2=param$legend
                popup1=paste0("<table>
                        <tr><th>Species</th><th>Contribution (%)</th>
                        </tr><tr><td>",shpi2@data$X1,HTML('&nbsp;'),"</td><td>",shpi2@data$X2,"</td>
                        </tr><tr><td>",shpi2@data$X3,HTML('&nbsp;'),"</td><td>",shpi2@data$X4,"</td>
                        </tr><tr><td>",shpi2@data$X5,HTML('&nbsp;'),"</td><td>",shpi2@data$X6,"</td>
                        </tr><tr><td>",shpi2@data$X7,HTML('&nbsp;'),"</td><td>",shpi2@data$X8,"</td>
                        </tr><tr><td>",shpi2@data$X9,HTML('&nbsp;'),"</td><td>",shpi2@data$X10,"</td>
                        </tr><tr><td>",shpi2@data$X11,HTML('&nbsp;'),"</td><td>",shpi2@data$X12,"</td>
                        </tr><tr><td>",shpi2@data$X13,HTML('&nbsp;'),"</td><td>",shpi2@data$X14,"</td>
                        </tr><tr><td>",shpi2@data$X15,HTML('&nbsp;'),"</td><td>",shpi2@data$X16,"</td>
                        </tr><tr><td>",shpi2@data$X17,HTML('&nbsp;'),"</td><td>",shpi2@data$X18,"</td>
                        </tr><tr><td>",shpi2@data$X19,HTML('&nbsp;'),"</td><td>",shpi2@data$X20,"</td>
                        </tr>
                        </table>")
    
                if(input$oth_bio2==0){ #if the input "other bioregion" is none
                        leafletProxy("map2") %>%
                        removeShape(layerId=as.character(1:12)) %>%
                        clearMarkers() %>%
                        clearControls() %>%
        
                        addPolygons(layerId=as.character(1:dim(shpi2)[1]), data=shpi2,
                                color = color2[!is.na(color2)],
                                weight = 2, smoothFactor = 0.5,
                                opacity = 0.7, fillOpacity = 0.7,
                                fillColor = color2[!is.na(color2)],
                                popup=popup1, highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))  %>%
        
                        addLegend(layerId="leg2",position = 'bottomright', 
                                colors = color2[!is.na(color2)],
                                labels = legend2[!is.na(legend2)],  
                                opacity = 1,      ##transparency
                                title = "Bioregions")
        
        
                }else{ #If there are bioregion line 
                        leafletProxy("map2") %>%
                        removeShape(layerId=as.character(9:12)) %>%
                        clearMarkers() %>%
                        clearControls() %>%

 
                        addPolygons(layerId=as.character(1:(dim(shpi2))[1]), data=shpi2,
                                color = color2[!is.na(color2)],
                                weight = 2, smoothFactor = 0.5,
                                opacity = 0.7, fillOpacity = 0.7,
                                fillColor = color2[!is.na(color2)],
                                popup=popup1,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = FALSE))  %>%
                    
                        addLegend(layerId="leg2",position = 'bottomright', 
                                colors = color2[!is.na(color2)],
                                labels = legend2[!is.na(legend2)],  
                               opacity = 1,      ##transparency
                                title = "Bioregions")%>%   ## title of the legend
      
                        addPolylines(layerId=as.character(12), data=line,color="#ff4500",opacity=1,options = popupOptions())
                }   
        })
  
  
  
#####Interaction#####################################################
        output$image1 <- renderImage({ #display the interaction 
                return(list(
                        src = paste("reseau_",input$Sim_met3,"_",input$Method3,"_",input$cell_size3,".png", sep=""),
                        contentType = "image/png",
                        height=800
                ))
                }, deleteFile = FALSE)
  
})


