::@echo off

::%~d0
::cd %~d0\AI

echo ------------------------------
echo Activate Python VENV

set VENVDIR=.venv
call %VENVDIR%/Scripts/activate.bat

python --version

::python -m pip install --upgrade pip
::python -m pip install -r kohya/requirements_windows.txt

echo -------------------------------

::cd %~d0\AI\kohya
cd kohya_ss

:: scale_parameter
set LORA_NAME=train_owhx
set TRAIN_SCRIPT=./sd-scripts/sdxl_train_network.py
set TRAIN_DATA=D:/AI/input/train
set REG_DATA=D:/AI/input/reg
set LORA_DIR=D:/AI/output/lora/train
set MODEL=D:/AI-Models/checkpoints/sdxl/sd_xl_base_1.0.safetensors
set LOGFOLDER=D:/AI/output/lora/log
set CPU_CORES=4

::@echo on

accelerate launch ^
--num_cpu_threads_per_process=%CPU_CORES% "%TRAIN_SCRIPT%" --enable_bucket --pretrained_model_name_or_path="%MODEL%" ^
--train_data_dir="%TRAIN_DATA%" ^
--reg_data_dir="%REG_DATA%" ^
--resolution="1024,1024" ^
--output_dir="%LORA_DIR%" ^
--logging_dir="%LOGFOLDER%" ^
--network_alpha="1" ^
--save_model_as=safetensors ^
--network_module=networks.lora --text_encoder_lr=0.0004 --unet_lr=0.0004 --network_dim=256 ^
--output_name="%LORA_NAME%" --lr_scheduler_num_cycles="10" --no_half_vae ^
--learning_rate="0.0004" --lr_scheduler="constant" --train_batch_size="1" ^
--max_train_steps="150" ^
--save_every_n_epochs="1" ^
--mixed_precision="bf16" ^
--save_precision="bf16" --cache_latents --cache_latents_to_disk --optimizer_type="Adafactor" ^
--optimizer_args scale_parameter=False relative_step=False ^
warmup_init=False --max_data_loader_n_workers="0" --bucket_reso_steps=64 --gradient_checkpointing --xformers --bucket_no_upscale

pause