% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/asIntegerDS.R
\name{asIntegerDS}
\alias{asIntegerDS}
\title{Coerces an R object into class integer}
\usage{
asIntegerDS(x.name)
}
\arguments{
\item{x.name}{the name of the input object to be coerced to class
integer. Must be specified in inverted commas. But this argument is
usually specified directly by <x.name> argument of the clientside function
{ds.asInteger}}
}
\value{
the object specified by the <newobj> argument (or its default name
<x.name>.int) which is written to the serverside. For further
details see help on the clientside function {ds.asInteger}
}
\description{
this function is based on the native R function {as.integer}
}
\details{
See help for function {as.integer} in native R
}
\author{
Amadou Gaye, Paul Burton for DataSHIELD Development Team
}
