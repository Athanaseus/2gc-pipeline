#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
doc: selfcal_simulation
inputs:
  makems_msname: string
  makems_dtime: float
  makems_telescope: string
  makems_nchan: int
  makems_freq0: float
  makems_direction: string
  makems_dfreq: float
  makems_synthesis: float
  simsky_sefd: float
  simsky_use_smearing: int
  simsky_output_column: string
  simsky_skymodel: File
  simsky_config: File
  makeimage_niter: int
  makeimage_auto_threshold: float
  makeimage_channels_out: int
  makeimage_join_channels: boolean
  makeimage_scale: string
  makeimage_name: string
  makeimage_datacolumn: string
  makeimage_size:
    type:
      type: array
      items: int
  makeimage_mgain: float
  sourcefinder_thresh_isl: float
  sourcefinder_thresh_pix: float
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
      name: format8fbfeec3-5824-4e2e-9da4-42058f13dadb
  convertfits_outfile: string
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
      name: output_format6e00b8b5-328c-41c2-bccc-1e6a3d83b3a7
  convertcatalog_output_skymodel: string
  convertcatalog_output_type:
    type:
      symbols:
      - Tigger
      - ASCII
      - BBS
      - NEWSTAR
      - auto
      type: enum
      name: output_typeee869295-59c6-482d-97b0-66a52835dd5f
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
      name: typec1de759b-ce5f-463c-8620-37d95c96f8a7
  convertcatalog_rename: boolean
  calibration_model_expression:
    type:
      type: array
      items: string
  calibration_sol_term_iters: string
  calibration_g_time_int: int
  calibration_sel_ddid: string
  calibration_madmax_plot: boolean
  calibration_g_save_to: string
  calibration_out_plots: boolean
  calibration_weight_column: string
  calibration_data_freq_chunk: int
  calibration_sol_jones: string
  calibration_g_freq_int: float
  calibration_madmax_enable: boolean
  calibration_dist_ncpu: int
  calibration_bbc_save_to: string
  calibration_montblanc_dtype: string
  calibration_madmax_estimate:
    type:
      symbols:
      - corr
      - all
      - diag
      - offdiag
      type: enum
      name: madmax_estimate31f18e3f-fb94-40e6-a2ee-adf8c7632193
  calibration_out_overwrite: boolean
  calibration_shared_memory: int
  calibration_g_clip_low: float
  calibration_madmax_threshold:
    type:
      type: array
      items: float
  calibration_log_boring: boolean
  calibration_data_column: string
  calibration_g_type: string
  calibration_montblanc_mem_budget: int
  calibration_data_time_chunk: int
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
      name: out_mode249f2d83-5779-423d-b324-5bde3eeddd3d
  calibration_out_name: string
  calibration_g_clip_high: float
  calibration_g_solvable: boolean
  calibration_out_casa_gaintables: boolean
outputs:
  makems:
    outputSource: simms/msname_out
    type: Directory
  simsky:
    outputSource: simulator/msname_out
    type: Directory
  makeimage_0:
    outputSource: wsclean/image_out
    type: File
  makeimage_1:
    outputSource: wsclean/images_out
    type:
      type: array
      items: File
  makeimage_2:
    outputSource: wsclean/msname_out
    type: Directory
  sourcefinder_0:
    outputSource: pybdsf/model_out
    type: File
  sourcefinder_1:
    outputSource: pybdsf/models_out
    type:
      type: array
      items: File
  calibration_0:
    outputSource: cubical/casa_plot_out
    type:
      type: array
      items: Directory
  calibration_1:
    outputSource: cubical/data_ms_out
    type: Directory
  calibration_2:
    outputSource: cubical/parmdb_save_out
    type:
      type: array
      items: File
  calibration_3:
    outputSource: cubical/plot_out
    type: Directory
