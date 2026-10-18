package funpreview
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.LevelUpPrompt;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class FunPreviewFrame extends Frame implements Disposeable, IManualSize
   {
      
      private var _thisOpenBim:Bitmap;
      
      private var _nextOpenBim:Bitmap;
      
      private var _openLevelBim:Bitmap;
      
      private var _openCPBim:Bitmap;
      
      private var _openFunBim:Bitmap;
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:ScaleBitmapImage;
      
      private var _aboveContain:Sprite;
      
      private var _belowContain:Sprite;
      
      private var _openTxt:FilterFrameText;
      
      private var _openLevelTxt:FilterFrameText;
      
      private var _sureBtn:IconButton;
      
      private var _level:int;
      
      private var _icon:BaseItemView;
      
      public function FunPreviewFrame()
      {
         super();
         initView();
         initEvent();
         initOpenlist("above",_aboveContain);
         initOpenlist("below",_belowContain);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,400,410);
      }
      
      private function initView() : void
      {
         _thisOpenBim = ComponentFactory.Instance.creatBitmap("asset.funpreview.thisopenfunTxt");
         _nextOpenBim = ComponentFactory.Instance.creatBitmap("asset.funpreview.nextopenfunTxt");
         _back1 = ComponentFactory.Instance.creatComponentByStylename("funpreview.FunPreviewBack1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("funpreview.FunPreviewBack2");
         _sureBtn = ComponentFactory.Instance.creatComponentByStylename("funpreview.sureBtn");
         _aboveContain = new Sprite();
         _belowContain = new Sprite();
         _belowContain.y = 140;
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_thisOpenBim);
         addToContent(_nextOpenBim);
         addToContent(_aboveContain);
         addToContent(_belowContain);
         addToContent(_sureBtn);
      }
      
      private function initEvent() : void
      {
         _sureBtn.addEventListener("click",_sureBtnClick);
         addEventListener("response",__frameResponse);
      }
      
      private function initOpenlist(param1:String, param2:Sprite) : void
      {
         var _loc7_:XML = null;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:BaseItemView = null;
         var _loc4_:XMLList = LevelUpPrompt.PromptXml..story;
         var _loc5_:int = _loc4_.length();
         if(thane.grades > _loc4_[_loc5_ - 1].@grade)
         {
            if(param1 == "above")
            {
               _loc7_ = _loc4_[_loc5_ - 1];
               _level = _loc4_[_loc5_ - 1].@grade;
            }
            else
            {
               _loc7_ = null;
               _level = 1000;
            }
         }
         else
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               if((thane.grades == _loc4_[_loc8_].@grade || thane.grades > _loc4_[_loc8_].@grade) && thane.grades < _loc4_[_loc8_ + 1].@grade)
               {
                  if(param1 == "above")
                  {
                     _loc7_ = _loc4_[_loc8_];
                     _level = _loc4_[_loc8_].@grade;
                  }
                  else
                  {
                     _loc7_ = _loc4_[_loc8_ + 1];
                     _level = _loc4_[_loc8_ + 1].@grade;
                  }
                  break;
               }
               _loc8_++;
            }
         }
         if(!_loc7_)
         {
            return;
         }
         param1 = "";
         _loc4_ = _loc7_.item;
         _loc5_ = _loc4_.length();
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            if(_loc4_[_loc8_].@type == "0")
            {
               if(param1 != "")
               {
                  param1 += ",";
               }
               param1 += _loc4_[_loc8_].@name;
            }
            if(_loc4_[_loc8_].@type == "1")
            {
               _loc6_ = ComponentFactory.Instance.creatCustomObject("playerlevelup.LevelUpItem");
               _loc6_.scaleX = _loc6_.scaleY = 0.7;
               _loc6_.icon.icon = IconFactory.getCommonIconPath("/upgradeTip/" + _loc4_[_loc8_].@url);
               _loc6_.tipData = "<font color=\'#fab634\'>" + _loc4_[_loc8_].@name + "</font>" + "<br/>" + _loc4_[_loc8_].@tip;
               param2.addChild(_loc6_);
               _loc6_.y = 40;
               _loc6_.x = 52 * _loc3_ + 108;
               _loc3_++;
            }
            _loc8_++;
         }
         _openLevelBim = ComponentFactory.Instance.creatBitmap("asset.funpreview.openlevelBMD");
         _openCPBim = ComponentFactory.Instance.creatBitmap("asset.funpreview.openCampaignBMD");
         _openFunBim = ComponentFactory.Instance.creatBitmap("asset.funpreview.openfunBMD");
         _openTxt = ComponentFactory.Instance.creatComponentByStylename("funpreview.openCPTxt");
         _openLevelTxt = ComponentFactory.Instance.creatComponentByStylename("funpreview.openLevelTxt");
         param2.addChild(_openLevelBim);
         param2.addChild(_openCPBim);
         param2.addChild(_openFunBim);
         param2.addChild(_openTxt);
         _openTxt.text = param1;
         param2.addChild(_openLevelTxt);
         _openLevelTxt.text = String(_level);
         if(_level > thane.grades)
         {
            _openLevelTxt.setFrame(2);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function _sureBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function removeEvent() : void
      {
         _sureBtn.removeEventListener("click",_sureBtnClick);
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("funpreview.FunPreviewFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

