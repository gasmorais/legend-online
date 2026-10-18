package doctor
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class DoctorStyle
   {
      
      public function DoctorStyle()
      {
         super();
         var _loc1_:XML = <xml name="doctorstyle">
				<set type="flash.text.TextFormat" stylename="doctor.FrameTitleText_t" args="Arial,15,0xFFDD83,true" letterSpacing="0"/>
				<set type="flash.text.TextFormat" stylename="doctor.Describetxt_t" args="Arial,12,0xffffff," letterSpacing="0"/>
				<set type="flash.text.TextFormat" stylename="doctor.LoaderItemResule_t" args="Arial,12,0xffffff,,,,,,left" letterSpacing="0"/>
			
				<set type="flash.filters.GlowFilter" stylename="doctor.FrameTitile_g" args="0x000000,1,5,5,5" />
				<set type="flash.filters.ColorMatrixFilter" stylename="doctor.DefaultFilter" args="1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0" />
				<set type="flash.filters.ColorMatrixFilter" stylename="doctor.LightFilter" args="1,0,0,0,25,0,1,0,0,25,0,0,1,0,25,0,0,0,1,0"/>
				<set type="flash.filters.ColorMatrixFilter" stylename="doctor.GrayFilter" args="0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0"/>
				<set type="flash.filters.GlowFilter" stylename="doctor.normal_f" args="0x000000,1,5,5,3" />		
		
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.FrameTitleText" 
					textFormatStyle="doctor.FrameTitleText_t" filterString="doctor.FrameTitile_g" 
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.CloseBtn" 
					backStyle="asset.core.closeBtn_style01" filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					displacement='false' isFollowMouse = "false"
				/>
				<component classname="com.pickgliss.ui.image.Scale9CornerImage" stylename="doctor.FrameBackgoundBase1" 
					resourceLink="asset.core.framestyle03_scale9bg1,asset.core.framestyle03_scale9bg2,asset.core.framestyle03_scale9bg3,asset.core.framestyle03_scale9bg4,asset.core.framestyle03_scale9bg5,asset.core.framestyle03_scale9bg6,asset.core.framestyle03_scale9bg7,asset.core.framestyle03_scale9bg8,asset.core.framestyle03_scale9bg9"
				/>
				<component classname="com.pickgliss.ui.image.Image" stylename="doctor.FrameTitleImage1" 
					resourceLink="asset.core.frameTitleImage2"
					width="229" height="17"
				/>
				<component classname="com.pickgliss.ui.image.MutipleImage" stylename="doctor.FrameBg1"
					resourceLink="doctor.FrameBackgoundBase1,doctor.FrameTitleImage1" imageRectString="-18|-15|0|23|0,232|17|-4|0|9" 
				/>
				<component classname="doctor.DoctorFrame" stylename="doctor.DoctorFrame"
					closestyle="doctor.CloseBtn" titleStyle="doctor.FrameTitleText" backStyle="doctor.FrameBg1" 
					closeInnerRectString="29,-31,-13,29,14" 
					moveInnerRectString="0,80,0,25,1" titleOuterRectPosString="0,-5,1"
					moveEnable="false" enterEnable="true" escEnable="true"
					containerX="-6" containerY="8"
					width="513" height="392"
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.MinBtn" 
					backStyle="asset.loading.DoctorMinBtn"  displacement="false"
					filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					width="29" height="29"	x="486" y="-22"
				/>
				<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="doctor.Back1" 
					resourceLink="asset.core.describeBackground_style06" scaleGridString="10,10,70,30"
					width="528" height="300" x="-2" y="4" 
				/>
				<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="doctor.Back2" 
					resourceLink="asset.core.InputBack_Style_01" scaleGridString="10,10,125,7"
					width="530" height="48" x="-3" y="304"
				/>
				<component classname="com.pickgliss.ui.controls.IconButton" stylename="doctor.CopyBtn" 
					backStyle="asset.core.ButtonStyle_03" 
					iconStyle="asset.loading.DoctorCopy" iconInnerRectString="32,48,10,22,13"
					filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					x="407" y="308"
				/>
				<component classname="com.pickgliss.ui.controls.IconButton" stylename="doctor.StartBtn" 
					backStyle="asset.core.ButtonStyle_03" 
					iconStyle="asset.loading.DoctorStart" iconInnerRectString="18,77,10,22,13"
					filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					x="407" y="308"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.Describetxt" 
					textFormatStyle="doctor.Describetxt_t" filterString="doctor.normal_f" autoSize="none"
					wordWrap="true" multiline="true" width="392" height="40" x="4" y="318"
				/>
				<component classname="com.pickgliss.ui.image.Image" stylename="doctor.LoaderItemBack"
					resourceLink="asset.loading.Spliceline"
					width="495" height="30"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.LoaderItemName" 
					textFormatStyle="doctor.Describetxt_t" filterString="doctor.normal_f" autoSize="none"
					width="170" height="22" x="10" y="6"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.LoaderItemProgress" 
					textFormatStyle="doctor.Describetxt_t" filterString="doctor.normal_f" autoSize="none"
					width="145" height="22" x="160" y="6"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.LoaderItemSpeed" 
					textFormatStyle="doctor.Describetxt_t" filterString="doctor.normal_f" autoSize="none"
					width="142" height="22" x="280" y="6"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.LoaderItemResule" 
					textFormatStyle="doctor.LoaderItemResule_t" filterString="doctor.normal_f" autoSize="none"
					width="144" height="22" x="345" y="6" isAutoFitLength="true"
				/>			
				<component classname="com.pickgliss.ui.controls.container.VBox" stylename="doctor.Vbox"
					spacing="0"
				/>	
				<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="doctor.Scrollbar02_Back" 
					resourceLink="asset.core.scrollbar02_bg" 
					width="15" height="24" 
				/>
				<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="doctor.scrollbar02_stepAsset" 
					resourceLink="asset.core.scrollbar02_step" scaleGridString="0,18,21,36"
					width="21" height="56"
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.Scrollbar02_Step" 
					backStyle="doctor.scrollbar02_stepAsset" displacement="false"
					filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					width="21" height="56" 
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.Scrollbar02_Up" 
					backStyle="asset.core.scrollbar02_up" displacement="false"
					width="11" height="10"	
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.Scrollbar02_Down" 
					backStyle="asset.core.scrollbar02_down"  displacement="false"
					width="11" height="10"	
				/>
				<component classname="com.pickgliss.ui.controls.Scrollbar" stylename="doctor.VScrollbar02" 
					trackStyle="doctor.Scrollbar02_Back" 
					thumbStyle="doctor.Scrollbar02_Step" 
					decreaseButtonStyle="doctor.Scrollbar02_Up" 
					increaseButtonStyle="doctor.Scrollbar02_Down" 
					trackInnerRectString="3,3,0,0,0" 
					thumbAreaInnerRectString="0,0,10,10,0" 
					decreaseButtonInnerRectString="10,10,0,0,9" 
					increaseButtonInnerRectString="10,10,0,0,10" 
					orientation="0" thumbMinSize="38" 
					width="21" height="200" 
				/>
				<component classname="com.pickgliss.ui.controls.ScrollPanel" stylename="doctor.ScrollPanel"
					vScrollbarStyle="doctor.VScrollbar02"
					vScrollbarInnerRectString="21,0,0,0,3"
					viewportInnerRectString="0,22,0,0,0" 
					vScrollProxy='0'
					x="1" y="7" width="524" height="290" 
				/>
			</xml>
			;
         ComponentFactory.Instance.setup(_loc1_);
      }
   }
}

