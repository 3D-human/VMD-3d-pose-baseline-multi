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

rem ---  �O���[�o��X���p�x�␳

echo --------------
set GROBAL_X_ANGLE=16
echo 3D�������ۂɃO���[�o��X���Ɏ኱�X���̂�␳���܂�
echo 0�`360�x�̐����݂̂���͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A%GROBAL_X_ANGLE%�x��]���܂��B
set /P GROBAL_X_ANGLE="�O���[�o��X���p�x�␳: "

rem ---  �����t���[���Ԉ����p�x

echo --------------
set SAME_DECIMATION_ANGLE=30
echo �t���[���̊Ԉ����Ɏg�p����p�x���w�肵�܂�
echo ������(X�������ւ̉�]�������ꍇ��)�Ɏw�肳�ꂽ�p�x�ȓ��̉�]���������ꍇ�ɊԈ�������܂��B
echo 0�`360�x�̐����݂̂���͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A%SAME_DECIMATION_ANGLE%�x�Ԉ����܂��B
set /P SAME_DECIMATION_ANGLE="�����t���[���Ԉ����p�x: "

rem ---  �َ��t���[���Ԉ����p�x

echo --------------
set DIFF_DECIMATION_ANGLE=6
echo �t���[���̊Ԉ����Ɏg�p����p�x���w�肵�܂�
echo �Ⴄ����(X�������ւ̉�]����Z�������ɉ�]�����ꍇ��)�Ɏw�肳�ꂽ�p�x�ȓ��̉�]���������ꍇ�ɊԈ�������܂��B
echo 0�`360�x�̐����݂̂���͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A%DIFF_DECIMATION_ANGLE%�x�Ԉ����܂��B
set /P DIFF_DECIMATION_ANGLE="�َ��t���[���Ԉ����p�x: "


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
python applications\pos2vmd_multi.py -v %VERBOSE% -t %TARGET_DIR% -x %GROBAL_X_ANGLE% -s %SAME_DECIMATION_ANGLE% -d %DIFF_DECIMATION_ANGLE%

