package supersignincard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SuperSigninCardManager;
   import mvc.module.supersignincard.SuperSigninCardModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SuperSigninCardFrame extends Frame
   {
      
      private var _descTxt:FilterFrameText;
      
      private var _descTxt2:FilterFrameText;
      
      private var _border:ScaleBitmapImage;
      
      private var _bg:Bitmap;
      
      private var _activateBtn:IconButton;
      
      private var _pointImg:Image;
      
      private var _pointTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _itemList:Vector.<SuperSigninCardItem>;
      
      private var _helpBtn:BaseButton;
      
      public function SuperSigninCardFrame()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("SuperSigninCardFrame.titleText");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardFrame.descTxt");
         _descTxt2 = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardFrame.descTxt2");
         _border = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.SuperSigninCardFrame.bg");
         _activateBtn = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardFrame.activateBtn");
         _pointImg = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardFrame.pointImg");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardFrame.pointTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardFrame.timeTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardFrame.helpBtn");
         _descTxt.text = LanguageMgr.GetTranslation("SuperSigninCardFrame.descTxt.text");
         _descTxt2.text = LanguageMgr.GetTranslation("SuperSigninCardFrame.descTxt2.text");
         _pointTxt.text = model.cardPrice + "";
         addToContent(_descTxt);
         addToContent(_descTxt2);
         addToContent(_border);
         addToContent(_bg);
         addToContent(_activateBtn);
         addToContent(_pointImg);
         addToContent(_pointTxt);
         addToContent(_timeTxt);
         addToContent(_helpBtn);
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SuperSigninCardItem = null;
         _itemList = new Vector.<SuperSigninCardItem>();
         _loc2_ = 0;
         while(_loc2_ < model.tempDic.keys.length)
         {
            _loc1_ = new SuperSigninCardItem(_loc2_ + 1);
            _loc1_.x = 28 + _loc2_ * 130;
            _loc1_.y = 35;
            addToContent(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("SUPER_SIGNIN_CARD_TEMP_UPDATE",this,__superSigninCardTempUpdateHandler);
         MsgMan.addObserver("SUPER_SIGNIN_CARD_UPDATE",this,__superSigninCardUpdateHandler);
         _activateBtn.addEventListener("click",__activateBtnClickHandler);
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnHandler);
         }
         playerModel.addEventListener("SYSTIME_UPGRADE_MINUTE",__systimeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("SUPER_SIGNIN_CARD_TEMP_UPDATE",this,__superSigninCardTempUpdateHandler);
         MsgMan.removeObserver("SUPER_SIGNIN_CARD_UPDATE",this,__superSigninCardUpdateHandler);
         _activateBtn.removeEventListener("click",__activateBtnClickHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         playerModel.removeEventListener("SYSTIME_UPGRADE_MINUTE",__systimeUpdateHandler);
      }
      
      private function __systimeUpdateHandler(param1:PlayerEvent) : void
      {
         refreshTime();
      }
      
      private function __activateBtnClickHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [callBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("SuperSigninCardFrame.activateBtnClick.text",model.cardPrice);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("supersignincard.SuperSigninCardFrame.helpFrame");
         _loc2_.show();
      }
      
      private function callBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(playerModel.playerInfo.point < model.cardPrice)
            {
               RechargeAlertMannager.show();
               return;
            }
            SuperSigninCardManager.instance.sendRequest(2);
         }
      }
      
      private function __superSigninCardTempUpdateHandler(param1:String, param2:Object) : void
      {
         _pointTxt.text = model.cardPrice + "";
         for each(var _loc3_:SuperSigninCardItem in _itemList)
         {
            _loc3_.refreshItem();
         }
      }
      
      private function __superSigninCardUpdateHandler(param1:String, param2:Object) : void
      {
         if(model.isOpen)
         {
            refreshView();
         }
         else
         {
            dispose();
         }
      }
      
      private function refreshView() : void
      {
         _activateBtn.enable = model.stateDic.keys.length == 0;
         refreshTime();
         for each(var _loc1_:SuperSigninCardItem in _itemList)
         {
            _loc1_.refreshView();
         }
      }
      
      private function refreshTime() : void
      {
         var _loc2_:int = DateFormatter.parse(model.stopTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
         var _loc1_:int = _loc2_ - playerModel.sysCurTimeBySecond;
         var _loc3_:String = DateFormatter.getStopDateString(_loc1_);
         _timeTxt.text = LanguageMgr.GetTranslation("SuperSigninCardFrame.timeTxt.text",_loc3_);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
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
      
      public function get model() : SuperSigninCardModel
      {
         return SuperSigninCardManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
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

