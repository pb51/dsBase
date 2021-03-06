#' @title tableDS is the first of two serverside aggregate functions
#' called by ds.table
#' @description creates 1-dimensional, 2-dimensional and 3-dimensional
#' tables using the {table} function in native R.
#' @details this serverside function is the workhorse of {ds.table} - creating
#' the table requested in the format specified by {ds.table}. For more
#' information see help for {ds.table} in DataSHIELD and the {table} function
#' in native R.
#' @param rvar.transmit is a character string (in inverted commas) specifiying the
#' name of the variable defining the rows in all of the 2 dimensional
#' tables that form the output. Fully specified by <rvar> argument in {ds.table}.
#' For more information see help for {ds.table}
#' @param cvar.transmit is a character string specifiying the
#' name of the variable defining the columns in all of the 2 dimensional
#' tables that form the output. Fully specified by <cvar> argument in {ds.table}.
#' For more information see help for {ds.table}
#' @param stvar.transmit is a character string specifiying the
#' name of the variable that indexes the separate two dimensional
#' tables in the output if the call specifies a 3 dimensional table.
#' Fully specified by <stvar> argument in {ds.table}.
#' For more information see help for {ds.table}
#' @param exclude.transmit for information see help on <exclude> argument 
#' of {ds.table}. Fully specified by <exclude> argument of {ds.table}
#' @param useNA.transmit for information see help on <useNA> argument 
#' of {ds.table}. Fully specified by <useNA> argument of {ds.table}
#' @param force.nfilter.transmit for information see help on <force.nfilter> argument 
#' of {ds.table}. Fully specified by <force.nfilter> argument of {ds.table}
#' @return For information see help for {ds.table}
#' @author Paul Burton for DataSHIELD Development Team, 13/11/2019
#' @export
tableDS<-function(rvar.transmit, cvar.transmit, stvar.transmit,
                    exclude.transmit, useNA.transmit, force.nfilter.transmit){


#########################################################################
# DataSHIELD MODULE: CAPTURE THE nfilter SETTINGS           			#
thr<-dsBase::listDisclosureSettingsDS() 								#
nfilter.tab<-as.numeric(thr$nfilter.tab)								#
#nfilter.glm<-as.numeric(thr$nfilter.glm)								#
#nfilter.subset<-as.numeric(thr$nfilter.subset)          				#
#nfilter.string<-as.numeric(thr$nfilter.string)              			#
#nfilter.stringShort<-as.numeric(thr$nfilter.stringShort)    			#
#nfilter.kNN<-as.numeric(thr$nfilter.kNN)								#
#datashield.privacyLevel<-as.numeric(thr$datashield.privacyLevel)       #
#########################################################################

#Force higher value of nfilter


if(!is.null(force.nfilter.transmit))
{
force.nfilter.active<-eval(parse(text=force.nfilter.transmit))

	if(force.nfilter.active<nfilter.tab)
	{
	return.message<-paste0("Failed: if force.nfilter is non-null it must be >= to nfilter.tab i.e.",nfilter.tab)  
	return(return.message)
	}
}
else
{
force.nfilter.active<-NULL
}

if(!is.null(force.nfilter.active)&&!is.na(force.nfilter.active)&&force.nfilter.active>nfilter.tab)
{
nfilter.tab<-force.nfilter.active
}



#Activate via eval when needed
#rvar
rvar<-eval(parse(text=rvar.transmit))
if(!is.factor(rvar))
	{
	rvar<-as.factor(rvar)
	}

#cvar
if(!is.null(cvar.transmit))
{
cvar<-eval(parse(text=cvar.transmit))

if(!is.factor(cvar))
	{
	cvar<-as.factor(cvar)
	}
}
else
{
cvar<-NULL
}

#stvar
if(!is.null(stvar.transmit))
{
stvar<-eval(parse(text=stvar.transmit))

if(!is.factor(stvar))
	{
	stvar<-as.factor(stvar)
	}

}
else
{
stvar<-NULL
}



#exclude
if(!is.null(exclude.transmit))
{
exclude.text<-strsplit(exclude.transmit, split=",")
exclude<-eval(parse(text=exclude.text))
}
else
{
exclude<-NULL
}

if(!is.null(rvar)&&!is.null(cvar)&&!is.null(stvar))
{
#Check cell counts valid without NAs or NaNs
counts.valid<-TRUE
test.outobj<-table(rvar,cvar,stvar,exclude="NaN",useNA="no")

numcells<-length(test.outobj)

	for (cell in 1:numcells)
	{ 
		if(test.outobj[cell]>0&&test.outobj[cell]<nfilter.tab)
		{
		counts.valid<-FALSE
		}
	}

	if(!counts.valid)
	{
	return.message<-paste0("Failed: at least one cell has a non-zero count less than nfilter.tab i.e. ",nfilter.tab)  
	return(return.message)
	}else{
	outobj<-table(rvar,cvar,stvar,exclude=exclude,useNA=useNA.transmit)	
	}

}

if(!is.null(rvar)&&!is.null(cvar)&&is.null(stvar))
{
#Check cell counts valid without NAs or NaNs
counts.valid<-TRUE
test.outobj<-table(rvar,cvar,exclude="NaN",useNA="no")

numcells<-length(test.outobj)

	for (cell in 1:numcells)
	{ 
		if(test.outobj[cell]>0&&test.outobj[cell]<nfilter.tab)
		{
		counts.valid<-FALSE
		}
	}

	if(!counts.valid)
	{
	return.message<-paste0("Failed: at least one cell has a non-zero count less than nfilter.tab i.e. ",nfilter.tab)  
	return(return.message)
	}else{
	outobj<-table(rvar,cvar,exclude=exclude,useNA=useNA.transmit)	
	}

}

if(!is.null(rvar)&&is.null(cvar)&&is.null(stvar))
{
#Check cell counts valid without NAs or NaNs
counts.valid<-TRUE
test.outobj<-table(rvar,exclude="NaN",useNA="no")

numcells<-length(test.outobj)

	for (cell in 1:numcells)
	{ 
		if(test.outobj[cell]>0&&test.outobj[cell]<nfilter.tab)
		{
		counts.valid<-FALSE
		}
	}

	if(!counts.valid)
	{
	return.message<-paste0("Failed: at least one cell has a non-zero count less than nfilter.tab i.e. ",nfilter.tab)  
	return(return.message)
	}else{
	outobj<-table(rvar,exclude=exclude,useNA=useNA.transmit)	
	}

}
return(outobj)

}
#AGGREGATE FUNCTION
# tableDS



