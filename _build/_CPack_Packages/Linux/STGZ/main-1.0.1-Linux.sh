#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the main-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the main-1.0.1-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "main Installer Version: 1.0.1, Copyright (c) Solve equation"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
LICENSE
=======

This is an installer created using CPack (https://cmake.org). No license provided.


____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the main will be installed in:"
    echo "  \"${toplevel}/main-1.0.1-Linux\""
    echo "Do you want to include the subdirectory main-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/main-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +155 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the main-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� �˄b �Z]l��;����`Z>RظMzn���|�3�X8X; 7����{{��[gwR�DH)'c5�CR%y�ST�/<RUML�R�-�h�C�Fj+Y
R�҇�љݙ��܎� ���?�����?�kg�~ƶ�np�%��RI	�r*c�Hr"���D2��brO*� R�~7K�vT5�842��8U�z����!Ϳ�rQu�զ��G4���x�S�^<��d<��'����H���^����u���]�a��c��dK�%T�;��5�:�nA��u�U��?�[.�2
�4��HgK蕖��$�7UGR����S,2^�h�0��l߮��Y��8~h�zϦ$׸)ū�8�I����Q���.I�BNP�wVL\_���!f��:�pҷ��9&D�e&"%����q�q�b<�e��h9)�����愡AݲL�II/u�t�7$��9Չ���Kw�V��i �������ӳ��?����}��Rg�O%df�ew��c���� ������C�R��j�cUx*Nk�B�MJ�h�GF�����d<�t�V6�Ύ@�繨�g�N�JpJ�l����$<�&�,Bt��݋�/&,=��>چ���J���:����N�\�]ݕ(�rmX�R3J7�;�����Јr�z�F�-�����W���e�\��nM#�y�2��[[�k��oP�z#|�"����s.ܝ�~<�A+R��ZJ��2�����!3˽⯹
��~��ye�-�Q��+(�e���q5����Ee&��6�*�#:�{R�;�u?ۈ;?P���,��?�x������x���Vܜ�3雕_Zl� �.e[��I���������Sq���۷����l�GU�o���Rdt�Xp�Ҷh"�*ݒ��x,KD�Nw՗�����gGA��ed�bi����0�Z��W�z|x	��H?��Zpwˊ�"�.p��k��m\�D����E
x����w��̲�ր��Wn��uۯ���z_.�W�����m���	����
� o�-���Gx��&J�8l!y ߨ]\Ai3/i�a�.��pG�gV��'�%�� �?���P�3�5�����m��5��a�н�ZE��Q�o��3�ၽ{G҇�]���j%����n�:�=��S�w+r��#��My��>�_��#��#�� ��N�2O����W-�0
8���I�C����_�zR~����_���۞�8�[�b���� ��P�*����Y��e����K���1������������2�&���Y��t�L[�HL;��l?��3���_���U�l�>9��(w,/��7KϫQG/9 �QD�m�A��b�Z��2�id�@�#�}\�ߢx�棋��fNN��`:zR[ѕT;F��bt�2��s�8�shm�hF',�xo(�ߢ���$y3�������i.���o��������0��t~��D|���Ҋj{��tM���I�?YK�GIM�.��n�{	��;���N����?g�r��~���{.��#>��]��-Ɵ	�W�=������s�)Q�/J|�*���y������1���s������o��>ai��rT�Q�9��W_O ����_���G��u�����e2~c�L�~��bc����
�����V;E�@��M`!��r����	��X�{�-���1�������&���!w���2}s��u��l����sx?����}�$�r|\�х�#�4|�r�K5{@K���N/�+��oj�W�2�Z���U��e��(��8�$1?�w�g;��.��'eR0Ϥ(��J�x>��,{"0�������23z^)����̎"(}��0��+�k���|F�iv]9O|��Q#���Q^�&x��7����L��N�o��Ne����u^��V����q��������wЏ�/a��%����'�k�s��NX�7���4����4������n����\���!�+GS��㍳Fk��8]�[���5�秖e�}�o�����;)o`l�j�,�O"v�N٧f^����-�?��E�Y��vҞ�ؘ�7���%��
�	�˂���7����,�A}Y�~c��)�Ah�F��ńљ�:�h�����S�h�j!3�g��1è�P�.��x�,��Ľ��x �XcU�x����P�L���b!Gp$	�ЍqM�H�j�̝"��r�`V5��>ô!r�'���v�`�6aM]^�S�{T���̤��eĳm{�e�F�eվ'���,�v��Y���:��1�,K�����N��Ǭ�����f�϶a_te�Ly-w-�G���egw��O�ó^iϝ�s��px?��e�'Jb�Ǎ�rX�S��e�nqx���Yr�SV�g��6�Y5j����b~�D�����a����A��m�o�XV������:�mĆ��j�Y����U���?�Y��Y�7�?S�N����̏U�����~������w������5�X"e<~a�8�6F�y��!�QVM!W�~�y���A���s���$K�$K��� ���N 2  