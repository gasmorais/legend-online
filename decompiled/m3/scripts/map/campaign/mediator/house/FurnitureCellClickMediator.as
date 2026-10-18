package map.campaign.mediator.house
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.DoubleClickManager;
   import flash.events.Event;
   import home.HomeSender;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import map.campaign.view.house.FurnitureBagCell;
   import mvc.module.home.FurnitureInfo;
   import mvc.module.home.HomeModel;
   import yishi.interfaces.IMediator;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class FurnitureCellClickMediator implements IMediator
   {
      
      private var _cell:FurnitureBagCell;
      
      public function FurnitureCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as FurnitureBagCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            DoubleClickManager.Instance.disableDoubleClick(_cell.icon);
            _cell.icon.removeEventListener("interactive_click",__mouseClickByClicker);
            _cell = null;
         }
      }
      
      private function __mouseClickByClicker(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:FurnitureInfo = null;
         if(!_cell || !_cell.furniture)
         {
            return;
         }
         if(!_cell.isCanClickItem)
         {
            return;
         }
         if(model.isSelf == false)
         {
            return;
         }
         HomeManager.instance.model.selectFurn = null;
         HomeManager.instance.model.clickFurn = null;
         if(model.inBuy)
         {
            return;
         }
         if(_cell.isNormalFilter)
         {
            if(findId() == 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("map.campaign.mediator.house.noId");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            _loc4_ = new FurnitureInfo();
            _loc4_.furnitureId = findId();
            _loc4_.templateId = _cell.furniture.TemplateId;
            _loc4_.posX = -1;
            _loc4_.posY = -1;
            _loc4_.x = StageReferance.stage.mouseX;
            _loc4_.y = StageReferance.stage.mouseY;
            _loc4_.rotation = 1;
            if(isSpecialType(_cell.furniture.Type))
            {
               _loc3_ = 0;
               while(_loc3_ < model.fixUpList.length)
               {
                  if(model.fixUpList[_loc3_].templateId == _loc4_.templateId)
                  {
                     return;
                  }
                  _loc3_++;
               }
               _loc4_.posX = 0;
               _loc4_.posY = 0;
               MsgMan.notifyObserver("ChildEvent.SPECIAL_REFRESH",_loc4_);
            }
            else
            {
               HomeManager.instance.model.selectFurn = _loc4_;
            }
         }
      }
      
      private function buyFurnitureCall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            HomeSender.buyFurniture(_cell.furniture.TemplateId,param2);
         }
      }
      
      private function findId() : int
      {
         if(!_cell || !_cell.furniture)
         {
            return 0;
         }
         if(model.selfInfo == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.mediator.house.noHouse"));
            return 0;
         }
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < model.fixUpList.length)
         {
            _loc1_.push(model.fixUpList[_loc2_].furnitureId);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < model.noFixList.length)
         {
            if(_cell.furniture.TemplateId == model.noFixList[_loc2_].templateId)
            {
               if(_loc1_.indexOf(model.noFixList[_loc2_].furnitureId) < 0)
               {
                  return model.noFixList[_loc2_].furnitureId;
               }
            }
            _loc2_++;
         }
         return 0;
      }
      
      private function isSpecialType(param1:int) : Boolean
      {
         return (param1 == 1 || param1 == 2) && inHouse;
      }
      
      private function get model() : HomeModel
      {
         return HomeManager.instance.model;
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

