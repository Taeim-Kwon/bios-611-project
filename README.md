# Introduction

## Have you ever wondered what faces to make in your professional head shot?

My bios-611-project intends to analyze LinkedIn Profile data to see how emotions recognized in people's profiles on a professional website such as LinkedIn would be related to the gender prediction. The dataset also includes the variables that determine which gender a person's image appears to be, so they were used with the emotion variables in this analysis. This would help us to consider possible improvement in facial recognition.

# Using This Repository

I installed Docker first to create a docker image and container and have worked on this project within the container. Docker container was built based on the Dockerfile which was provided in this repository, and should you docker run your container that was created during the build step. An apple silicon M1 was contained on my machine, so that's why amoselb/rstudio-m1 was written at the top of the Dockerfile and in some of the codes in place of rocker/verse. If you have windows, please change the line to FROM rocker/verse.

- To build the docker container, run this in your terminal:
```
docker build . -t kwon611
```

- Then, to open RStudio, run this:
```
docker run -p 8787:8787 -p 8888:8888 -v $(pwd):/home/rstudio/project -e PASSWORD=pwd -it kwon611
```

- Visit localhost:8787 via browser to access the project environment.
- The port 8888 is for visualization.
- setwd("~/project") in your RStudio Server

# About the Dataset

The dataset named LinkedInProfileData.csv which was posted in source_data in the repository comes from Kaggle (<https://www.kaggle.com/datasets/omashish/linkedin-profile-data>). 
The dataset is listed as CC0:Public Domain, which means no copyright.

# Project Organization

Makefile provided in the repository will help you understand and explore the project.

It is written as this way to produce artifacts:
```
target: dependency1 dependency2
        recipe
```

Note the blank before "recipe" is a tab.

When you want to build an artifact, for example derived_data/linkedin_derived.csv, invoke this in the terminal:
```
make derived_data/linkedin_derived.csv
```

# Report

To build a final report which has analysis of the dataset including figures, run this code in the RStudio terminal which should you set to /home/rstudio/project as a directory:
```
cd project/
make report.html
```