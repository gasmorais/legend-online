package mvc.module.home
{
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   
   public class FurnitureInfo
   {
      
      public var furnitureId:int;
      
      public var templateId:int;
      
      public var posX:int;
      
      public var posY:int;
      
      public var x:int;
      
      public var y:int;
      
      public var rotation:int;
      
      public function FurnitureInfo()
      {
         super();
      }
      
      public function get templateInfo() : FurnitureTempInfo
      {
         return TempleteManager.instance.furnitureTemplateCate.getTempById(templateId);
      }
      
      public function get width() : int
      {
         if(templateInfo && templateInfo["Icon" + rotation])
         {
            return int(templateInfo["Icon" + rotation].split(",")[1]);
         }
         return 1;
      }
      
      public function get height() : int
      {
         if(templateInfo && templateInfo["Icon" + rotation])
         {
            return int(templateInfo["Icon" + rotation].split(",")[2]);
         }
         return 1;
      }
      
      public function setRotation() : void
      {
         if(templateInfo.hasOwnProperty("Icon" + (rotation + 1)) && !StringHelper.isNullOrEmpty(templateInfo["Icon" + (rotation + 1)]))
         {
            rotation += 1;
         }
         else
         {
            rotation = 1;
         }
      }
      
      public function get canRotation1() : Boolean
      {
         if(area != 0)
         {
            return false;
         }
         if(templateInfo.hasOwnProperty("Icon2") && !StringHelper.isNullOrEmpty(templateInfo["Icon2"]))
         {
            return true;
         }
         return false;
      }
      
      public function get canRotation2() : Boolean
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:int = rotation;
         setRotation();
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         switch(area)
         {
            case 0:
               if(posX + width > HomeManager.instance.model.info.floor || posY + height > HomeManager.instance.model.info.floor)
               {
                  rotation = _loc10_;
                  return false;
               }
               if(width < height)
               {
                  _loc3_ = posX;
                  _loc6_ = posX + width;
                  _loc2_ = posY + width;
                  _loc4_ = posY + height;
               }
               else if(width > height)
               {
                  _loc3_ = posX + height;
                  _loc6_ = posX + width;
                  _loc2_ = posY;
                  _loc4_ = posY + height;
               }
               _loc9_ = model.floorList;
               break;
            case 1:
               _loc3_ = posX;
               _loc6_ = posX + width;
               _loc2_ = posY;
               _loc4_ = posY + height;
               _loc9_ = model.leftList;
               break;
            case 2:
               _loc3_ = posX;
               _loc6_ = posX + width;
               _loc2_ = posY;
               _loc4_ = posY + height;
               _loc9_ = model.rightList;
         }
         _loc5_ = _loc3_;
         loop0:
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc2_;
            loop1:
            while(true)
            {
               if(_loc7_ >= _loc4_)
               {
                  _loc5_++;
                  continue loop0;
               }
               _loc1_ = _loc9_[_loc5_][_loc7_].split("_");
               _loc8_ = 0;
               while(_loc8_ < _loc1_.length)
               {
                  if(model.filterType(int(_loc1_[_loc8_]),templateInfo.Type) == false)
                  {
                     break loop1;
                  }
                  _loc8_++;
               }
               _loc7_++;
            }
            rotation = _loc10_;
            return false;
         }
         rotation = _loc10_;
         return true;
      }
      
      public function get area() : int
      {
         var _loc1_:int = 0;
         if(templateInfo == null || inHome)
         {
            return _loc1_;
         }
         switch(templateInfo.Type - 1)
         {
            case 0:
            case 3:
            case 4:
            case 5:
            case 8:
               _loc1_ = rotation;
               break;
            case 1:
            case 2:
            case 6:
            case 7:
               _loc1_ = 0;
         }
         return _loc1_;
      }
      
      private function get model() : HomeModel
      {
         return HomeManager.instance.model;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
   }
}

