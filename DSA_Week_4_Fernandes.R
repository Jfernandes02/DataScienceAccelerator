# 20.3.5
1. The is.finite(x) says that only actual numbers are true where sa the !is.infinite(x) also covers anything that is inf
2. This is a safe way of comparing if two vectors of floating point numbers are (pairwise) equal. This is safer than using ==, because it has a built in tolerance
3. An integer vector can take 2*32 different values, but a double can hold much larger integers (2^64)
4. You can round to the nearest integer but it is biased toward up.

# 20.4.6
1. It tells you that there are missing values in the average because they are NULL. The sum will show you how many infinite numbers you have
2. is.vector tests for any of the "atomic" modes 
3. They both do the same thing but purr::set_names have a more specific function
4. 
  1. x[[length(x)]]
  2. x[seq(2, length(x), by = 2)]
  3. x[-length(x)]
  4. x[!is.na(x) & x %% 2 == 0]
5. They are the same for the most part but the which statement will ignore any NA value
6. It will just return an NA for both scenarios.

# 20.5.4
1. 
2. The biggest difference is that all the elements of a tibble has to have the same length, where as a list does not

# 21.2.1
1. 
  1. output <- vector("double", ncol(mtcars))
      names(output) <- names(mtcars)
      for (i in names(mtcars)) {
      output[i] <- mean(mtcars[[i]])
      }
      output
  2. output <- vector("double", ncol(flights))
  names(output) <- names(flights)
  for (i in names(flights)) {
    output[[i]] <- class(flights[[i]])
  }
  output
  3.   output <- vector("doule", ncol(iris))
  names(output) <- names(iris)
  for (i in names(iris)) {
    output[i] <- length(output[[i]]))
  }
  output
  4. n <- 10
  mu <- c(-10, 0, 10, 100)
  normals <- vector("list", length(mu))
  for (i in seq_along(normals)) {
    normals[[i]] <- rnorm(n, mean = mu[i])
  }
  normals
2. 
stringr::str_c(letters, collapse = "")
sqrt(sum((x - mean(x)) ^ 2) / (length(x) - 1))
all.equal(cumsum(x),out)
3. 
  1. 
  humps <- c("five", "four", "three", "two", "one", "no")
  for (i in humps) {
    cat(str_c("Alice the camel has ", rep(i, 3), " humps.",
              collapse = "\n"), "\n")
    if (i == "no") {
      cat("Now Alice is a horse.\n")
    } else {
      cat("So go, Alice, go.\n")
    }
    cat("\n")
  }
  2. 
  numbers <- c("ten", "nine", "eight", "seven", "six", "five",
               "four", "three", "two", "one")
  for (i in numbers) {
    cat(str_c("There were ", i, " in the bed\n"))
    cat("and the little one said\n")
    if (i == "one") {
      cat("I'm lonely...")
    } else {
      cat("Roll over, roll over\n")
      cat("So they all rolled over and one fell out.\n")
    }
    cat("\n")
  }
  3. 
  bottles <- function(i) {
    if (i > 2) {
      bottles <- str_c(i - 1, " bottles")
    } else if (i == 2) {
      bottles <- "1 bottle"
    } else {
      bottles <- "no more bottles"
    }
    bottles
  }
  beer_bottles <- function(n) {
    # should test whether n >= 1.
    for (i in seq(n, 1)) {
      cat(str_c(bottles(i), " of beer on the wall, ", bottles(i), " of beer.\n"))
      cat(str_c("Take one down and pass it around, ", bottles(i - 1),
                " of beer on the wall.\n\n"))
    }
    cat("No more bottles of beer on the wall, no more bottles of beer.\n")
    cat(str_c("Go to the store and buy some more, ", bottles(n), " of beer on the wall.\n"))
  }
  beer_bottles(3)
  4. 
  {r, eval = FALSE}
  output <- vector("integer", 0)
  for (i in seq_along(x)) {
    output <- c(output, lengths(x[[i]]))
  }
  output
# 21.3.5
  1. 
  {r, eval = FALSE}
  all_csv <- c("one.csv", "two.csv")
  all_dfs <- vector("list", length(all_csv))
  for (i in all_csv) {
    all_dfs[[i]] <- read_csv(all_csv[[i]])
  }
  bind_rows(all_dfs)
  2. 
  no_names <- 1:5
  some_names <- c("one" = 1, 2, "three" = 3)
  repeated_names <- c("one" = 1, "one" = 2, "three" = 3)
  for (nm in names(no_names)) print(identity(nm)) # nothing happens!
  for (nm in names(some_names)) print(identity(nm)) # the empty name get's filled with a ""
  for (nm in names(repeated_names)) print(identity(nm)) # everything get's printed out
  3. 
  {r, eval = FALSE}
  show_mean(iris)
  #> Sepal.Length: 5.84
  #> Sepal.Width:  3.06
  #> Petal.Length: 3.76
  #> Petal.Width:  1.20
  show_means <- function(x) {
    
    the_class <- vector("logical", length(x))
    for (i in seq_along(x)) the_class[[i]] <- is.numeric(x[[i]])
    
    x <- x[the_class]
    
    for (i in seq_along(x)) {
      cat(paste0(names(x)[i], ": ", round(mean(x[[i]]), 2)), fill = TRUE)
    }
  }
  show_means(iris)
  show_means(mtcars)
  
# 21.5.3
  1. looper("numeric", mtcars, mean)
  2. looper("character", flights, class)
  3. looper("numeric", iris, function(x) sum(table(unique(x))))
  4. ten_draws <- function(x) rnorm(10, mean = x)
  map(c(-10, 0, 10, 100), ten_draws)
  