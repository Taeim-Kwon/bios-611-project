.PHONY: clean

clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs
	rm -f report.html

.created-dirs:
	mkdir -p figures
	mkdir -p derived_data
	touch .created-dirs

# Create the pre-processed dataset
derived_data/linkedin_derived.csv: .created-dirs source_data/LinkedIn_Profile_Data.csv pre-process.R
	Rscript pre-process.R

# Create figures
figures/smile-density.png:\
  derived_data/linkedin_derived.csv\
  smile-density.R
	Rscript smile-density.R

figures/beauty-histogram.png:\
  derived_data/linkedin_derived.csv\
  beauty-histogram.R
	Rscript beauty-histogram.R

figures/scatter-plot.png:\
  derived_data/linkedin_derived.csv\
  scatter-plot.R
	Rscript scatter-plot.R

figures/log-density.png:\
  derived_data/linkedin_derived.csv\
  log-density.R
	Rscript log-density.R

# Create the report
report.html: figures/smile-density.png figures/beauty-histogram.png figures/scatter-plot.png figures/log-density.png
	R -e "rmarkdown::render(\"Report.Rmd\", output_format = \"html_document\")"