@echo off
rem --- 
rem ---  3D �� �֐߃f�[�^���� vmd�f�[�^�ɕϊ�
rem --- 

rem ---  �J�����g�f�B���N�g�������s��ɕύX
cd /d %~dp0

rem ---  3D�f�B���N�g���m�F
set /P TARGET_DIR="3D�f�[�^�̏o�͌��ʃf�B���N�g���p�X: "
rem --- echo PERSON_IDX�F%TARGET_DIR%

rem ---  X���p�x�␳
rem --- set /P X_ANGLE="X���p�x�␳(0�`360): "
rem --- echo X_ANGLE�F%X_ANGLE%

rem ---  python ���s
rem --- �ڍׂȃ��O���s�v�ȏꍇ�A--v �̌��̐������u2�v�ɐݒ肵�ĉ�����
rem --- �ڍׂȃ��O���K�v�ȏꍇ�A--v �̌��̐������u3�v�ɐݒ肵�ĉ�����
python applications\pos2vmd_multi.py --v 2 --t %TARGET_DIR% --a 0

