#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
doc: selfcal_simulation
inputs:
  makems_msname: string
  makems_telescope: string
  makems_direction: string
  makems_synthesis: float
  makems_dtime: float
  makems_freq0: float
  makems_dfreq: float
  makems_nchan: int
  simsky_config: File
  simsky_use_smearing: int
  simsky_sefd: float
  simsky_output_column: string
  simsky_skymodel: File
  makeimage1_name: string
  makeimage1_datacolumn: string
  makeimage1_save_source_list: boolean
  makeimage1_scale: string
  makeimage1_fit_spectral_pol: int
  makeimage1_channels_out: int
  makeimage1_join_channels: boolean
  makeimage1_mgain: float
  makeimage1_niter: int
  makeimage1_auto_threshold: float
  makeimage1_size:
    type:
      type: array
      items: int
  sourcefinder_outfile: string
  sourcefinder_format:
    type:
      type: enum
      symbols:
      - bbs
      - ds9
      - fits
      - star
      - kvis
      - ascii
      - csv
      - casabox
      - sagecal
      name: format99addd81-2fa7-4f50-bd3f-d4e4f2009340
  sourcefinder_thresh_isl: float
  sourcefinder_thresh_pix: float
  convertfits_outfile: string
  convertcatalog_output_skymodel: string
  convertcatalog_output_format:
    type:
      symbols:
      - Tigger
      - ASCII
      - BBS
      - NEWSTAR
      - AIPSCC
      - AIPSCCFITS
      - Gaul
      - auto
      type: enum
      name: output_formata9b4377e-dcd8-4eb1-8e54-d2a47aa27c10
  convertcatalog_output_type:
    type:
      symbols:
      - Tigger
      - ASCII
      - BBS
      - NEWSTAR
      - auto
      type: enum
      name: output_typea0b4e6bd-1fc0-41c4-af8c-bc37f7371113
  convertcatalog_type:
    type:
      symbols:
      - Tigger
      - ASCII
      - BBS
      - NEWSTAR
      - AIPSCC
      - AIPSCCFITS
      - Gaul
      - auto
      type: enum
      name: typebcc63315-baa3-4053-8ef9-c568901683d5
  convertcatalog_rename: boolean
  calibration_data_column: string
  calibration_out_column: string
  calibration_model_expression:
    type:
      type: array
      items: string
  calibration_data_time_chunk: int
  calibration_data_freq_chunk: int
  calibration_sel_ddid: string
  calibration_dist_ncpu: int
  calibration_sol_jones: string
  calibration_sol_term_iters: string
  calibration_out_name: string
  calibration_out_mode:
    type:
      symbols:
      - so
      - sc
      - sr
      - ss
      - ac
      - ar
      - as
      type: enum
      name: out_mode1046b230-6003-493a-9986-4c26611c3e4d
  calibration_weight_column: string
  calibration_montblanc_dtype: string
  calibration_g_type: string
  calibration_g_time_int: float
  calibration_g_freq_int: float
  calibration_g_save_to: string
  calibration_bbc_save_to: string
  calibration_g_clip_low: float
  calibration_g_clip_high: float
  calibration_madmax_enable: boolean
  calibration_madmax_plot: boolean
  calibration_madmax_threshold:
    type:
      type: array
      items: float
  calibration_madmax_estimate:
    type:
      symbols:
      - corr
      - all
      - diag
      - offdiag
      type: enum
      name: madmax_estimate23d348ff-0726-49ec-82d7-fc68bf4dabea
  calibration_out_plots: boolean
  calibration_out_casa_gaintables: boolean
  calibration_g_solvable: boolean
  calibration_out_overwrite: boolean
  calibration_log_boring: boolean
  calibration_shared_memory: int
  calibration_montblanc_mem_budget: int
  makeimage2_name: string
  makeimage2_datacolumn: string
  makeimage2_save_source_list: boolean
  makeimage2_scale: string
  makeimage2_fit_spectral_pol: int
  makeimage2_channels_out: int
  makeimage2_join_channels: boolean
  makeimage2_mgain: float
  makeimage2_niter: int
  makeimage2_auto_threshold: float
  makeimage2_size:
    type:
      type: array
      items: int
  makecube1_output: string
  makecube1_stack: boolean
  makecube1_fits_axis: string
  sofia_mask_steps_doFlag: boolean
  sofia_mask_steps_doScaleNoise: boolean
  sofia_mask_steps_doSCfind: boolean
  sofia_mask_steps_doMerge: boolean
  sofia_mask_steps_doReliability: boolean
  sofia_mask_steps_doParameterise: boolean
  sofia_mask_steps_doWriteMask: boolean
  sofia_mask_steps_doMom0: boolean
  sofia_mask_steps_doMom1: boolean
  sofia_mask_steps_doWriteCat: boolean
  sofia_mask_steps_doCubelets: boolean
  sofia_mask_scaleNoise_statistic: string
  sofia_mask_SCfind_threshold: float
  sofia_mask_SCfind_rmsMode: string
  sofia_mask_merge_radiusX: int
  sofia_mask_merge_radiusY: int
  sofia_mask_merge_radiusZ: int
  sofia_mask_merge_minSizeX: int
  sofia_mask_merge_minSizeY: int
  sofia_mask_merge_minSizeZ: int
  sofia_mask_writeCat_basename: string
  transfermodel_spectra: boolean
  transfermodel_row_chunks: int
  transfermodel_model_chunks: int
  transfermodel_points_only: boolean
  transfermodel_num_sources: int
  transfermodel_num_workers: int
