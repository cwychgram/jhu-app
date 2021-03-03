tab_101 <- fluidPage(
  fluidRow(
    column(3
    ),
    column(6,
           align = "center",
           span(tags$b("Geography Ticks & You"), style = "color:#000000; font-size:40px; font-family: Arial"), 
    ),
    column(3
    )
  ),
  br(),
  br(),
  fluidRow(
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "left",
           span(tags$b("What are tick-borne diseases?"), style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;"),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  fluidRow(
    column(8,
           br(),
           # style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Tick-borne diseases are spread to humans and dogs through the bite of infected ticks. They fall under the category of vector-borne diseases, which are diseases caused by vectors such as ticks, mosquitoes, and fleas. Not all tick species spread disease. Of those that do, different species spread different diseases, and some spread more than one disease."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "You may have heard of Lyme disease or even know someone who has been affected by it. Lyme disease is the most common vector-borne disease in North America, where the primary bacterium that causes it, Borrelia burgdorferi, is spread to humans through the bite of infected blacklegged ticks. Early symptoms of Lyme disease in humans can include a skin rash, fever, achiness, and fatigue. Timely diagnosis and treatment are important to prevent the infection from spreading to other parts of the body, and to reduce the risk of persistent symptoms after treatment. There is no human vaccine for Lyme disease."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Other tick-borne diseases in the United States and, to some extent, Canada, include babesiosis, ehrlichiosis, anaplasmosis, southern tick-associated rash illness, Rocky Mountain spotted fever, tick-borne relapsing fever, tularemia, and Powassan virus. Tick-borne diseases, including Lyme disease, are found throughout the world.")
    ),
    column(1
    ),
    column(3,
           # br(),
           # img(src = "ixodes-front.jpg", height = "50%", width = "50%", align = "left")
    )
  ),
  br(),
  br(),
  fluidRow(
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "left",
           span(tags$b("Why are tick-borne diseases a public health problem?"), style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;"),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  fluidRow(
    column(8,
           br(),
           # style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Tick-borne diseases are on the rise. Reported cases are increasing, the geographic distribution of some ticks -- including those that spread Lyme disease -- is expanding, and the pace of discovery of new tick-borne pathogens and diseases has accelerated. Recently, scientists have even been trying to understand why bites from Lone Star ticks are causing some people to have severe allergic reactions to red meat!"),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "We do not know the true burden of tick-borne diseases, especially Lyme disease. There is significant underreporting of cases due to the passive nature of the surveillance system, which relies on busy healthcare providers and diagnostic laboratories initiating the reporting of cases to public health agencies. In recent years, Massachusetts, an endemic state for Lyme disease, has stopped spending the time and resources required to report cases to the US Centers for Disease Control and Prevention (CDC). This example underscores the fact that passive surveillance can produce misleading maps as well as gaps in knowledge, because we do not know whether changes in the number of cases are the result of underreporting or something else, such as yearly fluctuations in tick populations or educational interventions."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Using health insurance claims data, CDC has estimated that around 476,000 Americans are diagnosed and treated for Lyme disease each year -- a figure that is more than ten times the number of reported cases! The disease is estimated to cost the US health care system between $712 million and $1.3 billion each year, but this cost burden could be even higher if cases are underestimated."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Although surveillance data give us an incomplete picture of Lyme and other tick-borne diseases -- both in terms of their numbers and their burden to society -- there is a lot that these data tell us. For example, we know that since national surveillance for Lyme disease began in the United States in 1991 (Canada in 2009), reported cases have increased steadily. We also know that although cases are reported year-round, they tend to peak in the late spring and summer months when nymphal ticks (immature ticks that are very small and hard to see on skin) are most active, and people spend more time outdoors. Most importantly, we know that geography matters. Your risk of getting Lyme disease varies depending on where you live or travel."),
    ),
    column(1
    ),
    column(3,

    )
  ),
  br(),
  br(),
  fluidRow(
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "left",
           span(tags$b("What's going on where I live?"), style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;"),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  fluidRow(
    column(8,
           br(),
           fluidRow(
             box(
               status = "success",
               width = 8,
               column(
                 width = 5,
                 fluidRow(
                   selectInput("state_101", 
                               "Select State:", 
                               choices = c(" ", sort(unique(counties$STNAME)))
                   )
                 )
               ),
               column(
                 width = 2
               ),
               column(
                 width = 5,
                 fluidRow(
                   selectInput("county_101", 
                               "Select County:", 
                               choices = NULL
                   )
                 )
               )
             )
           ),
           fluidRow(
             column(7,
                    box(
                      solidHeader = TRUE,
                      status = "success",
                      width = 12,
                      height = 700,
                      title = uiOutput("map_title_101"),
                      leafletOutput("map_101", height = "640px", width = "100%")
                    )
             ),
             column(5,
                    box(
                      solidHeader = TRUE,
                      status = "success",
                      width = 12,
                      height = 350,
                      title = "Plot of Lyme Disease Incidence, 2000-2018",
                      plotOutput("comp_plot", height = "295px", width = "100%")
                    )
             )
           )
    ),
    column(1
    ),
    column(3,
           
    )
  ),
  br(),
  fluidRow(
    column(8,
           align = "left",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "*Incidence is calculated as the number of confirmed and probable cases per 100,000 people."),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  br(),
  br(),
  fluidRow(
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "left",
           span(tags$b("Why does geography matter for tick-borne diseases?"), style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;"),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  fluidRow(
    column(8,
           br(),
           # style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Tick-borne diseases have complex ecologies. Ecology simply means how living things are connected to each other and their physical surroundings. Geography matters in terms of where ticks and their hosts (the animals that they bite) are distributed, how environmental factors such as climate and land cover affect the distribution of both, and how people -- the 'you' in this story -- encounter ticks. All of these are interrelated and affect disease risk in a complex way."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Importantly, different tick species have different geographic distributions, and these distributions can expand over time. Where ticks live strongly depends on a range of factors like tick behavior, host availability, and environmental conditions. These factors in turn influence where cases of disease are reported."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Reported cases of Lyme disease in the US are concentrated in endemic areas in the Northeast, mid-Atlantic, upper Midwest, and West Coast. However, the ticks that spread Lyme disease are expanding their geographic range. As a result, Lyme disease is also expanding geographically, both south into states like North Carolina and Tennessee and north into Canada."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "There is a lot of complexity regarding what is driving the geographic spread of ticks and tick-borne diseases. This makes it difficult to predict for any given year how many cases there will be and where those cases will be."),
    ),
    column(1
    ),
    column(3,
           # br(),
           # img(src = "", height = "50%", width = "50%", align = "left")
    )
  ),
  br(),
  br(),
  fluidRow(
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "left",
           span(tags$b("Why is the geography of tick-borne diseases so complicated?"), style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;"),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  fluidRow(
    column(8,
           br(),
           # style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Ticks have a complex lifecycle that can take up to three years to complete. Most ticks, including the blacklegged tick, have four life stages: egg, larva, nymph, and adult. After hatching, ticks must take a several day-long blood meal at each stage to survive. Blacklegged ticks can feed from mammals, birds, and reptiles, but they require a new host at each stage. During their lifecycle, they have multiple opportunities to become infected, to infect their hosts, and to hitch a ride on their hosts to new areas. Many factors can influence their abundance and infection rate during this time, including landscape features, temperature, rainfall, and host availability. These factors can also determine how different tick species (and even the same species in different geographic areas) behave in seeking out a host."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Predicting geographic variation in the risk of Lyme and other tick-borne diseases is made more challenging by the lack of systematic surveillance of tick populations. This is why scientists are so interested in studying what determines variation in tick abundance and infection across space and time. Two major processes that have been implicated in the geographic spread of tick-borne diseases are land use change, including forest fragmentation, and climate change."),
    ),
    column(1
    ),
    column(3,
           # br(),
           # img(src = "", height = "50%", width = "50%", align = "left")
    )
  ),
  br(),
  br(),
  fluidRow(
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "left",
           span(tags$b("What is forest fragmentation and how does it affect tick-borne disease risk?"), style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;"),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  fluidRow(
    column(8,
           br(),
           # style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Forest fragmentation happens when large, continuous blocks of forest are divided into smaller patches to make space for roads, houses and other buildings, and agriculture. Land use changes in the eastern US over the past several decades have included reforestation of former farmland and forest fragmentation for suburban development."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Wooded and forested areas can support a diversity of animals, but many animals depend on the stable environmental conditions (e.g., temperature, sunlight, and humidity) that undisturbed forest interiors provide. Fragmentation exposes them to less stable 'edge' environments and can reduce their numbers. This loss of diversity reduces the number of predators and competitors of the white-footed mouse, which is the most competent reservoir (or source) for Borrelia burgdorferi, the Lyme disease-causing bacterium. White-footed mice thrive in fragmented forests, where they become the predominant host for ticks in their larval stage. Unlike some other host animals, white-footed mice don’t groom ticks from their bodies. Increasing mice populations can lead to an increased number of ticks and an increased number of infected ticks."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "White-tailed deer also thrive in fragmented forests, especially the transitional area between forest and open, vegetated areas where they like to forage for food. Deer populations have increased over the years as populations of predator animals have been reduced by human activity, deer hunting has declined, and foraging area has expanded due to forest fragmentation. Although deer do not carry Lyme disease, because adult ticks primarily feed on deer, they play an important role in the tick lifecycle and are a determinant of tick abundance in subsequent generations. The movement of deer is also responsible for the spread of ticks into novel areas."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "The ecological interactions taking place in fragmented forests are complicated and understudied, but it is important to know that forest fragmentation brings people into closer contact with areas where ticks may live."),
    ),
    column(1
    ),
    column(3,
           # br(),
           # img(src = "", height = "50%", width = "50%", align = "left")
    )
  ),
  br(),
  br(),
  fluidRow(
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "left",
           span(tags$b("How does climate change affect tick-borne disease risk?"), style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;"),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  fluidRow(
    column(8,
           br(),
           # style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Ticks spend most of their lives in vegetation and leaf litter, where factors such as temperature, precipitation, and humidity can affect their survival and host-seeking behavior. They generally don't do well in extreme environments that are too hot, dry, or cold. But for ticks, their microclimate, or the climate of their very small surrounding area, is also important. Even in adverse conditions such as high temperature and low humidity, ticks can seek refuge in leaf litter where there is more shade and moisture."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Rising temperatures due to climate change are expected to increase the range of favorable habitats for ticks. For example, Lyme disease is already becoming more common in parts of Canada that previously were too cold for blacklegged tick populations to become established. Warmer winter and spring temperatures in the eastern US could also lead to an earlier start to nymphal tick activity and thus an earlier start to the Lyme disease season. Climate change could also affect the distribution of tick host animals, which adds another layer of complexity to the future distribution of ticks."),
    ),
    column(1
    ),
    column(3,
           # br(),
           # img(src = "", height = "50%", width = "50%", align = "left")
    )
  ),
  br(),
  br(),
  fluidRow(
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "left",
           span(tags$b("If the ticks that spread Lyme disease have such a wide geographic distribution, why do most cases occur in just a few states?"), style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;"),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  fluidRow(
    column(8,
           br(),
           # style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "There is a lot of uncertainty and active research about this question. Possible explanations involve geographic differences in host diversity, tick behavior, and human behavior."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "When ticks feed from a variety of available host animals, their chances of becoming infected with Borrelia burgdorferi are lower because only a few animals, like the white-footed mouse, are competent reservoirs for the bacterium. It also means that fewer infected ticks bite people. Geographic variation in the composition of host species could explain why rates of human disease are higher in some locations compared to others."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "There could also be geographic differences in tick behavior. Research suggests that blacklegged ticks in the south selectively feed from lizards such as skinks, which are poor transmitters of Borrelia burgdorferi. Southern ticks tend to remain in the leaf litter when seeking hosts, while their northern counterparts tend to climb onto taller vegetation, increasing their chances of attaching to a passing human or other large mammal. Differences in tick behavior could be associated with climate. Warmer southern temperatures increase the risk of ticks drying out and dying, so ticks may prefer to seek hosts that are nearby in the leaf litter. There is a lot of uncertainty about the impact of climate change on tick behavior. Will rising temperatures in the mid-Atlantic cause ticks in this region to behave more like southern ticks?"),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Tick-borne disease risk also depends on aspects of human behavior, including participation in activities that bring people into contact with ticks and adoption of self-protective measures. Geographic variation in human behavior could also help explain differences between the distribution of ticks and the incidence of human disease."),
    ),
    column(1
    ),
    column(3,
           # br(),
           # img(src = "", height = "50%", width = "50%", align = "left")
    )
  ),
  br(),
  br(),
  fluidRow(
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "left",
           span(tags$b("Where do we go from here?"), style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;"),
           br(),
           br()
    ),
    column(1
    ),
    column(3
    )
  ),
  fluidRow(
    column(8,
           br(),
           # style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "Our mission is to harness and illustrate the power of geography in tick-borne diseases. Our next step is to form collaborative partnerships that will leverage resources and knowledge to close data gaps. We aim to expand our data resources across North America and eventually worldwide and ensure that these resources collectively represent a One Health, trans-disciplinary approach that considers the health of people, animals, and the environment."),
           br(),
           br(),
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "But this story ends with you. What can you do? Whether you are a researcher, clinician, public health practitioner, have a connection to Lyme disease, or are simply curious about tick-borne diseases, our website has resources for you. Our Data Dashboard allows you to explore and download relevant data and maps. Our News & Resources section links to information, research publications, and other resources on tick-borne diseases. We hope that you will spread the word about our website and help us spotlight the relevance of geography to tick-borne diseases. Most importantly, our call to action is for more research and awareness about the growing, but often overlooked, problem of tick-borne diseases."),
    ),
    column(1
    ),
    column(3,
           # br(),
           # img(src = "", height = "50%", width = "50%", align = "left")
    )
  ),
  br(),
  br(),
  br()
)