cwlVersion: v1.1
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: stimela/meqtrees:1.2.0
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.msname)
        writable: true
      - entry: $(inputs.skymodel)

baseCommand: /usr/bin/meqtree-pipeliner.py

arguments: ['--mt', '$( runtime.cores )',
            '-c', '$( inputs.tdlconf.path )',
            '${var SECTION = "stefcal";
               if (inputs.section) {
                 SECTION = inputs.section;
               }
               return "["+SECTION+"]"
              }',
            '${var params = {};
               var THREADS = inputs.threads;
               var prefix = inputs.prefix;
               if (inputs.write_flags_to_ms) {
                 params["ims_sel.ms_write_flags"] = 1;
                 if (inputs.fill_legacy_flags) {
                   params["ms_sel.ms_fill_legacy_flags"] = 1;
                 } else {
                   params["ms_sel.ms_fill_legacy_flags"] = 0;
                 }
               }
               if (inputs.write_flagset) {
                 params["ms_rfl.read_flagsets"] = inputs.write_flagset;
                 if (inputs.write_flag_policy) {
                   params["ms_sel.ms_write_flag_policy"] = "add to set";
                 } else {
                   params["ms_sel.ms_write_flag_policy"] = "replace set";
                 }
               }
               if (inputs.read_flagsets) {
                 params["ms_rfl.read_flagsets"] = inputs.read_flagsets;
               }
               if (inputs.read_flags_from_ms) {
                 params["ms_sel.ms_read_flags"] = 1;
               } else {
                 params["ms_sel.ms_read_flags"] = 0;
               }
               if (inputs.read_legacy_flags) {
                 params["ms_rfl.read_legacy_flags"] = 1;
               } else {
                 params["ms_rfl.read_legacy_flags"] = 0;
               }
               params["ms_sel.msname"] = inputs.msname.path;
               params["ms_sel.field_index"] = inputs.field_id;
               params["ms_sel.ddid_index"] = inputs.spw_id;
               params["ms_sel.tile_size"] = inputs.tile_size;
               params["ms_sel.input_column"] = inputs.column;
               params["ms_sel.output_column"] = inputs.output_column;
               params["tiggerlsm.filename"] =  inputs.skymodel.path;
               params["tiggerlsm.lsm_subset"] = inputs.subset;
               params["ms_sel.ms_corr_sel"] = inputs.output_data;

               var saveconf = inputs.save_config;
               
               if (inputs.beam_files_pattern) {
                 var beam_files_pattern = inputs.beam_files_pattern;
               } else {
                 var beam_files_pattern = "all";
               }

               if (inputs.output_data) {
                 params["do_output"] = inputs.output_data;
               } else {
                 params["do_output"] = "CORR_RES";
               }

               if (inputs.model_column) {
                 var model_column = inputs.model_column;
               } else {
                 var model_column = "MODEL_DATA";
               }
   
               if (inputs.Gjones) {
                 params["stefcal_gain.enabled"] = 1;
                 if (inputs.Gjones_apply_only) {
                   params["stefcal_gain.mode"] = "apply";
                 } else {
                   params["stefcal_gain.mode"] = "solve-save";
                 }
                 if (inputs.Gjones_solution_intervals) {
                   params["stefcal_gain.timeint"] = inputs.Gjones_solution_intervals[0];
                   params["stefcal_gain.freqint"] = inputs.Gjones_solution_intervals[1];
                 } else {
                   params["stefcal_gain.timeint"] = 1;
                   params["stefcal_gain.freqint"] = 1;
                 }
                 if (inputs.jones_implementation) {
                   params["stefcal_gain.implementation"] = inputs.jones_implementation;
                 } else {
                   params["stefcal_gain.implementation"] = "Gain2x2";
                 }
                 params["stefcal_gain.flag_ampl"] = inputs.Gjones_ampl_clipping;
                 params["stefcal_gain.flag_chisq"] = inputs.Gjones_chisq_clipping;
                 params["stefcal_gain.flag_chisq_threshold"] = inputs.Gjones_thresh_sigma;
                 params["stefcal_gain.flag_ampl_low"] = inputs.Gjones_ampl_clipping_low;
                 params["stefcal_gain.flag_ampl_high"] = inputs.Gjones_ampl_clipping_high;
                 params["stefcal_gain.table"] = inputs.Gjones_gain_table;
               }
              var cmdline_params = "";
              for (var key in params) {
                if (params[key] !== null) {
                  cmdline_params = cmdline_params.concat(key+"="+params[key]+" ");
                }
              }
              return cmdline_params;
            }',
            '/usr/lib/python2.7/dist-packages/Cattery/Calico/calico-stefcal.py',
            '=stefcal'
           ]

