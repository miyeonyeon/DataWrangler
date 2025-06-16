#' mRNA expression transformation
#'
#' @param FCmat fragment count (raw gene expression). a the number of genes x (1+the number of samples) matrix having merged_kb in the first column.
#' @return FPKM and TPM normalized matrices
#' @references https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline
#' @export

FCtrans = function(FCmat) {

  # FPKM normalization
  ScalingFactor <- matrix(apply(FCmat[,-1],2,sum)/10^6, 1, ncol(FCmat[,-1]))
  merged_kb <- FCmat$merged_kb

  SFmat <- repmat(ScalingFactor, nrow(FCmat), 1)
  FCmat1 <- FCmat[,-1]/SFmat
  FCmat_FPKM <- FCmat1/repmat(matrix(merged_kb,nrow(FCmat),1),1,ncol(FCmat1))

  # TPM normalization
  deno <- repmat(matrix(apply(FCmat_FPKM,2,sum),1,ncol(FCmat_FPKM)), nrow(FCmat_FPKM), 1)
  FCmat_TPM <- (FCmat_FPKM/deno)*10^6

  return(list(FPKM=FCmat_FPKM, TPM=FCmat_TPM))
}
