package view.inside
{
   import bag.helper.GoodsCheck;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.FashionEvent;
   import events.MountsEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ExchangeBoxManager;
   import managers.FashionManager;
   import managers.MountsManager;
   import mvc.module.exchange.ExchangeBoxModel;
   import mvc.module.mounts.MountShopInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
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
   import yishi.view.tips.MessageTipManager;
   
   public class ShopBoxView extends Sprite implements Disposeable
   {
      
      private static const MAX_SUCCESS_COUNT:int = 10;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _sexwoman:Bitmap;
      
      private var _bg:MutipleImage;
      
      private var _back:ScaleFrameImage;
      
      private var _pointBg:MutipleImage;
      
      private var _giftBg:MutipleImage;
      
      private var _shopCartBtn:IconButton;
      
      private var _recharge:IconButton;
      
      private var _giftTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _viewBack:ScaleFrameImage;
      
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
      
      private var _mountKeyCountTxt:FilterFrameText;
      
      private var _keyCount:int;
      
      private var _mountKeyCount:int;
      
      private var _index:int;
      
      private var _boxMc:MovieClip;
      
      private var _fireMc:MovieClip;
      
      public function ShopBoxView(param1:int)
      {
         super();
         _index = param1;
         resolveConfigValue();
         initView();
         initEvent();
         ExchangeBoxManager.instance.sendExchangeBoxOperate(4);
         ExchangeBoxManager.instance.sendExchangeBoxOperate(5);
      }
      
      private function initView() : void
      {
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("shop.Back1");
         _sexwoman = ComponentFactory.Instance.creatBitmap("asset.shop.sexwoman");
         _boxMc = ComponentFactory.Instance.creatCustomObject("shop.boxMc");
         _fireMc = ComponentFactory.Instance.creatCustomObject("shop.fireMc");
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBG2");
         _back = ComponentFactory.Instance.creatComponentByStylename("shopBoxView.back");
         _pointBg = ComponentFactory.Instance.creatComponentByStylename("shop.pointImage");
         _giftBg = ComponentFactory.Instance.creatComponentByStylename("shop.bindDiamond");
         _shopCartBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ShopCartBtn");
         _recharge = ComponentFactory.Instance.creatComponentByStylename("shop.ChargeBtn");
         _giftTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GiftTextStyle1");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PointTextStyle1");
         _viewBack = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.viewBack");
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
         _mountKeyCountTxt = ComponentFactory.Instance.creatComponentByStylename("ExchangeBoxFrame.mountKeyCountTxt");
         addChild(_sexwoman);
         addChild(_boxMc);
         addChild(_fireMc);
         addChild(_bg1);
         addChild(_bg);
         _bg.y -= 6;
         addChild(_back);
         addChild(_pointBg);
         _pointBg.x = 221;
         _pointBg.y = 458;
         addChild(_giftBg);
         _giftBg.x = 400;
         _giftBg.y = 458;
         addChild(_shopCartBtn);
         _shopCartBtn.y -= 6;
         addChild(_recharge);
         addChild(_giftTxt);
         addChild(_pointTxt);
         addChild(_viewBack);
         addChild(_leftMcImage);
         addChild(_rightMcImage);
         addChild(_leftCostText);
         addChild(_rightCostText);
         addChild(_leftBuyText);
         addChild(_rightBuyText);
         addChild(_alertText);
         addChild(_moreBuyContiner);
         addChild(_hotHbox);
         addChild(_oneLeftBtn);
         addChild(_oneKeyBtn);
         addChild(_oneRightBtn);
         addChild(_fashionKeyCountTxt);
         addChild(_mountKeyCountTxt);
         refreshKeyCount();
         _giftTxt.text = playerInfo.giftToken1 + "";
         _pointTxt.text = playerInfo.point + "";
         updateIndex();
         _boxMc.gotoAndPlay(1);
         _fireMc.gotoAndPlay(1);
      }
      
      private function updateIndex() : void
      {
         var _loc2_:GoodsTemplateInfo = null;
         var _loc1_:int = 0;
         _back.setFrame(_index);
         _viewBack.setFrame(_index);
         _leftMcImage.setFrame(_index);
         _rightMcImage.setFrame(_index);
         _alertText.htmlText = LanguageMgr.GetTranslation("ExchangeBoxFrame.alertText.text" + _index);
         if(_index == 1)
         {
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208020);
            _loc1_ = fashionOnceBuyCount;
            _fashionKeyCountTxt.visible = true;
            _mountKeyCountTxt.visible = false;
            _oneRightBtn.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.oneRightBtn.tipData2");
         }
         else
         {
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208017);
            _loc1_ = mountOnceBuyCount;
            _fashionKeyCountTxt.visible = false;
            _mountKeyCountTxt.visible = true;
            _oneRightBtn.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.oneRightBtn.tipData");
         }
         if(_loc2_)
         {
            _oneLeftBtn.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.oneLeftBtn.tipData",_loc2_.TemplateName,_loc1_);
         }
         if(_loc2_)
         {
            _oneKeyBtn.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.oneLeftBtn.tipData",_loc2_.TemplateName,_loc1_ * 10);
         }
         refreshView();
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
      
      public function refreshKeyCount() : void
      {
         _keyCount = GoodsManager.instance.getGoodsNumByTempId(208132);
         _fashionKeyCountTxt.text = LanguageMgr.GetTranslation("exchangebox.ExchangeBoxFrame.keyCount",_keyCount);
         _mountKeyCount = GoodsManager.instance.getGoodsNumByTempId(212600721);
         _mountKeyCountTxt.text = LanguageMgr.GetTranslation("exchangebox.ExchangeBoxFrame.keyCount2",_mountKeyCount);
      }
      
      private function initEvent() : void
      {
         _recharge.addEventListener("click",__onRechargeHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         _oneLeftBtn.addEventListener("click",__LeftBtnClickHandler);
         _oneKeyBtn.addEventListener("click",__LeftBtnClickHandler);
         _oneRightBtn.addEventListener("click",__oneRightBtnHandler);
         MsgMan.addObserver("EXCHANGE_HOT_UPDATE",this,__updateHotListHandler);
         MsgMan.addObserver("EXCHANGE_BUY_BACK",this,__updatBuyResultHandler);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__updateBuyCountHandler);
         FashionManager.instance.addEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
         MountsManager.instance.avatarList.addEventListener("mountListChange",__updateMountInfoHandler);
         MsgMan.addObserver("EXCHANGE_DROP_UPDATE",this,__updateDropListHandler);
         _shopCartBtn.addEventListener("click",__shopCartBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _recharge.removeEventListener("click",__onRechargeHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
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
         _shopCartBtn.removeEventListener("click",__shopCartBtnHandler);
      }
      
      private function __shopCartBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",200);
      }
      
      private function __refreshPlayerInfoHandler(param1:Event) : void
      {
         _pointTxt.text = playerInfo.point + "";
         _giftTxt.text = playerInfo.giftToken1 + "";
      }
      
      private function __onRechargeHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
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
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_index == 1)
         {
            _leftCostText.text = fashionCost + "";
            _rightCostText.text = fashionHotCost + "";
            _loc5_ = fashionMaxCount - model.fashionHasBuy;
            _loc4_ = fashionHotMaxCount - model.hotFashionHasBuy;
            _loc3_ = 10 - model.fashionHasBuy % 10;
         }
         else
         {
            _leftCostText.text = mountCost + "";
            _rightCostText.text = mountHotCost + "";
            _loc5_ = mountMaxCount - model.mountHasBuy;
            _loc4_ = mountHotMaxCount - model.hotMountHasBuy;
            _loc3_ = 10 - model.mountHasBuy % 10;
         }
         _leftBuyText.text = LanguageMgr.GetTranslation("ExchangeBoxFrame.leftBuyText.text",_loc5_);
         _rightBuyText.text = LanguageMgr.GetTranslation("ExchangeBoxFrame.leftBuyText.text",_loc4_);
         NumberViewUtils.refreshValue(_loc3_,_moreBuyContiner,_numberBitmap,18,24,14,18,"0123456789");
         _moreBuyContiner.x = _loc3_ >= 10 ? 444 : 447;
      }
      
      private function __updatBuyResultHandler(param1:String, param2:Object) : void
      {
         var showList:Array;
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
         addChild(_curPlayMc);
         if(showList.length == 1)
         {
            item = ComponentFactory.Instance.creatCustomObject("ExchangeBoxFrame.getItem" + getIndex(body.type,body.op));
            gInfo = new GoodsInfo();
            gInfo.templateId = showList[0].itemId;
            gInfo.count = showList[0].itemCount;
            item.data = gInfo;
            _curPlayMc["showGoods0"]["goodItem"].removeChildAt(0);
            _curPlayMc["showGoods0"]["goodItem"].addChild(item);
            if(GoodsCheck.isFashion(gInfo.templateInfo) || gInfo.templateInfo.SonType == 218)
            {
               _curPlayMc["showGoods0"]["effect"].visible = true;
            }
            else
            {
               _curPlayMc["showGoods0"]["effect"].visible = false;
            }
         }
         _curPlayMc.addFrameScript(36,function():void
         {
            if(showList.length > 1)
            {
               showItemFrame(showList);
            }
            else if(gInfo && (GoodsCheck.isFashion(gInfo.templateInfo) || gInfo.templateInfo.SonType == 218))
            {
               showAvatarFrame(gInfo);
            }
         });
         _curPlayMc.addFrameScript(_curPlayMc.totalFrames - 1,function():void
         {
            _curPlayMc.stop();
            ObjectUtils.disposeViolentMc(_curPlayMc);
            _curPlayMc = null;
            setViewState(true,10);
         });
         refreshKeyCount();
      }
      
      public function showItemFrame(param1:Array) : void
      {
         var _loc2_:ShopBoxFrame = ComponentFactory.Instance.creatComponentByStylename("view.inside.ShopBoxFrame",[param1]);
         _loc2_.show();
      }
      
      public function showAvatarFrame(param1:GoodsInfo) : void
      {
         var _loc2_:ShopAvatarFrame = ComponentFactory.Instance.creatComponentByStylename("view.inside.ShopAvatarFrame",[param1]);
         _loc2_.show();
      }
      
      private function getIndex(param1:int, param2:int) : int
      {
         if(param1 == 2 || param1 == 3 || param2 == 1)
         {
            return 2;
         }
         return 1;
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
      }
      
      private function __updateDropListHandler(param1:String, param2:Object) : void
      {
         var _loc3_:Array = null;
         var _loc6_:Array = null;
         var _loc5_:Array = null;
         var _loc4_:String = LanguageMgr.GetTranslation("ExchangeBoxFrame.leftMcImage.tipData.typeStr" + _index);
         if(_index == 1)
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
         _leftMcImage.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.leftMcImage.tipData") + "\n" + _loc4_ + "," + getGoodsDesc(_loc3_);
         _rightMcImage.tipData = LanguageMgr.GetTranslation("ExchangeBoxFrame.rightMcImage.tipData") + "\n" + getGoodsDesc(_loc6_) + "," + getGoodsDesc(_loc5_);
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
                  _loc5_ += _loc2_.TemplateName + ",";
               }
            }
            _loc3_++;
         }
         return _loc5_.substring(0,_loc5_.lastIndexOf(","));
      }
      
      private function __updateHotListHandler(param1:String, param2:Object) : void
      {
         var _loc4_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         _hotHbox.removeAllChild();
         var _loc3_:Array = _index == 1 ? model.hotFashionArr : model.hotMountArr;
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
      
      private function __LeftBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = param1.target == _oneKeyBtn;
         if(_index == 1)
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
         if(_index == 1)
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
            _loc5_ = _mountKeyCount > 0 ? true : _loc5_;
         }
         if(!_loc5_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         if(_index == 1)
         {
            _loc8_ = LanguageMgr.GetTranslation("ExchangeBoxFrame.buyAlert.content2",_loc4_,1);
            SimpleAlertHelper.instance.data = [rightBuyResultHandler2,_loc6_,_loc4_];
         }
         else
         {
            _loc8_ = LanguageMgr.GetTranslation("ExchangeBoxFrame.buyAlert.content3",_loc4_,1);
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
         if(_mountKeyCount > 0)
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
      
      private function get model() : ExchangeBoxModel
      {
         return ExchangeBoxManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_sexwoman);
         _sexwoman = null;
         ObjectUtils.disposeViolentMc(_boxMc);
         _boxMc = null;
         ObjectUtils.disposeViolentMc(_fireMc);
         _fireMc = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_pointBg);
         _pointBg = null;
         ObjectUtils.disposeObject(_giftBg);
         _giftBg = null;
         ObjectUtils.disposeObject(_shopCartBtn);
         _shopCartBtn = null;
         ObjectUtils.disposeObject(_recharge);
         _recharge = null;
         ObjectUtils.disposeObject(_giftTxt);
         _giftTxt = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_viewBack);
         _viewBack = null;
         ObjectUtils.disposeObject(_oneLeftBtn);
         _oneLeftBtn = null;
         ObjectUtils.disposeObject(_oneKeyBtn);
         _oneKeyBtn = null;
         ObjectUtils.disposeObject(_oneRightBtn);
         _oneRightBtn = null;
         ObjectUtils.disposeObject(_leftCostText);
         _leftCostText = null;
         ObjectUtils.disposeObject(_rightCostText);
         _rightCostText = null;
         ObjectUtils.disposeObject(_leftBuyText);
         _leftBuyText = null;
         ObjectUtils.disposeObject(_rightBuyText);
         _rightBuyText = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_numberBitmap);
         _numberBitmap = null;
         ObjectUtils.disposeObject(_moreBuyContiner);
         _moreBuyContiner = null;
         ObjectUtils.disposeObject(_leftMcImage);
         _leftMcImage = null;
         ObjectUtils.disposeObject(_rightMcImage);
         _rightMcImage = null;
         ObjectUtils.disposeObject(_fashionKeyCountTxt);
         _fashionKeyCountTxt = null;
         ObjectUtils.disposeViolentMc(_curPlayMc);
         _curPlayMc = null;
         ObjectUtils.disposeAllChildren(_hotHbox);
         _hotHbox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

