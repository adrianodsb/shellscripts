################################################################
#                                                              #
#       Registrar Canal                                        #
#                                                              #
################################################################


VAR1=`subscription-manager identity | grep -i "org ID:" | awk -F " " '{print $3}'`


if [ $VAR1 == DREADS ]

                then
                        VAR2=`subscription-manager list --consumed | grep -i "No consumed" | awk -F " " '{print $1}'`

                        if [ "$VAR2" == "Nenhum" ]

                                then

                                echo "Qual Canal voce deseja subscrever?"
                                echo "(1) RHEL for SAP"
                                echo "(2) RHEL VDC"
                                read opcao

                                        case $opcao in

                                                1) subscription-manager attach --pool=008f86a15b0ef9de015b10484dee074a ;;
                                                2) subscription-manager attach --pool=008f86a15b0ef9de015b10484e5c07aa ;;

                                        esac


                                 else
                                        VAR3=`subscription-manager list --consumed | grep -i "Nome da Subscrição:"`

                                        echo -n "O servidor utilza o canal - $VAR3"
                        fi



                else

                        echo -n " O servidor não esta registrado no satellite"
                        echo -n " Para register use o script rhn_register.sh"

fi

----

#!/bin/bash


#################################
#                               #
#       Resolver problemas      #
#                               #
#################################

subscription-manager remove --all
subscription-manager unregister
subscription-manager clean

VAR1=`subscription-manager identity | grep -i "org ID:" | awk -F " " '{print $3}'`

VAR2=`rpm -qa | grep katello-ca-consumer`

if [ "$VAR1" == "DREADS" ]

                then
                        echo "Servidor Já está resitrado"

                        subscription-manager identity

                else

                        echo -n "Qual a versão do RHEL (ex. 6.5)"
                        read versao
                        rpm -e $VAR2
                        rpm -Uvh http://s1rhnp01.capgv.intra.bnb/pub/katello-ca-consumer-latest.noarch.rpm
                        subscription-manager register --org="DREADS" --activationkey="key_$versao"
                        echo "Servidor registrado"

fi

----

#!/bin/bash


################################################################
#                                                              #
#       Registrar Servidor                                     #
#                                                              #
################################################################


VAR1=`subscription-manager identity | grep -i "org ID:" | awk -F " " '{print $3}'`

VAR2=`rpm -qa | grep katello-ca-consumer`

if [ "$VAR1" == "DREADS" ]

                then
                        echo "Servidor Já está resitrado"

                        subscription-manager identity

                else

                        echo -n "Qual a versão do RHEL (ex. 6.5)"
                        read versao
                        rpm -e $VAR2
                        rpm -Uvh http://s1rhnp01.capgv.intra.bnb/pub/katello-ca-consumer-latest.noarch.rpm
                        subscription-manager register --org="DREADS" --activationkey="key_$versao"
                        echo "Servidor registrado"

fi

----

#!/bin/bash


##############################
#                            #
#    Ataualizar Katello      #
#                            #
##############################

VAR1=`rpm -qa | grep katello-ca-consumer-s1rhnp01.capgv.intra.bnb-1.0-1.noarch`

if [ $? -eq 0 ]

                then
                        rpm -e $VAR1
                        rpm -ivh http://s1rhnp01.capgv.intra.bnb/pub/katello-ca-consumer-latest.noarch.rpm


                else
                     VAR2=`rpm -qa | grep katello-ca-consumer-s1rhnp01.capgv.intra.bnb-1.0-2.noarch`
                        echo "Katello já está na versão mais atual - $VAR2"

fi
