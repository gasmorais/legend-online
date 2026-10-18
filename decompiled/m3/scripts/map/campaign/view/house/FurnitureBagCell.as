package map.campaign.view.house
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import map.campaign.mediator.house.FurnitureCellClickMediator;
   import mvc.module.home.HomeModel;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.MediatorMananger;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class FurnitureBagCell extends BaseItemView
   {
      
      public static const NAME:String = "map.campaign.view.house.FurnitureBagCell";
      
      private var _equipStyle:String;
      
      protected var _shape:Shape;
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      public var celltType:String;
      
      private var _furniture:FurnitureTempInfo;
      
      private var _buyBtn:BaseButton;
      
      public var isCanClickItem:Boolean = true;
      
      public function FurnitureBagCell()
      {
         super();
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("FurnitureBagCell.buyBtn");
         createShape();
      }
      
      private function createShape() : void
      {
         if(!_shape)
         {
            _shape = new Shape();
         }
         _shape.graphics.beginFill(16711680);
         _shape.graphics.drawRect(0,0,41,41);
         _shape.graphics.endFill();
         _shape.x = 2;
         _shape.y = 2;
         _shape.blendMode = "multiply";
      }
      
      protected function removeShape() : void
      {
         if(_shape && _shape.parent)
         {
            _shape.parent.removeChild(_shape);
         }
      }
      
      public function get furniture() : FurnitureTempInfo
      {
         return _furniture;
      }
      
      public function set furniture(param1:FurnitureTempInfo) : void
      {
         var _loc2_:String = null;
         _furniture = param1;
         clean();
         if(_buyBtn)
         {
            _buyBtn.visible = false;
         }
         if(_furniture == null)
         {
            super.data = null;
            return;
         }
         if(_icon)
         {
            _icon.icon = IconFactory.getFurnitureByType(_furniture.TemplateId);
            _loc2_ = _furniture.NeedPoints + LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.point");
            if(_furniture.NeedPoints <= 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("FurnitureBagCell.OneLineTip.cannotBuy");
            }
            _icon.tipData = _furniture.TemplateName;
         }
         if(_buyBtn)
         {
            _buyBtn.enable = _furniture.NeedPoints > 0;
         }
         if(_profile)
         {
            _profile.visible = true;
            _profile.setFrame(furniture.Grade);
         }
         refreshTxt();
         removeShape();
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      public function setBuyVisible(param1:Boolean) : void
      {
         if(_buyBtn)
         {
            _buyBtn.visible = _furniture && param1;
         }
      }
      
      public function refreshTxt(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         if(_furniture == null)
         {
            return;
         }
         if(_itemText)
         {
            _loc2_ = param1 == 0 ? getCountTxt() : param1;
            if(_loc2_ <= 0)
            {
               _itemText.text = "";
               setGrayFilter();
            }
            else
            {
               if(isSpecialType(_furniture.Type))
               {
                  _itemText.text = "";
               }
               else
               {
                  _itemText.text = _loc2_ + "";
               }
               setNormalFilter();
            }
         }
      }
      
      private function getCountTxt() : int
      {
         var _loc2_:int = 0;
         if(homeModel.selfInfo == null)
         {
            return 0;
         }
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < homeModel.noFixList.length)
         {
            if(homeModel.noFixList[_loc2_].templateId == _furniture.TemplateId)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function __buyBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc12_:Array = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc5_:String = null;
         if(inHouse)
         {
            _loc6_ = int(HomeManager.instance.model.selfInfo.houseLv);
         }
         else if(inHome)
         {
            _loc6_ = int(HomeManager.instance.model.selfInfo.homeLv);
         }
         if(furniture.NeedPoints <= 0)
         {
            if(inHouse)
            {
               _loc2_ = LanguageMgr.GetTranslation("map.campaign.mediator.house.cannotBuy1");
            }
            else if(inHome)
            {
               _loc2_ = LanguageMgr.GetTranslation("map.campaign.mediator.house.cannotBuy2");
            }
            MessageTipManager.instance().show(_loc2_);
         }
         else if(furniture.Grade > _loc6_)
         {
            if(inHouse)
            {
               _loc2_ = LanguageMgr.GetTranslation("map.campaign.mediator.house.HouseLevelLimi1t",furniture.Grade);
            }
            else if(inHome)
            {
               _loc2_ = LanguageMgr.GetTranslation("map.campaign.mediator.house.HouseLevelLimit2",furniture.Grade);
            }
            MessageTipManager.instance().show(_loc2_);
         }
         else if(furniture.NeedPoints > 0)
         {
            _loc11_ = int(furniture.NeedPoints);
            if(inHouse)
            {
               _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(homeModel.selfInfo.houseLv,45);
            }
            else if(inHome)
            {
               _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(homeModel.selfInfo.homeLv,46);
            }
            if(_loc4_)
            {
               _loc12_ = _loc4_.TemplateName.split(",");
               _loc3_ = 0;
               _loc7_ = 0;
               while(_loc7_ < homeModel.fixUpList.length)
               {
                  if(homeModel.fixUpList[_loc7_].templateInfo.FurnitureType == furniture.FurnitureType)
                  {
                     _loc3_++;
                  }
                  _loc7_++;
               }
               if(isSpecialType(_furniture.Type))
               {
                  if(_loc3_ > 0)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("map.campaign.mediator.house.buyFurniture4",furniture.TemplateName);
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
                  _loc7_ = 0;
                  while(_loc7_ < homeModel.selfInfo.storeList1.length)
                  {
                     if(homeModel.selfInfo.storeList1[_loc7_].templateInfo.FurnitureType == furniture.FurnitureType)
                     {
                        _loc2_ = LanguageMgr.GetTranslation("map.campaign.mediator.house.buyFurniture4",furniture.TemplateName);
                        MessageTipManager.instance().show(_loc2_);
                        return;
                     }
                     _loc7_++;
                  }
               }
               if(parseInt(_loc12_[furniture.FurnitureType - 1]) <= _loc3_)
               {
                  _loc2_ = LanguageMgr.GetTranslation("map.campaign.mediator.house.buyFurniture1",_loc11_,furniture.TemplateName);
               }
               else
               {
                  _loc2_ = LanguageMgr.GetTranslation("map.campaign.mediator.house.buyFurniture2",_loc11_,furniture.TemplateName);
               }
            }
            SimpleAlertHelper.instance.data = [buyFurnitureCall];
            _loc8_ = LanguageMgr.GetTranslation("public.confirm");
            _loc9_ = LanguageMgr.GetTranslation("public.cancel");
            _loc10_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = _loc2_;
            SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc5_,_loc8_,_loc9_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc11_);
         }
      }
      
      private function buyFurnitureCall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
      }
      
      private function get homeModel() : HomeModel
      {
         return HomeManager.instance.model;
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [FurnitureCellClickMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.campaign.view.house.FurnitureBagCell");
      }
      
      override public function dispose() : void
      {
         if(_shape)
         {
            _shape.graphics.clear();
         }
         _shape = null;
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnHandler);
            _buyBtn.dispose();
         }
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         super.dispose();
      }
      
      override public function get width() : Number
      {
         return 60;
      }
      
      override public function get height() : Number
      {
         return 60;
      }
      
      private function isSpecialType(param1:int) : Boolean
      {
         return (param1 == 1 || param1 == 2) && inHouse;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
   }
}

