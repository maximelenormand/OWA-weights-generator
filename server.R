library(shiny)

source("owg.R")

options(scipen=999)

shinyServer( function(input, output) {
  
    #Upper-bound sd_w
    maxsdw=(1/(2*sqrt(3)))
    
    #Warning if inconsistent level of risk and trade-off
    suit=reactive({
      suit=TRUE
      if(input$tradeoff > (4*input$risk*(1-input$risk))){
        suit=FALSE
      }
      suit
    })  
    
    #Run the optimization process
    val=reactive({
      val=inv.moment.tnorm(input$risk,input$tradeoff*maxsdw)  
    })
    
    #Discretize weight distribution
    tab=reactive({
      tab=as.numeric(owg(input$nb_cri,input$risk,input$tradeoff,warn=FALSE))  
    })
   
    #Plot
    output$f_w <- renderPlot({
      
      #Default values 
      colo="steelblue"   #color blue if ok
      estrisk=NA         #Estimated risk value   
      esttrad=NA         #Estimated trade-off value  
      orness=NA          #Orness of w 
      andness=NA         #Andness of w  
      disp=NA            #Disp of w 
      trad=NA            #Tradeoff of w 
      
      #IF delta_w > 0 (i.e. standard deviation > 0)
      if(input$tradeoff>0){
        
        #Oprimisation process
        val=val()
        
        #Update values
        estrisk=val$estmuw
        esttrad=val$estsdw/maxsdw
        ness=orandness(tab())
        orness=ness$orness
        andness=ness$andness
        trad=tradeoff(tab())
        disp=trad$disp
        trad=trad$trad
        
        #If not suitable solution found then RED
        if(!suit()){
          colo="#CC6666"
        }
        
        #Particular case when sd is negative
        if(val$sd<0){
          colo="white"
        }

        #Plot fw
        x=seq(-1,2,0.0001)
        y=dtruncnorm(x,a=0,b=1,mean=val$mu,sd=val$sd)
    
        par(mar=c(5,6,0.5,15))
        plot(x,y,type="l",xlim=c(-0.25,1.25), axes=FALSE, xlab="", ylab="", col=colo, lwd=4)
        polygon(x, y, col = alpha(colo, 0.5), border=alpha(colo, 0.5))
        axis(1, cex.axis=1.5)
        axis(2, cex.axis=1.5, las=2)
        mtext("Order weights", 1, cex=2, line=3.5)
        mtext("PDF", 2, cex=2, line=3)
        box(lwd=1.5)
      
      #ELSE  
      }else{
        
        #Update values
        estrisk=input$risk
        esttrad=input$tradeoff
        ness=orandness(tab())
        orness=ness$orness
        andness=ness$andness
        trad=tradeoff(tab())
        disp=trad$disp
        trad=trad$trad
        
        #Plot fw as Dirac delta function
        x=seq(-1,2,0.0001)
        y=rep(0,length(x))
        y[10001+10000*input$risk]=1
        
        par(mar=c(5,6,0.5,15))
        plot(x,y,type="l",xlim=c(-0.25,1.25), axes=FALSE, xlab="", ylab="", col=colo, lwd=4)
        axis(1, cex.axis=1.5)
        axis(2, cex.axis=1.5, las=2)
        mtext("Order weights", 1, cex=2, line=3.5)
        mtext("PDF", 2, cex=2, line=3)
        box(lwd=1.5)
        
      }
      
      #Legend to display the values
      legend("right", 
             legend=c(as.expression(bquote(Risk == .(round(estrisk,digits=3)))),
                      as.expression(bquote(Tradeoff == .(round(esttrad,digits=3)))),
                      "",
                      as.expression(bquote(orness == .(round(orness,digits=3)))),
                      as.expression(bquote(andness == .(round(andness,digits=3)))),
                      as.expression(bquote(Disp == .(round(disp,digits=3)))),
                      as.expression(bquote(trad == .(round(trad,digits=3))))),
             xpd=NA,
             inset=c(-0.35,0),
             bty="n",
             cex=2,
             text.col=colo,
             text.font=2)
    
  })
  
  #Warning if no suitable solution found (in RED) 
  output$warning = renderText({
    
    wrn=""
    
    if(input$tradeoff>0){
      
      val=val()
      if(!suit()){
        wrn=paste("<font size=4pt; color=\"#CC6666\"><b>Warning! No suitable PDF found for these risk and trade-off values</b></font>")
      }else{
        wrn=paste("<font size=4pt; color=\"#fffffff\"><b>Warning! No suitable PDF found for these values of risk and trade-off</b></font>")
      }

    }
    
    wrn
    
  })
  
  #Display table (cut if n>=16)
  output$table = renderTable({
    tab=tab() #OWA weights
    tab=data.frame(t(cbind(tab,tab)))
    colnames(tab)=paste("W_",1:length(tab),sep="")
    if(dim(tab)[2]>=16){
      tab=tab[,1:16]
      tab[1,16]="..."
      colnames(tab)[16]="..."
    }
    tab[1,]
  })
  
  #Link to download the table of OWA weights
  output$download_w <- downloadHandler(
     filename = function() {
       paste('OWA_Weights','.csv', sep='')
     },
     content = function(file) {
       tab=tab()
       tab=data.frame(ID=paste("W_",1:length(tab),sep=""),Weights=tab)
       #tab$Weights=format(tab$Weights, scientific=FALSE)
       write.csv2(tab, file, row.names=FALSE)
     }
   )
  
  #Parabolic decision-strategy space
  output$para <- renderPlot({
    
      #Color blue if ok 
      colo="steelblue"   
     
      #If not suitable solution found then RED
      if(!suit()){
        colo="#CC6666"
      }
     
      #Parabole
      x=seq(0,1,0.001)
      y=-4*x^2+4*x
    
      #Plot
      par(mar=c(5,5.5,1,1))
      plot(x,y,type="l",lwd=4,col="black",axes=FALSE,xlab="",ylab="", xlim=c(0,1), ylim=c(0,1))
      axis(1, cex.axis=1.5)
      axis(2, cex.axis=1.5, las=2)
      mtext("Risk", 1, cex=2, line=3.5)
      mtext("Tradeoff", 2, cex=2, line=3.5)
      box(lwd=1.5) 
      
      points(input$risk, input$tradeoff, col=colo, pch=16, cex=1.5)

  })
  
})