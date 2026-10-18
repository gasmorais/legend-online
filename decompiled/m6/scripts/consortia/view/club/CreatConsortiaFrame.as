package consortia.view.club
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.IMEManager;
   import yishi.manager.ResourceManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class CreatConsortiaFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _conditonImg:Bitmap;
      
      private var _iconImg:Bitmap;
      
      private var _nameImg:Bitmap;
      
      private var _arrow1Img:Bitmap;
      
      private var _arrow2Img:Bitmap;
      
      private var _lineImg:Bitmap;
      
      private var _inputBg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _levelConditionTxt:FilterFrameText;
      
      private var _goldConditionTxt:FilterFrameText;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _inputTipsTxt:FilterFrameText;
      
      private var _creatBtn:TextButton;
      
      private var _closeBtn:TextButton;
      
      private var _txtChange:String = "";
      
      public function CreatConsortiaFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command01");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.CreatConsortiaDescribeBackground");
         _conditonImg = ComponentFactory.Instance.creatBitmap("asset.consortia.creatConditionImg");
         _iconImg = ComponentFactory.Instance.creatBitmap("asset.consortia.creatAlertIcon");
         _nameImg = ComponentFactory.Instance.creatBitmap("asset.consortia.consortiaNameImg");
         _lineImg = ComponentFactory.Instance.creatBitmap("asset.consortia.inputBg");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.consortia.lineImg");
         _arrow1Img = ComponentFactory.Instance.creatBitmap("asset.consortia.arrowIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.creatFrameConsortiaNameTextStyle");
         _inputTipsTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.CreatFrameInputTipTextStyle");
         _levelConditionTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.creatFrameLevelConditionTextStyle");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.creatFrameTipsTextStyle");
         _goldConditionTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.creatFrameGoldConditionTextStyle");
         _creatBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.creatButton");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.closeButton");
         _arrow2Img = new Bitmap(_arrow1Img.bitmapData);
         _arrow2Img.x = _arrow1Img.x + 125;
         _arrow2Img.y = _arrow1Img.y;
         _nameTxt.text = "";
         _inputTipsTxt.text = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command02");
         _levelConditionTxt.text = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command03",12);
         _tipsTxt.text = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command04");
         _goldConditionTxt.text = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command05",200000);
         _creatBtn.text = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command06");
         _closeBtn.text = LanguageMgr.GetTranslation("public.close");
         addToContent(_bg);
         addToContent(_conditonImg);
         addToContent(_iconImg);
         addToContent(_nameImg);
         addToContent(_lineImg);
         _lineImg.width = 170;
         addToContent(_inputBg);
         addToContent(_arrow1Img);
         addToContent(_arrow2Img);
         addToContent(_nameTxt);
         addToContent(_inputTipsTxt);
         addToContent(_levelConditionTxt);
         addToContent(_tipsTxt);
         addToContent(_goldConditionTxt);
         addToContent(_creatBtn);
         addToContent(_closeBtn);
         checkEnabled();
      }
      
      private function uninit() : void
      {
         _closeBtn = null;
         _creatBtn = null;
         _nameTxt = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _nameTxt.addEventListener("focusIn",__onFocusInHandler);
         _nameTxt.addEventListener("focusOut",__onFocusOutHandler);
         _nameTxt.addEventListener("keyDown",__onKeydownHandler);
         _nameTxt.addEventListener("change",__onTxtChange);
         _closeBtn.addEventListener("click",__onCloseHandler);
         _creatBtn.addEventListener("click",__onCreatHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__onPlayInfoUpdata);
      }
      
      private function __onTxtChange(param1:Event) : void
      {
         var _loc2_:int = int(_nameTxt.text.replace(/[^\x00-\xff]/g,"xx").length);
         if(_loc2_ > 10)
         {
            _nameTxt.text = _txtChange;
         }
         _txtChange = _nameTxt.text;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__onCloseHandler);
         }
         if(_creatBtn)
         {
            _creatBtn.removeEventListener("click",__onCreatHandler);
         }
         _nameTxt.removeEventListener("focusIn",__onFocusInHandler);
         _nameTxt.removeEventListener("focusOut",__onFocusOutHandler);
         _nameTxt.removeEventListener("keyDown",__onKeydownHandler);
         thane.removeEventListener("THANE_LEVEL_UPDATE",__onPlayInfoUpdata);
         _nameTxt.removeEventListener("change",__onTxtChange);
      }
      
      private function __onFocusInHandler(param1:FocusEvent) : void
      {
         IMEManager.enable();
         _inputTipsTxt.visible = false;
      }
      
      private function __onFocusOutHandler(param1:FocusEvent) : void
      {
         if(StringHelper.isNullOrEmpty(_nameTxt.text))
         {
            _inputTipsTxt.visible = true;
         }
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13 && Boolean(_creatBtn.enable))
         {
            __onCreatHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function checkEnabled() : void
      {
         var _loc1_:Array = GoodsManager.instance.getGoodsBySonType(295);
         if(gold.count < 200000 && _loc1_.length == 0)
         {
            _goldConditionTxt.setFrame(2);
         }
         else
         {
            _goldConditionTxt.setFrame(1);
         }
         if(thane.grades < 12)
         {
            _levelConditionTxt.setFrame(2);
         }
         else
         {
            _levelConditionTxt.setFrame(1);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __onCloseHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __onCreatHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _creatBtn.mouseEnabled = false;
         if(canCreat())
         {
            FrameControllerManager.instance.consortiaController.creatConsortia(_nameTxt.text);
            dispose();
         }
         else
         {
            _creatBtn.mouseEnabled = true;
         }
      }
      
      private function canCreat() : Boolean
      {
         var _loc1_:String = "";
         var _loc3_:Array = GoodsManager.instance.getGoodsBySonType(295);
         if(gold.count < 200000)
         {
            _loc1_ = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command08",200000);
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(thane.grades < 12)
         {
            _loc1_ = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command09",12);
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         _nameTxt.text = StringHelper.trim(_nameTxt.text);
         if(StringHelper.isNullOrEmpty(_nameTxt.text))
         {
            _loc1_ = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command10");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(FilterWordManager.isGotForbiddenWords(_nameTxt.text,"name") || Boolean(FilterWordManager.isGotForbiddenWords(_nameTxt.text,"chat")))
         {
            _loc1_ = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command11");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         var _loc2_:int = int(_nameTxt.text.replace(/[^\x00-\xff]/g,"xx").length);
         if(_loc2_ > 10 || _loc2_ < 4)
         {
            _loc1_ = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command12");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         return true;
      }
      
      private function __onPlayInfoUpdata(param1:PlayerEvent) : void
      {
         checkEnabled();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

