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
  query_res = content(res)
  data.frame(file=names(query_res), unix.path=unlist(query_res))
}



# query = c("M210903_008_1_1_4704.d",
#           "M210903_017_1_1_4713.d",
#           "M210903_026_1_1_4722.d",
#           "M210903_035_1_1_4731.d",
#           "M210903_044_1_1_4740.d",
#           "M210903_053_1_1_4749.d",
#           "M210903_063_1_1_4759.d",
#           "M210903_072_1_1_4768.d",
#           "M210903_081_1_1_4777.d",
#           "M210903_090_1_1_4786.d",
#           "M210903_099_1_1_4795.d",
#           "M210903_108_1_1_4804.d")
#
# rawpathfinder(query[1:4])
