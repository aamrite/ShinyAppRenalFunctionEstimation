#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$GFR <- renderText({
      if (input$Method=="CG"){
          sexfac<-ifelse(input$Gender==1,0.85,1)
      }
      if (input$Method=="MDRD"){
          sexfac<-ifelse(input$Gender==1,0.742,1)
      }
      
     racefac<-ifelse(input$Race==1,1.212,1)
     crcl<-((140-input$Age)*input$Weight)*sexfac/(72*input$Creatinine)
     gfr<- 175*(input$Creatinine)**-1.154*(input$Age)**-0.203*sexfac*racefac 
     out<-round(ifelse(input$Method=="CG", crcl,gfr),0)
     unitmdrd<-paste("ml/min/1.73m","^2", sep="" )
     ifelse(input$Method=="CG", paste(out, "(mL/min)", sep= " "), paste(out,unitmdrd, sep=" " ))
  })
  
  output$Status <- renderPlot({
      if (input$Method=="CG"){
          sexfac<-ifelse(input$Gender==1,0.85,1)
      }
      if (input$Method=="MDRD"){
          sexfac<-ifelse(input$Gender==1,0.742,1)
      }
      
      racefac<-ifelse(input$Race==1,1.212,1)
      crcl<-((140-input$Age)*input$Weight)*sexfac/(72*input$Creatinine)
      gfr<- 175*(input$Creatinine)**-1.154*(input$Age)**-0.203*sexfac*racefac 
      out<-round(ifelse(input$Method=="CG", crcl,gfr),0)
      out2<-ifelse(out>=150, 150, out)##creates a variable with max value of 150 for GFR
      x<-c(0:150)
      y<- rep(1, 151)
      x1<-c(0:out2)
      y1<-rep(0.5, length(x1))
      data1<-as.data.frame(cbind(x,y))
      data2<-as.data.frame(cbind(x1,y1))
      rects<-as.data.frame(cbind(xstart=c(0,15,30,60,90), xend=c(15,30,60,90,150), col=letters[1:5]))
      rects$xstart<-as.numeric(as.character(rects$xstart))
      rects$xend<-as.numeric(as.character(rects$xend))
      ggplot(data=data1, aes(x=x,y=y))+
          geom_line(aes(x=x, y=y))+
          theme(axis.line.x = element_line(color="black", size = 1),
                axis.line.y = element_line(color="black", size = 1),
                axis.title.x= element_text(face="bold",size=16),
                axis.title.y= element_text(face="bold",size=16),
                axis.text.x =element_text(face="bold",size=12),
                axis.text.y =element_blank(),
                axis.ticks.y=element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                legend.position = "none")+
          scale_x_continuous(expand = c(0, 0), limits=c(0,151)) +
          scale_y_continuous(expand = c(0, 0))+
          xlab("eGFR or Creatinine Clearance")+
          ylab("")+
          geom_rect(inherit.aes=FALSE,data=rects, aes(xmin=xstart, xmax=xend, ymin=0, ymax=1, fill=col), alpha=0.2)+
          geom_line(inherit.aes = FALSE, data=data2,aes(x=x1, y=y1, size=1), arrow=arrow(type="open"))+
          annotate(geom="text", x=5, y=0.9, label="ESRD")+
          annotate(geom="text", x=22, y=0.9, label="Severe RI")+
          annotate(geom="text", x=40, y=0.9, label="Moderate RI")+
          annotate(geom="text", x=70, y=0.9, label="Mild RI")+
          annotate(geom="text", x=100, y=0.9, label="Normal")
          
          
  }) 
})
