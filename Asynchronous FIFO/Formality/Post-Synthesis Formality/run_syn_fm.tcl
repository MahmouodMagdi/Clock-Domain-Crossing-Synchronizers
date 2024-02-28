
mkdir -p logs
mkdir -p reports

# Invoke Formality
fm_shell -f syn_fm_script.tcl | tee logs/syn_fm_log.log
