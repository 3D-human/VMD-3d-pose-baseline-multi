@echo off
rem --- 
rem ---  3D �� �֐߃f�[�^���� vmd�f�[�^�ɕϊ�
rem --- 

rem ---  �J�����g�f�B���N�g�������s��ɕύX
cd /d %~dp0

rem ---  3d-pose-baseline-vmd��͌���JSON�f�B���N�g���p�X
echo 3d-pose-baseline-vmd�̉�͌��ʃf�B���N�g���̐�΃p�X����͂��ĉ������B(3d_{���s����}_idx00)
echo ���̐ݒ�͔��p�p�����̂ݐݒ�\�ŁA�K�{���ڂł��B
set TARGET_DIR=
set /P TARGET_DIR=��3D��͌��ʃf�B���N�g���p�X: 
rem echo TARGET_DIR�F%TARGET_DIR%

IF /I "%TARGET_DIR%" EQU "" (
    ECHO 3D��͌��ʃf�B���N�g���p�X���ݒ肳��Ă��Ȃ����߁A�����𒆒f���܂��B
    EXIT /B
)

rem ---  �{�[���\��CSV�t�@�C��
echo --------------
set MODEL_BONE_CSV=born\���ɂ܂����~�N�{�[��.csv
echo �g���[�X�Ώۃ��f���̃{�[���\��CSV�t�@�C���̑��΂������͐�΃p�X����͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A�u%MODEL_BONE_CSV%�v�̃t�@�C����ǂݍ��݂܂��B
set /P MODEL_BONE_CSV="�{�[���\��CSV�t�@�C��: "

rem ---  �����p���t���[���ԍ�
echo --------------
set UPRIGHT_FRAME_IDX=1
echo �ł��邾���l�������ʌ����Œ������Ă���t���[����INDEX(1�n�܂�)����͂��ĉ������B
echo ���Ɏ�Ɨ����t�����̎O�p�����ʔ���̊�ƂȂ�܂��B
echo �w�肳�ꂽ�t���[���̐l���̈ʒu��MMD�̃Z���^�[�ƂȂ�܂��B
echo �������͂����AENTER�����������ꍇ�A%UPRIGHT_FRAME_IDX%�t���[���ڂ𒼗��Ƃ��ď������܂��B
set /P UPRIGHT_FRAME_IDX="�����p���t���[��INDEX: "

rem ---  FK or IK

echo --------------
echo ����IK�ŏo�͂��邩�Ayes �� no ����͂��ĉ������B
echo no ����͂����ꍇ�AFK�ŏo�͂��܂�
echo �������͂����AENTER�����������ꍇ�AIK�ŏo�͂��܂��B
set IK_FLAG=1
set IS_IK=yes
set /P IS_IK="��IK�o�͐���[yes/no]: "

IF /I "%IS_IK%" EQU "no" (
    set IK_FLAG=0
    set HEEL_POSITION=0
    rem -- FK�̏ꍇ�A���ʒu�␳�͍s��Ȃ�
    goto CONFIRM_CENTER
)

rem ---  ���ʒu�␳
echo --------------
set HEEL_POSITION=0
echo ����Y���␳�l�𐔒l(������)�œ��͂��ĉ������B
echo �}�C�i�X�l����͂���ƒn�ʂɋߕt���A�v���X�l����͂���ƒn�ʂ��牓������܂��B
echo ������x�͎����ŕ␳���܂����A�␳������Ȃ��ꍇ�ɁA�ݒ肵�ĉ������B
echo �������͂����AENTER�����������ꍇ�A�␳���s���܂���B
set /P HEEL_POSITION="���ʒu�␳: "


:CONFIRM_CENTER

rem ---  �Z���^�[XY�ړ��{��
echo --------------
set CENTER_XY_SCALE=30
echo �Z���^�[XY�ړ��Ɋ|����{���𐮐��œ��͂��ĉ������B
echo �l���������قǁA�Z���^�[XY�ړ��̕����������Ȃ�܂��B
echo �������͂����AENTER�����������ꍇ�A�{���u%CENTER_XY_SCALE%�v�ŏ������܂��B
set /P CENTER_XY_SCALE="�Z���^�[XY�ړ��{��: "

rem ---  �Z���^�[Z�ړ��{��
echo --------------
set CENTER_Z_SCALE=5
echo �Z���^�[Z�ړ��Ɋ|����{���𐔒l(������)�œ��͂��ĉ������B
echo �l���������قǁA�Z���^�[Z�ړ��̕����������Ȃ�܂��B
echo �ڈ��Ƃ��āA�J��������̋������߂��قǁA�{�����������������������ł��B
echo �������͂����AENTER�����������ꍇ�A�{���u%CENTER_Z_SCALE%�v�ŏ������܂��B
echo 0����͂����ꍇ�A�Z���^�[Z���ړ����s���܂���B
set /P CENTER_Z_SCALE="�Z���^�[Z�ړ��{��: "

rem ---  �O���[�o��X���p�x�␳

echo --------------
set GROBAL_X_ANGLE=15
echo 3D�������ۂɃO���[�o��X���Ɏ኱�X���̂�␳���܂�
echo -180�`180�x�̐����݂̂���͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A%GROBAL_X_ANGLE%�x��]���܂��B
set /P GROBAL_X_ANGLE="�O���[�o��X���p�x�␳: "

rem ---  �Z���^�[�ړ��Ԉ�����

echo --------------
set CENTER_DECIMATION_MOVE=0.5
echo �Z���^�[�L�[�̊Ԉ����Ɏg�p����ړ��ʂ𐔒l(������)�Ŏw�肵�܂�
echo �w�肳�ꂽ�͈͓��̈ړ����������ꍇ�ɊԈ�������܂��B
echo �������͂����AENTER�����������ꍇ�A�u%CENTER_DECIMATION_MOVE%�v�̈ړ��ʂŊԈ����܂��B
echo �Z���^�[�ړ��Ԉ����ʂ�0�ɂ����ꍇ�A�Ԉ������s���܂���B
set /P CENTER_DECIMATION_MOVE="�Z���^�[�ړ��Ԉ�����: "

IF /I "%CENTER_DECIMATION_MOVE%" EQU "0" (
    rem -- �Ԉ������s��Ȃ�
    set IK_DECIMATION_MOVE=0
    set DECIMATION_ANGLE=0
    set ALIGNMENT=1
    

    goto CONFRIM_LOG
)
rem -- �Ԉ�������

rem ---  IK�ړ��Ԉ�����

echo --------------
set IK_DECIMATION_MOVE=1.5
echo IK�L�[�̊Ԉ����Ɏg�p����ړ��ʂ𐔒l�i�����j�Ŏw�肵�܂�
echo �w�肳�ꂽ�͈͓��̈ړ����������ꍇ�ɊԈ�������܂��B
echo �������͂����AENTER�����������ꍇ�A�u%IK_DECIMATION_MOVE%�v�̈ړ��ʂŊԈ����܂��B
set /P IK_DECIMATION_MOVE="IK�ړ��Ԉ�����: "

rem ---  �Ԉ����p�x

echo --------------
set DECIMATION_ANGLE=10
echo ��]�L�[�̊Ԉ����Ɏg�p����p�x���w�肵�܂�
echo �w�肳�ꂽ�p�x�ȓ��̉�]���������ꍇ�ɊԈ�������܂��B
echo -180�`180�x�̐����݂̂���͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A%DECIMATION_ANGLE%�x�Ԉ����܂��B
set /P DECIMATION_ANGLE="�Ԉ����p�x: "

rem ---  �Ԉ����L�[����

echo --------------
echo �Ԉ������L�[�𑵂��邩�Ayes �� no ����͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�Ayes�Ƃ݂Ȃ��A�Ԉ������L�[�𑵂��܂��B
set ALIGNMENT=1
set IS_ALIGNMENT=yes
set /P IS_ALIGNMENT="�Ԉ����L�[����[yes/no]: "

IF /I "%IS_ALIGNMENT%" EQU "no" (
    set ALIGNMENT=0
)


rem ---  �ڍ׃��O�L��

:CONFRIM_LOG

echo --------------
echo �ڍׂȃ��O���o�����Ayes �� no ����͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A�ʏ탍�O�̂ݏo�͂��܂��B
set VERBOSE=2
set IS_DEBUG=no
set /P IS_DEBUG="�ڍ׃��O[yes/no]: "

IF /I "%IS_DEBUG%" EQU "yes" (
    set VERBOSE=3
)



rem ---  python ���s
python applications\pos2vmd_multi.py -v %VERBOSE% -t %TARGET_DIR% -b %MODEL_BONE_CSV% -u %UPRIGHT_FRAME_IDX% -c %CENTER_XY_SCALE% -z %CENTER_Z_SCALE% -x %GROBAL_X_ANGLE% -m %CENTER_DECIMATION_MOVE% -i %IK_DECIMATION_MOVE% -d %DECIMATION_ANGLE% -a %ALIGNMENT% -k %IK_FLAG% -e %HEEL_POSITION%

