package map.outercity.view.layer
{
   import com.pickgliss.ui.ComponentFactory;
   import events.FreedomTeamEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import managers.FreedomTeamManager;
   import map.internals.data.BaseCastle;
   import map.internals.event.OuterCityEvent;
   import map.outercity.OuterCityModel;
   import map.outercity.manager.OuterCityManager;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class OuterCityDenseFogLayer extends Sprite
   {
      
      private var w:int;
      
      private var h:int;
      
      private var _model:OuterCityModel;
      
      private var holeArmyObj:Object;
      
      private var holeBuildObj:Object;
      
      public function OuterCityDenseFogLayer(param1:int, param2:int)
      {
         super();
         w = param1;
         h = param2;
         init();
      }
      
      private function init() : void
      {
         _model = OuterCityManager.instance.model;
         this.blendMode = "layer";
         this.graphics.beginFill(0,0.8);
         this.graphics.drawRect(0,0,w,h);
         this.mouseChildren = this.mouseEnabled = false;
         holeArmyObj = {};
         holeBuildObj = {};
         addEvent();
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("layMapArmy",__layMapArmyHandler);
         NotificationManager.instance.addEventListener("OUTERCITY_ADD_DENSEFOG_BY_BUILD",addBuildHole);
         NotificationManager.instance.addEventListener("HIDE_OTHERS",onTeamDismiss);
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__syncTeamInfoHandler);
         OuterCityManager.instance.model.addEventListener("REMOVE_ARMY",onRemoveArmy);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("layMapArmy",__layMapArmyHandler);
         this.removeEventListener("enterFrame",onEnterFrame);
         NotificationManager.instance.removeEventListener("OUTERCITY_ADD_DENSEFOG_BY_BUILD",addBuildHole);
         NotificationManager.instance.removeEventListener("HIDE_OTHERS",onTeamDismiss);
         NotificationManager.instance.removeEventListener("TEAM_INFO_SYNC",__syncTeamInfoHandler);
         OuterCityManager.instance.model.removeEventListener("REMOVE_ARMY",onRemoveArmy);
      }
      
      private function onRemoveArmy(param1:OuterCityEvent) : void
      {
         if(param1.data == null)
         {
            return;
         }
         var _loc2_:int = int(param1.data.userId);
         if(holeArmyObj[_loc2_] == null)
         {
            return;
         }
         removeChild(holeArmyObj[_loc2_]);
         holeArmyObj[_loc2_] = null;
      }
      
      private function __syncTeamInfoHandler(param1:FreedomTeamEvent) : void
      {
         for(var _loc2_:String in holeArmyObj)
         {
            if(!FreedomTeamManager.instance.memberIsOnline(int(_loc2_)))
            {
               if(holeArmyObj[_loc2_] == null)
               {
                  return;
               }
               removeChild(holeArmyObj[_loc2_]);
               holeArmyObj[_loc2_] = null;
            }
         }
      }
      
      private function onTeamDismiss(param1:NotificationEvent = null) : void
      {
         var _loc2_:Bitmap = null;
         var _loc4_:BaseArmy = null;
         var _loc5_:int = 0;
         for(var _loc6_:String in holeArmyObj)
         {
            if(_loc6_ != playerInfo.userId.toString())
            {
               if(FreedomTeamManager.instance.model != null)
               {
                  _loc4_ = FreedomTeamManager.instance.model.getMemberByUserId(int(_loc6_));
                  if(_loc4_ == null)
                  {
                     _loc2_ = holeArmyObj[_loc6_];
                     if(_loc2_ != null)
                     {
                        removeChild(_loc2_);
                        holeArmyObj[_loc6_] = null;
                     }
                  }
               }
               else
               {
                  _loc2_ = holeArmyObj[_loc6_];
                  if(_loc2_ != null)
                  {
                     removeChild(_loc2_);
                     holeArmyObj[_loc6_] = null;
                  }
               }
            }
         }
         if(FreedomTeamManager.instance.model == null)
         {
            return;
         }
         var _loc3_:Array = FreedomTeamManager.instance.model.allMembers;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_];
            _loc2_ = holeArmyObj[_loc4_.userId];
            if(_loc2_ == null && _loc4_.armyView != null)
            {
               addArmyHole(_loc4_.userId,_loc4_.armyView.x,_loc4_.armyView.y);
            }
            _loc5_++;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Bitmap = null;
         for each(var _loc2_:BaseArmy in _model.allArmyDict)
         {
            _loc4_ = int(_loc2_.userId);
            _loc3_ = holeArmyObj[_loc4_];
            if(_loc3_ != null)
            {
               _loc3_.x = _loc2_.armyView.x - _loc3_.width / 2;
               _loc3_.y = _loc2_.armyView.y - _loc3_.height / 2;
            }
         }
      }
      
      private function __layMapArmyHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         for each(var _loc3_:UserArmy in _loc2_)
         {
            if(FreedomTeamManager.instance.model != null)
            {
               if(FreedomTeamManager.instance.model.getMemberByUserId(_loc3_.userId) != null)
               {
                  addArmyHole(_loc3_.userId,_loc3_.armyView.x,_loc3_.armyView.y);
                  this.addEventListener("enterFrame",onEnterFrame);
               }
            }
            if(_loc3_.userId == playerInfo.userId)
            {
               addArmyHole(_loc3_.userId,_loc3_.armyView.x,_loc3_.armyView.y);
               this.addEventListener("enterFrame",onEnterFrame);
            }
         }
      }
      
      public function addArmyHole(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Bitmap = holeArmyObj[param1];
         if(_loc4_ == null)
         {
            _loc4_ = createHole();
            addChild(_loc4_);
            _loc4_.x = param2 - _loc4_.width / 2;
            _loc4_.y = param3 - _loc4_.height / 2;
            holeArmyObj[param1] = _loc4_;
         }
      }
      
      private function addBuildHole(param1:OuterCityEvent) : void
      {
         var _loc3_:BaseCastle = param1.data as BaseCastle;
         var _loc2_:Bitmap = holeBuildObj[_loc3_.info.occupyPlayerId];
         if(_loc2_ == null)
         {
            _loc2_ = createHole();
            addChild(_loc2_);
            _loc2_.x = _loc3_.x - _loc2_.width / 2;
            _loc2_.y = _loc3_.y - _loc2_.height / 2;
            holeBuildObj[_loc3_.info.occupyPlayerId] = _loc2_;
         }
      }
      
      private function createHole() : Bitmap
      {
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.outercity.FogMaskAsset");
         _loc1_.blendMode = "erase";
         return _loc1_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
      }
   }
}

