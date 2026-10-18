package theseuspvp.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.theseuspvp.TheseusPvpReportInfo;
   
   public class TheseusPvpReportItem extends Sprite
   {
      
      public var _coreBg:ScaleBitmapImage;
      
      public var _reportWL:ScaleFrameImage;
      
      public var _reportUD:ScaleFrameImage;
      
      public var _headBg:Image;
      
      public var _AD:ScaleFrameImage;
      
      public var _reportUDTxt:FilterFrameText;
      
      public var _reportNickNameTxt:FilterFrameText;
      
      public var _reportServerTxt:FilterFrameText;
      
      public var _reportTimeTxt:FilterFrameText;
      
      private var _icon:TheseusPvpHeadIcon;
      
      private var _data:TheseusPvpReportInfo;
      
      public function TheseusPvpReportItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _coreBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.coreBg");
         _reportWL = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.reportWL");
         _reportUD = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.reportUD");
         _headBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.reportHeadBg");
         _AD = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.AD");
         _reportUDTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.reportUDTxt");
         _reportNickNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.reportNickNameTxt");
         _reportServerTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.reportServerTxt");
         _reportTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.reportTimeTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.reportHeadIcon");
         addChild(_coreBg);
         addChild(_reportWL);
         addChild(_reportUD);
         addChild(_headBg);
         addChild(_icon);
         addChild(_AD);
         addChild(_reportUDTxt);
         addChild(_reportNickNameTxt);
         addChild(_reportServerTxt);
         addChild(_reportTimeTxt);
         _coreBg.width = 528;
         _coreBg.height = 73;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_coreBg);
         _coreBg = null;
         ObjectUtils.disposeObject(_reportWL);
         _reportWL = null;
         ObjectUtils.disposeObject(_reportUD);
         _reportUD = null;
         ObjectUtils.disposeObject(_headBg);
         _headBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_AD);
         _AD = null;
         ObjectUtils.disposeObject(_reportUDTxt);
         _reportUDTxt = null;
         ObjectUtils.disposeObject(_reportNickNameTxt);
         _reportNickNameTxt = null;
         ObjectUtils.disposeObject(_reportServerTxt);
         _reportServerTxt = null;
         ObjectUtils.disposeObject(_reportTimeTxt);
         _reportTimeTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get data() : TheseusPvpReportInfo
      {
         return _data;
      }
      
      public function set data(param1:TheseusPvpReportInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         if(_data)
         {
            _loc2_ = _data.isWin ? 1 : 2;
            _reportWL.setFrame(_loc2_);
            _reportUD.setFrame(_loc2_);
            _reportUDTxt.setFrame(_loc2_);
            _AD.setFrame(_data.mode == 0 ? 1 : 2);
            _reportUDTxt.text = _data.integral > 0 ? "+" + _data.integral : "" + _data.integral;
            _reportNickNameTxt.text = _data.nickName;
            _reportServerTxt.text = _data.serverName;
            _reportTimeTxt.text = _data.fightDate;
            _icon.headIcon = _data.job;
         }
      }
   }
}

