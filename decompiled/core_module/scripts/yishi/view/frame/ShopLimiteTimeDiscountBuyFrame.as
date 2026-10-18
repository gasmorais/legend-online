package yishi.view.frame
{
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.LimiteTimeDiscountInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ShopLimiteTimeDiscountBuyFrame extends BuyFrameI
   {
      
      public function ShopLimiteTimeDiscountBuyFrame()
      {
         super();
      }
      
      override protected function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _buyImage.setFrame(1);
         var _loc4_:LimiteTimeDiscountInfo = _data as LimiteTimeDiscountInfo;
         _isUseBindPoint = _data.isBindMoney;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = _loc4_.templateId;
         _icon.data = _loc3_;
         _nameTxt.text = _loc3_.templateInfo.TemplateName;
         var _loc2_:GoodsTemplateInfo = _loc3_.templateInfo;
         var _loc1_:int = _loc2_.SonType;
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
         _selfSelectBtn.x = 102;
         _friendSelectBtn.visible = false;
      }
      
      override protected function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = null;
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
               _loc2_ = checkExist((_data as LimiteTimeDiscountInfo).templateId);
               if(!StringHelper.isNullOrEmpty(_loc2_))
               {
                  MessageTipManager.instance().show(_loc2_);
                  _closeButton.dispatchEvent(new MouseEvent("click"));
                  return;
               }
               _loc6_ = 0;
               if(_discountUI && _discountUI.selectedItem && _discountUI.selectedItem.selectBtn.selected && _discountUI.selectedItem.itemId != 0)
               {
                  _loc6_ = _discountUI.selectedItem.itemId;
               }
               _loc5_ = int(_data.id);
               _loc4_ = _isuseBindPointBtn.selected ? 2 : 1;
               ShopManager.Instance.buyOneNew(_loc5_,_buyNum,playerInfo.userId,_loc4_,true,1,_loc6_);
               dispose();
            }
            return;
         }
         _loc3_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.buyFailed");
         MessageTipManager.instance().show(_loc3_);
         dispose();
      }
   }
}

