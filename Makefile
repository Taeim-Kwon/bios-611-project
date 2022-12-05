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

# Create the derived dataset for emotion, beauty, and gender
derived_data/emotion_gender.csv: .created-dirs derived_data/linkedin_derived.csv emotion_gender_dataset.R
	Rscript emotion_gender_dataset.R

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

figures/emo_gender_gbm.png\
 figures/emo_gender_roc.png\
 figures/emo_gender_calculation.png:\
  derived_data/emotion_gender.csv\
  emotion_gender.R
	Rscript emotion_gender.R

figures/collinearity_beauty.png:\
  derived_data/linkedin_derived.csv\
  collinearity_beauty.R
	Rscript collinearity_beauty.R

figures/emo_beauty_lasso.png:\
  derived_data/emotion_gender.csv\
  emotion_gender_lasso.R
	Rscript emotion_gender_lasso.R

figures/emo_lasso.png:\
  derived_data/emotion_gender.csv\
  emotion_lasso.R
	Rscript emotion_lasso.R

# Create the report
report.html: figures/smile-density.png figures/beauty-histogram.png figures/scatter-plot.png figures/log-density.png figures/emo_gender_gbm.png figures/emo_gender_roc.png figures/emo_gender_calculation.png figures/collinearity_beauty.png figures/emo_beauty_lasso.png figures/emo_lasso.png
	R -e "rmarkdown::render(\"Report.Rmd\", output_format = \"html_document\")"