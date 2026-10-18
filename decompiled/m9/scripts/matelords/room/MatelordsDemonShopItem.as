package matelords.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.matelords.MatelordsDemonShopInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.MatelordsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MatelordsDemonShopItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _itemName:FilterFrameText;
      
      private var _itemDesc:FilterFrameText;
      
      private var _costText:FilterFrameText;
      
      private var _hasText:FilterFrameText;
      
      private var _buyBtn:BaseButton;
      
      private var _data:MatelordsDemonShopInfo;
      
      public function MatelordsDemonShopItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.MatelordsDemonShopItem.back");
         _icon = ComponentFactory.Instance.creatCustomObject("MatelordsDemonShopItem.icon");
         _itemName = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopItem.itemName");
         _itemDesc = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopItem.itemDesc");
         _costText = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopItem.costText");
         _hasText = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopItem.hasText");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopItem.buyBtn");
         addChild(_back);
         addChild(_icon);
         addChild(_itemName);
         addChild(_itemDesc);
         addChild(_costText);
         addChild(_hasText);
         addChild(_buyBtn);
      }
      
      public function set data(param1:MatelordsDemonShopInfo) : void
      {
         var _loc3_:SkillTempInfo = null;
         var _loc2_:String = null;
         _data = param1;
         clean();
         if(_data)
         {
            _back.visible = true;
            _buyBtn.visible = true;
            _icon.visible = true;
            if(_data.templateId == -1 || _data.templateId == -2)
            {
               _icon.tipStyle = "yishi.view.tips.OneLineTip";
               _icon.icon = ComponentFactory.Instance.creatBitmap("asset.MatelordsDemonShopItem.icon" + Math.abs(_data.templateId));
               _icon.tipData = LanguageMgr.GetTranslation("MatelordsDemonShopItem.itemDesc.text" + Math.abs(_data.templateId));
               _itemName.text = LanguageMgr.GetTranslation("MatelordsDemonShopItem.itemName.text" + Math.abs(_data.templateId));
               _itemDesc.text = LanguageMgr.GetTranslation("MatelordsDemonShopItem.itemDesc.text" + Math.abs(_data.templateId));
            }
            else
            {
               _loc3_ = TempleteManager.instance.skillTemplateDic[_data.templateId];
               if(!_loc3_)
               {
                  return;
               }
               _icon.tipStyle = "yishi.view.tips.goods.SkillTips";
               _icon.icon = IconFactory.getTecIconByIcon(_loc3_.Icons);
               _icon.tipData = _loc3_;
               _itemName.text = _loc3_.TemplateName;
               _itemDesc.text = _loc3_.Description;
            }
            if(_itemDesc.numLines > 2)
            {
               _loc2_ = _itemDesc.getLineText(1).substring(0,_itemDesc.getLineText(1).length - 5);
               _itemDesc.text = _itemDesc.getLineText(0) + _loc2_ + "...";
            }
            _costText.htmlText = LanguageMgr.GetTranslation("MatelordsDemonShopItem.costText.text",_data.price);
            _hasText.htmlText = LanguageMgr.GetTranslation("MatelordsDemonShopItem.hasText.text",_data.leftCount);
         }
      }
      
      private function clean() : void
      {
         _back.visible = false;
         _icon.icon = null;
         _icon.visible = false;
         _itemName.text = "";
         _itemDesc.text = "";
         _costText.text = "";
         _hasText.text = "";
         _buyBtn.visible = false;
      }
      
      public function get data() : MatelordsDemonShopInfo
      {
         return _data;
      }
      
      private function initEvent() : void
      {
         _buyBtn.addEventListener("click",__buyHandler);
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__buyHandler);
      }
      
      private function __buyHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(_data.leftCount >= _data.maxCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MatelordsDemonShopItem.buyBtn.alert"));
            return;
         }
         if(_data.price > MatelordsManager.instance.model.altarScore)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MatelordsDemonShopItem.noScore.alert"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = _data.templateId < 0 ? LanguageMgr.GetTranslation("rewardsFindBackFrame.items") : LanguageMgr.GetTranslation("armyII.viewII.skill.FastSkillItem.txt");
         var _loc6_:String = LanguageMgr.GetTranslation("MatelordsDemonShopItem.BuyConfirm.content",_data.price,_loc4_);
         SimpleAlertHelper.instance.data = [confirmBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2);
      }
      
      private function confirmBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MatelordsManager.instance.sendRequestDemoOp(2,_data.templateId);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_itemName);
         _itemName = null;
         ObjectUtils.disposeObject(_itemDesc);
         _itemDesc = null;
         ObjectUtils.disposeObject(_costText);
         _costText = null;
         ObjectUtils.disposeObject(_hasText);
         _hasText = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

