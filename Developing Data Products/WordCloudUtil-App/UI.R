library(shiny)
library(rCharts)

# The initial idea is based in:
# http://shiny.rstudio.com/gallery/word-cloud.html

fluidPage(
  # Application title
  titlePanel("Word Cloud Util"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      # Text input for the App.
      textInput("text", label = h3("Input"), 
                value = "Introduce any text or URL"),
      actionButton("update", "Change"),
      hr(),
      # Both sliders for Frw. and Max. words
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 50, value = 1),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 300,  value = 100)
    ),
    mainPanel(
      tabsetPanel(
        # Main panel for the Word Clod
        tabPanel('Word Cloud',
           # Word Clod plot with id plot1
           plotOutput("plot1"),
           h4('R console'),
           # Language sentence introduced in the text input
           verbatimTextOutput("languageInput"),
           # Language Output provided by textcat package
           verbatimTextOutput("languageOutput")),
        # Top 10 panel for the top ten words
        tabPanel('Top 10',
           # Bar chart for the top ten words id plot2
           showOutput("plot2","highcharts")),
        # Help panel
        tabPanel('Help',
           # HTML Text
           h3('User Manual'),
           hr(),
           p("Word Cloud Util is a simple application for word count visualization 
           and language detection."),
           p("This application is based in the original example", 
             a("Shiny Word Cloud", 
               href = "http://shiny.rstudio.com/gallery/word-cloud.html"), 
              ". An application for visual representation of the words that make 
              up a text, where the size is greater for words that appear more 
              frequently."),
           br(),
           h4('Introduction'),
           p("The application has been separated in three different tabs:"),
           tags$li( "Word Cloud: Shows the Word Cloud."),
           tags$li( "Top 10: Shows the top ten word by frequency."),
           tags$li( "Help: Shows the present help."),
           br(),
           h5("Word Cloud use"),
           p("The user is required to enter a text or a URL in the Input box, for 
             example:"),
           tags$li( "Text example: Hello. My name is Inigo Montoya. You killed 
                    my father. Prepare to die."),
           tags$li( "URL example: http://www.example.com/ or https://www.example.com/"),
           br(),
           p("Each time that a new sentence is introduced the button Change needs 
             to be press, at least once. For URL the application needs some time
             to process all the words."),
           br(),
           p("Moreover can be selected also the Minimum Frequency of word, so 
            those words with less frequency than the wan chosen will not be 
            shown; and Maximum Number of Words shown in the word cloud."),
           br(),
           h6("NOTE: Minimum Frequency and Maximum Number of Word ",
              tags$b("do only act"), 
              "if is possible to show results, otherwise it will be ignored"),
           br(),
           h5("Top 10"),
           p("Given the text introduced in the Text Input area the bar chart 
            shows the top ten word selected by frequency.")
        )
      )
    )
  )
)