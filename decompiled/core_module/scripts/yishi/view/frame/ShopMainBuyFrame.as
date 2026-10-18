package yishi.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.MainShopInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.PathManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.StringHelper;
   import yishi.view.frame.giftdonatio.GiftDonatioFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ShopMainBuyFrame extends BuyFrameI
   {
      
      public function ShopMainBuyFrame()
      {
         super();
      }
      
      override protected function refreshView() : void
      {
         var _loc5_:Object = null;
         var _loc3_:GoodsInfo = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc1_:int = 0;
         if(!_data)
         {
            return;
         }
         _buyImage.setFrame(1);
         var _loc4_:MainShopInfo = _data as MainShopInfo;
         if(_data.isGift)
         {
            _nameTxt.text = _loc4_.names;
            _icon.icon.icon = PathManager.info.REQUEST_PATH + _data.url;
            _loc5_ = {
               "name":_loc4_.names,
               "content":_loc4_.content
            };
            _icon.icon.tipData = _loc5_;
            _icon.icon.tipStyle = "yishi.view.tips.ShopMainTips";
         }
         else
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc4_.templateId;
            _icon.data = _loc3_;
            _nameTxt.text = _loc3_.templateInfo.TemplateName;
            _loc2_ = _loc3_.templateInfo;
            _loc1_ = _loc2_.SonType;
            if(_loc1_ == 218)
            {
               _addBtn.visible = false;
               _deleteBtn.visible = false;
               _buyNumTxt.type = "dynamic";
            }
            else
            {
               _addBtn.visible = true;
               _deleteBtn.visible = true;
               _buyNumTxt.type = "input";
            }
         }
         _selfSelectBtn.x = 102;
         _friendSelectBtn.visible = false;
         if(_nameTxt.text.length > 30)
         {
            _nameTxt.text = _nameTxt.text.substr(0,29) + "...";
         }
      }
      
      override public function get PayMoney() : int
      {
         return playerInfo.point;
      }
      
      override protected function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc3_:GiftDonatioFrame = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         if(_data)
         {
            _selfConfirmBtn.enable = false;
            _friendConfirmBtn.enable = false;
            if(int(_priceTxt.text) > PayMoney)
            {
               RechargeAlertMannager.show();
               _closeButton.dispatchEvent(new MouseEvent("click"));
               return;
            }
            if(_selfSelectBtn.selected)
            {
               _loc2_ = checkExist((_data as MainShopInfo).templateId);
               if(!StringHelper.isNullOrEmpty(_loc2_))
               {
                  MessageTipManager.instance().show(_loc2_);
                  _closeButton.dispatchEvent(new MouseEvent("click"));
                  return;
               }
               _loc5_ = 0;
               if(_discountUI && _discountUI.selectedItem && _discountUI.selectedItem.selectBtn.selected && _discountUI.selectedItem.itemId != 0)
               {
                  _loc5_ = _discountUI.selectedItem.itemId;
               }
               ShopManager.Instance.buyOne((_data as MainShopInfo).id,_buyNum,playerInfo.userId,1,true,_loc5_);
               if(_callBack != null)
               {
                  SocketManager.instance.addEventListener("SLGSocketEvent" + 90,__shopResult);
               }
               dispose();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("shop.GiftDonatioFrame");
            _loc3_.isDiscount = true;
            _loc3_.ShopId = (_data as MainShopInfo).id;
            _loc3_.number = _buyNum;
            _loc3_.show();
            _closeButton.dispatchEvent(new MouseEvent("click"));
            return;
         }
         _loc4_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.buyFailed");
         MessageTipManager.instance().show(_loc4_);
         dispose();
      }
   }
}

