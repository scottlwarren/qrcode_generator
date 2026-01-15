library(shiny)
library(qrcode)

# Define UI
ui <- fluidPage(
  titlePanel("G4S permanent QR Code generator"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("url_input", "Enter URL:", value = "https://www.g4s.com"),
      actionButton("generate", "Click to generate a unique QR code.", class = "btn-primary"),
      hr(),
      helpText("Click to create QR Code.")
    ),
    
    mainPanel(
      plotOutput("qr_plot", width = "300px", height = "300px")
    )
  )
)


server <- function(input, output) {
  

  qr_data <- eventReactive(input$generate, {
    req(input$url_input) 
    qr_code(input$url_input)
  }, ignoreNULL = TRUE) 
  

  output$qr_plot <- renderPlot({
    plot(qr_data())
  })
}


shinyApp(ui = ui, server = server)
