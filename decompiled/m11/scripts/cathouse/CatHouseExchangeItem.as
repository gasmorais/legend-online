package cathouse
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.CatHouseManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.CurrencyType;
   import mvc.module.currency.PlayerCurrencyInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.CatHouseTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class CatHouseExchangeItem extends Component
   {
      
      private var _data:CatHouseTemplateInfo;
      
      private var _bg:Bitmap;
      
      private var _baseItemView:BaseItemView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _overBack:Bitmap;
      
      private var _hBox:HBox;
      
      private var _currencyIndexs:Array = [];
      
      private var _type:int;
      
      private var _plantNum:FilterFrameText;
      
      private var _plantBtn:IconButton;
      
      private var _needPoint:int;
      
      public function CatHouseExchangeItem(param1:CatHouseTemplateInfo)
      {
         _data = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc5_:CatHouseCurrencyItem = null;
         var _loc4_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("asset.cathouse.CatHouseExchangeBg");
         _baseItemView = ComponentFactory.Instance.creatCustomObject("cathouse.ItemBaseItemView");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("cathouse.exchangeItemName");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("cathouse.exchangeItemBtn");
         _overBack = ComponentFactory.Instance.creatBitmap("asset.cathouse.CatHouseExchangeOver");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("catHouse.exchangeItemHBox");
         _plantNum = ComponentFactory.Instance.creatComponentByStylename("cathouse.exchangeItemNum");
         _plantBtn = ComponentFactory.Instance.creatComponentByStylename("cathouse.plantItemBtn");
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            if(int(_data["NeedItem" + _loc2_]) != 0)
            {
               _loc1_ = [int(_data["NeedItem" + _loc2_]),int(_data["NeedCount" + _loc2_])];
               _currencyIndexs.push(_loc1_);
            }
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _currencyIndexs.length)
         {
            _loc5_ = new CatHouseCurrencyItem();
            _loc5_.index = goodsIdToImageId(_currencyIndexs[_loc4_][0]);
            _loc5_.value = _currencyIndexs[_loc4_][1];
            _loc5_.enoughMaterial = goodsIdToEnough(_currencyIndexs[_loc4_][0],_currencyIndexs[_loc4_][1]);
            _hBox.addChild(_loc5_);
            _loc4_++;
         }
         addChild(_bg);
         addChild(_baseItemView);
         addChild(_nameTxt);
         addChild(_hBox);
         addChild(_overBack);
         addChild(_buyBtn);
         addChild(_plantNum);
         addChild(_plantBtn);
         _baseItemView.icon.icon = IconFactory.getCatHouseIconPath(_data.Icon);
         _baseItemView.profile = _data.Profile;
         _baseItemView.setProfileVisible(true);
         _baseItemView.tipData = _data;
         _nameTxt.text = _data.TemplateName;
         _overBack.visible = false;
         var _loc3_:int = int(CatHouseManager.instance.getCountByTemplateId(_data.TemplateId));
         if(_loc3_ > 0)
         {
            _buyBtn.visible = false;
            _plantNum.text = LanguageMgr.GetTranslation("cathouse.CatHouseExchangeItem.exchangeNum",_loc3_);
         }
         else
         {
            _plantBtn.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         _buyBtn.addEventListener("click",__onClickHandler);
         _plantBtn.addEventListener("click",__onClickHandler);
         addEventListener("rollOver",__rollHandler);
         addEventListener("rollOut",__rollHandler);
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__onClickHandler);
         _plantBtn.removeEventListener("click",__onClickHandler);
         removeEventListener("rollOver",__rollHandler);
         removeEventListener("rollOut",__rollHandler);
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      private function __onClickHandler(param1:Event) : void
      {
         var _loc2_:PlayerCurrencyInfo = null;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc11_:String = null;
         var _loc5_:int = 0;
         var _loc9_:IconButton;
         switch(_loc9_ = param1.currentTarget as IconButton)
         {
            case _buyBtn:
               if(_currencyIndexs.length == 1 && _currencyIndexs[0][0] == -100)
               {
                  if(_currencyIndexs[0][1] > ResourceManager.instance.gold.count)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
                  }
                  else
                  {
                     requestOperate(1,_data.TemplateId,_type);
                  }
                  return;
               }
               _needPoint = 0;
               _loc2_ = PlayerCurrencyManager.instance.currencyInfo;
               _loc10_ = int(ConfigInfoManager.instance.getCattoysPoint());
               _loc6_ = 0;
               while(_loc6_ < _currencyIndexs.length)
               {
                  _loc8_ = int(_currencyIndexs[_loc6_][0]);
                  _loc7_ = int(CurrencyType.CAT_TOY_VALUE_LIST.indexOf(_loc8_));
                  _loc4_ = int(_loc2_.getCatToyCurrencyInfoByType(CurrencyType.CAT_TOY_TYPE_LIST[_loc7_]).amount);
                  if(_currencyIndexs[_loc6_][1] > _loc4_)
                  {
                     _needPoint += (_currencyIndexs[_loc6_][1] - _loc4_) * _loc10_;
                  }
                  _loc6_++;
               }
               if(_needPoint == 0)
               {
                  requestOperate(1,_data.TemplateId,_type);
                  return;
               }
               _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
               _loc11_ = LanguageMgr.GetTranslation("cathouse.CatHouseExchangeItem.buyAlert",_needPoint);
               SharedManagerHelper.ins.needAlert("cathouse.CatHouseExchangeItem.buyAlert",upgradeResultHandler,_loc3_,_loc11_,"");
               break;
            case _plantBtn:
               _loc5_ = int(CatHouseManager.instance.getCattoysRandomId(_data.TemplateId));
               requestOperate(2,_data.TemplateId,_loc5_);
         }
      }
      
      private function upgradeResultHandler(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc2_ >= _needPoint)
         {
            _loc3_ = param1 ? 0 : 1;
            requestOperate(1,_data.TemplateId,_type,_loc3_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function requestOperate(param1:int, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         CatHouseManager.instance.OperateCatHouse(param1,param2,param3,param4);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CLOSE_EXCHANGE_FRAME"));
      }
      
      private function __rollHandler(param1:Event) : void
      {
         _overBack.visible = param1.type == "rollOver";
      }
      
      private function goodsIdToEnough(param1:int, param2:int) : Boolean
      {
         var _loc3_:PlayerCurrencyInfo = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1 == -100)
         {
            return ResourceManager.instance.gold.count >= param2;
         }
         if(param1 < 0)
         {
            _loc3_ = PlayerCurrencyManager.instance.currencyInfo;
            _loc5_ = int(CurrencyType.CAT_TOY_VALUE_LIST.indexOf(param1));
            _loc4_ = int(_loc3_.getCatToyCurrencyInfoByType(CurrencyType.CAT_TOY_TYPE_LIST[_loc5_]).amount);
            return _loc4_ >= param2;
         }
         return false;
      }
      
      private function goodsIdToImageId(param1:int) : int
      {
         var _loc2_:int = param1;
         if(param1 == -100)
         {
            _loc2_ = 7;
         }
         else if(param1 < 0)
         {
            _loc2_ = -(_loc2_ + 2000) / 100;
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_baseItemView);
         _baseItemView = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_overBack);
         _overBack = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_plantNum);
         _plantNum = null;
         ObjectUtils.disposeObject(_plantBtn);
         _plantBtn = null;
         _data = null;
         _currencyIndexs = null;
         super.dispose();
      }
   }
}

