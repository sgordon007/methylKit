% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/methSeg.R
\docType{methods}
\name{methSeg}
\alias{methSeg}
\title{Segment methylation or differential methylation profile}
\usage{
methSeg(obj, diagnostic.plot = TRUE, ...)
}
\arguments{
\item{obj}{\code{\link[GenomicRanges]{GRanges}}, \code{\link{methylDiff}}, 
\code{\link{methylDiffDB}},
           \code{\link{methylRaw}} or \code{\link{methylRawDB}} . If the object is a 
           \code{\link[GenomicRanges]{GRanges}}
            it should have one meta column with methylation scores}

\item{diagnostic.plot}{if TRUE a diagnostic plot is plotted. The plot shows
methylation and length statistics per segment group. In addition, it 
shows diagnostics from mixture modeling: the density function estimated 
and BIC criterion used to decide the optimum number of components
in mixture modeling.}

\item{...}{arguments to \code{\link[fastseg]{fastseg}} function in fastseg 
package, or to \code{\link[mclust]{densityMclust}}
       in Mclust package, could be used to fine tune the segmentation algorithm.
       E.g. Increasing "alpha" will give more segments. 
       Increasing "cyberWeight" will give also more segments."maxInt" controls
       the segment extension around a breakpoint. "minSeg" controls the minimum
       segment length. "G" argument
       denotes number of components used in BIC selection in mixture modeling.
       For more details see fastseg and Mclust documentation.}
}
\value{
A \code{\link[GenomicRanges]{GRanges}} object with segment 
        classification and information. 
       'seg.mean' column shows the mean methylation per segment.
       'seg.group' column shows the segment groups obtained by mixture modeling
}
\description{
The function uses a segmentation algorithm (\code{\link[fastseg]{fastseg}}) 
to segment the methylation profiles. Following that, it uses
gaussian mixture modelling to cluster the segments into k components. This process
uses mean methylation value of each segment in the modeling phase. Each
component ideally indicates quantitative classification of segments, such
as high or low methylated regions.
}
\details{
To be sure that the algorithm will work on your data, 
       the object should have at least 5000 records
}
\examples{

\donttest{
 download.file("https://dl.dropboxusercontent.com/u/1373164/H1.chr21.chr22.rds",
               destfile="H1.chr21.chr22.rds",method="curl")

 mbw=readRDS("H1.chr21.chr22.rds")

 # it finds the optimal number of componets as 6
 res=methSeg(mbw,diagnostic.plot=TRUE,maxInt=100,minSeg=10)

 # however the BIC stabilizes after 4, we can also try 4 componets
 res=methSeg(mbw,diagnostic.plot=TRUE,maxInt=100,minSeg=10,G=1:4)

 # get segments to BED file
 methSeg2bed(res,filename="H1.chr21.chr22.trial.seg.bed")
}

unlink(list.files(pattern="H1.chr21.chr22",full.names=TRUE))

}
\seealso{
\code{\link{methSeg2bed}}
}
\author{
Altuna Akalin, contributions by Arsene Wabo
}
