package map.campaign.view.market
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLVariables;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MarketModel;
   import map.campaign.data.StallInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MarketSellFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _goodsSp:Sprite;
      
      private var _sellSp:Sprite;
      
      private var _itemList:Vector.<MarketSellItem>;
      
      private var _data:StallInfo;
      
      private var _stallSellBtn:IconButton;
      
      private var _cancleSellBtn:IconButton;
      
      private var _costTxt:FilterFrameText;
      
      private var _rentImg:MutipleImage;
      
      private var _sellNum:int = 12;
      
      private var _sellPetBtn:TextButton;
      
      private var _type:int;
      
      private var _stallNameTxt:FilterFrameText;
      
      private var _stallName:String;
      
      private var _petView:MarketPetView;
      
      public function MarketSellFrame(param1:int = 1)
      {
         _type = param1;
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,425,550);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("market.MarketSellFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarketSellFrame.bg");
         _rentImg = ComponentFactory.Instance.creatComponentByStylename("MarketSellFrame.rentImg");
         _stallSellBtn = ComponentFactory.Instance.creatComponentByStylename("MarketSellFrame.sellBtn");
         _cancleSellBtn = ComponentFactory.Instance.creatComponentByStylename("MarketSellFrame.cancleSellBtn");
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("MarketSellFrame.costTxt");
         _sellPetBtn = ComponentFactory.Instance.creatComponentByStylename("MarketSellFrame.sellPetBtn");
         _stallNameTxt = ComponentFactory.Instance.creatComponentByStylename("MarketSellFrame.stallNameTxt");
         _goodsSp = new Sprite();
         _sellSp = new Sprite();
         _itemList = new Vector.<MarketSellItem>();
         addToContent(_bg);
         addToContent(_goodsSp);
         addToContent(_sellSp);
         _sellSp.addChild(_rentImg);
         _sellSp.addChild(_stallNameTxt);
         _sellSp.addChild(_stallSellBtn);
         _sellSp.addChild(_costTxt);
         _sellSp.addChild(_sellPetBtn);
         addToContent(_cancleSellBtn);
         _goodsSp.x = 6;
         if(_type == 1)
         {
            _goodsSp.y = 40;
         }
         else if(_type == 2)
         {
            _goodsSp.y = 6;
         }
         _cancleSellBtn.visible = _type == 2;
         _sellSp.visible = _type == 1;
         _sellPetBtn.text = LanguageMgr.GetTranslation("market.MarketSellFrame.sellPet");
         _stallNameTxt.text = LanguageMgr.GetTranslation("market.MarketSellFrame.renameTxt");
         addGoods();
      }
      
      private function addGoods() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _sellNum)
         {
            _itemList[_loc1_] = new MarketSellItem();
            _itemList[_loc1_].pos = _loc1_;
            _itemList[_loc1_].x = _loc1_ % 2 * 195;
            _itemList[_loc1_].y = int(_loc1_ / 2) * 60;
            _goodsSp.addChild(_itemList[_loc1_]);
            _loc1_++;
         }
      }
      
      private function unitView() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_stallSellBtn)
         {
            _stallSellBtn.dispose();
         }
         _stallSellBtn = null;
         if(_cancleSellBtn)
         {
            _cancleSellBtn.dispose();
         }
         _cancleSellBtn = null;
         if(_rentImg)
         {
            _rentImg.dispose();
         }
         _rentImg = null;
         if(_costTxt)
         {
            _costTxt.dispose();
         }
         _costTxt = null;
         if(_sellPetBtn)
         {
            _sellPetBtn.dispose();
         }
         _sellPetBtn = null;
         if(_stallNameTxt)
         {
            _stallNameTxt.dispose();
         }
         _stallNameTxt = null;
         ObjectUtils.disposeAllChildren(_goodsSp);
         _goodsSp = null;
         _itemList = null;
      }
      
      override protected function addChildren() : void
      {
         if(_backgound)
         {
            addChild(_backgound);
         }
         addChild(_container);
         if(_title)
         {
            addChild(_title);
         }
         addChild(_moveRect);
         if(_type == 2 && _closeButton)
         {
            addChild(_closeButton);
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         if(isDie)
         {
            return;
         }
         _data = model.selfStall;
         if(!_stallName)
         {
            _stallName = _data.name ? _data.name : LanguageMgr.GetTranslation("CampaignArmy.stallName",playerInfo.nickName);
            _stallNameTxt.text = _data.name ? _data.name : LanguageMgr.GetTranslation("market.MarketSellFrame.renameTxt");
         }
         if(_type == 2)
         {
            titleText = _stallName;
         }
         _costTxt.text = "100000";
         _loc1_ = 0;
         while(_loc1_ < _sellNum)
         {
            _itemList[_loc1_].data = _data.items[_loc1_];
            _loc1_++;
         }
         if(_petView && _petView.isDie == false)
         {
            _petView.refresh();
         }
         moveEnable = _type == 2;
         if(_stallSellBtn)
         {
            _stallSellBtn.enable = true;
         }
         if(_stallNameTxt)
         {
            _type == 1 ? (_stallNameTxt.type = "input") : (_stallNameTxt.type = "dynamic");
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_stallSellBtn)
         {
            _stallSellBtn.addEventListener("click",__sellHandler);
         }
         if(_cancleSellBtn)
         {
            _cancleSellBtn.addEventListener("click",__cancleHandler);
         }
         if(_sellPetBtn)
         {
            _sellPetBtn.addEventListener("click",__sellPetHandler);
         }
         if(_stallNameTxt)
         {
            _stallNameTxt.addEventListener("change",__stallNameTxtHandler);
         }
         MsgMan.addObserver("CampaignEvent.MARKET_OPBACK",this,__opbackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_stallSellBtn)
         {
            _stallSellBtn.removeEventListener("click",__sellHandler);
         }
         if(_cancleSellBtn)
         {
            _cancleSellBtn.removeEventListener("click",__cancleHandler);
         }
         if(_sellPetBtn)
         {
            _sellPetBtn.removeEventListener("click",__sellPetHandler);
         }
         if(_stallNameTxt)
         {
            _stallNameTxt.removeEventListener("change",__stallNameTxtHandler);
         }
         MsgMan.removeObserver("CampaignEvent.MARKET_OPBACK",this,__opbackHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               __cancleHandler(null);
         }
      }
      
      private function __opbackHandler(param1:String, param2:Object) : void
      {
         if(param2 && param2.userId == playerInfo.userId && param2.isSuccess)
         {
            if(_type == 2)
            {
               refreshView();
            }
         }
      }
      
      private function __stallNameTxtHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_stallNameTxt.text) > 24)
         {
            _stallNameTxt.text = _stallName;
         }
         else
         {
            _stallName = _stallNameTxt.text;
         }
      }
      
      private function __sellPetHandler(param1:MouseEvent) : void
      {
         if(_petView == null || Boolean(_petView.isDie))
         {
            _petView = ComponentFactory.Instance.creatComponentByStylename("market.MarketPetView");
            _petView.show();
         }
      }
      
      private function __cancleHandler(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(model.selfStall.state == 2)
         {
            SimpleAlertHelper.instance.data = [endSellCall];
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc2_ = LanguageMgr.GetTranslation("market.MarketSellFrame.endSellTip");
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_);
         }
      }
      
      private function endSellCall(param1:Boolean = false, param2:Boolean = false) : void
      {
         if(param1)
         {
            model.endSell();
            dispose();
         }
      }
      
      private function __sellHandler(param1:MouseEvent) : void
      {
         if(_stallSellBtn && _stallNameTxt)
         {
            _stallSellBtn.enable = false;
            _stallNameTxt.type = "dynamic";
            serverCheck(_stallName);
         }
      }
      
      private function serverCheck(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["nickname"] = param1;
         _loc2_["rnd"] = Math.random();
         _loc2_["type"] = 3;
         var _loc3_:String = PathManager.info.REQUEST_PATH + "nicknamecheck";
         LoaderManagerII.instance.load(_loc3_,7,8,__serverCheckResult,null,null,null,_loc2_);
      }
      
      private function __serverCheckResult(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:String = null;
         if(_stallSellBtn)
         {
            _stallSellBtn.enable = true;
         }
         if(_stallNameTxt)
         {
            _stallNameTxt.type = "input";
         }
         var _loc4_:XML = new XML(param2);
         if(String(_loc4_.@value) == "true")
         {
            if(hasGoods == false)
            {
               _loc3_ = LanguageMgr.GetTranslation("market.MarketSellFrame.noGoods");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            if(model.selfStall.state != 1)
            {
               _loc3_ = LanguageMgr.GetTranslation("market.MarketSellFrame.wrongState");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            model.beginSell(_stallName);
         }
         else
         {
            MessageTipManager.instance().show(_loc4_.@message);
         }
      }
      
      private function get hasGoods() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _sellNum)
         {
            if(_itemList[_loc1_].data)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

