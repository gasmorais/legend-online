package newmemorycard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.NewMemoryCardManager;
   import mvc.module.newmemorycard.NewMemoryCardModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.utils.DateFormatter;
   import yishi.utils.HashMap;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.TimerUtils;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class NewMemoryCardFrame extends Frame implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var cardSp:Sprite;
      
      private var ROW:int = 4;
      
      private var COLOME:int = 6;
      
      private var cards:HashMap;
      
      private var _rightBg:ScaleBitmapImage;
      
      private var _txtBg:MutipleImage;
      
      private var _spanel:ScrollPanel;
      
      private var _sprite:Sprite;
      
      private var _helpTxt:FilterFrameText;
      
      private var _refreshBtn:IconButton;
      
      private var _buyBtn:IconButton;
      
      private var _specialItem:BaseItemView;
      
      private var _linkTxt:FilterFrameText;
      
      private var _stepTxt:FilterFrameText;
      
      private var _buyStepTxt:FilterFrameText;
      
      private var _remainTimeText:FilterFrameText;
      
      public function NewMemoryCardFrame()
      {
         super();
         initView();
         addEvent();
         NewMemoryCardManager.instance.send(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,875,660);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("NewMemoryCardFrame.titleText.text");
         _bg = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.bg");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.rightBg");
         _txtBg = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.txtBg");
         _spanel = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.spanel");
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.helpTxt");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.refreshBtn");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.buyBtn");
         _specialItem = ComponentFactory.Instance.creatCustomObject("NewMemoryCardFrame.specialItem");
         _linkTxt = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.linkTxt");
         _stepTxt = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.stepTxt");
         _buyStepTxt = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.buyStepTxt");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardFrame.remainTimeText");
         addToContent(_bg);
         addToContent(_rightBg);
         addToContent(_txtBg);
         addToContent(_spanel);
         addToContent(_refreshBtn);
         addToContent(_buyBtn);
         addToContent(_specialItem);
         addToContent(_linkTxt);
         addToContent(_stepTxt);
         addToContent(_buyStepTxt);
         addToContent(_remainTimeText);
         _helpTxt.htmlText = LanguageMgr.GetTranslation("NewMemoryCardFrame.helpTxt.text");
         _spanel.setView(_helpTxt);
         initCards();
         _linkTxt.htmlText = "<a href=\'event:#\'>" + LanguageMgr.GetTranslation("NewMemoryCardFrame.linkTxt.text") + "</a>";
         TimerUtils.addSecendTimer("TIME",1,99999,setRemainTime);
      }
      
      public function setRemainTime() : void
      {
         var _loc2_:Date = DateFormatter.parse(NewMemoryCardManager.instance.model.stopTime,"YYYY-MM-DD hh:mm:ss");
         var _loc1_:Number = _loc2_.time / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc1_ >= 60)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc1_));
         }
         else if(_loc1_ > 0)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc1_));
         }
         else
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function initCards() : void
      {
         var _loc4_:NewMemoryCardItem = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         cardSp = new Sprite();
         cardSp.x = 12;
         cardSp.y = 17;
         addToContent(cardSp);
         cards = new HashMap();
         _loc2_ = 0;
         while(_loc2_ < ROW)
         {
            _loc3_ = 0;
            while(_loc3_ < COLOME)
            {
               _loc1_ = _loc2_ * 6 + _loc3_;
               _loc4_ = new NewMemoryCardItem(_loc1_);
               cardSp.addChild(_loc4_);
               _loc4_.x = _loc3_ * 100;
               _loc4_.y = _loc2_ * 135;
               cards.put(_loc1_,_loc4_);
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("NEW_MEMORYCARD_UPDATE",this,__updateMemoryCardHandler);
         _linkTxt.addEventListener("link",__linkClickHandler);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshState);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("NEW_MEMORYCARD_UPDATE",this,__updateMemoryCardHandler);
         _linkTxt.removeEventListener("link",__linkClickHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshState);
      }
      
      private function __refreshState(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         if(model.lock)
         {
            return;
         }
         var _loc5_:int = int(ConfigInfoManager.instance.newMemoryCardLimitTimes);
         if(model.step >= _loc5_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("NewMemoryCardFrame.buy.limitText"));
            return;
         }
         var _loc4_:int = int(ConfigInfoManager.instance.newMemoryCardMaxTimes);
         if(model.buyCount >= _loc4_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("NewMemoryCardFrame.buy.maxText"));
            return;
         }
         var _loc7_:int = int(ConfigInfoManager.instance.newMemoryCardCostdiamond);
         var _loc3_:int = int(ConfigInfoManager.instance.newMemoryCardBuyTimes);
         var _loc6_:int = _loc4_ - model.buyCount;
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc8_:String = LanguageMgr.GetTranslation("NewMemoryCardFrame.TodayNotAlert.content.text",_loc7_,_loc3_,_loc6_);
         SharedManagerHelper.ins.needAlert("newmemorycard.NewMemoryCardFrame.buyClick",buyCallBack,_loc2_,_loc8_);
      }
      
      private function buyCallBack() : void
      {
         var _loc1_:int = int(ConfigInfoManager.instance.newMemoryCardCostdiamond);
         if(playerInfo.point < _loc1_)
         {
            RechargeAlertMannager.show();
            return;
         }
         NewMemoryCardManager.instance.send(3);
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         if(model.lock)
         {
            return;
         }
         SimpleAlertHelper.instance.data = [refreshCallBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("NewMemoryCardFrame.refresh.content.txt");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
      
      private function refreshCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            NewMemoryCardManager.instance.send(4);
         }
      }
      
      private function __linkClickHandler(param1:TextEvent) : void
      {
         if(model.lock)
         {
            return;
         }
         var _loc2_:NewMemoryCardGoodsFrame = ComponentFactory.Instance.creatComponentByStylename("newmemorycard.goodsFrame");
         _loc2_.data = model.dropInfo;
         _loc2_.show();
      }
      
      private function __updateMemoryCardHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:NewMemoryCardItem = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(model.clickIndexArr.length >= 2)
         {
            _loc2_ = 0;
            while(_loc2_ < model.clickIndexArr.length)
            {
               _loc1_ = cards.getValue(model.clickIndexArr[_loc2_]) as NewMemoryCardItem;
               _loc1_.play();
               _loc2_++;
            }
         }
         _stepTxt.text = LanguageMgr.GetTranslation("NewMemoryCardFrame.stepTxt.text",model.freeStep);
         _buyStepTxt.text = LanguageMgr.GetTranslation("NewMemoryCardFrame.buyStepTxt.text",model.buyStep);
         var _loc4_:Array = model.specialInfo.split(",");
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = _loc4_[0];
         _loc5_.count = _loc4_[1];
         _specialItem.data = _loc5_;
         _refreshBtn.enable = model.canRefresh;
         if(model.opType == 4)
         {
            _loc3_ = 0;
            while(_loc3_ < ROW * COLOME)
            {
               _loc1_ = cards.getValue(_loc3_) as NewMemoryCardItem;
               _loc1_.reset();
               _loc3_++;
            }
         }
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
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      private function get model() : NewMemoryCardModel
      {
         return NewMemoryCardManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         TimerUtils.removeSecendTimer("TIME");
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_helpTxt);
         _helpTxt = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_specialItem);
         _specialItem = null;
         ObjectUtils.disposeObject(_linkTxt);
         _linkTxt = null;
         ObjectUtils.disposeObject(_stepTxt);
         _stepTxt = null;
         ObjectUtils.disposeObject(_buyStepTxt);
         _buyStepTxt = null;
         ObjectUtils.disposeObject(_remainTimeText);
         _remainTimeText = null;
         ObjectUtils.disposeAllChildren(_sprite);
         _sprite = null;
         ObjectUtils.disposeAllChildren(_spanel);
         _spanel = null;
         ObjectUtils.disposeAllChildren(cardSp);
         cardSp = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

