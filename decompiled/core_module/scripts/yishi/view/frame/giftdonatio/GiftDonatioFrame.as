package yishi.view.frame.giftdonatio
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.shop.ItemBuyInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class GiftDonatioFrame extends Frame
   {
      
      public var ShopId:int;
      
      public var isDiscount:Boolean;
      
      public var sevenYearCallBack:Function;
      
      public var number:int;
      
      private var _autoSearchList:AutoSearchFriendView;
      
      private var _bg:Bitmap;
      
      private var _cancelBtn:SelectedCheckButton;
      
      private var _confirmBtn:SelectedCheckButton;
      
      private var _consortiaList:Array = [];
      
      private var _curIndex:int;
      
      private var _data:ShopGoodsInfo;
      
      private var _friendList:Array = [];
      
      private var _gifTxtImg:Bitmap;
      
      private var _nameBg:ScaleBitmapImage;
      
      private var _presentToImg:Bitmap;
      
      private var _selectIndex:int;
      
      private var _targetComb:FriendCombox;
      
      private var _txtChange:String = "";
      
      private var _isShopCart:Boolean;
      
      private var _shopModel:ShopModel;
      
      private var _info:ItemBuyInfo;
      
      public function GiftDonatioFrame()
      {
         super();
         _shopModel = ShopManager.Instance.model;
         initView();
         addEvent();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninit();
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      protected function onInput(param1:MouseEvent) : void
      {
         __txtChange(null);
         StageReferance.stage.addEventListener("click",onStageClick);
         param1.stopPropagation();
      }
      
      protected function onSelectFriend(param1:NotificationEvent) : void
      {
         if(param1.data)
         {
            _targetComb.textField.text = param1.data[0] + "";
         }
         hideList();
      }
      
      protected function onStageClick(param1:Event) : void
      {
         StageReferance.stage.removeEventListener("click",onStageClick);
         hideList();
      }
      
      private function __comConsortia(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(_curIndex == 2)
         {
            return;
         }
         _curIndex = 2;
         _selectIndex = 0;
         initComboBox(getConsortiaNameList());
      }
      
      private function __comboFriend(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(_curIndex == 1)
         {
            return;
         }
         _curIndex = 1;
         _selectIndex = 0;
         initComboBox(getAllFriendNameList());
      }
      
      private function __comboHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc5_:ItemBuyInfo = null;
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         if(sevenYearCallBack != null)
         {
            if(_targetComb.textValue == null || _targetComb.textValue == "")
            {
               _loc4_ = LanguageMgr.GetTranslation("shop.view.frame.GiftDonatioFrame.command01");
               MessageTipManager.instance().show(_loc4_);
               return;
            }
            sevenYearCallBack(_targetComb.textValue);
            dispose();
            return;
         }
         if(!isShopCart)
         {
            if(_targetComb.textValue == null || _targetComb.textValue == "")
            {
               _loc2_ = LanguageMgr.GetTranslation("shop.view.frame.GiftDonatioFrame.command01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            _loc5_ = new ItemBuyInfo();
            _loc5_.nickname = _targetComb.textValue;
            _loc5_.goodId = ShopId;
            _loc5_.count = number;
            _loc5_.isDiscount = isDiscount;
            FrameControllerManager.instance.shopController.model.giftInfo = _loc5_;
            ShopManager.Instance.sendPresent();
            dispose();
         }
         else
         {
            if(_targetComb.textValue == null || _targetComb.textValue == "")
            {
               _loc3_ = LanguageMgr.GetTranslation("shop.view.frame.GiftDonatioFrame.command01");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            showConfirm();
            _info = new ItemBuyInfo();
            _info.nickname = _targetComb.textValue;
            dispose();
         }
      }
      
      private function showConfirm() : void
      {
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc1_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         if(_shopModel.shopCartList.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.shopCartItem.null"));
            return;
         }
         if(playerInfo.giftToken >= _shopModel.allCostBindPoint())
         {
            _loc3_ = _shopModel.allCostBindPoint();
         }
         else
         {
            _loc3_ = playerInfo.giftToken;
         }
         var _loc4_:int = _shopModel.allCostPoint() + _shopModel.allCostBindPoint() - _loc3_;
         if(playerInfo.point >= _loc4_)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.fastCharge");
            _loc6_ = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.buyText4",_loc4_);
            SimpleAlertHelper.instance.data = [__confirmBuy];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc1_,false,true);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("public.fastCharge");
            _loc6_ = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.buyText3");
            SimpleAlertHelper.instance.data = [__charge];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc1_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"FastChargeAlert");
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __confirmBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.shopController.model.giftInfo = _info;
            ShopManager.Instance.sendShopCartPresent();
         }
      }
      
      private function __charge(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            __chargeBtnHandler(null);
            dispose();
         }
      }
      
      private function __chargeBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
               break;
            case 2:
         }
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         _selectIndex = param1.index;
      }
      
      private function __onCancelHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __selectField(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _selectIndex = 0;
      }
      
      private function __txtChange(param1:Event) : void
      {
         var _loc2_:int = _targetComb.textField.text.replace(/[^\x00-\xff]/g,"xx").length;
         if(_loc2_ > 12)
         {
            _targetComb.textField.text = _txtChange;
         }
         _txtChange = _targetComb.textField.text;
         if(_targetComb.textField.text == "")
         {
            hideList();
         }
         else
         {
            showList();
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _targetComb.button.addEventListener("click",__comboHandler);
         _targetComb.addEventListener("friend_selected",__comboFriend);
         _targetComb.addEventListener("consortia_selected",__comConsortia);
         _targetComb.addEventListener("select_textField",__selectField);
         _targetComb.addEventListener("change",__txtChange);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",__onCancelHandler);
         _targetComb.textField.addEventListener("click",onInput);
         NotificationManager.instance.addEventListener("SELECT_FRIEND",onSelectFriend);
      }
      
      private function getAllFriendNameList() : Array
      {
         _friendList.splice(0,_friendList.length);
         var _loc1_:Dictionary = FriendManager.getInstance().friendList;
         for each(var _loc2_:ThaneInfo in _loc1_)
         {
            _friendList.push(_loc2_.nickName);
         }
         return _friendList;
      }
      
      private function getConsortiaNameList() : Array
      {
         _consortiaList.length = 0;
         var _loc2_:SimpleDictionary = ConsortiaManager.instance.model.consortiaMemberList;
         for each(var _loc1_:ThaneInfo in _loc2_)
         {
            if(_loc1_.userId != thane.userId)
            {
               _consortiaList.push(_loc1_.nickName);
            }
         }
         return _consortiaList;
      }
      
      private function getTogetherFriendNameList() : Array
      {
         _friendList.splice(0,_friendList.length);
         var _loc1_:Dictionary = FriendManager.getInstance().friendList;
         for each(var _loc2_:FriendItemCellInfo in _loc1_)
         {
            if(_loc2_.groupId != -1)
            {
               _friendList.push(_loc2_.nickName);
            }
         }
         return _friendList;
      }
      
      private function hideList() : void
      {
         if(_autoSearchList.parent)
         {
            _autoSearchList.parent.removeChild(_autoSearchList);
         }
      }
      
      private function initComboBox(param1:Array) : void
      {
         var _loc3_:int = 0;
         _targetComb.beginChanges();
         _targetComb.selctedPropName = "text";
         var _loc2_:VectorListModel = _targetComb.listPanel.vectorListModel;
         _loc2_.clear();
         while(_loc3_ < param1.length)
         {
            _loc2_.append(param1[_loc3_]);
            _loc3_++;
         }
         _targetComb.listPanel.list.updateListView();
         _targetComb.listPanel.list.addEventListener("listItemClick",__itemClick);
         _targetComb.commitChanges();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.quickbuy.GiftFrameGifTxtImgBg");
         _gifTxtImg = ComponentFactory.Instance.creatBitmap("asset.quickbuy.GiftFrameGifTxtImg");
         _presentToImg = ComponentFactory.Instance.creatBitmap("asset.quickbuy.PresentToImg");
         _targetComb = ComponentFactory.Instance.creatComponentByStylename("shop.FriendCombox");
         _nameBg = ComponentFactory.Instance.creatComponentByStylename("shop.comboxInputbg2");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("shop.FriendComboxUpgradeBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("shop.FriendComboxCancelBtn");
         addToContent(_bg);
         addToContent(_gifTxtImg);
         addToContent(_presentToImg);
         addToContent(_nameBg);
         addToContent(_targetComb);
         _targetComb.listPanel.vUnitIncrement = 5;
         (_targetComb.button as TextButton).text = LanguageMgr.GetTranslation("shop.view.frame.GiftDonatioFrame.Selectedfriend");
         addToContent(_cancelBtn);
         _cancelBtn.text = LanguageMgr.GetTranslation("public.cancel");
         addToContent(_confirmBtn);
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         initComboBox(getAllFriendNameList());
         _curIndex = 1;
         _autoSearchList = new AutoSearchFriendView(getTogetherFriendNameList());
         _autoSearchList.x = 103;
         _autoSearchList.y = 99;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_targetComb != null)
         {
            _targetComb.button.removeEventListener("click",__comboHandler);
            _targetComb.removeEventListener("change",__txtChange);
            _targetComb.removeEventListener("friend_selected",__comboFriend);
            _targetComb.removeEventListener("consortia_selected",__comConsortia);
            _targetComb.removeEventListener("select_textField",__selectField);
         }
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__onCancelHandler);
         }
         if(_targetComb)
         {
            _targetComb.textField.removeEventListener("click",onInput);
         }
         NotificationManager.instance.removeEventListener("SELECT_FRIEND",onSelectFriend);
      }
      
      private function showList() : void
      {
         if(contains(_autoSearchList))
         {
            removeChild(_autoSearchList);
         }
         _autoSearchList.setSearchString(_targetComb.textField.text);
         addChild(_autoSearchList);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function uninit() : void
      {
         if(_targetComb)
         {
            _targetComb.dispose();
         }
         ObjectUtils.disposeAllChildren(this);
         _targetComb = null;
         _confirmBtn = null;
         _cancelBtn = null;
      }
      
      public function get isShopCart() : Boolean
      {
         return _isShopCart;
      }
      
      public function set isShopCart(param1:Boolean) : void
      {
         _isShopCart = param1;
      }
   }
}

