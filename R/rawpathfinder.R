#' Query rawpathfinder for files/folders raw unix paths.
#'
#' @param query A character vector with names of files/folders.
#' @param protocol Used protocol: http or https.
#' @param ip The ip of the rawpathfinder flask service.
#' @param port The port of the rawpathfinder flask service.
#' @return A data frame with files/folder names maped to unix paths.
#' @importFrom httr POST content
#' @examples
#' \dontrun{
#' query = c("M210903_008_1_1_4704.d",
#'           "M210903_017_1_1_4713.d",
#'           "M210903_026_1_1_4722.d")
#' rawpathfinder(query)
#' }
#' @export
rawpathfinder = function(query,
                         protocol="http",
                         ip="192.168.1.209",
                         port=8958){
  service.url = paste0(protocol, "://", ip, ":", port, "/find")
  res = POST(url = service.url,
             body = list(query=query),
             encode = "json")
  query_res = unlist(content(res))
  query_res = data.frame(pattern=unlist(query_res), unix.path=names(query_res), row.names = NULL)
  query_res = query_res[order(query_res$pattern),]
  rownames(query_res) = NULL
  query_res
}
