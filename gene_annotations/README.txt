README



The original code for annotation can be found in the GGR_gene-annotations.ipynb.


***** EXPLANATION OF COLUMNS *******
Gene-table-annot.txt contains annotations for all the genes.
Each column name is of form (annotation type)_(source)
E.g.
GR_direct = GR pathway genes found by Ian's direct candidates list.
Immune_GO = Immune response genes found by GO annotations.
Diabetes_GSEA = Diabetes-related genes found by a search on Broad's Gene Set Enrichment Analysis on  MSigDB.
DEG_edgeR-0.05 = Diff-exp genes found by edgeR (run by Ian) at fdr 0.05 

GR, Immune, and Metabolism also have columns as, e.g.:
"GR_union" = union of all GR-annotated genes
"GR_intersection" = intersection of all GR-annotated genes



********ORIGINAL DATA DOCUMENTATION ***********


The format is:

# Data type
relevant_file.txt
original_file
url/how this was found
Other notes

---

# Transcription-Factor binding genes, BioGuo
Homo_sapiens_TF_EnsemblID.txt
Homo_sapiens_TF_EnsemblID-truncated.txt
http://www.bioguo.org/AnimalTFDB/download/Homo_sapiens_TF_EnsemblID.txt
12/9/16



# Transcription-Factor binding genes, GO
GO_TF-binding_GO:0008134.txt
goa_human.gaf
GO annotation: TF binding, 0008134


# GR Pathway Genes: GO 
GO_GR-Pathway_GO/0042921.txt
GO/0042921-download.txt
http://amigo.geneontology.org/amigo/term/GO:0042921, 
GO: 0042921, download human associated
Molecular signals from glucocorticoid binding to receptor
Total: 21 genes in human
8/26/16


# GR Pathway genes, GSEA
GSEA_GR-pathway-genes.txt
GSEA_GR-pathway.xml
Broad’s Gene Set Enrichment Analysis  http://software.broadinstitute.org/gsea/msigdb/search.jsp 
Among C2: Canonical, KEGG, BIOCARTA, Reactome pathways, search:
glucocorticoid, and choose the one that says PID_REG (curated by Nature, NCI)
8/26/16


# GR Pathway Genes: Direct candidates
GR_direct_candidates.txt
These were curated by Ian. Procedure:
Genes: up-regulated
0.5, 1, 2hrs dex 
10 kb from GR binding site
Includes pos. controls: DUSP1, PER1
Total: 111 genes

# Differential Expression
sig_genes_reg_fdr-(0.01, 0.05, 0.1, 0.2)-all-ensg.txt
From Ian's DEG bed files
All timepoints compared to basal expression (t0)


# Immune Genes, GOC
Immune-GOC-Priority.txt
This is a looser list of genes possibly associated with Immune response.
Gene Ontology Consortium’s curated list, http://wiki.geneontology.org/index.php/Immunologically_Important_Genes_Listed_by_Priority_Score, 7/25/16
1325 genes
Combined 4 databases, inflammatory stimulus, Mouse Genome Informatics, OMIM, GO
Processing in Immune-GOC-Priority/
7/29/16


# Immune Genes, GO
GO_Immune_GO/0002376.txt
http://www.geneontology.org/gene-associations/goa_human_gaf.gz
GO annotation: Immune Response GO:0002376
8/26/16

# Immune Genes, GSEA
GSEA_immune-response-genes.txt
GSEA_immune-response.xml
Broad GSEA, http://software.broadinstitute.org/gsea/msigdb/search.jsp
Among Canonical, KEGG, BIOCARTA, Reactome pathways, search:
immune AND response
See "summary.txt" for the original gene sets from the search.
8/26/16



# Carbohydrate Metabolic Genes, GO
GO_Carb-metab_GO/0005975.txt
goa_human.gaf
GO annotation: Carb. metabolism, GO:0005975
8/26/16

# Glucose Metabolic Genes, GSEA
GSEA_glucose-metabolism-genes.txt
GSEA_glucose-metabolism.xml
Broad’s Gene Set Enrichment Analysis  http://software.broadinstitute.org/gsea/msigdb/search.jsp 7/29/16
Among Canonical, KEGG, BIOCARTA, Reactome pathways, search:
gluconeogensis OR (glucose AND metabolism) OR glycolysis
See "GSEA_glucose-metabolism.summary.txt" for the original gene sets from the search.


# Lipid Metabolic Genes, GSEA
GSEA_lipid-metabolism-genes.txt
GSEA_lipid-metabolism.xml
Broad’s Gene Set Enrichment Analysis  http://software.broadinstitute.org/gsea/msigdb/search.jsp 7/29/16
Among Canonical, KEGG, BIOCARTA, Reactome pathways, search:
lipid AND metabolism
See "GSEA_lipid-metabolism.txt" for the original pathways.



# Diabetes genes, GSEA
GSEA_diabetes-genes.txt
GSEA_diabetes.xml
Broad’s Gene Set Enrichment Analysis  http://software.broadinstitute.org/gsea/msigdb/search.jsp 7/29/16
Among Canonical, KEGG, BIOCARTA, Reactome pathways, search:
Diabetes
See "GSEA_diabetes.txt" for the original pathways.

# Obesity genes, GSEA
GSEA_obesity-genes.txt
GSEA_obesity.xml
Broad's Gene Set Enrichment Analysis http://software.broadinstitute.org/gsea/msigdb/search.jsp 12/27/16Among Canonical, KEGG, BIOCARTA, Reactome pathways, search:
Obesity
See "GSEA_obesity.txt" for the original pathways.



# DNA-binding genes, GO
GO_DNA-binding_GO/0003677.txt
goa_human.gaf
GO annotation: DNA binding, GO:0003677
8/26/16

# Chromosome-organisation genes, GO
GO_Chrom-org_GO:0007001-GO:0051277-GO:0051276.txt
goa_human.gaf
GO annotation: Chromosome organization, matches synonyms: 0007001, 0051277, 0051276

# Histone-binding genes, GO
GO_Hist-binding_GO:0042393.txt
goa_human.gaf
GO annotation: Histone binding, 00042393
