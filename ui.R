ui <- fluidPage(
#  theme = "style.css",
  br(),
  fluidRow(style="font-size:small",
    
    column(2,style="background-color: #F2F2F2;",
      checkboxInput("dataOption","More Data Option",value = FALSE),
      conditionalPanel("input.dataOption==1",
      radioButtons("fileSourceType","File:",choices = c("PID List","Local Upload","Enter PID"), selected = "Local Upload")       
      ),
      #ecube list
      conditionalPanel("input.fileSourceType=='PID List'",
        uiOutput("PID_1")
      ),
      conditionalPanel("input.fileSourceType=='Local Upload'",
        fileInput('file1', '',
                  accept=c('text/csv', 
                           'text/comma-separated-values,text/plain', 
                           '.csv'))
      ),
      conditionalPanel("input.fileSourceType=='Enter PID'",
                       
        fluidRow(column(9,textInput("pid_3",NULL,placeholder = "Enter PID Here")),column(3,actionButton("confirmPID","OK",class="btn btn-primary btn-sm",
                                                                                                        style="font-size:98%;height:25px;width:35px")))
      ),
      hr(),
      
      checkboxInput("useFilters","Use Filters",FALSE),
      conditionalPanel("input.useFilters == 1",
        uiOutput("FILTERS"),
        uiOutput("FILTER_GROUP")
      ),
      hr(),
      uiOutput("Y"),
      uiOutput("X"),
      hr(),
      uiOutput("SCATTER_X"),
      uiOutput("SCATTER_Y"),
      hr(),
      uiOutput("FACET_1"),
      uiOutput("FACET_2"),
      hr(),
      uiOutput("LAYER"),
      uiOutput("RED"),
      hr(),
      checkboxInput("attr_use_list","Use pre-defined Attributes", value = FALSE),
      p("")
    ),
    column(10,
           fluidRow(
              column(1,actionButton("ok","Chart !",class = "btn btn-primary btn-xs",style="font-size:98%;height:25px;width:65px")),
              column(2,radioButtons("plotType",NULL,choices = c("ggplot2","plotly"),selected = "ggplot2",inline = TRUE)),
              column(7,textOutput("info"))
           ),
           tabsetPanel(
             tabPanel("Boxplot",
               uiOutput("BOXPLOT"),

               
               fluidRow(column(2,numericInput("boxplot_width","Width",value = 1000, min=100,max = 2000, step = 10)),
                        column(2,numericInput("boxplot_height","Height",value = 400,min=100, max = 1000, step = 10))
                        ),
               #verbatimTextOutput("L"),
               checkboxInput("show_delete_boxplot","Delete Specific Points",value = FALSE),
               conditionalPanel(
                 "input.show_delete_boxplot",
                 uiOutput("BOXPLOT_DELETE")
                 #plotOutput("boxplot_delete",brush = "brush_1")
               ),
#               plotOutput("boxplot_delete",brush = "brush_1"),
               ""
               
             ),
             tabPanel("Scatterplot",
                uiOutput("SCATTER"),
                fluidRow(column(2,numericInput("scatter_width","Width",value = 1000, min=100,max = 2000, step = 10)),
                         column(2,numericInput("scatter_height","Height",value = 400,min=100, max = 1000, step = 10))
                ),
                checkboxInput("show_delete_scatter","Delete Specific Points",value = FALSE),
                conditionalPanel(
                  "input.show_delete_scatter",
                  #plotOutput("scatter_delete", brush = "brush_1", width = 1000, height=400),
                  uiOutput("SCATTER_DELETE")
                ),
                ""      
               
             ),
             tabPanel("CDF",
                      uiOutput("CDF"),
                      fluidRow(column(2,numericInput("cdf_width","Width",value = 1000, min=100,max = 2000, step = 10)),
                               column(2,numericInput("cdf_height","Height",value = 400,min=100, max = 1000, step = 10))
                      ),
                      ""      
                      
             )
           ),
          br(),
           fluidRow(
             column(1,actionButton("delete","Delete",class = "btn btn-primary btn-xs",style="font-size:98%;height:25px;width:85px")),
             column(1,actionButton("reset","Reset",class = "btn btn-primary btn-xs",style="font-size:98%;height:25px;width:85px"))
           ),
          hr(),
          checkboxInput("showDownload","Download File", value = FALSE),
          conditionalPanel("input.showDownload",
                           uiOutput("DOWNLOADLIST"),
                           radioButtons("useSelected",NULL,c("All rows in raw data"=1,"Rows selected by filters"=2)),
                           downloadButton("downloadData","Download",class = "btn btn-primary btn-xs")
                           ),
          br(),br()
    )
  ),

  absolutePanel(
    top = 90, right = 50, width = 300,draggable = TRUE,fixed = TRUE,

    checkboxInput("hint","    ",value = FALSE),

    conditionalPanel("input.hint==1",
                       div( style="font-size:x-small",
                            textOutput("pvalue"),
                            textOutput("pvalue_2"),
                            tableOutput("info_table")

                       )
                     )
  )

  
)
#fluidPage