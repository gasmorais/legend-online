package map.campaign.view.ui.unrealshooting
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingModel;
   import mvc.controler.UnrealShootingController;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class UnrealShootingBufferBuyItem extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _iconItem:BaseIconView;
      
      private var _itemCost:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _unbuyBtn:IconButton;
      
      private var _buffTemplateInfo:VehicleSkillBuffTemplate;
      
      private var _templateId:int;
      
      private var _cost:int;
      
      private var _buyEnable:Boolean;
      
      private var _controller:UnrealShootingController = FrameControllerManager.instance.unrealShootingController;
      
      private var _model:UnrealShootingModel = _controller.model;
      
      public function UnrealShootingBufferBuyItem(param1:int, param2:int)
      {
         _templateId = param1;
         _cost = param2;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBufferBuyItem.Bg");
         _iconItem = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingBufferBuyItem.IconItem");
         _itemCost = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBufferBuyItem.ItemCost");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBufferBuyItem.BuyBtn");
         _unbuyBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBufferBuyItem.UnbuyBtn");
         _buffTemplateInfo = TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(templateId);
         if(_buffTemplateInfo)
         {
            _iconItem.icon = IconFactory.getCommonIconPath(_buffTemplateInfo.Icon);
            _iconItem.tipData = _buffTemplateInfo;
         }
         _itemCost.setFrame(1);
         _itemCost.text = _cost.toString();
         _unbuyBtn.enable = false;
         buyEnable = false;
         addChild(_bg);
         addChild(_iconItem);
         addChild(_itemCost);
         addChild(_buyBtn);
         addChild(_unbuyBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_iconItem);
         _iconItem = null;
         ObjectUtils.disposeObject(_itemCost);
         _itemCost = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_unbuyBtn);
         _unbuyBtn = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         }
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(buyEnable)
         {
            SoundManager.instance.play("008");
            if(_model.selfPoint < _cost)
            {
               _loc2_ = LanguageMgr.GetTranslation("map.campaign.view.ui.unrealshooting.UnrealShootingBufferBuyItem.buyTips01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            SimpleAlertHelper.instance.data = [buyBtnClickCallBack];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("mainBar.MainToolBar.prompt");
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.view.ui.unrealshooting.UnrealShootingBufferBuyItem.buyTips02",_cost,_buffTemplateInfo.Name);
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,true);
         }
      }
      
      private function buyBtnClickCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            _controller.sendUnrealShootingBuyBuff(templateId);
         }
      }
      
      public function get buyEnable() : Boolean
      {
         return _buyEnable;
      }
      
      public function set buyEnable(param1:Boolean) : void
      {
         _buyEnable = param1;
         if(buyEnable)
         {
            _buyBtn.visible = true;
            _unbuyBtn.visible = false;
         }
         else
         {
            _buyBtn.visible = false;
            _unbuyBtn.visible = true;
         }
         if(_model.selfPoint < _cost)
         {
            _itemCost.setFrame(2);
         }
         else
         {
            _itemCost.setFrame(1);
         }
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

