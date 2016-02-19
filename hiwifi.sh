while true
do
	echo ""
	echo ""
	echo "*********************************************************"
	echo "                  极路由工具箱v1.0                       "
	echo "                                  ——Powered by 火日攻天  "
	echo " 为了方便root后的操作写的，有些借鉴了之前的大牛的成果    "
	echo " 再此对三流火，freedom等大神表示感谢                     "
	echo " 脚本仅在极3测试过，不过很多功能都是在我有极2的时候写的  "
	echo " 理论极1、极1s、极2也可使用，不保证，使用风险自负        "
	echo "                                                         "
	echo "*********************************************************"
	echo ""
	echo "1、保root，备份固件，刷uboot"
	echo "2、常用功能"
	echo "3、还原操作"
	echo "0、退出" 
	read -n1 -p "请选择需要进行的操作[1-3、0]?" selectnum
	echo ""
	case $selectnum in
		1)
			echo ""
			echo ""
			echo "*********************************************************"
			echo "                                                         "
			echo "               保root，备份固件，刷uboot                 "
			echo "                                  ——Powered by 火日攻天  "
			echo "                                                         "
			echo "*********************************************************"	
			echo "1、升级后保持root，不更新uboot（每次升级后建议重新操作）"
			echo "2、备份所有（mtd0-9，SD卡加密分区密码）"
			echo "3、刷uboot"
			echo "4、关闭reset功能（防失去root）" 
			echo "5、还原reset功能" 
			echo "0、返回" 
			read -n1 -p "请选择需要进行的操作[1-5、0]?" selectnum
			echo ""
			case $selectnum in
				1)
					echo '升级后保持root，不更新uboot（每次升级后需要重新操作）'
					echo '请不要再设置里恢复出厂设置，也不要长按reset键'
					echo '害怕自己手残，请运行4、关闭reset键功能'
								
					echo "config dropbear" > /etc/config/dropbear;
					echo "	option PasswordAuth 'on'" >> /etc/config/dropbear;
					echo "	option RootPasswordAuth 'on'" >> /etc/config/dropbear;
					echo "	option Port '22'" >> /etc/config/dropbear;
					echo "	option enable 'on'" >> /etc/config/dropbear;
					ln -s /etc/config/dropbear /etc/rc.d/S39dropbear > /dev/null 2>&1
					grep -q "sed -i 's/1022/22/g' /etc/config/dropbear" /etc/rc.local || sed -i "/exit 0/i\sed -i 's/1022/22/g' /etc/config/dropbear" /etc/rc.local
					grep -q "/etc/init.d/dropbear enable" /etc/rc.local || sed -i "/exit 0/i\/etc/init.d/dropbear enable" /etc/rc.local
					grep -q "/etc/init.d/dropbear start" /etc/rc.local || sed -i "/exit 0/i\/etc/init.d/dropbear start" /etc/rc.local
					echo "/etc/rc.local" > /etc/sysupgrade.conf;
					echo "/etc/config/dropbear" >> /etc/sysupgrade.conf;
					echo "/etc/rc.d/S39dropbear" >> /etc/sysupgrade.conf;
					echo "/etc/sysupgrade.conf" >> /etc/sysupgrade.conf;
					echo "/lib/upgrade/keep.d/firesun" >> /etc/sysupgrade.conf;
					if [ -f "/lib/upgrade/hiwifi.sh" ]; then
						echo "/lib/upgrade/hiwifi.sh" >> /etc/sysupgrade.conf;
					fi
					echo "/etc/rc.local" > /lib/upgrade/keep.d/firesun;
					echo "/etc/config/dropbear" >> /lib/upgrade/keep.d/firesun;
					echo "/etc/rc.d/S39dropbear" >> /lib/upgrade/keep.d/firesun;
					echo "/etc/sysupgrade.conf" >> /lib/upgrade/keep.d/firesun;
					echo "/lib/upgrade/keep.d/firesun" >> /lib/upgrade/keep.d/firesun;
					if [ -f "/lib/upgrade/hiwifi.sh" ]; then
						echo "/lib/upgrade/hiwifi.sh" >> /lib/upgrade/keep.d/firesun;
					fi
					if [ -f "/lib/upgrade/hiwifi.sh" ]; then
						sed -i 's/upgrade_boot=1/upgrade_boot=0/g' /lib/upgrade/hiwifi.sh
					fi
					
					echo "保root不升uboot成功"
					echo "如更新了系统，建议重做此操作（保险起见）"

					echo ''
					read -n1 -s -p "按下任意键继续" var
					;;
				2)
					
					echo "备份mtd0-9"
					echo "备份mtd0到/tmp/mtd0.bin"
					cat /dev/mtd0 > /tmp/mtd0.bin
					echo "备份mtd1到/tmp/mtd1.bin"
					cat /dev/mtd1 > mtd1.bin
					echo "备份mtd2到/tmp/mtd2.bin"
					cat /dev/mtd2 > mtd2.bin
					echo "备份mtd3到/tmp/mtd3.bin"
					cat /dev/mtd3 > mtd3.bin
					echo "备份mtd4到/tmp/mtd4.bin"
					cat /dev/mtd4 > mtd4.bin
					echo "备份mtd5到/tmp/mtd5.bin"
					cat /dev/mtd5 > mtd5.bin
					echo "备份mtd6到/tmp/mtd6.bin"
					cat /dev/mtd6 > mtd6.bin
					echo "备份mtd7到/tmp/mtd7.bin"
					cat /dev/mtd7 > mtd7.bin
					echo "备份mtd8到/tmp/mtd8.bin"
					cat /dev/mtd8 > mtd8.bin
					echo "备份mtd9到/tmp/mtd9.bin"
					cat /dev/mtd9 > mtd9.bin
					
					echo "备份编程器固件到/tmp/fullflash.bin"
					cat /dev/mtd0 /dev/mtd1 /dev/mtd2 /dev/mtd9 /dev/mtd6 /dev/mtd7 /dev/mtd8 > /tmp/fullflash.bin
					
					echo "备份SD卡分区密钥到/tmp/key.txt"
					/sbin/hi_crypto_key device-crypt-key
					/sbin/hi_crypto_key device-crypt-key > /tmp/key.txt
					echo "全部备份完成，请到/tmp/目录复制"		
					
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;		
					
				3)
				
					echo "uboot操作——Powered by 火日攻天"
					echo "1、自己指定uboot"
					read -n1 -p "请选择需要进行的操作[1]?" ubooti
					case "$ubooti" in
						1)
							read -p "请输入uboot路径（如/tmp/uboot.bin）:" ubootpath
							if [ -f "$ubootpath" ]; then 
								echo "请确认"
								echo $ubootpath
								echo "地址正确"
								read -n1 -p "开始替换Uboot，是否继续,请输入[Y/N]?" yn
								echo ""
								if [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then
									mtd -r write $ubootpath u-boot
									echo "刷uboot成功"
								else
									echo "未进行替换"
								fi					
							else
								echo "uboot文件不存在" 
							fi 
							;;
					esac
					
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;
			
				4)	
					echo "备份配置"
					cp /etc/config/system /etc/config/system.firesun.bak
					cp /usr/lib/lua/luci/view/admin_web/system/reboot_reset.htm /usr/lib/lua/luci/view/admin_web/system/reboot_reset.htm.firesun.bak
					cp /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm.firesun.bak
					
					echo "关闭reset按键的功能"
					sed -i "/^config button 'btn_RESET'$/{NNNNN; d}" /etc/config/system 	
					
					echo "关闭系统后台恢复出厂设置的功能"
					sed  -i 's/$("#reset_btn").click(function(){$/&\nalert("要不要root了，还reset！");return;/' /usr/lib/lua/luci/view/admin_web/system/reboot_reset.htm
					sed -i 's/window.parent.reset_window(format_disk, device_type);/\/\/window.parent.reset_window(format_disk, device_type);/g' /usr/lib/lua/luci/view/admin_web/system/reboot_reset.htm
					
					sed  -i 'N;/\n.*path={"admin_web", "system","reboot_reset"}/!P;D' /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm
					sed -i '/path={"admin_web", "system","reboot_reset"}/{NN; d}' /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm
					
					echo "操作成功，请重启系统生效，最好同时清除浏览器缓存"
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;
				5)	
					if [ -f "/etc/config/system.firesun.bak" ] && [ -f "/usr/lib/lua/luci/view/admin_web/system/reboot_reset.htm.firesun.bak" ] && [ -f "/usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm.firesun.bak" ]; then 
						echo '还原系统配置'
						cp /etc/config/system.firesun.bak /etc/config/system
						cp /usr/lib/lua/luci/view/admin_web/system/reboot_reset.htm.firesun.bak /usr/lib/lua/luci/view/admin_web/system/reboot_reset.htm
						cp /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm.firesun.bak /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm
						rm -f /etc/config/system.firesun.bak
						rm -f /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm.firesun.bak
						rm -f /usr/lib/lua/luci/view/admin_web/system/reboot_reset.htm.firesun.bak
						echo '还原成功，请重启系统生效'
					else
						echo "备份文件不存在，无法还原" 
					fi 
					
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;
				0)
					echo "返回"
					;;
				*)
					echo "输入错误"
					echo ""
					read -n1 -s -p "按下任意键继续" var
			esac
			;;
		2)
			echo ""
			echo ""
			echo "*********************************************************"
			echo "                                                         "
			echo "                      常用功能                           "
			echo "                                  ——Powered by 火日攻天  "
			echo "                                                         "
			echo "*********************************************************"	
		
			echo "1、开启根目录共享"
			echo "2、允许远程访问ssh"
			echo "3、使用openwrt源"
			echo "4、去除4006024680.com"
			echo "5、Hosts操作"	
			echo "6、移除华3认证"	
			echo "7、移除锐捷认证"	
			echo "0、返回" 
			read -n1 -p "请选择需要进行的操作[1-7、0]?" selectnum
			echo ""
			case $selectnum in
				1)
					echo '开启根目录共享——Powered by 火日攻天'
					echo '请输入samba密码（账号为root）'
					echo '如果输错了，请自己执行smbpasswd -a root更改密码'
					smbpasswd -a root
					echo '备份samba配置'
					cp /etc/config/samba /etc/config/samba.firesun.bak
					cp /etc/samba/smb.conf.template /etc/samba/smb.conf.template.firesun.bak
					echo '添加根目录共享为HiWiFi'
					echo "config sambashare 'HiWiFi' " >> /etc/config/samba
					echo "	option name 'HiWiFi'" >> /etc/config/samba
					echo "	option read_only 'no'" >> /etc/config/samba
					echo "	option create_mask '0644'" >> /etc/config/samba
					echo "	option dir_mask '0644'" >> /etc/config/samba
					echo "	option path '/'" >> /etc/config/samba
					echo "	option guest_ok 'no'" >> /etc/config/samba
					echo "	option users 'root '" >> /etc/config/samba
					echo '允许root账户登录samba'
					sed -i 's/invalid/#invalid/g' /etc/samba/smb.conf.template
					echo '重启samba'
					/etc/init.d/samba reload
					echo '开启成功，请在我的电脑输入\\192.168.199.1\查看名为HiWiFi的共享'
					
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;
				2)
					echo '允许远程访问ssh——Powered by 火日攻天'
					echo '打开防火墙22端口'
					echo '备份防火墙配置'
					cp /etc/config/firewall /etc/config/firewall.firesun.bak
					echo "config rule" >> /etc/config/firewall
					echo "	option name 'wanssh'" >> /etc/config/firewall
					echo "	option src 'wan'" >> /etc/config/firewall
					echo "	option proto 'tcp'" >> /etc/config/firewall
					echo "	option dest_port '22'" >> /etc/config/firewall
					echo "	option target 'ACCEPT'" >> /etc/config/firewall
					echo '重启防火墙'
					/etc/init.d/firewall restart
					echo '开启成功，建议配合动态域名插件使用'
					
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;		

				3)
					echo '使用openwrt源——Powered by 火日攻天'
					echo '备份系统源配置'
					cp /etc/opkg.conf /etc/opkg.conf.firesun.bak
					cp /etc/opkg.d/opkg-secure.conf /etc/opkg.d/opkg-secure.conf.firesun.bak
					cp /etc/opkg.d/opkg-fast.conf /etc/opkg.d/opkg-fast.conf.firesun.bak
					echo '更改源为openwrt源'
					sed -i '/^src\/gz barrier_breaker/d' /etc/opkg.conf
					sed -i '1isrc/gz barrier_breaker http://downloads.openwrt.org.cn/PandoraBox/ralink/mt7620/packages' /etc/opkg.conf
					sed -i '/^src\/gz barrier_breaker/d' /etc/opkg.d/opkg-secure.conf
					sed -i '1isrc/gz barrier_breaker http://downloads.openwrt.org.cn/PandoraBox/ralink/mt7620/packages' /etc/opkg.d/opkg-secure.conf
					sed -i '/^src\/gz barrier_breaker/d' /etc/opkg.d/opkg-fast.conf
					sed -i '1isrc/gz barrier_breaker http://downloads.openwrt.org.cn/PandoraBox/ralink/mt7620/packages' /etc/opkg.d/opkg-fast.conf
					
					echo '更新源'
					opkg update
					echo '更换成功'
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;
					
				4)
					echo '去除4006024680.com——Powered by 火日攻天'
					echo '备份原网页'
					cp /etc/nginx/turbo_aws_500.html /etc/nginx/turbo_aws_500.html.firesun.bak
					cp /etc/nginx/turbo_aws_502.html /etc/nginx/turbo_aws_502.html.firesun.bak
					cp /etc/nginx/turbo_aws_503.html /etc/nginx/turbo_aws_503.html.firesun.bak
					cp /etc/nginx/turbo_aws_504.html /etc/nginx/turbo_aws_504.html.firesun.bak
					cp /etc/nginx/vh.all.conf /etc/nginx/vh.all.conf.firesun.bak
					cp /etc/nginx/vh.tw-netchk.conf /etc/nginx/vh.tw-netchk.conf.firesun.bak
					echo '去除4006024680.com'
					sed -i 's/4006024680.com/192.168.199.1/g' /etc/nginx/turbo_aws_500.html
					sed -i 's/4006024680.com/192.168.199.1/g' /etc/nginx/turbo_aws_502.html
					sed -i 's/4006024680.com/192.168.199.1/g' /etc/nginx/turbo_aws_503.html
					sed -i 's/4006024680.com/192.168.199.1/g' /etc/nginx/turbo_aws_504.html
					sed -i 's/4006024680.com/192.168.199.1/g' /etc/nginx/vh.all.conf
					sed -i 's/4006024680.com/192.168.199.1/g' /etc/nginx/vh.tw-netchk.conf
					echo '去除成功'
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;

				5)
					echo "Hosts操作——Powered by 火日攻天"
					echo "1、覆盖Host文件"
					echo "2、追加Host文件"
					echo "3、查看自定义Host文件"
					read -n1 -p "请选择需要进行的操作[1-3]?" hostsi
					case "$hostsi" in
						1)
						read -p "请输入hosts路径（如/tmp/hosts）:" hostspath
						if [ -f "$hostspath" ]; then 
							cat $hostspath > /etc/hosts.d/firesunhosts
							echo "覆盖成功"
							/etc/init.d/dnsmasq reload
							echo "重启DNS服务成功"
						else
							echo "Hosts文件不存在" 
						fi 
						;;
						2)
						read -p "请输入hosts路径（如/tmp/hosts）:" hostspath
						if [ -f "$hostspath" ]; then 
							echo "" >> /etc/hosts.d/firesunhosts
							cat $hostspath >> /etc/hosts.d/firesunhosts
							echo "追加成功"
							/etc/init.d/dnsmasq reload
							echo "重启DNS服务成功"
						else
							echo "Hosts文件不存在" 
						fi 
						;;
						3)
						touch /etc/hosts.d/firesunhosts
						cat /etc/hosts.d/firesunhosts
						echo ""
						;;
					esac
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;
					
				6)
					echo "移除华3认证"	
					sed  -i 'N;/\n.*path={"admin_web", "plugin","x3c"}/!P;D' /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm
					sed -i '/path={"admin_web", "plugin","x3c"}/{NN; d}' /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm
					rm -f /usr/lib/lua/luci/view/admin_web/plugin/x3c.htm
					opkg remove x3c8021x	
					echo "移除成功"
					echo ""
					read -n1 -s -p "按下任意键继续" var					
					;;	
				7)
					echo "移除锐捷认证"	
					sed  -i 'N;/\n.*path={"admin_web", "plugin","mentohust"}/!P;D' /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm
					sed -i '/path={"admin_web", "plugin","mentohust"}/{NN; d}' /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm
					rm -f /usr/lib/lua/luci/view/admin_web/plugin/mentohust.htm
					opkg remove mentohust	
					echo "移除成功"
					echo ""
					read -n1 -s -p "按下任意键继续" var					
					;;		
					
				0)
					echo "返回"			
					;;
		 
				*)
					echo "输入错误"
					echo ""
					read -n1 -s -p "按下任意键继续" var
			esac
			;;
		3)
			echo ""
			echo ""
			echo "*********************************************************"
			echo "                                                         "
			echo "                      还原操作                           "
			echo "                                  ——Powered by 火日攻天  "
			echo "                                                         "
			echo "*********************************************************"	
			echo "1、关闭根目录共享"
			echo "2、禁止远程访问ssh"
			echo "3、还原hiwifi源"
			echo "4、还原4006024680.com"
			echo "0、返回" 
			read -n1 -p "请选择需要进行的操作[1-4、0]?" selectnum
			echo ""
			case $selectnum in
				1)
					echo '关闭根目录共享——Powered by 火日攻天'
					if [ -f "/etc/config/samba.firesun.bak" ] && [ -f "/etc/samba/smb.conf.template.firesun.bak" ]; then 
						echo '还原samba配置'
						cp /etc/config/samba.firesun.bak /etc/config/samba
						cp /etc/samba/smb.conf.template.firesun.bak /etc/samba/smb.conf.template
						rm -f /etc/config/samba.firesun.bak
						rm -f /etc/samba/smb.conf.template.firesun.bak
						echo '重启samba'
						/etc/init.d/samba reload
						echo '关闭成功'
					else
						echo "备份文件不存在，无法还原" 
					fi 
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;
				2)
					echo '禁止远程访问ssh——Powered by 火日攻天'
					if [ -f "/etc/config/firewall.firesun.bak" ]; then 
						echo '还原防火墙配置'
						cp /etc/config/firewall.firesun.bak /etc/config/firewall
						rm -f /etc/config/firewall.firesun.bak
						echo '重启防火墙'
						/etc/init.d/firewall restart
						echo '禁止成功'
					else
						echo "备份文件不存在，无法还原" 
					fi 
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;		

				3)
					echo '还原hiwifi源——Powered by 火日攻天'
					if [ -f "/etc/opkg.conf.firesun.bak" ] && [ -f "/etc/opkg.d/opkg-secure.conf.firesun.bak" ] && [ -f "/etc/opkg.d/opkg-fast.conf.firesun.bak" ]; then 
						echo '还原系统源配置'
						cp /etc/opkg.conf.firesun.bak /etc/opkg.conf
						cp /etc/opkg.d/opkg-secure.conf.firesun.bak /etc/opkg.d/opkg-secure.conf
						cp /etc/opkg.d/opkg-fast.conf.firesun.bak /etc/opkg.d/opkg-fast.conf
						rm -f /etc/opkg.conf.firesun.bak
						rm -f /etc/opkg.d/opkg-secure.conf.firesun.bak
						rm -f /etc/opkg.d/opkg-fast.conf.firesun.bak
						echo '更新源'
						rm -f /var/opkg-lists/barrier_breaker
						opkg update
						echo '还原成功'
					else
						echo "备份文件不存在，无法还原" 
					fi 	
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;
					
				4)
					echo '还原4006024680.com——Powered by 火日攻天'
					if [ -f "/etc/nginx/turbo_aws_500.html.firesun.bak" ] && [ -f "/etc/nginx/turbo_aws_502.html.firesun.bak" ] && [ -f "/etc/nginx/turbo_aws_503.html.firesun.bak" ] && [ -f "/etc/nginx/turbo_aws_504.html.firesun.bak" ] && [ -f "/etc/nginx/vh.all.conf.firesun.bak" ] && [ -f "/etc/nginx/vh.tw-netchk.conf.firesun.bak" ]; then 
						echo '还原原网页'
						cp /etc/nginx/turbo_aws_500.html.firesun.bak /etc/nginx/turbo_aws_500.html
						cp /etc/nginx/turbo_aws_502.html.firesun.bak /etc/nginx/turbo_aws_502.html
						cp /etc/nginx/turbo_aws_503.html.firesun.bak /etc/nginx/turbo_aws_503.html
						cp /etc/nginx/turbo_aws_504.html.firesun.bak /etc/nginx/turbo_aws_504.html
						cp /etc/nginx/vh.all.conf.firesun.bak /etc/nginx/vh.all.conf
						cp /etc/nginx/vh.tw-netchk.conf.firesun.bak /etc/nginx/vh.tw-netchk.conf
						rm -f /etc/nginx/turbo_aws_500.html.firesun.bak
						rm -f /etc/nginx/turbo_aws_502.html.firesun.bak
						rm -f /etc/nginx/turbo_aws_503.html.firesun.bak
						rm -f /etc/nginx/turbo_aws_504.html.firesun.bak
						rm -f /etc/nginx/vh.all.conf.firesun.bak
						rm -f /etc/nginx/vh.tw-netchk.conf.firesun.bak
						echo '还原成功'
					else
						echo "备份文件不存在，无法还原" 
					fi 
					
					echo ""
					read -n1 -s -p "按下任意键继续" var
					;;
				0)
					echo "返回"
					;;
				*)
					echo "输入错误"
					echo ""
					read -n1 -s -p "按下任意键继续" var
			esac
			;;	
		0)
			echo "退出"
			exit 0
			;;
		*)
			echo "输入错误"
			echo ""
			read -n1 -s -p "按下任意键继续" var
	esac
done
