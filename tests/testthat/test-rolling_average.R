library(incidence2)

context("rolling_average")

dates <- Sys.Date() + 1:10
groups <- sample(letters[1:3], length(dates), replace = TRUE)
dat <- data.frame(dates, groups)
x <- incidence(dat, date_index = "dates", groups = groups)

test_that("rolling_average adds class", {
  expected <- c("incidence2_ra", class(x))
  expect_identical(class(add_rolling_average(x)), expected)
})

dates <- rep(c(Sys.Date() + 1:4, Sys.Date() + 4), 3)
groups <- rep(paste0("groups", 1:3), each = 5)

dat <- data.frame(dates, groups)
x <- incidence(dat, date_index = "dates", groups = groups)
ra <- add_rolling_average(x)

test_that("rolling_average works as expected", {
  expected <- expected <- rep(c(NA, NA, 1, 4/3), each = 3)
  expect_equal(ra$rolling_average, expected)
})

test_that("remove_rolling works", {
  expect_equal(remove_rolling_average(ra), x)
})


