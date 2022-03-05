#!/usr/bin/env Rscript

options(stringAsfactors = FALSE)
args <- commandArgs(trailingOnly = TRUE)

library(bio3d)

dcdfile <- args[1]
pdbfile <- args[2]

dcd <- read.dcd(dcdfile)
pdb <- read.pdb(pdbfile,hex=TRUE)

method <- args[3]
selection <- args[4]
domain <- args[5]
id <- args[6]
pcid <- as.integer(id)

pdbout <- args[7]


if (selection == "string") {
    inds <- atom.select(pdb, string = domain)
}
if (selection == "elety") {
    inds <- atom.select(pdb, elety = domain)
}
if (selection == "resid") {
    inds <- atom.select(pdb, resid = domain)
}
if (selection == "segid") {
    inds <- atom.select(pdb, segid = domain)
}
xyz <- fit.xyz(fixed = pdb$xyz, mobile =  dcd,
    fixed.inds = inds$xyz, mobile.inds = inds$xyz)

if (method == "FALSE") {
    pc <- pca.xyz(xyz[, inds$xyz], use.svd = FALSE,ncore=8)
}
if (method == "TRUE") {
    pc <- pca.xyz(xyz[, inds$xyz], use.svd = TRUE,ncore=8)
}

mktrj.pca(pc, pc = pcid, b = pc$au[, pcid], file = pdbout)
