library(shiny)
library(tm)
library(wordcloud)
library(rCharts)
library(rvest)
library(textcat)

# The initial idea is based in:
# http://shiny.rstudio.com/gallery/word-cloud.html

function(input, output, session) {
  # Define a reactive expression for the document term matrix
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        modText(input$text)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  # Output for the sentence
  output$languageInput <- renderPrint({
    input$update
    isolate(input$text)
  })
  
  # Output for the lenguage detected
  output$languageOutput<-renderText({
    input$update
    # Verify if an URL was introduced
    if (substr(input$text,1:4,4) == "http") {
      # Receive a list of possible languages from the homepage text
      languages <- textcat(htmlText(input$text))
      # Convert it to a table and dataframe so it can be sorted
      tableLanguages <- as.data.frame(table(languages))
      # Select the most freq. language and "deduce" that this is the main 
      # language in the homepage
      lang <- as.character(tableLanguages[order(-tableLanguages$Freq),][1,1])
      isolate(lang)
    } else {
      isolate(textcat(input$text))
    }
  })

  # Output plot for the Word Cloud
  output$plot1 <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Paired"))
  })
  
  # Output bar chart for the top 10 words
  output$plot2 <- renderChart({
    input$update
    # Retrun a matrix converted to datafram so it can be sorted
    isolate(textForChart<-as.data.frame(modText(input$text)))
    isolate(textForChart$names <- rownames(textForChart))
    isolate(names(textForChart) <- c('count','words'))
    isolate(sortedText <- textForChart[order(-textForChart$count),])
    # Obtain just the top 10 words
    isolate(textForChartTop10 <- head(sortedText,10))
    hp1 <- hPlot(x = 'words', y = 'count', data = textForChartTop10, type = 'bar')
    hp1$addParams(dom ='plot2')
    return(hp1)
  })
  # This metod return the text for the specified html tags
  htmlText <- function(text) {
    htmlpage <- read_html(text)
    htmltext <- html_nodes(htmlpage,'a, p, b, i, h1, h2, h3, h4, h5')
    finaltext <- html_text(htmltext)
  } 
  # This method fix the text and return a sorted matrix
  modText <- function(text) {
    if (substr(text,1:4,4) == "http") {
      finaltext <- htmlText(text)
      # Obtain the text in case an URL was introduced and call medText recursively
      modText(finaltext)
    } else {
      myCorpus = Corpus(VectorSource(text))
      # all text to lower case
      myCorpus = tm_map(myCorpus, content_transformer(tolower))
      # remove puntuation
      myCorpus = tm_map(myCorpus, removePunctuation)
      # remove numbers
      myCorpus = tm_map(myCorpus, removeNumbers)
      
      myDTM = TermDocumentMatrix(myCorpus, control = list(minWordLength = 1))
      
      m = as.matrix(myDTM)
      #sort the text
      sort(rowSums(m), decreasing = TRUE)
    }
  }
}


