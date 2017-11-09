# tximeta: Import transcript quantification with automagic generation of metadata

# Idea in diagrams

Before `tximeta`, current versions of Salmon and Sailfish already 
propogate a *signature* of the transcriptome sequence into the index
and quantification directories. This can be diagrammed like so, where 
the dotted lines represent not direct links, but possible comparisons
that could be made based on signature.

![](img/quant.png)

Following quantification, and even performed by a different analyst or 
at a different institute, when importing quantifications into 
R/Bioconductor, the `tximeta` software would check a database of known 
signatures, and upon finding a match, would add annotation and metadata
to the quantifications, returning a `SummarizedExperiment` object.

![](img/tximeta.png)

# Idea in text

`tximeta` performs numerous annotation and metadata gathering tasks on
behalf of users during the import of transcript quantifications from
Salmon or Sailfish into R/Bioconductor. The goal is to provide
something similar to the experience of `GEOquery`, which downloaded
microarray expression data from NCBI GEO and simultaneously brought
along associated pieces of metadata. Doing this automatically helps to
prevent costly bioinformatic errors. To use `tximeta`, all one needs
is the `quant` directory output from Salmon (version >= 0.8.1) or
Sailfish. 

The key idea within `tximeta` is to store a *signature* of
the transcriptome sequence itself using a hash function, computed and
stored by the `index` and `quant` functions of Salmon and
Sailfish. This signature acts as the identifying information for later
building out rich annotations and metadata in the background, on
behalf of the user. This should greatly facilitate genomic workflows,
where the user can immediately begin overlapping their transcriptomic
data with other genomic datasets, e.g. epigenetic tracks such as ChIP
or methylation, as the data has been embedded within an organism and
genome context, including the proper genome version. We seek to
reduce wasted time of bioinformatic analysts, prevent costly
bioinformatic mistakes, and promote computational reproducibility by
avoiding situations of annotation and metadata ambiguity, when files
are shared publicly or among collaborators but critical details go
missing.
	
# This package is in beta 

Expect that this package will change a lot in the coming months. This
is a prototype for how automatic generation of transcriptome metadata
from a transcriptome sequence signature might work.  Note that, as it
is only a prototype, `tximeta` currently supports only the past 5
releases for Gencode (CHR: reference chromosomes only) and Ensembl
(`cdna.all`), for human and mouse. The long term goal will be to
automate signature generation for as many transcriptomes as possible,
including different versions, sources, organisms, etc.

In addition, we are very interested in solving problem cases for this
approach, such as 
[derived transcriptomes](https://github.com/mikelove/tximeta/issues/2)
(e.g. filtered, or edited after downloading from source) and de novo
transcriptomes, such as those generated by StringTie, Trinity,
Scripture, Oases, etc.
We hope that for both of these cases `tximeta` might help to assist in
computational reproducibility of quantification, by encapsulating the
steps need to generate the transcriptome and providing a signature for
checking the sequence is indeed the same.

# Feasability

We plan to progammatically download and hash the cDNA sequence of as
many transcriptomes as possible. Ideally, we could partner with
owners of transcriptome sources and produce cDNA sequence hashes
without downloading, although the download speed is not
prohibitive. Downloading a human transcriptome from GENCODE takes ~5
seconds with a download speed of ~10MB/s, unzipping takes ~1 second,
and hashing the cDNA sequence (excluding sequence names) with
`compute_fasta_digest` takes ~3 seconds. Therefore filling out a
table linking the hash values to metadata for the 5 GENCODE human
transcriptome releases from 2015-2017 can be accomplished in less than
a minute.

# Take a look at the example

We have a [prototype vignette](https://github.com/mikelove/tximeta/blob/master/inst/script/tximeta.knit.md)
for how `tximeta` would look, and some thoughts on next steps at the
end of the document.

# Feedback

We'd love to hear your feedback. Please file an 
[Issue on GitHub](https://github.com/mikelove/tximeta/issues).
