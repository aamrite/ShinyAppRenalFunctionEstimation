#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Estimate your Renal Function"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       radioButtons("Method",
                   "Choose method for estimating GFR:",
                   c("Cockcraft-Gault"="CG", "Modification of Diet in Renal Disease"="MDRD"),
                   selected="CG"),
       selectInput("Gender", "Choose Gender:", choices=list("Female"=1, "Male"=2)),
       selectInput("Race", "Choose Race:", choices=list("African American"=1, "Others"=2)),
       sliderInput("Age", "Select Age (years):", min=18, max=100, value=30),
       sliderInput("Weight", "Select Weight (kg):", min=20, max=200, value=70),
       sliderInput("Creatinine", "Select Serum Creatinine (mg/dL):", min=0.1, max=3, value=0.8,step=0.1),
       br(),
       helpText("The app calculates the renal function in terms of creatinine clearance (if Cockcroft-Gault is chosen) or estimated glomerular filtration rate (eGFR- if MDRD is chosen)"),
       submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       
           h3("Your creatinine clearance (CG) or eGFR (MDRD) is:"),
           textOutput("GFR"),
           br(),
           br(),
           h3("Your renal function category is:"),
           plotOutput("Status"),
           p("Key- ESRD: end stage renal disease; RI: renal impairment. Your renal function category corresponds to the rectangle of the arrow end. 
             If your number is greater than 150 assume it to be 150", strong("(normal)"))
       )
    )
  )
 )

