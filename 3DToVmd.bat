@echo off
rem --- 
rem ---  3D �� �֐߃f�[�^���� vmd�f�[�^�ɕϊ�
rem --- 

rem ---  �J�����g�f�B���N�g�������s��ɕύX
cd /d %~dp0

rem ---  ��͌���JSON�f�B���N�g���p�X
echo 3d-pose-baseline-vmd�̉�͌��ʃf�B���N�g���̃t���p�X����͂��ĉ������B(3d_{���s����}_idx00)
echo ���̐ݒ�͔��p�p�����̂ݐݒ�\�ŁA�K�{���ڂł��B
set TARGET_DIR=
set /P TARGET_DIR=��3D��͌��ʃf�B���N�g���p�X: 
rem echo TARGET_DIR�F%TARGET_DIR%

IF /I "%TARGET_DIR%" EQU "" (
    ECHO 3D��͌��ʃf�B���N�g���p�X���ݒ肳��Ă��Ȃ����߁A�����𒆒f���܂��B
    EXIT /B
)

rem ---  �㔼�g�O���[�o��X���p�x�␳

echo --------------
set GROBAL_UPPER_X_ANGLE=37
echo 3D�������ۂɏ㔼�g���O���[�o��X���Ɏ኱�X���̂�␳���܂�
echo 0�`360�x�̐����݂̂���͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A%GROBAL_UPPER_X_ANGLE%�x��]���܂��B
set /P GROBAL_UPPER_X_ANGLE="�㔼�g�O���[�o��X���p�x�␳: "

rem ---  �����g�O���[�o��X���p�x�␳

echo --------------
set GROBAL_LOWER_X_ANGLE=17
echo 3D�������ۂɉ����g���O���[�o��X���Ɏ኱�X���̂�␳���܂�
echo 0�`360�x�̐����݂̂���͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A%GROBAL_LOWER_X_ANGLE%�x��]���܂��B
set /P GROBAL_LOWER_X_ANGLE="�㔼�g�O���[�o��X���p�x�␳: "


rem ---  �ڍ׃��O�L��

echo --------------
echo �ڍׂȃ��O���o�����Ayes �� no ����͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A�ʏ탍�O�̂ݏo�͂��܂��B
set VERBOSE=2
set /P IS_DEBUG="�ڍ׃��O[yes/no]: "

IF /I "%IS_DEBUG%" EQU "yes" (
    set VERBOSE=3
)


rem ---  python ���s
python applications\pos2vmd_multi.py --v %VERBOSE% --t %TARGET_DIR% --u %GROBAL_UPPER_X_ANGLE% --l %GROBAL_LOWER_X_ANGLE%

