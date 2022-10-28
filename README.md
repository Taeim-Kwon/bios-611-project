# Introduction

## Have you ever wondered what faces to make in your professional head shot?

My bios-611-project intends to analyze LinkedIn Profile data to see how people's profiles used in a professional website such as LinkedIn would be related to their profession. This would help understand how important setting up a profile is.

# Using This Repository

I installed Docker first to create a docker image and container and work on this project within the container. Docker container was built based on the Dockerfile which was provided in this repository. An apple silicon M1 was contained on my machine, so that's why amoselb/rstudio-m1 was written at the top of the Dockerfile and in some of the codes in place of rocker/verse.

- To build the docker container, run this:
```
docker build . -t kwon611
```

- Then, to open RStudio, run this:
```
docker run -p 8787:8787 -p 8888:8888 -v $(pwd):/home/rstudio/project -e PASSWORD=pwd -it amoselb/rstudio-m1
```

- Visit localhost:8787 via browser to access the project environment.

# About the Dataset

The data set named LinkedInProfileData.csv which was posted in the repository comes from Kaggle (<https://www.kaggle.com/datasets/omashish/linkedin-profile-datahttps://www.kaggle.com/datasets/omashish/linkedin-profile-data>). The data set is listed as CC0:Public Domain, which means no copyright.

# Project Organization

Makefile provided in the repository will help you understand and explore the project.

It is written as this way to produce artifacts:
target: dependency1 dependency2
        recipe

Note the blank before recipe is a tab.

When you want to build an artifact, for example derived_data/linkedin_derived.csv, invoke this:
```
make derived_data/linkedin_derived.csv
```

# Report

Building a final report which has analysis of the dataset including figures originally should have been done with this code in the terminal:
```
make report.html
```

However, as there was an issue making the report in html with that code, please open Report.Rmd and knit it in the Rmd file for now. This should be fixed and will be able to build the report with Make invoke later. 