outputs:
  makems:
    outputSource: simms/msname_out
    type: Directory
  simsky:
    outputSource: simulator/msname_out
    type: Directory
  makeimage1_0:
    outputSource: wsclean/dirty_image_out
    type: File
  makeimage1_1:
    outputSource: wsclean/dirty_images_out
    type:
      type: array
      items: File
  makeimage1_2:
    outputSource: wsclean/model_image_out
    type: File
  makeimage1_3:
    outputSource: wsclean/model_images_out
    type:
      type: array
      items: File
  makeimage1_4:
    outputSource: wsclean/msname_out
    type: Directory
  makeimage1_5:
    outputSource: wsclean/psf_image_out
    type: File
  makeimage1_6:
    outputSource: wsclean/psf_images_out
    type:
      type: array
      items: File
  makeimage1_7:
    outputSource: wsclean/residual_image_out
    type: File
  makeimage1_8:
    outputSource: wsclean/residual_images_out
    type:
      type: array
      items: File
  makeimage1_9:
    outputSource: wsclean/restored_image_out
    type: File
  makeimage1_10:
    outputSource: wsclean/restored_images_out
    type:
      type: array
      items: File
  makeimage1_11:
    outputSource: wsclean/source_list
    type: File
  sourcefinder_0:
    outputSource: pybdsf/model_out
    type: File
  sourcefinder_1:
    outputSource: pybdsf/models_out
    type:
      type: array
      items: File
  calibration_0:
    outputSource: tmpyh9lrhqj/casa_plot_out
    type:
    - 'null'
    - type: array
      items: Directory
  calibration_1:
    outputSource: tmpyh9lrhqj/msname_out
    type: Directory
  calibration_2:
    outputSource: tmpyh9lrhqj/parmdb_save_out
    type:
      type: array
      items: File
  calibration_3:
    outputSource: tmpyh9lrhqj/plot_out
    type: Directory
  makeimage2_0:
    outputSource: wsclean-1/dirty_image_out
    type: File
  makeimage2_1:
    outputSource: wsclean-1/dirty_images_out
    type:
      type: array
      items: File
  makeimage2_2:
    outputSource: wsclean-1/model_image_out
    type: File
  makeimage2_3:
    outputSource: wsclean-1/model_images_out
    type:
      type: array
      items: File
  makeimage2_4:
    outputSource: wsclean-1/msname_out
    type: Directory
  makeimage2_5:
    outputSource: wsclean-1/psf_image_out
    type: File
  makeimage2_6:
    outputSource: wsclean-1/psf_images_out
    type:
      type: array
      items: File
  makeimage2_7:
    outputSource: wsclean-1/residual_image_out
    type: File
  makeimage2_8:
    outputSource: wsclean-1/residual_images_out
    type:
      type: array
      items: File
  makeimage2_9:
    outputSource: wsclean-1/restored_image_out
    type: File
  makeimage2_10:
    outputSource: wsclean-1/restored_images_out
    type:
      type: array
      items: File
  makeimage2_11:
    outputSource: wsclean-1/source_list
    type: File
  makecube1_0:
    outputSource: fitstool/image_out
    type: File
  makecube1_1:
    outputSource: fitstool/images_out
    type:
      type: array
      items: File
  sofia_mask_0:
    outputSource: sofia/writeOutAscii
    type:
    - 'null'
    - File
  sofia_mask_1:
    outputSource: sofia/writeOutCat
    type:
    - 'null'
    - File
  sofia_mask_2:
    outputSource: sofia/writeOutCubelets
    type:
    - 'null'
    - Directory
  sofia_mask_3:
    outputSource: sofia/writeOutMask
    type:
    - 'null'
    - File
  sofia_mask_4:
    outputSource: sofia/writeOutMom0
    type:
    - 'null'
    - File
  sofia_mask_5:
    outputSource: sofia/writeOutMom1
    type:
    - 'null'
    - File
  sofia_mask_6:
    outputSource: sofia/writeOutNrch
    type:
    - 'null'
    - File
  transfermodel:
    outputSource: crystalball/msname_out
    type: Directory