steps:
  simms:
    run: /home/aramaila/gitPackages/Stimela/stimela/cargo/cab/simms.cwl
    in:
      msname: makems_msname
      dtime: makems_dtime
      telescope: makems_telescope
      nchan: makems_nchan
      freq0: makems_freq0
      direction: makems_direction
      dfreq: makems_dfreq
      synthesis: makems_synthesis
    out:
    - msname_out
  simulator:
    run: /home/aramaila/gitPackages/Stimela/stimela/cargo/cab/simulator.cwl
    in:
      msname: simms/msname_out
      use_smearing: simsky_use_smearing
      output_column: simsky_output_column
      sefd: simsky_sefd
      skymodel: simsky_skymodel
      config: simsky_config
    out:
    - msname_out
  wsclean:
    run: /home/aramaila/gitPackages/Stimela/stimela/cargo/cab/wsclean.cwl
    in:
      msname: simulator/msname_out
      niter: makeimage_niter
      auto_threshold: makeimage_auto_threshold
      channels_out: makeimage_channels_out
      join_channels: makeimage_join_channels
      scale: makeimage_scale
      name: makeimage_name
      datacolumn: makeimage_datacolumn
      size: makeimage_size
      mgain: makeimage_mgain
    out:
    - image_out
    - images_out
    - msname_out
  pybdsf:
    run: /home/aramaila/gitPackages/Stimela/stimela/cargo/cab/pybdsf.cwl
    in:
      thresh_isl: sourcefinder_thresh_isl
      filename: wsclean/image_out
      thresh_pix: sourcefinder_thresh_pix
      outfile: sourcefinder_outfile
      format: sourcefinder_format
    out:
    - model_out
    - models_out
  bdsf_fits2lsm:
    run: /home/aramaila/gitPackages/Stimela/stimela/cargo/cab/bdsf_fits2lsm.cwl
    in:
      phase_centre_image: wsclean/image_out
      outfile: convertfits_outfile
      infile: pybdsf/model_out
    out:
    - model_out
    - models_out
  tigger_convert:
    run: /home/aramaila/gitPackages/Stimela/stimela/cargo/cab/tigger_convert.cwl
    in:
      output_format: convertcatalog_output_format
      output_type: convertcatalog_output_type
      rename: convertcatalog_rename
      input_skymodel: bdsf_fits2lsm/model_out
      output_skymodel: convertcatalog_output_skymodel
      type: convertcatalog_type
    out:
    - model_out
    - models_out
  cubical:
    run: /home/aramaila/gitPackages/Stimela/stimela/cargo/cab/cubical.cwl
    in:
      model_expression: calibration_model_expression
      g_time_int: calibration_g_time_int
      sel_ddid: calibration_sel_ddid
      madmax_plot: calibration_madmax_plot
      g_save_to: calibration_g_save_to
      out_plots: calibration_out_plots
      data_ms: wsclean/msname_out
      out_mode: calibration_out_mode
      out_casa_gaintables: calibration_out_casa_gaintables
      g_freq_int: calibration_g_freq_int
      madmax_enable: calibration_madmax_enable
      model_lsm: tigger_convert/models_out
      bbc_save_to: calibration_bbc_save_to
      montblanc_dtype: calibration_montblanc_dtype
      madmax_estimate: calibration_madmax_estimate
      dist_ncpu: calibration_dist_ncpu
      out_overwrite: calibration_out_overwrite
      madmax_threshold: calibration_madmax_threshold
      g_clip_low: calibration_g_clip_low
      shared_memory: calibration_shared_memory
      log_boring: calibration_log_boring
      data_column: calibration_data_column
      g_type: calibration_g_type
      weight_column: calibration_weight_column
      sol_term_iters: calibration_sol_term_iters
      montblanc_mem_budget: calibration_montblanc_mem_budget
      data_time_chunk: calibration_data_time_chunk
      data_freq_chunk: calibration_data_freq_chunk
      out_name: calibration_out_name
      g_clip_high: calibration_g_clip_high
      g_solvable: calibration_g_solvable
      sol_jones: calibration_sol_jones
    out:
    - casa_plot_out
    - data_ms_out
    - parmdb_save_out
    - plot_out
