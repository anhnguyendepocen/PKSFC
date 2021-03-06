#' Create a summary of an sfc object
#'  
#' @param object The sfc object to be summarised
#' @param ... optional parameters to be passed to function
#' @return A summary of the sfc object
#' 
#' @author Antoine Godin
#' @export

summary.sfc<-function(object,...){
  result<-paste("Model:",object$name)
  if(is.null(object$blocks)){
    if(is.null(object$equations)){
      result<-paste("\nThe model doesn't have equations yet")
    }else{
      result<-paste(result,"\nEquations:",sep="")
      for(j in 1:length(object$equations)){
        result<-paste(result,"\n",object$equations[j,1],"=",object$equations[j,2],"#",object$equations[j,3])
      }
    }
  }else{
    result<-paste(result,"\nEquations:",sep="")
    for(j in 1:length(object$blocks)){
      result<-paste(result,"\nBlock: ",j,sep="")
      for(i in 1:length(object$blocks[[j]])){
        index<-object$blocks[[j]][i]
        result<-paste(result,"\n",object$equations[index,1],"=",object$equations[index,2],"#",object$equations[index,3])
      }
    }
  }
  if(is.null(object$endog)){
    result<-paste("\nThe model doesn't have endogenous variables yet")
  }else{
    result<-paste(result,"\nInitial Values:")
    for(i in 1:length(object$endog[,1])){
      result<-paste(result,"\n",object$endog[i,1],"=",object$endog[i,2],"#",object$endog[i,4])
    }
  }
  if(is.null(object$variables)){
    result<-paste("\nThe model doesn't have exogenous variables yet")
  }else{
    result<-paste(result,"\nExogenous Values:")
    for(i in 1:length(object$variables[,1])){
      if(length(which(object$endog==object$variables[i,1]))==0){
        result<-paste(result,"\n",object$variables[i,1],"=",object$variables[i,2],"#",object$variables[i,3])
      }
    }
  }
  class(result)<-"summary.sfc"
  result
}
