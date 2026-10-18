package exchangebox
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FashionEvent;
   import events.MountsEvent;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ExchangeBoxManager;
   import managers.FashionManager;
   import managers.MountsManager;
   import mvc.module.exchange.ExchangeBoxModel;
   import mvc.module.fashion.FashionModel;
   import mvc.module.mounts.MountShopInfo;
   import mvc.module.mounts.WildSoulCollection;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.BulePowerItem;
   import yishi.view.tips.MessageTipManager;
   
   public class ExchangeBoxFrame extends Frame
   {
      
      private static const MAX_SUCCESS_COUNT:int = 10;
      
      private var _border:ScaleBitmapImage;
      
      private var _back:ScaleFrameImage;
      
      private var _viewBack:ScaleFrameImage;
      
      private var _fashionBookBtn:IconButton;
      
      private var _mountBookBtn:IconButton;
      
      private var _collectBar:BulePowerItem;
      
      private var _oneLeftBtn:IconButton;
      
      private var _oneKeyBtn:IconButton;
      
      private var _oneRightBtn:IconButton;
      
      private var _leftCostText:FilterFrameText;
      
      private var _rightCostText:FilterFrameText;
      
      private var _leftBuyText:FilterFrameText;
      
      private var _rightBuyText:FilterFrameText;
      
      private var _alertText:FilterFrameText;
      
      private var _numberBitmap:BitmapData;
      
      private var _moreBuyContiner:Component;
      
      private var _leftMcImage:ScaleFrameImage;
      
      private var _rightMcImage:ScaleFrameImage;
      
      private var _curPlayMc:MovieClip;
      
      private var _hotHbox:HBox;
      
      private var _curFrameType:int;
      
      private var fashionCost:int;
      
      private var fashionHotCost:int;
      
      private var fashionMaxCount:int;
      
      private var fashionHotMaxCount:int;
      
      private var fashionOnceBuyCount:int;
      
      private var mountCost:int;
      
      private var mountHotCost:int;
      
      private var mountMaxCount:int;
      
      private var mountHotMaxCount:int;
      
      private var mountOnceBuyCount:int;
      
      private var _fashionKeyCountTxt:FilterFrameText;
      
      private var _keyCount:int;
      
      public function ExchangeBoxFrame()
      {
         super();
         resolveConfigValue();
         initView();
         addEvent();
         ExchangeBoxManager.instance.sendExchangeBoxOperate(4);
         ExchangeBoxManager.instance.sendExchangeBoxOperate(5);
      }
      
      private function resolveConfigValue() : void
      {
         var _loc1_:Array = ConfigInfoManager.instance.getFashionBoxArr();
         var _loc2_:Array = ConfigInfoManager.instance.getMountBoxArr();
         fashionCost = int(_loc1_[0].split(",")[0]);
         fashionHotCost = int(_loc1_[1].split(",")[0]);
         fashionMaxCount = int(_loc1_[0].split(",")[1]);
         fashionHotMaxCount = int(_loc1_[1].split(",")[1]);
         fashionOnceBuyCount = int(_loc1_[0].split(",")[2]);
         mountCost = int(_loc2_[0].split(",")[0]);
         mountHotCost = int(_loc2_[1].split(",")[0]);
         mountMaxCount = int(_loc2_[0].split(",")[1]);
         mountHotMaxCount = int(_loc2_[1].split(",")[1]);
         mountOnceBuyCount = int(_loc2_[0].split(",")[2]);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.back");
         _viewBack = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.viewBack");
         _fashionBookBtn = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.fashionBookBtn");
         _mountBookBtn = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.mountBookBtn");
         _collectBar = ComponentFactory.Instance.creatCustomObject("ExchangeBoxFrame.collectBar",[true]);
         _leftMcImage = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.leftMcImage");
         _rightMcImage = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.rightMcImage");
         _oneLeftBtn = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.oneLeftBtn");
         _oneKeyBtn = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.oneKeyBtn");
         _oneRightBtn = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.oneRightBtn");
         _leftCostText = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.leftCostText");
         _rightCostText = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.rightCostText");
         _leftBuyText = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.leftBuyText");
         _rightBuyText = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.rightBuyText");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.alertText");
         _numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.ExchangeBoxFrame.NumBmpData");
         _moreBuyContiner = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.moreBuyContiner");
         _hotHbox = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.hotHbox");
         _fashionKeyCountTxt = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.fashionKeyCountTxt");
         addToContent(_border);
         addToContent(_back);
         addToContent(_viewBack);
         addToContent(_fashionBookBtn);
         _fashionBookBtn.visible = false;
         addToContent(_mountBookBtn);
         _mountBookBtn.visible = false;
         addToContent(_collectBar);
         addToContent(_leftMcImage);
         addToContent(_rightMcImage);
         addToContent(_leftCostText);
         addToContent(_rightCostText);
         addToContent(_leftBuyText);
         addToContent(_rightBuyText);
         addToContent(_alertText);
         addToContent(_moreBuyContiner);
         addToContent(_hotHbox);
         addToContent(_oneLeftBtn);
         addToContent(_oneKeyBtn);
         addToContent(_oneRightBtn);
         addToContent(_fashionKeyCountTxt);
         refreshKeyCount();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _fashionBookBtn.addEventListener("click",__fashionBookHandler);
         _mountBookBtn.addEventListener("click",__mountBookHandler);
         _oneLeftBtn.addEventListener("click",__LeftBtnClickHandler);
         _oneKeyBtn.addEventListener("click",__LeftBtnClickHandler);
         _oneRightBtn.addEventListener("click",__oneRightBtnHandler);
         MsgMan.addObserver("EXCHANGE_HOT_UPDATE",this,__updateHotListHandler);
         MsgMan.addObserver("EXCHANGE_BUY_BACK",this,__updatBuyResultHandler);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__updateBuyCountHandler);
         FashionManager.instance.addEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
         MountsManager.instance.avatarList.addEventListener("mountListChange",__updateMountInfoHandler);
         MsgMan.addObserver("EXCHANGE_DROP_UPDATE",this,__updateDropListHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_fashionBookBtn)
         {
            _fashionBookBtn.removeEventListener("click",__fashionBookHandler);
         }
         if(_mountBookBtn)
         {
            _mountBookBtn.removeEventListener("click",__mountBookHandler);
         }
         if(_oneLeftBtn)
         {
            _oneLeftBtn.removeEventListener("click",__LeftBtnClickHandler);
         }
         if(_oneKeyBtn)
         {
            _oneKeyBtn.removeEventListener("click",__LeftBtnClickHandler);
         }
         if(_oneRightBtn)
         {
            _oneRightBtn.removeEventListener("click",__oneRightBtnHandler);
         }
         MsgMan.removeObserver("EXCHANGE_HOT_UPDATE",this,__updateHotListHandler);
         MsgMan.removeObserver("EXCHANGE_BUY_BACK",this,__updatBuyResultHandler);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__updateBuyCountHandler);
         FashionManager.instance.removeEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
         MountsManager.instance.avatarList.removeEventListener("mountListChange",__updateMountInfoHandler);
         MsgMan.removeObserver("EXCHANGE_DROP_UPDATE",this,__updateDropListHandler);
      }
      
      public function refreshKeyCount() : void
      {
         _keyCount = GoodsManager.instance.getGoodsNumByTempId(208132);
         _fashionKeyCountTxt.text = LanguageMgr.GetTranslation("exchangebox.ExchangeBoxFrame.keyCount",_keyCount);
      }
      
      private function __receivedBookHandler(param1:FashionEvent) : void
      {
         refreshView();
      }
      
      private function __updateMountInfoHandler(param1:MountsEvent) : void
      {
         refreshView();
      }
      
      private function __updateBuyCountHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function __updatBuyResultHandler(param1:String, param2:Object) : void
      {
         var showList:Array;
         var i:int;
         var item:BaseItemView;
         var gInfo:GoodsInfo;
         var msg:String = param1;
         var body:Object = param2;
         if(!body)
         {
            return;
         }
         showList = body.list;
         if(_curPlayMc)
         {
            ObjectUtils.disposeViolentMc(_curPlayMc);
         }
         _curPlayMc = null;
         setViewState(false,body.type);
         _curPlayMc = ComponentFactory.Instance.creatCustomObject("ExchangeBoxFrame.buyResultMc" + body.type + "_" + body.op);
         addToContent(_curPlayMc);
         i = 0;
         while(i < showList.length)
         {
            item = ComponentFactory.Instance.creatCustomObject("ExchangeBoxFrame.getItem" + getIndex(body.type,body.op));
            gInfo = new GoodsInfo();
            gInfo.templateId = showList[i].itemId;
            gInfo.count = showList[i].itemCount;
            item.data = gInfo;
            _curPlayMc["showGoods" + i]["goodItem"].removeChildAt(0);
            _curPlayMc["showGoods" + i]["goodItem"].addChild(item);
            i = i + 1;
         }
         _curPlayMc.addFrameScript(_curPlayMc.totalFrames - 1,function():void
         {
            _curPlayMc.stop();
            ObjectUtils.disposeViolentMc(_curPlayMc);
            _curPlayMc = null;
            setViewState(true,10);
         });
         refreshKeyCount();
      }
      
      private function getIndex(param1:int, param2:int) : int
      {
         if(param1 == 2 || param1 == 3 || param2 == 1)
         {
            return 2;
         }
         return 1;
      }
      
      private function __updateHotListHandler(param1:String, param2:Object) : void
      {
         var _loc4_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         _hotHbox.removeAllChild();
         var _loc3_:Array = curFrameType == 1 ? model.hotFashionArr : model.hotMountArr;
         for each(var _loc5_:MountShopInfo in _loc3_)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("ExchangeBoxFrame.hotItem");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc5_.tempId;
            _loc6_.count = _loc5_.count;
            _loc4_.data = _loc6_;
            _hotHbox.addChild(_loc4_);
         }
      }
      
      private function __updateDropListHandler(param1:String, param2:Object) : void
      {
         var _loc3_:Array = null;
         var _loc6_:Array = null;
         var _loc5_:Array = null;
         var _loc4_:String = LanguageMgr.GetTranslation("ExchangeBoxFrame.leftMcImage.tipData.typeStr" + curFrameType);
         if(curFrameType == 1)
         {
            _loc3_ = model.fashionDropArr;
            _loc6_ = model.fashionHotDropArr;
            _loc5_ = model.hotFashionArr;
         }
         else
         {
            _loc3_ = model.mountDropArr;
            _loc6_ = model.mountHotDropArr;
            _loc5_ = model.hotMountArr;
         }
         _leftMcImage.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.leftMcImage.tipData") + "\n" + _loc4_ + ", " + getGoodsDesc(_loc3_);
         _rightMcImage.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.rightMcImage.tipData") + "\n" + getGoodsDesc(_loc6_) + ", " + getGoodsDesc(_loc5_);
      }
      
      private function getGoodsDesc(param1:Array) : String
      {
         var _loc3_:int = 0;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc5_:String = "";
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc4_.indexOf(param1[_loc3_].tempId) == -1)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1[_loc3_].tempId);
               if(!(!_loc2_ || param1[_loc3_].count == 0))
               {
                  _loc4_.push(param1[_loc3_].tempId);
                  _loc5_ += _loc2_.TemplateName + ", ";
               }
            }
            _loc3_++;
         }
         return _loc5_.substring(0,_loc5_.lastIndexOf(","));
      }
      
      private function setViewState(param1:Boolean, param2:int) : void
      {
         if(param2 == 0 || param2 == 1)
         {
            _leftMcImage.visible = false;
            _rightMcImage.visible = true;
         }
         else if(param2 == 2 || param2 == 3)
         {
            _leftMcImage.visible = true;
            _rightMcImage.visible = false;
         }
         else
         {
            _leftMcImage.visible = true;
            _rightMcImage.visible = true;
         }
         _oneKeyBtn.enable = _oneLeftBtn.enable = _oneRightBtn.enable = param1;
         this.closeButton.enable = param1;
      }
      
      private function __fashionBookHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("fashion",1);
      }
      
      private function __mountBookHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("mounts",2);
      }
      
      private function __LeftBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:Boolean = false;
         SoundManager.instance.play("022");
         var _loc6_:Boolean = param1.target == _oneKeyBtn;
         if(curFrameType == 1)
         {
            _loc7_ = 0;
            _loc9_ = _loc6_ ? 1 : 0;
            _loc4_ = int(_loc6_ ? fashionCost * 10 : fashionCost);
            if(_loc6_)
            {
               _loc5_ = model.fashionHasBuy + 10 > fashionMaxCount ? false : true;
            }
            else
            {
               _loc5_ = model.fashionHasBuy + 1 > fashionMaxCount ? false : true;
            }
         }
         else
         {
            _loc7_ = 1;
            _loc9_ = _loc6_ ? 1 : 0;
            _loc4_ = int(_loc6_ ? mountCost * 10 : mountCost);
            if(_loc6_)
            {
               _loc5_ = model.mountHasBuy + 10 > mountMaxCount ? false : true;
            }
            else
            {
               _loc5_ = model.mountHasBuy + 1 > mountMaxCount ? false : true;
            }
         }
         if(!_loc5_)
         {
            if(_loc6_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ExchangeBoxFrame.buyAlert.oneKeyBuy.Alert"));
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData"));
            }
            return;
         }
         SimpleAlertHelper.instance.data = [leftBuyResultHandler,_loc7_,_loc9_,_loc4_];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc10_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc8_:int = int(_loc6_ ? 10 : 1);
         var _loc11_:String = LanguageMgr.GetTranslation("ExchangeBoxFrame.buyAlert.content",_loc4_,_loc8_);
         SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc11_,_loc2_,_loc3_,true,true,true,2,"USEBINDPOINT_ALERT",180,"",null,"SimpleAlert");
      }
      
      private function leftBuyResultHandler(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!param1)
         {
            return;
         }
         if(param2)
         {
            _loc6_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc6_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc6_ >= param5)
         {
            _loc7_ = param2 ? 0 : 1;
            ExchangeBoxManager.instance.sendExchangeBoxOperate(param3,param4,_loc7_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __oneRightBtnHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Boolean = false;
         var _loc8_:String = null;
         SoundManager.instance.play("022");
         if(curFrameType == 1)
         {
            _loc4_ = fashionHotCost;
            _loc6_ = 2;
            _loc5_ = model.hotFashionHasBuy < fashionHotMaxCount ? true : false;
            _loc5_ = _keyCount > 0 ? true : _loc5_;
         }
         else
         {
            _loc4_ = mountHotCost;
            _loc6_ = 3;
            _loc5_ = model.hotMountHasBuy < mountHotMaxCount ? true : false;
         }
         if(!_loc5_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         if(curFrameType == 1)
         {
            _loc8_ = LanguageMgr.GetTranslation("ExchangeBoxFrame.buyAlert.content2",_loc4_,1);
            SimpleAlertHelper.instance.data = [rightBuyResultHandler2,_loc6_,_loc4_];
         }
         else
         {
            _loc8_ = LanguageMgr.GetTranslation("ExchangeBoxFrame.buyAlert.content",_loc4_,1);
            SimpleAlertHelper.instance.data = [rightBuyResultHandler,_loc6_,_loc4_];
         }
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc2_,_loc3_,true,true,true,2);
      }
      
      private function rightBuyResultHandler(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         if(!param1)
         {
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= param4)
         {
            ExchangeBoxManager.instance.sendExchangeBoxOperate(param3,0);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function rightBuyResultHandler2(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         if(!param1)
         {
            return;
         }
         if(_keyCount > 0)
         {
            ExchangeBoxManager.instance.sendExchangeBoxOperate(param3,0);
         }
         else if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= param4)
         {
            ExchangeBoxManager.instance.sendExchangeBoxOperate(param3,0);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = 0;
         var _loc1_:* = 0;
         if(curFrameType == 1)
         {
            _loc1_ = _collectBar.max = fashionModel.fashionIds.length;
            _loc2_ = _collectBar.current = fashionModel.bookList.keys.length;
            _collectBar.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.collectBar.tipdata1",_loc2_,_loc1_);
            _leftCostText.text = fashionCost + "";
            _rightCostText.text = fashionHotCost + "";
            _loc5_ = fashionMaxCount - model.fashionHasBuy;
            _loc4_ = fashionHotMaxCount - model.hotFashionHasBuy;
            _loc3_ = 10 - model.fashionHasBuy % 10;
         }
         else
         {
            _loc1_ = _collectBar.max = wildSoulCollection.allMountTempLen;
            _loc2_ = _collectBar.current = wildSoulCollection.data.keys.length;
            _collectBar.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.collectBar.tipdata2",_loc2_,_loc1_);
            _leftCostText.text = mountCost + "";
            _rightCostText.text = mountHotCost + "";
            _loc5_ = mountMaxCount - model.mountHasBuy;
            _loc4_ = mountHotMaxCount - model.hotMountHasBuy;
            _loc3_ = 10 - model.mountHasBuy % 10;
         }
         _leftBuyText.text = LanguageMgr.GetTranslation("ExchangeBoxFrame.leftBuyText.text",_loc5_);
         _rightBuyText.text = LanguageMgr.GetTranslation("ExchangeBoxFrame.leftBuyText.text",_loc4_);
         NumberViewUtils.refreshValue(_loc3_,_moreBuyContiner,_numberBitmap,18,24,14,18,"0123456789");
         _moreBuyContiner.x = _loc3_ >= 10 ? 170 : 175;
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
      
      public function get curFrameType() : int
      {
         return _curFrameType;
      }
      
      public function set curFrameType(param1:int) : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc2_:int = 0;
         _curFrameType = param1;
         _back.setFrame(_curFrameType);
         _viewBack.setFrame(_curFrameType);
         _leftMcImage.setFrame(_curFrameType);
         _rightMcImage.setFrame(_curFrameType);
         _alertText.htmlText = LanguageMgr.GetTranslation("ExchangeBoxFrame.alertText.text" + curFrameType);
         if(curFrameType == 1)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208020);
            titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_fashionbox");
            _loc2_ = fashionOnceBuyCount;
            _fashionBookBtn.visible = true;
            _mountBookBtn.visible = false;
            _fashionKeyCountTxt.visible = true;
            _oneRightBtn.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.oneRightBtn.tipData2");
         }
         else
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208017);
            titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_mountbox");
            _loc2_ = mountOnceBuyCount;
            _mountBookBtn.visible = true;
            _fashionBookBtn.visible = false;
            _fashionKeyCountTxt.visible = false;
            _oneRightBtn.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.oneRightBtn.tipData");
         }
         if(_loc3_)
         {
            _oneLeftBtn.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.oneLeftBtn.tipData",_loc3_.TemplateName,_loc2_);
         }
         if(_loc3_)
         {
            _oneKeyBtn.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.oneLeftBtn.tipData",_loc3_.TemplateName,_loc2_ * 10);
         }
         refreshView();
      }
      
      public function show(param1:int = 0) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         curFrameType = param1;
         FrameControllerManager.instance.exchangeBoxControler.isOpenFrame = true;
      }
      
      private function get model() : ExchangeBoxModel
      {
         return ExchangeBoxManager.instance.model;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FashionManager.instance.fashionModel;
      }
      
      private function get wildSoulCollection() : WildSoulCollection
      {
         return MountsManager.instance.avatarList;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_border)
         {
            ObjectUtils.disposeObject(_border);
         }
         _border = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_viewBack)
         {
            ObjectUtils.disposeObject(_viewBack);
         }
         _viewBack = null;
         if(_fashionBookBtn)
         {
            ObjectUtils.disposeObject(_fashionBookBtn);
         }
         _fashionBookBtn = null;
         if(_mountBookBtn)
         {
            ObjectUtils.disposeObject(_mountBookBtn);
         }
         _mountBookBtn = null;
         if(_collectBar)
         {
            ObjectUtils.disposeObject(_collectBar);
         }
         _collectBar = null;
         if(_oneLeftBtn)
         {
            ObjectUtils.disposeObject(_oneLeftBtn);
         }
         _oneLeftBtn = null;
         if(_oneRightBtn)
         {
            ObjectUtils.disposeObject(_oneRightBtn);
         }
         _oneRightBtn = null;
         if(_oneKeyBtn)
         {
            ObjectUtils.disposeObject(_oneKeyBtn);
         }
         _oneKeyBtn = null;
         if(_leftCostText)
         {
            ObjectUtils.disposeObject(_leftCostText);
         }
         _leftCostText = null;
         if(_rightCostText)
         {
            ObjectUtils.disposeObject(_rightCostText);
         }
         _rightCostText = null;
         if(_leftBuyText)
         {
            ObjectUtils.disposeObject(_leftBuyText);
         }
         _leftBuyText = null;
         if(_rightBuyText)
         {
            ObjectUtils.disposeObject(_rightBuyText);
         }
         _rightBuyText = null;
         if(_alertText)
         {
            ObjectUtils.disposeObject(_alertText);
         }
         _alertText = null;
         if(_numberBitmap)
         {
            ObjectUtils.disposeObject(_numberBitmap);
         }
         _numberBitmap = null;
         if(_moreBuyContiner)
         {
            ObjectUtils.disposeObject(_moreBuyContiner);
         }
         _moreBuyContiner = null;
         if(_leftMcImage)
         {
            ObjectUtils.disposeObject(_leftMcImage);
         }
         _leftMcImage = null;
         if(_rightMcImage)
         {
            ObjectUtils.disposeObject(_rightMcImage);
         }
         _rightMcImage = null;
         if(_fashionKeyCountTxt)
         {
            ObjectUtils.disposeObject(_fashionKeyCountTxt);
         }
         _fashionKeyCountTxt = null;
         if(_hotHbox)
         {
            ObjectUtils.disposeObject(_hotHbox);
         }
         _hotHbox = null;
         if(_curPlayMc)
         {
            ObjectUtils.disposeViolentMc(_curPlayMc);
         }
         _curPlayMc = null;
         FrameControllerManager.instance.exchangeBoxControler.isOpenFrame = false;
         super.dispose();
      }
   }
}

