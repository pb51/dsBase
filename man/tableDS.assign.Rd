% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tableDS.assign.R
\name{tableDS.assign}
\alias{tableDS.assign}
\title{tableDS.assign is the serverside assign function
called by ds.table}
\usage{
tableDS.assign(
  rvar.transmit,
  cvar.transmit,
  stvar.transmit,
  exclude.transmit,
  useNA.transmit
)
}
\arguments{
\item{rvar.transmit}{is a character string (in inverted commas) specifiying the
name of the variable defining the rows in all of the 2 dimensional
tables that form the output. Fully specified by <rvar> argument in {ds.table}.
For more information see help for {ds.table}}

\item{cvar.transmit}{is a character string specifiying the
name of the variable defining the columns in all of the 2 dimensional
tables that form the output. Fully specified by <cvar> argument in {ds.table}.
For more information see help for {ds.table}}

\item{stvar.transmit}{is a character string specifiying the
name of the variable that indexes the separate two dimensional
tables in the output if the call specifies a 3 dimensional table.
Fully specified by <stvar> argument in {ds.table}.
For more information see help for {ds.table}}

\item{exclude.transmit}{for information see help on <exclude> argument 
of {ds.table}. Fully specified by <exclude> argument of {ds.table}}

\item{useNA.transmit}{for information see help on <useNA> argument 
of {ds.table}. Fully specified by <useNA> argument of {ds.table}}
}
\value{
For information see help for {ds.table}
}
\description{
helps creates 1-dimensional, 2-dimensional and 3-dimensional
tables using the {table} function in native R.
}
\details{
If the <table.assign> argument of {ds.table} is set to TRUE,
this assign function writes the
the table requested in the format specified by {ds.table} function
as an object named by the <newobj> argument of {ds.table}. For more
information see help for {ds.table} in DataSHIELD and the {table} function
in native R.
}
\author{
Paul Burton for DataSHIELD Development Team, 13/11/2019
}
