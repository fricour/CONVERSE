[![DOI](https://zenodo.org/badge/469748694.svg)](https://zenodo.org/badge/latestdoi/469748694)

# Code and data used for the CONVERSE paper

CONVERSE stands for **con**tinuous **ve**rtical **se**questration, which refers to a new carbon sequestration approach where it is assumed that carbon sequestration (for >= 100 years) flux can occur at all depths in the water column. In this repository, you will find all the codes and data used in the associated paper published in Nature Geoscience.

## Main code (and data used in input)

- **01_compute_b_attenuation**: Script used to compute different b attenuation coefficients based on a fine grid and interpolated on a coarser grid for further calculations.
  - **B_martin.mat**: file containing the constant (Martin et al., 1987), geographically variable (Henson et al., 2012) and regionalized (Guidi et al., 2015) b attenuation coefficients.
  - **expHensonmod.mat**: file containing the particulate organic carbon (POC) export at 100 m illustrated in Figure 4b of Henson et al., (2012).
  - **F100.mat**: file containing the f100 (i.e. fraction of retained biogenic carbon after 100 years) computed by Siegel et al., (2021).
 
- **02_compute_Fsedim**: Script used to compute the POC flux in the sediment based on Hayes et al., (2021).
  - **TOCConc1degR.nc** and **F_TOCMapR3.nc**: NetCDF files containing metadata (latitude/longitude) and the flux of POC in the sediment.
  - **marmap_coord_-180;-90;180;90_res_60.csv**: csv file containing the bathymetry (grid resolution of 60 minutes) from the NOAA (see also https://www.ncei.noaa.gov/products/bathymetry). NOTE: to get this data, you need to run the script **03_get_bathy_from_NOAA.R**.
 
- **03_get_bathy_from_NOAA**: See 02_compute_Fsedim but basically, it just fetches bathymetry data from NOAA server.

- **04_fill_missing_Hayes_pixels**: See 02_compute_Fsedim but basically, it just fills the missing POC sediment flux values where Hayes et al., (2021) did not have values (either missing data or pixels where the bathymetry is below 1000 m).

- **05_get_results**: This is the main code that interests you ! All Tables and Figures in the paper are based on this code. Briefly, it describes the different steps to compute continuous carbon sequestration fluxes for the multiple components of the biological carbon pump (i.e. gravitational pump, physically-mediated injection pumps and biological-mediated injection pumps also referred to as the daily and seasonal migration pumps). In this part, we compute this for the seven versions of CONVERSE.
  - **expHensonmod.mat**: see above.
  - **Figure4mats.mat**: file containing the primary production illustrated in Figure 4a of Henson et al., (2012).
  - **SIMPLE_TRIM_output_CORRECTED.nc**: NetCDF file containing data from the paper of Devries and Weber (2017). Data available [here](https://tdevries.eri.ucsb.edu/models-and-data-products/) under 'SIMPLE-TRIM output' (~400 MB). NOTE: in case of error (e.g. HDF error when reading the NetCDF file either with Python or with `ncdump` in your terminal, type `HDF5_USE_FILE_LOCKING=FALSE` in your terminal and run the script again.

## Figures

Data used for figures (2, 4, 5 and ED1-4) are available in `data/output_data_for_figures`. Scripts to create those figures are available in `create_figures`.
