# Transparent programme monitoring: verified delivery requires dated documentary proof.
valid_statuses <- c("proposed", "funding_requested", "scheduled_unverified",
                    "implementation_reported_unverified", "completed_verified")
required_columns <- c("activity_id", "year", "quarter", "theme", "activity",
                      "status", "completed_on", "evidence_locator", "source_label")

validate_activity_register <- function(x) {
  if (!is.data.frame(x)) stop("Expected a data.frame")
  missing <- setdiff(required_columns, colnames(x))
  if (length(missing) > 0) stop(paste("Missing fields:", paste(missing, collapse = ", ")))
  if (anyNA(x[, required_columns])) stop("Missing fields should be empty strings, not NA")
  if (any(!nzchar(trimws(x$activity_id)))) stop("activity_id must not be empty")
  if (anyDuplicated(x$activity_id)) stop("Every activity_id must be unique")
  if (any(!(x$status %in% valid_statuses))) stop("Invalid documented status")
  if (any(!(x$quarter %in% paste0("Q", 1:4)))) stop("Quarter must be Q1..Q4")
  if (any(!grepl("^20[0-9]{2}$", as.character(x$year)))) stop("Bad year")
  done <- x$status == "completed_verified"
  if (any(done & !nzchar(trimws(x$completed_on)))) stop("Completed activity requires date")
  if (any(done & !nzchar(trimws(x$evidence_locator)))) stop("Completed activity requires evidence locator")
  if (any(done & !grepl("^20[0-9]{2}-[0-9]{2}-[0-9]{2}$", x$completed_on))) {
    stop("Completion date must be ISO date YYYY-MM-DD")
  }
  if (anyNA(as.Date(x$completed_on[done], format = "%Y-%m-%d"))) {
    stop("Completion date is not valid")
  }
  invisible(TRUE)
}

read_register <- function(path) {
  x <- utils::read.csv(path, stringsAsFactors = FALSE, na.strings = NULL,
                       colClasses = "character", check.names = FALSE)
  validate_activity_register(x)
  x
}

quarter_summary <- function(x) {
  validate_activity_register(x)
  if (nrow(x) == 0) {
    return(data.frame(year = character(), quarter = character(),
                      registered_activities = integer(),
                      verified_completions_in_register = integer(),
                      pending_evidence = integer(),stringsAsFactors=FALSE))
  }
  groups <- unique(x[c("year","quarter")]); groups <- groups[order(groups$year, groups$quarter),]
  out <- do.call(rbind,lapply(seq_len(nrow(groups)), function(i) {
    g <- groups[i,]; r <- x[x$year == g$year & x$quarter == g$quarter, ]
    data.frame(year = g$year, quarter = g$quarter,
               registered_activities = nrow(r),
               verified_completions_in_register = sum(r$status == "completed_verified"),
               pending_evidence = sum(r$status %in% c("scheduled_unverified","implementation_reported_unverified")),
               stringsAsFactors = FALSE)
  }))
  rownames(out) <- NULL
  out
}

status_summary <- function(x) {
  validate_activity_register(x)
  out <- data.frame(status = valid_statuses,
                    records_in_supplied_register = as.integer(table(factor(x$status,levels=valid_statuses))))
  out
}

theme_summary <- function(x) {
  validate_activity_register(x)
  if (nrow(x) == 0) return(data.frame(theme=character(),records=integer()))
  z <- aggregate(rep.int(1L,nrow(x)), list(theme=x$theme), sum)
  names(z)[2] <- "records"
  z[order(z$theme),]
}
