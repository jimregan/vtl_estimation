# Assignment on vocal tract length estimation

This repository has two sets of scripts; one, to perform VTL estimation; the other, support scripts to munge the data (usually in LaTeX tables, so I could copy/paste to/from the assignment).

## VTL scripts

[baseline.pl](https://github.com/jimregan/vtl_estimation/blob/master/baseline.pl) implements the baseline method, with the equation for formants rewritten in terms of length. Because this is only suitable for schwa, it also calculates the means of several different ranges of formants (to see which looked best).

[necioglu.pl](https://github.com/jimregan/vtl_estimation/blob/master/necioglu.pl) implements the method that Rodríguez et al. attribute to Necioglu et al. (I wasn't able to locate the paper).

> Necioglu, B. F., Clements, M., & Barnwell III, T. P. (2000). Unsupervised estimation of the human vocal tract length over sentence level utterances. In *IEEE International Conference on Acoustics, Speech, and Signal Processing, 2000. ICASSP’00.* (Vol. 3, pp. 1319–1322). Istanbul. doi: 10.1109/ICASSP.2000.861821

[rodriguez.pl](https://github.com/jimregan/vtl_estimation/blob/master/rodriguez.pl) implements the re-estimation procedure mentioned in this paper:

> Rodríguez, W. R., Saz, O., Miguel, A., & Lleida, E. (2010). On Line Vocal Tract Length Estimation for Speaker Normalization in Speech Recognition. *FALA 2010: VI Jornadas en Tecnología del Habla and II Iberian SLTech Workshop*, 119–122.

[rodriguez-online.pl](https://github.com/jimregan/vtl_estimation/blob/master/rodriguez-online.pl) is a frame level version of the above, that operates on the raw LPC data exported from Praat.

## Data munging

[tabletotex.pl](https://github.com/jimregan/vtl_estimation/blob/master/tabletotex.pl) converts the LPC data exported from Praat to a LaTeX table.

[framefilt.pl](https://github.com/jimregan/vtl_estimation/blob/master/framefilt.pl) filters the frames from the above, to only include those within (hardcoded) times.

[framemean.pl](https://github.com/jimregan/vtl_estimation/blob/master/framemean.pl) operates on the output of the above, calculating the mean of the formants for each vowel.