inputs:
  IFRjones_apply_only:
    type: boolean?
    doc: Apply existing gains
  beam_files_pattern:
    type: File?
    doc: Beam files pattern
  Gjones_chisq_clipping:
    type: boolean?
    doc: Gjones chi square clipping
    inputBinding:
      valueFrom: | 
        ${
          var value = 0;
          var par_value = inputs.Gjones_chisq__clipping;
          if (par_value) {
            value=1;
          }
          return value;
        }
  Bjones_smoothing_intervals:
    type: int[]?
    doc: Solution intervals in time and frequency in time/frequency bins for Bjones.
      Should be given as a list of two integers
  skymodel:
    type: File?
    doc: Sky model to use for the calibration
  read_legacy_flags:
    type: boolean?
    doc: Read legacy flags
  DDjones_matrix_type:
    type:
      - 'null'
      - type: enum
        symbols: [Gain2x2, GainDiag, GainDiagPhase, GainDiang2a, GainDiagCommon]
    doc: Jones matrix type
  write_flagset:
    type: string?
    doc: name of flagset to write new flags to
  section:
    type: string?
    doc: Section to execute in TDL config file. Only needed if using custom TDL config
  Bjones_ampl_clipping_low:
    type: float?
    doc: Bjones flagging amplitude
  Gjones_ampl_clipping:
    type: boolean?
    doc: Gjones amplitude clipping
    inputBinding:
      valueFrom: | 
        ${
          var value = 0;
          var par_value = inputs.Gjones_ampl_clipping;
          if (par_value) {
            value=1;
          }
          return value;
        }
  subset:
    type: string?
    doc: Source subset to use for the calibration
  add_vis_model:
    type: boolean?
    doc: Add visibility model data to the calibration model. This model should be
      saved in the MODEL_DATA column
  Gjones_thresh_sigma:
    type: float?
    doc: Gjones threshold level
    default: 10.0
  read_flags_from_ms:
    type: boolean?
    doc: Use existing flags from MS
  Gjones_ampl_clipping_high:
    type: float?
    doc: Gjones flagging amplitude
    default: 2.0
  DDjones_tag:
    type: string?
    doc: Tag for sources that will recieve DD calibration
  prefix:
    type: string?
    doc: Prefix for gain and diagnostic plots. If not specified will use basename of MS.
  DDjones_solution_intervals:
    type: int[]?
    doc: Solution intervals in time and frequency in time/frequency bins. Should be
      given as a list of two integers
  output_data:
    type:
      - 'null'
      - type: enum
        symbols: [CORR_DATA, RES, CORR_RES, CORR_DATA_SUB, PREDICT, DATA+PREDICT]
    doc: Data to be outputed after calibration
  model_column:
    type: string?
    doc: Visbility model column
  make_plots:
    type: boolean?
    doc: Make gain plots
  Bjones_chisq_clipping:
    type: boolean?
    doc: Bjones chi square clipping
  Bjones_ampl_clipping_high:
    type: float?
    doc: Bjones flagging amplitude
  spw_id:
    type: int?
    doc: SPW ID
  beam_m_axis:
    type: string?
    doc: Beam m axis
  DDjones_niter:
    type: int?
    doc: Number of iterations
  IFRjones:
    type: boolean?
    doc: Enable interferometer based gain solutions
  DDjones_smoothing_intervals:
    type: int[]?
    doc: Smoothing intervals in time and frequency in time/frequency bins. Should
      be given as a list of two integers
  DDjones_thresh_sigma:
    type: float?
    doc: DDjones threshold level
  Gjones_apply_only:
    type: boolean?
    doc: Apply existing gains
  beam_l_axis:
    type: string?
    doc: Beam l axis
  Gjones_matrix_type:
    type:
      type: enum
      symbols: [Gain2x2, GainDiag, GainDiagPhase, GainDiag2a, GainDiagCommon]
    doc: Jones matrix type
    default: Gain2x2
  DDjones_ampl_clipping_low:
    type: float?
    doc: DDjones flagging amplitude
  DDjones_apply_only:
    type: boolean?
    doc: Apply existing gains
  read_flagsets:
    type: string?
    doc: Read flagsets
  Gjones_smoothing_intervals:
    type: int[]?
    doc: Solution intervals in time and frequency in time/frequency bins. Should be
      given as a list of two integers
  Bjones_thresh_sigma:
    type: float?
    doc: Bjones threshold level
  threads:
    type: int?
    doc: Number of CPUs to use for  multithreading
  Bjones_apply_only:
    type: boolean?
    doc: Apply existing gains
  DDjones_ampl_clipping:
    type: boolean?
    doc: DDjones amplitude clipping
  Bjones_ampl_clipping:
    type: boolean?
    doc: Bjones amplitude clipping
  beam_type:
    type:
      - 'null'
      - type: enum
        symbols: [fits, emsss]
    doc: Type of input beam files
  tdlconf:
    type: File?
    doc: TDL configuration file. If not specified, will use a default template
  Bjones:
    type: boolean?
    doc: 'Enable Bjones direction dependent calibration '
  Gjones_ampl_clipping_low:
    type: float?
    doc: Gjones flagging amplitude
    default: 0.3
  DDjones_chisq_clipping:
    type: boolean?
    doc: DDjones chi square clipping
  DDjones:
    type: boolean?
    doc: Enable direction dependent calibration
  data_selection:
    type: string?
    doc: TaQL selction string
  correlations:
    type:
      - 'null'
      - type: enum
        symbols: [2x2, '2x2, diagonal terms only', '2', '1', 1 corr to 2x2 diag]
    doc: Correlations to use
  output_column:
    type: string?
    doc: Column that the calibrated data should be dumped into
  column:
    type: string?
    doc: Column that has the data to be calibrated
  fill_legacy_flags:
    type: boolean?
    doc: Fill legacy flags
  Gjones_solution_intervals:
    type: int[]?
    doc: Solution intervals in time and frequency in time/frequency bins. Should be
      given as a list of two integers
  Bjones_solution_intervals:
    type: int[]?
    doc: Solution intervals in time and frequency in time/frequency bins for Bjones.
      Should be given as a list of two integers
  Ejones:
    type: boolean?
    doc: Add a primary beam model
  write_flagset_policy:
    type:
      - 'null'
      - type: enum
        symbols: [add, replace]
    doc: Add or replace flagset if it already exists.
  label:
    type: string?
    doc: Label for gain and diagnostic plots from the caibration. May not be needed
      if 'prefix' is provided.
  parallactic_angle_rotation:
    type: boolean?
    doc: Enable parallactic angle rotation. Enable if telescope mount is ALT-AZ
  field_id:
    type: int?
    doc: Field ID
  tile_size:
    type: int?
    doc: Size of tile (time bins) to process. Can be used to reduce memory footprint
  Gjones:
    type: boolean?
    doc: Enable direction dependent calibration
  write_flags_to_ms:
    type: boolean?
    doc: Write flags to MS
  DDjones_ampl_clipping_high:
    type: float?
    doc: DDjones flagging amplitude
  msname:
    type: Directory
    doc: Name of MS to be calibrated
  save_config:
    type: string?
    doc: Save final configuration (after all command-line arguments have been applied)
  Gjones_gain_table:
    type: string?
    doc: G Jones gain table file name
  Bjones_gain_table:
    type: string?
    doc: B Jones gain table file name
  DDjones_gain_table:
    type: string?
    doc: DD Jones gain table file name
  IFRjones_gain_table:
    type: string?
    doc: IFR Jones gain table file name

outputs:
  cp_file_out:
    type: File
    doc: Save gain file
    outputBinding:
      glob: '*.cp'
  msname_out:
    type: Directory
    doc: Output ms
    outputBinding:
      outputEval: $(inputs.msname)