steps:
  simms:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/simms.cwl
    in:
      telescope: makems_telescope
      dfreq: makems_dfreq
      direction: makems_direction
      dtime: makems_dtime
      freq0: makems_freq0
      msname: makems_msname
      nchan: makems_nchan
      synthesis: makems_synthesis
    out:
    - msname_out
  simulator:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/simulator.cwl
    in:
      config: simsky_config
      msname: simms/msname_out
      skymodel: simsky_skymodel
      output_column: simsky_output_column
      sefd: simsky_sefd
      use_smearing: simsky_use_smearing
    out:
    - msname_out
  wsclean:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/wsclean.cwl
    in:
      msname: simulator/msname_out
      name: makeimage1_name
      auto_threshold: makeimage1_auto_threshold
      channels_out: makeimage1_channels_out
      datacolumn: makeimage1_datacolumn
      fit_spectral_pol: makeimage1_fit_spectral_pol
      join_channels: makeimage1_join_channels
      mgain: makeimage1_mgain
      niter: makeimage1_niter
      save_source_list: makeimage1_save_source_list
      scale: makeimage1_scale
      size: makeimage1_size
    out:
    - dirty_image_out
    - dirty_images_out
    - model_image_out
    - model_images_out
    - msname_out
    - psf_image_out
    - psf_images_out
    - residual_image_out
    - residual_images_out
    - restored_image_out
    - restored_images_out
    - source_list
  pybdsf:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/pybdsf.cwl
    in:
      filename: wsclean/restored_image_out
      outfile: sourcefinder_outfile
      format: sourcefinder_format
      thresh_isl: sourcefinder_thresh_isl
      thresh_pix: sourcefinder_thresh_pix
    out:
    - model_out
    - models_out
  bdsf_fits2lsm:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/bdsf_fits2lsm.cwl
    in:
      infile: pybdsf/model_out
      outfile: convertfits_outfile
      phase_centre_image: wsclean/restored_image_out
    out:
    - model_out
    - models_out
  tigger_convert:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/tigger_convert.cwl
    in:
      input_skymodel: bdsf_fits2lsm/model_out
      output_format: convertcatalog_output_format
      output_skymodel: convertcatalog_output_skymodel
      output_type: convertcatalog_output_type
      type: convertcatalog_type
      rename: convertcatalog_rename
    out:
    - model_out
    - models_out
  tmpyh9lrhqj:
    run: /tmp/tmpyh9lrhqj.cwl
    in:
      bbc_save_to: calibration_bbc_save_to
      data_ms: wsclean/msname_out
      madmax_estimate: calibration_madmax_estimate
      model_expression: calibration_model_expression
      out_mode: calibration_out_mode
      data_column: calibration_data_column
      data_freq_chunk: calibration_data_freq_chunk
      data_time_chunk: calibration_data_time_chunk
      dist_ncpu: calibration_dist_ncpu
      g_clip_high: calibration_g_clip_high
      g_clip_low: calibration_g_clip_low
      g_freq_int: calibration_g_freq_int
      g_save_to: calibration_g_save_to
      g_solvable: calibration_g_solvable
      g_time_int: calibration_g_time_int
      g_type: calibration_g_type
      log_boring: calibration_log_boring
      madmax_enable: calibration_madmax_enable
      madmax_plot: calibration_madmax_plot
      madmax_threshold: calibration_madmax_threshold
      model_lsm: tigger_convert/models_out
      montblanc_dtype: calibration_montblanc_dtype
      montblanc_mem_budget: calibration_montblanc_mem_budget
      out_casa_gaintables: calibration_out_casa_gaintables
      out_column: calibration_out_column
      out_name: calibration_out_name
      out_overwrite: calibration_out_overwrite
      out_plots: calibration_out_plots
      sel_ddid: calibration_sel_ddid
      shared_memory: calibration_shared_memory
      sol_jones: calibration_sol_jones
      sol_term_iters: calibration_sol_term_iters
      weight_column: calibration_weight_column
    out:
    - casa_plot_out
    - msname_out
    - parmdb_save_out
    - plot_out
  wsclean-1:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/wsclean.cwl
    in:
      msname: tmpyh9lrhqj/msname_out
      name: makeimage2_name
      auto_threshold: makeimage2_auto_threshold
      channels_out: makeimage2_channels_out
      datacolumn: makeimage2_datacolumn
      fit_spectral_pol: makeimage2_fit_spectral_pol
      join_channels: makeimage2_join_channels
      mgain: makeimage2_mgain
      niter: makeimage2_niter
      save_source_list: makeimage2_save_source_list
      scale: makeimage2_scale
      size: makeimage2_size
    out:
    - dirty_image_out
    - dirty_images_out
    - model_image_out
    - model_images_out
    - msname_out
    - psf_image_out
    - psf_images_out
    - residual_image_out
    - residual_images_out
    - restored_image_out
    - restored_images_out
    - source_list
  fitstool:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/fitstool.cwl
    in:
      image: wsclean-1/restored_images_out
      output: makecube1_output
      fits_axis: makecube1_fits_axis
      stack: makecube1_stack
    out:
    - image_out
    - images_out
  sofia:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/sofia.cwl
    in:
      SCfind_rmsMode: sofia_mask_SCfind_rmsMode
      SCfind_threshold: sofia_mask_SCfind_threshold
      import_inFile: fitstool/image_out
      merge_minSizeX: sofia_mask_merge_minSizeX
      merge_minSizeY: sofia_mask_merge_minSizeY
      merge_minSizeZ: sofia_mask_merge_minSizeZ
      merge_radiusX: sofia_mask_merge_radiusX
      merge_radiusY: sofia_mask_merge_radiusY
      merge_radiusZ: sofia_mask_merge_radiusZ
      scaleNoise_statistic: sofia_mask_scaleNoise_statistic
      steps_doCubelets: sofia_mask_steps_doCubelets
      steps_doFlag: sofia_mask_steps_doFlag
      steps_doMerge: sofia_mask_steps_doMerge
      steps_doMom0: sofia_mask_steps_doMom0
      steps_doMom1: sofia_mask_steps_doMom1
      steps_doParameterise: sofia_mask_steps_doParameterise
      steps_doReliability: sofia_mask_steps_doReliability
      steps_doSCfind: sofia_mask_steps_doSCfind
      steps_doScaleNoise: sofia_mask_steps_doScaleNoise
      steps_doWriteCat: sofia_mask_steps_doWriteCat
      steps_doWriteMask: sofia_mask_steps_doWriteMask
      writeCat_basename: sofia_mask_writeCat_basename
    out:
    - writeOutAscii
    - writeOutCat
    - writeOutCubelets
    - writeOutMask
    - writeOutMom0
    - writeOutMom1
    - writeOutNrch
  crystalball:
    run: /home/athanaseus/Documents/gitPackages/Stimela/stimela/cargo/cab/crystalball.cwl
    in:
      ms: wsclean-1/msname_out
      model_chunks: transfermodel_model_chunks
      num_sources: transfermodel_num_sources
      num_workers: transfermodel_num_workers
      points_only: transfermodel_points_only
      row_chunks: transfermodel_row_chunks
      sky_model: wsclean-1/source_list
      spectra: transfermodel_spectra
    out:
    - msname_out
