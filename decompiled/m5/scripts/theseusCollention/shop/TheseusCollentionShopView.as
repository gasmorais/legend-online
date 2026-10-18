package theseusCollention.shop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import managers.TheseussoulManager;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import mvc.module.theseus.TheseusCollenTionModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusCollentionShopView extends Sprite
   {
      
      protected var _leftbg:Bitmap;
      
      private var _money:FilterFrameText;
      
      private var _numBtnSelect:Bitmap;
      
      protected var _numberText:FilterFrameText;
      
      private var _numberTextbg:Bitmap;
      
      private var _numberdescText:FilterFrameText;
      
      private var _moneybg:Bitmap;
      
      private var _moneyicon:Bitmap;
      
      private var goodsList:Array = [];
      
      private var _data:ShopGoodsInfo;
      
      public var buyNum:int = 1;
      
      public var totalPrice:int;
      
      private var _btnVbox:HBox;
      
      private var itemList:Vector.<TheseusShopItem>;
      
      private var curPageData:Array;
      
      private var _numBtn1:TextButton;
      
      private var _numBtn10:TextButton;
      
      private var _numBtn50:TextButton;
      
      private var _numBtn100:TextButton;
      
      private var _buyBtn:IconButton;
      
      private var _openNum:int;
      
      private var _bg:Bitmap;
      
      public function TheseusCollentionShopView()
      {
         super();
         goodsList = [];
         for each(var _loc1_:ShopGoodsInfo in TempleteManager.instance.getthessShopTemplateDic())
         {
            goodsList.push(_loc1_);
         }
         goodsList.sortOn("Id",2);
         _data = goodsList[0];
         initView();
         initListView();
         addEvent();
      }
      
      public function get shopmodel() : ShopModel
      {
         return ShopManager.Instance.model;
      }
      
      private function initView() : void
      {
         _leftbg = ComponentFactory.Instance.creatBitmap("theseusCollection_leftBg2");
         addChild(_leftbg);
         _leftbg.width = 855;
         _leftbg.height = 458;
         _bg = ComponentFactory.Instance.creatBitmap("theseusCollection_shopBg");
         _bg.y = 5;
         _numberTextbg = ComponentFactory.Instance.creatBitmap("theseusCollection_shopnumSelect");
         _btnVbox = ComponentFactory.Instance.creatComponentByStylename("ui.theseuscollection.ShopHbox");
         _numBtnSelect = ComponentFactory.Instance.creatBitmap("theseusCollection_shopnumbtnSelect");
         _numBtn1 = ComponentFactory.Instance.creatComponentByStylename("collect.shopbtn1");
         _numBtn10 = ComponentFactory.Instance.creatComponentByStylename("collect.shopbtn2");
         _numBtn100 = ComponentFactory.Instance.creatComponentByStylename("collect.shopbtn4");
         _numBtn50 = ComponentFactory.Instance.creatComponentByStylename("collect.shopbtn3");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("theseusCollectionshopBuy");
         _numBtn1.text = "1";
         _numBtn10.text = "10";
         _numBtn100.text = "100";
         _numBtn50.text = "50";
         _moneyicon = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _moneybg = ComponentFactory.Instance.creatBitmap("theseusCollection_shopnumbg");
         _money = ComponentFactory.Instance.creatComponentByStylename("theseuscollectionshopBox.view.moneynum");
         _moneybg.x = -15;
         _numberdescText = ComponentFactory.Instance.creatComponentByStylename("theseuscollectionshopBox.view.numberdescText");
         _numberText = ComponentFactory.Instance.creatComponentByStylename("core.InputTextStyle");
         _numberText.selectable = true;
         _numberText.text = "1";
         _numberText.x = 690;
         _numberText.y = 223;
         addChild(_bg);
         addChild(_numBtnSelect);
         addChild(_numberText);
         _numBtnSelect.x = _numBtn1.x - 20;
         _numBtnSelect.y = 200;
         _numBtn1.y = _numBtn1.y;
         addChild(_numBtn1);
         addChild(_numBtn10);
         addChild(_numBtn50);
         addChild(_numberTextbg);
         addChild(_numberText);
         addChild(_numberdescText);
         _numberdescText.text = LanguageMgr.GetTranslation("theseuscollectbox.txt2");
         addChild(_buyBtn);
         _moneybg.y = 325;
         _moneybg.x = 360;
         addChild(_moneybg);
         addChild(_moneyicon);
         _moneyicon.y = 325;
         _moneyicon.x = 450;
         addChild(_money);
         _money.x = 385;
         _money.y = 325;
      }
      
      private function addEvent() : void
      {
         _numBtn1.addEventListener("click",__openBottleHandler);
         _numBtn10.addEventListener("click",__openBottleHandler);
         _numBtn100.addEventListener("click",__openBottleHandler);
         _numBtn50.addEventListener("click",__openBottleHandler);
         _buyBtn.addEventListener("click",__buyHandler);
         MsgMan.addObserver("SELECT_TheseusshopBOX_CHANGE",this,__selectFormulaItemHandler);
         _numberText.addEventListener("keyDown",__keydownHandler);
         _numberText.addEventListener("change",__textChangHandler);
         _numberText.addEventListener("focusIn",__inHandler);
         NotificationManager.instance.addEventListener("BTHESSOXSHOPBUYEFF",shopTimeGiftRefresh);
      }
      
      private function initListView() : void
      {
         var _loc4_:GoodsInfo = null;
         var _loc2_:int = 0;
         var _loc1_:TheseusShopItem = null;
         var _loc3_:Array = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(350);
         _loc3_.sortOn("TemplateId",2);
         itemList = new Vector.<TheseusShopItem>();
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = new TheseusShopItem(_loc2_);
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc3_[_loc2_].TemplateId;
            _loc4_.count = model.boxBagDic[_loc3_[_loc2_].TemplateId] ? model.boxBagDic[_loc3_[_loc2_].TemplateId].count : 0;
            if(_loc2_ == 0)
            {
               model.selectshopBox = _loc4_;
            }
            _loc1_.data = _loc4_;
            _btnVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         _btnVbox.commitChanges();
         addChild(_btnVbox);
         __selectFormulaItemHandler();
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      private function refreshView(param1:Object = null) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc2_:TheseusShopItem = null;
         var _loc3_:int = 0;
         var _loc4_:Array = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(350);
         _loc4_.sortOn("TemplateId",2);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = itemList[_loc3_];
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc4_[_loc3_].TemplateId;
            _loc5_.count = model.boxBagDic[_loc4_[_loc3_].TemplateId] ? model.boxBagDic[_loc4_[_loc3_].TemplateId].count : 0;
            if(_loc5_.templateId == model.selectshopBox.templateId)
            {
               model.selectshopBox.count = _loc5_.count;
               _data = goodsList[_loc3_];
            }
            _loc2_.data = _loc5_;
            _loc3_++;
         }
         __selectFormulaItemHandler();
      }
      
      private function removeEvent() : void
      {
         _numBtn1.removeEventListener("click",__openBottleHandler);
         _numBtn10.removeEventListener("click",__openBottleHandler);
         _numBtn100.removeEventListener("click",__openBottleHandler);
         _numBtn50.removeEventListener("click",__openBottleHandler);
         _buyBtn.removeEventListener("click",__buyHandler);
         MsgMan.removeObserver("SELECT_TheseusshopBOX_CHANGE",this,__selectFormulaItemHandler);
         _numberText.removeEventListener("keyDown",__keydownHandler);
         _numberText.removeEventListener("change",__textChangHandler);
         _numberText.removeEventListener("focusIn",__inHandler);
         NotificationManager.instance.removeEventListener("BTHESSOXSHOPBUYEFF",shopTimeGiftRefresh);
      }
      
      private function shopTimeGiftRefresh(param1:NotificationEvent) : void
      {
         goodsList = [];
         for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getthessShopTemplateDic())
         {
            goodsList.push(_loc2_);
         }
         goodsList.sortOn("Id",2);
         refreshView();
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _numberText.setSelection(0,_numberText.text.length);
      }
      
      protected function __textChangHandler(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = int(_numberText.text);
         var _loc4_:int = int(_data.canBuyNum);
         _numberText.text = Math.min(_loc2_,_loc4_).toString();
         buyNum = Math.min(_loc2_,_loc4_);
         _numBtnSelect.visible = false;
         var _loc5_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc6_:int = int(_data.GiftToken > 0 ? _loc5_.point + _loc5_.giftToken : _loc5_.point);
         totalPrice = buyNum * _data.Point;
         if(_loc6_ >= totalPrice)
         {
            _loc3_ = "#95feff";
         }
         else
         {
            _loc3_ = "#FF0000";
         }
         _money.htmlText = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc3_,totalPrice);
      }
      
      private function __keydownHandler(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __buyHandler(param1:MouseEvent) : void
      {
         var _loc7_:TodayNotAlertFrame = null;
         if(buyNum <= 0)
         {
            return;
         }
         if(_data.canBuyNum <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuscollectshoptips",_data.template.TemplateName));
            return;
         }
         totalPrice = buyNum * _data.Point;
         var _loc4_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("theseuscollectbox.txt5",totalPrice,buyNum,_data.template.TemplateName);
         if(_data.GiftToken > 0)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("offerReward.RefreshAlertFrame");
            _loc7_.show(_loc6_,_loc4_,startRefreshAlertBack);
         }
         else
         {
            SimpleAlertHelper.instance.data = [buyCallBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_);
         }
      }
      
      private function startRefreshAlertBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            totalPrice = _data.Point * buyNum;
            if(!LogicUtils.judgePointEnoughToShowPay(totalPrice,false))
            {
               return;
            }
            _loc4_ = int(_data.Id);
            _loc3_ = param2 ? 2 : 1;
            ShopManager.Instance.buyOne(_loc4_,buyNum,playerInfo.userId,_loc3_,false);
         }
      }
      
      private function buyCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            totalPrice = _data.Point * buyNum;
            if(!LogicUtils.judgePointEnoughToShowPay(totalPrice,false))
            {
               return;
            }
            _loc3_ = int(_data.Id);
            ShopManager.Instance.buyOne(_loc3_,buyNum,playerInfo.userId,1,false);
         }
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __openBottleHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         var _loc4_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc5_:int = int(_data.GiftToken > 0 ? _loc4_.point + _loc4_.giftToken : _loc4_.point);
         _numBtnSelect.visible = false;
         switch(param1.currentTarget)
         {
            case _numBtn1:
               buyNum = 1;
               break;
            case _numBtn10:
               if(_data.canOneCount < 10)
               {
                  buyNum = _data.canBuyNum;
                  totalPrice = buyNum * _data.Point;
                  if(_loc5_ >= totalPrice)
                  {
                     _loc3_ = "#95feff";
                  }
                  else
                  {
                     _loc3_ = "#FF0000";
                  }
                  _numberText.text = _data.canBuyNum + "";
                  _money.htmlText = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc3_,totalPrice);
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command06"));
                  return;
               }
               buyNum = 10;
               break;
            case _numBtn100:
               if(_data.canOneCount < 100)
               {
                  _numberText.text = _data.canBuyNum + "";
                  buyNum = _data.canBuyNum;
                  totalPrice = buyNum * _data.Point;
                  if(_loc5_ >= totalPrice)
                  {
                     _loc3_ = "#95feff";
                  }
                  else
                  {
                     _loc3_ = "#FF0000";
                  }
                  _money.htmlText = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc3_,totalPrice);
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command06"));
                  return;
               }
               buyNum = 100;
               break;
            case _numBtn50:
               if(_data.canOneCount < 50)
               {
                  buyNum = _data.canBuyNum;
                  totalPrice = buyNum * _data.Point;
                  if(_loc5_ >= totalPrice)
                  {
                     _loc3_ = "#95feff";
                  }
                  else
                  {
                     _loc3_ = "#FF0000";
                  }
                  _numberText.text = _data.canBuyNum + "";
                  _money.htmlText = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc3_,totalPrice);
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command06"));
                  return;
               }
               buyNum = 50;
         }
         _numBtnSelect.x = param1.currentTarget.x - 20;
         _numBtnSelect.visible = true;
         totalPrice = buyNum * _data.Point;
         if(_loc5_ >= totalPrice)
         {
            _loc3_ = "#95feff";
         }
         else
         {
            _loc3_ = "#FF0000";
         }
         _money.htmlText = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc3_,totalPrice);
         _numberText.text = buyNum + "";
      }
      
      private function __selectFormulaItemHandler(param1:String = "", param2:Object = null) : void
      {
         var _loc6_:int = 0;
         var _loc3_:TheseusShopItem = null;
         var _loc4_:String = null;
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc3_ = itemList[_loc6_];
            if(_loc3_.data && model.selectshopBox && _loc3_.data.templateId == model.selectshopBox.templateId)
            {
               _loc3_.select = true;
               _data = goodsList[_loc6_];
               model.selectshopBoxindex = 1 + _loc6_;
            }
            else
            {
               _loc3_.select = false;
            }
            _loc6_++;
         }
         _numBtnSelect.x = 240;
         _numberText.text = "1";
         buyNum = 1;
         totalPrice = buyNum * _data.Point;
         var _loc5_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc7_:int = int(_data.GiftToken > 0 ? _loc5_.point + _loc5_.giftToken : _loc5_.point);
         if(_loc7_ >= totalPrice)
         {
            _loc4_ = "#95feff";
         }
         else
         {
            _loc4_ = "#FF0000";
         }
         _money.htmlText = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc4_,totalPrice);
         _numBtnSelect.visible = true;
      }
      
      public function dispose() : void
      {
         removeEvent();
         curPageData = null;
         ObjectUtils.disposeObject(_btnVbox);
         _btnVbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
      }
   }
}

