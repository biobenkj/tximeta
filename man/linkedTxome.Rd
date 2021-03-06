% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/linkedTxome.R
\name{linkedTxome}
\alias{linkedTxome}
\alias{makeLinkedTxome}
\alias{loadLinkedTxome}
\title{Make and load linked transcriptomes ("linkedTxome")}
\usage{
makeLinkedTxome(
  indexDir,
  source,
  organism,
  release,
  genome,
  fasta,
  gtf,
  write = TRUE,
  jsonFile
)

loadLinkedTxome(jsonFile)
}
\arguments{
\item{indexDir}{the local path to the Salmon index}

\item{source}{the source of transcriptome (e.g. "GENCODE", "Ensembl", "de-novo")}

\item{organism}{organism (e.g. "Homo sapiens")}

\item{release}{release number (e.g. "27")}

\item{genome}{genome (e.g. "GRCh38", or "none")}

\item{fasta}{location(s) for the FASTA transcript sequences
(of which the transcripts used to build the index is equal or a subset).
This can be a local path, or an HTTP or FTP URL}

\item{gtf}{location for the GTF/GFF file
(of which the transcripts used to build the index is equal or a subset).
This can be a local path, or an HTTP or FTP URL
While the \code{fasta} argument can take a vector of length greater than one
(more than one FASTA file containing transcripts used in indexing),
the \code{gtf} argument has to be a single GTF/GFF file. If transcripts
were added to a standard set of reference transcripts (e.g. fusion genes,
or pathogen transcripts), it is recommended that the tximeta user would manually
add these to the GTF/GFF file, and post the modified GTF/GFF publicly, such as
on Zenodo. This enables consistent annotation and downstream annotation
tasks, such as by \code{summarizeToGene}.}

\item{write}{logical, should a JSON file be written out
which documents the transcriptome checksum and metadata? (default is TRUE)}

\item{jsonFile}{the path to the json file for the linkedTxome}
}
\value{
nothing, the function is run for its side effects
}
\description{
For now, for details please see the vignette \code{inst/script/linked.Rmd}
}
\examples{

# point to a Salmon quantification file with an additional artificial transcript
dir <- system.file("extdata/salmon_dm", package="tximportData")
file <- file.path(dir, "SRR1197474.plus", "quant.sf")
coldata <- data.frame(files=file, names="SRR1197474", sample="1",
                      stringsAsFactors=FALSE)

# now point to the Salmon index itself to create a linkedTxome
# as the index will not match a known txome
indexDir <- file.path(dir, "Dm.BDGP6.22.98.plus_salmon-0.14.1")

# point to the source FASTA and GTF:
fastaFTP <- c("ftp://ftp.ensembl.org/pub/release-98/fasta/drosophila_melanogaster/cdna/Drosophila_melanogaster.BDGP6.22.cdna.all.fa.gz",
              "ftp://ftp.ensembl.org/pub/release-98/fasta/drosophila_melanogaster/ncrna/Drosophila_melanogaster.BDGP6.22.ncrna.fa.gz",
              "extra_transcript.fa.gz")
gtfPath <- file.path(dir, "Drosophila_melanogaster.BDGP6.22.98.plus.gtf.gz")

# now create a linkedTxome, linking the Salmon index to its FASTA and GTF sources
makeLinkedTxome(indexDir=indexDir, source="Ensembl", organism="Drosophila melanogaster",
                release="98", genome="BDGP6.22", fasta=fastaFTP, gtf=gtfPath, write=FALSE)

# to clear the entire linkedTxome table
# (don't run unless you want to clear this table!)
# bfcloc <- getTximetaBFC()
# bfc <- BiocFileCache(bfcloc)
# bfcremove(bfc, bfcquery(bfc, "linkedTxomeTbl")$rid)

}
