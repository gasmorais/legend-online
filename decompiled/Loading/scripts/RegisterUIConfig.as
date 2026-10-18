package
{
   public class RegisterUIConfig
   {
      
      public function RegisterUIConfig()
      {
         super();
      }
      
      public function getXML() : XML
      {
         return <style name="mainloadingii" source="ui/zh_cn/swf/mainloadingii.swf">
				  <sets>
					<set type="flash.filters.GlowFilter" stylename="core.normal_f" args="0x000000,1,5,5,3" />
					<set type="flash.filters.ColorMatrixFilter" stylename="core.DefaultFilter" args="1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0" />
					<set type="flash.filters.ColorMatrixFilter" stylename="core.LightFilter" args="1,0,0,0,25,0,1,0,0,25,0,0,1,0,25,0,0,0,1,0"/>
					<set type="flash.filters.ColorMatrixFilter" stylename="core.GrayFilter" args="0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0"/>
					<set type="flash.filters.ColorMatrixFilter" stylename="core.DarkGrayFilter" args="0.1,0.59,0.11,0,0,0.1,0.59,0.11,0,0,0.1,0.59,0.11,0,0,0,0,0,1,0"/>
					<set type="flash.filters.ColorMatrixFilter" stylename="core.DarkFilter" args="0.8,0,0,0,6.1,0,0.8,0,0,6.1,0,0,0.8,0,6.1,0,0,0,1,0"/>
					<set type="flash.text.TextFormat" stylename="mainloadingii.register.ReNameTxt_t" args="Arial,20,0xFFfA04,,,,,,center" />
					<set type="flash.text.TextFormat" stylename="mainloadingii.register.renameFrameDescribeTxt_t" args="Arial,12,0x13b541,,,,,,center" />
					<set type="flash.text.TextFormat" stylename="mainloadingii.register.renameFrameDescribeErrorTxt_t" args="Arial,12,0xFF0000,,,,,,center" />
					<set type="flash.text.TextFormat" stylename="mainloadingii.register.commonTipTF" args="Arial,14,0xffffff" letterSpacing="1" leading="3"/>
					<set type="flash.filters.GlowFilter" stylename="mainloadingii.register.GlowFilter" args="0x00a8ec,1,5,5,5" />
				  </sets>
				  
				  <bitmaps>
					<bitmapData resourceLink="asset.mainloadingii.register.RoleIcon_1" x="508" y="-16" stylename="asset.mainloadingii.register.RoleIcon_1"/>
					<bitmapData resourceLink="asset.mainloadingii.register.RoleIcon_2" x="501" y="43" stylename="asset.mainloadingii.register.RoleIcon_2"/>
					<bitmapData resourceLink="asset.mainloadingii.register.RoleIcon_3" x="507" y="2" stylename="asset.mainloadingii.register.RoleIcon_3"/>
					<bitmapData resourceLink="asset.mainloadingii.register.RoleIcon_4" x="522" y="-64" stylename="asset.mainloadingii.register.RoleIcon_4"/>
					<bitmapData resourceLink="asset.mainloadingii.register.RoleIcon_5" x="554" y="12" stylename="asset.mainloadingii.register.RoleIcon_5"/>
					<bitmapData resourceLink="asset.mainloadingii.register.RoleIcon_6" x="465" y="-67" stylename="asset.mainloadingii.register.RoleIcon_6"/>
					<bitmapData resourceLink="asset.mainloadingii.register.head1" x="17" y="16" stylename="asset.mainloadingii.register.head1"/>
					<bitmapData resourceLink="asset.mainloadingii.register.head2" x="17" y="26" stylename="asset.mainloadingii.register.head2"/>
					<bitmapData resourceLink="asset.mainloadingii.register.head3" x="19" y="27" stylename="asset.mainloadingii.register.head3"/>
					<bitmapData resourceLink="asset.mainloadingii.register.head4" x="27" y="21" stylename="asset.mainloadingii.register.head4"/>
					<bitmapData resourceLink="asset.mainloadingii.register.head5" x="19" y="29" stylename="asset.mainloadingii.register.head5"/>
					<bitmapData resourceLink="asset.mainloadingii.register.head6" x="17" y="16" stylename="asset.mainloadingii.register.head6"/>
					<bitmapData resourceLink="asset.mainloadingii.register.Back" x="0" y="0" stylename="asset.mainloadingii.register.Back"/>
				
			
				
				
				  </bitmaps>
				  
				  <customDisplay>
					<custom classname="register.HeadComp" stylename="mainloadingii.register.ChooseView.HeadComp1" x="189" y="463" />
					<custom classname="register.HeadComp" stylename="mainloadingii.register.ChooseView.HeadComp2" x="313" y="449" />
					<custom classname="register.HeadComp" stylename="mainloadingii.register.ChooseView.HeadComp3" x="439" y="434" />
					<custom classname="register.HeadComp" stylename="mainloadingii.register.ChooseView.HeadComp4" x="566" y="420" />
					<custom classname="register.HeadComp" stylename="mainloadingii.register.ChooseView.HeadComp5" x="691" y="406" />
					<custom classname="register.HeadComp" stylename="mainloadingii.register.ChooseView.HeadComp6" x="816" y="392" />
					<custom classname="asset.mainloadingii.register.MainFigureBg" stylename="asset.mainloadingii.register.MainFigureBg" x="75" y="95" />
					<custom classname="asset.mainloadingii.register.figureNameBg" stylename="asset.mainloadingii.register.figureNameBg" x="870" y="593" />
				
				
				  </customDisplay>
				  
				  <components>
					<component classname="com.pickgliss.ui.controls.IconButton" stylename="mainloadingii.register.ChooseView.ConfirmBtn" backStyle="asset.mainloadingii.register.btnOkBg" 
						iconStyle="asset.mainloadingii.register.btnOkTxt" iconInnerRectString="40,102,15,29,13"
						displacement="true" filterString="core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter" alpha="1" autoSizeAble="true" buttonMode="true" enable="true" enableHtml="false" iconFrameChange="true" isFollowMouse="true" mouseChildren="false" mouseEnabled="true" pressEnable="false" scaleX="1" scaleY="1" tipGapH="0" tipGapV="0" x="899" y="642"/>
					<component classname="com.pickgliss.ui.controls.SelectedButton" stylename="mainloadingii.register.ChooseView.PlayerBack"  
						unSelectedStyle="asset.mainloadingii.register.PlayerBackUnselected" selectedStyle="asset.mainloadingii.register.PlayerBackSelected" 
						filterString="core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter" 
						x="300" y="-35"
					/>
					<component classname="com.pickgliss.ui.controls.SelectedButton" stylename="mainloadingii.register.ChooseView.PlayerNew"  
						unSelectedStyle="asset.mainloadingii.register.PlayerNewUnselected" selectedStyle="asset.mainloadingii.register.PlayerNewSelected" 
						filterString="core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter" 
						x="550" y="-35"
					/>
					<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="mainloadingii.register.ChooseView.commonTipBg" 
						resourceLink="asset.mainloadingii.register.TipsBg" scaleGridString="10,10,250,70" alpha="0.8"
						x="460" y="-25"
					/>
					<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="mainloadingii.register.ChooseView.commonTipText" 
						textFormatStyle="mainloadingii.register.commonTipTF"
					/>
					<component classname="com.pickgliss.ui.controls.BaseButton" stylename="mainloadingii.register.ChooseView.ShaiziBtn" 
						backStyle="asset.mainloadingii.register.ShaiziBtn"  
						filterString="core.DefaultFilter,mainloadingii.register.GlowFilter,core.DefaultFilter,core.GrayFilter"
						x="1140" y="590"
					/>
					<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="mainloadingii.register.ChooseView.ReNameTxt" 
						textFormatStyle="mainloadingii.register.ReNameTxt_t" autoSize="none" 
						restrict="^ " type="input" 
						height="25" width="153" 
						x="985" y="590" 
					/>
					<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="mainloadingii.register.ChooseView.DescribeTxt"
						textFormatStyle="mainloadingii.register.renameFrameDescribeErrorTxt_t,mainloadingii.register.renameFrameDescribeTxt_t" autoSize="none"
						height="20"  width="200" 
						x="913" y="627" 
					/>
				  </components>
				</style>;
      }
   }
}

