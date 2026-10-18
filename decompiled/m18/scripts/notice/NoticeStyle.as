package notice
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class NoticeStyle
   {
      
      public function NoticeStyle()
      {
         super();
         var _loc1_:XML = <xml name="noticestyle">
							<set type="flash.text.TextFormat" stylename="notice.FrameTitleText_t" args="Arial,15,0xFFDD83,true" letterSpacing="2"/>
							<set type="flash.text.TextFormat" stylename="notice.Describetxt_t" args="Arial,12,0xffffff," letterSpacing="2"/>
							<set type="flash.text.TextFormat" stylename="notice.UpdateBroadCastDate_t" args="Arial,14,0xffeb79,,,,,,left"  letterSpacing="1"/>
							<set type="flash.filters.GlowFilter" stylename="notice.FrameTitile_g" args="0x000000,1,5,5,5" />
							<set type="flash.filters.ColorMatrixFilter" stylename="notice.DefaultFilter" args="1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0" />
							<set type="flash.filters.ColorMatrixFilter" stylename="notice.LightFilter" args="1,0,0,0,25,0,1,0,0,25,0,0,1,0,25,0,0,0,1,0"/>
							<set type="flash.filters.ColorMatrixFilter" stylename="notice.GrayFilter" args="0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0"/>
							<set type="flash.filters.GlowFilter" stylename="notice.normal_f" args="0x000000,1,5,5,3" />		
					
							<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="notice.FrameTitleText" 
								textFormatStyle="notice.FrameTitleText_t" filterString="notice.FrameTitile_g" 
							/>
							<component classname="com.pickgliss.ui.controls.BaseButton" stylename="notice.CloseBtn" 
								backStyle="asset.core.closeBtn_style01" filterString="notice.DefaultFilter,notice.LightFilter,notice.DefaultFilter,notice.GrayFilter"
								displacement='false' isFollowMouse = "false"
							/>
							<component classname="com.pickgliss.ui.image.Scale9CornerImage" stylename="notice.FrameBackgoundBase1" 
                                resourceLink="asset.core.style02_scale9bg1,asset.core.style02_scale9bg2,asset.core.style02_scale9bg3,asset.core.style02_scale9bg4,asset.core.style02_scale9bg5,asset.core.style02_scale9bg6,asset.core.style02_scale9bg7,asset.core.style02_scale9bg8,asset.core.style02_scale9bg9"
							/>
							<component classname="com.pickgliss.ui.image.Image" stylename="notice.FrameTitleImage1" 
								resourceLink="asset.core.frameTitleImage2"
								width="229" height="17"
							/>
							<component classname="com.pickgliss.ui.image.MutipleImage" stylename="notice.FrameBg1"
								resourceLink="notice.FrameBackgoundBase1" imageRectString="-18|-15|0|23|0" 
							/>
							<component classname="notice.NoticeFrame" stylename="notice.NoticeFrame"
								closestyle="notice.CloseBtn" titleStyle="notice.FrameTitleText" backStyle="notice.FrameBg1" 
								closeInnerRectString="29,3,12,29,14" 
								moveInnerRectString="0,30,0,45,1" titleOuterRectPosString="0,12,1"
								moveEnable="false" enterEnable="true" escEnable="true"
								containerX="8" containerY="45"
								width="635" height="407"
							/>
                            <custom classname="asset.timestory.UpdateBroadCastBack" stylename="noticeFrame.UpdateBroadCastBack" 
                                x='0' y="0" width="618" height="324"
                            />
                            <component classname="com.pickgliss.ui.controls.ScrollPanel" stylename="noticeFrame.UpdateBroadCastScroll" 
			                    vScrollbarStyle="notice.VScrollbar03"
			                    vScrollbarInnerRectString="16,0,0,0,3"
			                    viewportInnerRectString="0,0,0,0,5"
			                    vScrollProxy="0" vUnitIncrement="5"
			                    width="618" height="324"
		                    />
							<component classname="com.pickgliss.ui.controls.Scrollbar" stylename="notice.VScrollbar03" 
								trackStyle="notice.Scrollbar03_Back" 
								thumbStyle="notice.Scrollbar03_Step" 
								decreaseButtonStyle="notice.Scrollbar03_Up" 
								increaseButtonStyle="notice.Scrollbar03_Down" 
                                trackInnerRectString="0,0,0,0,0" 
			                    thumbAreaInnerRectString="1,1,16,16,0" 
			                    decreaseButtonInnerRectString="16,16,0,0,9" 
			                    increaseButtonInnerRectString="16,16,0,0,10" 
			                    orientation="0" thumbMinSize="23" 
			                    width="16" height="200" 
							/>
							<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="notice.Scrollbar03_Back" 
								resourceLink="asset.core.scrollbar03_bg" 
								width="15" height="24" 
							/>
							<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="notice.scrollbar03_stepAsset" 
								resourceLink="asset.core.scrollbar03_step" scaleGridString="0,13,13,26"
								width="13" height="36"
							/>
							<component classname="com.pickgliss.ui.controls.BaseButton" stylename="notice.Scrollbar03_Step" 
								backStyle="notice.scrollbar03_stepAsset" displacement="false"
								filterString="notice.DefaultFilter,notice.LightFilter,notice.DefaultFilter,notice.GrayFilter"
								width="13" height="36" 
							/>
							<component classname="com.pickgliss.ui.controls.BaseButton" stylename="notice.Scrollbar03_Up" 
								backStyle="asset.core.scrollbar03_up" displacement="false"
								width="16" height="16"	
							/>
							<component classname="com.pickgliss.ui.controls.BaseButton" stylename="notice.Scrollbar03_Down" 
								backStyle="asset.core.scrollbar03_down"  displacement="false"
								width="16" height="16"	
							/>
							<component classname="com.pickgliss.ui.controls.ScrollPanel" stylename="notice.ScrollPanel"
								vScrollbarStyle="notice.VScrollbar02"
								vScrollbarInnerRectString="21,0,0,0,3"
								viewportInnerRectString="0,22,0,0,0" 
								vScrollProxy='0'
								x="1" y="7" width="524" height="290" 
							/>
					        <component classname="com.pickgliss.ui.text.FilterFrameText" stylename="noticeFrame.UpdateBroadCastDate"	
								textFormatStyle="notice.UpdateBroadCastDate_t" filterString="notice.normal_f"
								autoSize="none"  width="220" height="20"
								x="345" y="7"
 							/>
						</xml>
			;
         ComponentFactory.Instance.setup(_loc1_);
      }
   }
}

