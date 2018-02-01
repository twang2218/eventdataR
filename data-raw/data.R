library(curl)
library(xesreadR)
library(readr)

load_remote_xes <- function(url, ext = ".xes.gz") {
  tmp <- tempfile(fileext = ext)
  message(paste0("Downloading '", url, "' ..."))
  curl::curl_download(url, tmp)

  message("Parsing XES file ...")
  data <- xesreadR::read_xes(tmp)
  file.remove(tmp)

  message("DONE")
  return(data)
}

load_remote_csv <- function(url, ext = ".csv.zip", delim = ",") {
  tmp <- tempfile(fileext = ext)
  message(paste0("Downloading '", url, "' ..."))
  curl::curl_download(url, tmp)

  message("Parsing CSV file ...")
  data <- readr::read_delim(tmp, delim = delim)
  file.remove(tmp)

  message("DONE")
  return(data)
}

save_data <- function(name, data) {
  message(paste("[", name, "]"))
  e <- new.env()
  assign(name, data, envir = e)
  print(str(get(name, envir = e)))

  filename <- file.path("data", paste0(name, ".rda"))
  message(paste0("Saving data to '", filename, "' ..."))
  save(list = name, file = filename, envir = e, compress = "bzip2")

  message("DONE")
}

generate_datasets <- function() {
  # sepsis
  save_data("sepsis", load_remote_xes("https://data.4tu.nl/repository/uuid:915d2bfb-7e84-49ad-a286-dc35f063a460/DATA1", ext = ".xes.gz"))

  # BPIC11
  save_data("BPIC11", load_remote_xes("https://data.4tu.nl/repository/uuid:d9769f3d-0ab0-4fb8-803b-0d1120ffcf54/DATA1", ext = ".xes.gz"))

  # BPIC12
  save_data("BPIC12", load_remote_xes("https://data.4tu.nl/repository/uuid:3926db30-f712-4394-aebc-75976070e91f/DATA1", ext = ".xes.gz"))

  # BPIC13
  save_data("BPIC13_closed_problems", load_remote_xes("https://data.4tu.nl/repository/uuid:c2c3b154-ab26-4b31-a0e8-8f2350ddac11/DATA1", ext = ".xes.gz"))
  save_data("BPIC13_incidents", load_remote_xes("https://data.4tu.nl/repository/uuid:500573e6-accc-4b0c-9576-aa5468b10cee/DATA1", ext = ".xes.gz"))
  save_data("BPIC13_open_problems", load_remote_xes("https://data.4tu.nl/repository/uuid:3537c19d-6c64-4b1d-815d-915ab0e479da/DATA1", ext = ".xes.gz"))

  # BPIC14
  save_data("BPIC14_incidents", readr::read_delim("https://data.4tu.nl/repository/uuid:86977bac-f874-49cf-8337-80f26bf5d2ef/DATA", delim = ";"))
  save_data("BPIC14_change_details", readr::read_delim("https://data.4tu.nl/repository/uuid:d5ccb355-ca67-480f-8739-289b9b593aaf/DATA", delim = ";"))
  save_data("BPIC14_incident_details", readr::read_delim("https://data.4tu.nl/repository/uuid:3cfa2260-f5c5-44be-afe1-b70d35288d6d/DATA", delim = ";"))
  save_data("BPIC14_interaction_details", readr::read_delim("https://data.4tu.nl/repository/uuid:3d5ae0ce-198c-4b5c-b0f9-60d3035d07bf/DATA", delim = ";"))

  # BPIC15
  save_data("BPIC15_1", load_remote_xes("https://data.4tu.nl/repository/uuid:a0addfda-2044-4541-a450-fdcc9fe16d17/DATA1", ext = ".xes"))
  save_data("BPIC15_2", load_remote_xes("https://data.4tu.nl/repository/uuid:63a8435a-077d-4ece-97cd-2c76d394d99c/DATA1", ext = ".xes"))
  save_data("BPIC15_3", load_remote_xes("https://data.4tu.nl/repository/uuid:ed445cdd-27d5-4d77-a1f7-59fe7360cfbe/DATA1", ext = ".xes"))
  save_data("BPIC15_4", load_remote_xes("https://data.4tu.nl/repository/uuid:679b11cf-47cd-459e-a6de-9ca614e25985/DATA1", ext = ".xes"))
  save_data("BPIC15_5", load_remote_xes("https://data.4tu.nl/repository/uuid:b32c6fe5-f212-4286-9774-58dd53511cf8/DATA1", ext = ".xes"))

  # BPIC16
  save_data("BPIC16_clicks_logged_in", load_remote_csv("https://data.4tu.nl/repository/uuid:01345ac4-7d1d-426e-92b8-24933a079412/DATA1", ext = ".csv.zip"))
  save_data("BPIC16_clicks_not_logged_in", load_remote_csv("https://data.4tu.nl/repository/uuid:9b99a146-51b5-48df-aa70-288a76c82ec4/DATA1", ext = ".csv.zip"))
  save_data("BPIC16_complaints", readr::read_delim("https://data.4tu.nl/repository/uuid:e30ba0c8-0039-4835-a493-6e3aa2301d3f/DATA", ext = ".xes.gz"))
  save_data("BPIC16_questions", readr::read_delim("https://data.4tu.nl/repository/uuid:2b02709f-9a84-4538-a76a-eb002eacf8d1/DATA", ext = ".xes.gz"))
  save_data("BPIC16_werkmap_messages", readr::read_delim("https://data.4tu.nl/repository/uuid:c3f3ba2d-e81e-4274-87c7-882fa1dbab0d/DATA", ext = ".xes.gz"))

  # BPIC17
  # Too big to generate
  # save_data("BPIC17", load_remote_xes("https://data.4tu.nl/repository/uuid:5f3067df-f10b-45da-b98b-86ae4c7a310b/DATA1", ext = ".xes.gz"))
  save_data("BPIC17_offer", load_remote_xes("https://data.4tu.nl/repository/uuid:7e326e7e-8b93-4701-8860-71213edf0fbe/DATA1", ext = ".xes.gz"))
}
