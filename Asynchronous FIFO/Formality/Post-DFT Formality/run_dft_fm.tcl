
mkdir -p logs
mkdir -p reports

# Invoke Formality
fm_shell -f dft_fm_script.tcl | tee logs/dft_fm_log.log
