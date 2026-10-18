package battle.view.map
{
   import battle.BattleManager;
   import battle.data.BattleBackGroundData;
   import battle.data.BattleMapData;
   import battle.events.BattleEvent;
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.EffectContainer;
   import battle.utils.BattleUtils;
   import battle.view.roles.RoleViewBase;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.battle.LivingCleanMsg;
   import com.road.yishi.proto.battle.LivingInfoMsg;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.system.IME;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.GoddessRoleInfo;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.PawnRoleInfo;
   import yishi.datas.objects.PetRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.events.RoleEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.interfaces.IPhysics;
   import yishi.manager.IMEManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.TimerUtils;
   
   public class BattleMapView extends BattleMap
   {
      
      private static const REVIVE_BATTLE_TYPE:Vector.<uint> = new <uint>[310,311];
      
      private var _mapData:BattleMapData;
      
      private var _battleModel:BattleModel;
      
      private var _gasEffectContainer:EffectContainer;
      
      private var _mapLayers:Vector.<DisplayObject> = new Vector.<DisplayObject>();
      
      private var _sceneEffectLayers:Vector.<DisplayObject> = new Vector.<DisplayObject>();
      
      private var dieRoleInfoArr:Vector.<HeroRoleInfo>;
      
      public function BattleMapView(param1:BattleModel)
      {
         super();
         _battleModel = param1;
         _gasEffectContainer = new EffectContainer();
         _gasEffectContainer.mouseChildren = _gasEffectContainer.mouseEnabled = false;
         NotificationManager.instance.addEventListener("sceneEffectClose",onSceneEffecCloseHandler);
         param1.addEventListener("BATTLE_OTHER_LIVING_VISIBLE",__otherLivingVisibleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4680,clearDiedRole);
      }
      
      private function onSceneEffecCloseHandler(param1:Event) : void
      {
         if(SharedManager.instance.allowSceneEffect)
         {
            showSceneEffect();
         }
         else
         {
            removeSceneEffect();
         }
      }
      
      private function __otherLivingVisibleHandler(param1:BattleEvent) : void
      {
         var _loc2_:int = param1.data ? 1 : -1;
         for each(var _loc3_:RoleViewBase in _rolesDict)
         {
            if(!ifSelfLiving(_loc3_.info))
            {
               if(!_loc3_.info.startload)
               {
                  _loc3_.info.load();
               }
               else
               {
                  _loc3_.displayMode(_loc2_);
               }
            }
         }
      }
      
      protected function ifSelfLiving(param1:RoleInfo) : Boolean
      {
         var _loc2_:int = int(BattleManager.getInstance().battleModel.selfHero.userId);
         if(param1 is HeroRoleInfo)
         {
            if((param1 as HeroRoleInfo).heroInfo.userId && param1.face == 2)
            {
               return false;
            }
            return _loc2_ == (param1 as HeroRoleInfo).heroInfo.userId;
         }
         if(param1 is PawnRoleInfo)
         {
            return 1 == (param1 as PawnRoleInfo).face;
         }
         if(param1 is PetRoleInfo)
         {
            if(_loc2_ == (param1 as PetRoleInfo).userId && param1.face == 2)
            {
               return false;
            }
            return _loc2_ == (param1 as PetRoleInfo).userId;
         }
         if(param1 is GoddessRoleInfo)
         {
            return _loc2_ == (param1 as GoddessRoleInfo).userId;
         }
         return false;
      }
      
      override public function update() : void
      {
         super.update();
         if(StageReferance.stage.focus is TextField && TextField(StageReferance.stage.focus).type == "input")
         {
            if(!IME.enabled)
            {
               IMEManager.enable();
            }
         }
         else if(IME.enabled)
         {
            IMEManager.disable();
         }
         BattleUtils.ManagerDepth(_rolesContainer);
         for each(var _loc1_:RoleViewBase in _rolesDict)
         {
            _loc1_.updateShadowPos();
         }
         var _loc2_:Dictionary = BattleManager.getInstance().battleModel.roleList;
         for each(var _loc3_:RoleInfo in _loc2_)
         {
            _loc3_.update();
         }
      }
      
      override public function addRole(param1:RoleViewBase) : void
      {
         var _loc2_:RoleInfo = RoleViewBase(param1).info;
         removeRole(_loc2_.livingId);
         _rolesContainer.addChild(param1);
         _rolesDict[_loc2_.livingId] = param1;
         _loc2_.addEventListener("die",onRoleDie,false,0,true);
      }
      
      public function revierBoss(param1:RoleViewBase) : void
      {
         var _loc2_:RoleInfo = RoleViewBase(param1).info;
         _rolesContainer.addChild(param1);
         _loc2_.addEventListener("die",onRoleDie,false,0,true);
      }
      
      private function onRoleDie(param1:RoleEvent) : void
      {
         var _loc4_:RoleInfo = param1.target as RoleInfo;
         _loc4_.removeEventListener("die",onRoleDie);
         if(!_rolesDict)
         {
            return;
         }
         var _loc2_:RoleViewBase = _rolesDict[_loc4_.livingId];
         if(!_loc2_)
         {
            return;
         }
         _loc2_.clearEffectWhenDie();
         var _loc3_:Boolean = REVIVE_BATTLE_TYPE.indexOf(BattleManager.getInstance().battleModel.battleType) >= 0;
         if(_loc4_ is HeroRoleInfo && HeroRoleInfo(_loc4_).type != 3 && HeroRoleInfo(_loc4_).type != 7 && HeroRoleInfo(_loc4_).type != 8)
         {
            _loc2_.setBloodStripVisible(false,true);
         }
         else if(_loc4_ is HeroRoleInfo && HeroRoleInfo(_loc4_).type == 3 && _loc3_)
         {
            _loc4_.action("Die");
            _loc2_.setBloodStripVisible(false,false);
            _loc2_.parent.removeChild(_loc2_);
         }
         else if(!(_loc4_ is PetRoleInfo))
         {
            removeRole(_loc4_.livingId);
            BattleManager.getInstance().battleModel.removeRole(_loc4_);
         }
      }
      
      private function clearDiedRole(param1:SLGSocketEvent) : void
      {
         var battleType:int;
         var pkg:PackageIn;
         var msg:LivingCleanMsg;
         var length:int;
         var userInfo:LivingInfoMsg;
         var i:int;
         var role:RoleViewBase;
         var event:SLGSocketEvent = param1;
         if(BattleManager.getInstance().battleModel == null)
         {
            return;
         }
         battleType = int(BattleManager.getInstance().battleModel.battleType);
         if(!(battleType == 295 || battleType == 3854 || battleType == 3911))
         {
            return;
         }
         pkg = event.data as PackageIn;
         msg = new LivingCleanMsg();
         msg = pkg.readBody(msg) as LivingCleanMsg;
         length = int(msg.livingInfos.length);
         i = 0;
         while(i < length)
         {
            userInfo = msg.livingInfos[i];
            role = _rolesDict[userInfo.living];
            if(role && role.info is HeroRoleInfo)
            {
               if(HeroRoleInfo(role.info).userId == PlayerManager.instance.currentPlayerModel.userInfo.userId)
               {
                  if(battleType != 3911)
                  {
                     BattleManager.selfDie = true;
                     TimerUtils.setTimeout(function():void
                     {
                        if(!BattleManager.isExitingBattle)
                        {
                           BattleManager.onFightCanceled();
                        }
                     },1500);
                     break;
                  }
                  if(dieRoleInfoArr == null)
                  {
                     dieRoleInfoArr = new Vector.<HeroRoleInfo>();
                  }
                  dieRoleInfoArr.push(HeroRoleInfo(role.info));
               }
               else if(role && HeroRoleInfo(role.info).userId != PlayerManager.instance.currentPlayerModel.userInfo.userId)
               {
                  if(dieRoleInfoArr == null)
                  {
                     dieRoleInfoArr = new Vector.<HeroRoleInfo>();
                  }
                  dieRoleInfoArr.push(HeroRoleInfo(role.info));
               }
            }
            else if(role && role.info is PetRoleInfo)
            {
            }
            i = i + 1;
         }
         TimerUtils.setTimeout(function():void
         {
            var _loc1_:HeroRoleInfo = null;
            var _loc2_:HeroRoleInfo = null;
            var _loc3_:int = 0;
            while(dieRoleInfoArr && dieRoleInfoArr.length > 0)
            {
               if(BattleManager.selfDie)
               {
                  return;
               }
               _loc1_ = dieRoleInfoArr.pop();
               _loc3_ = int(_loc1_.petLivingId);
               BattleManager.getInstance().battleMap.removeRole(_loc1_.livingId);
               BattleManager.getInstance().battleModel.removeHeroAndPet(_loc1_.livingId);
               BattleManager.getInstance().battleMap.removeRole(_loc3_);
               BattleManager.getInstance().battleModel.removeHeroAndPet(_loc3_);
               _loc2_ = BattleManager.getInstance().battleModel.getChildInfoByLivingId(_loc1_.livingId);
               if(_loc2_)
               {
                  BattleManager.getInstance().battleMap.removeRole(_loc2_.livingId);
                  BattleManager.getInstance().battleModel.removeHeroAndPet(_loc2_.livingId);
               }
               BattleManager.getInstance().battleUIView.removeDieRole(_loc1_.userId);
            }
         },1500);
      }
      
      override public function removeRole(param1:int) : void
      {
         var _loc2_:RoleViewBase = _rolesDict[param1] as RoleViewBase;
         if(_loc2_)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc2_.dispose();
         }
         delete _rolesDict[param1];
      }
      
      override public function addPhysics(param1:IPhysics) : void
      {
         _physics[param1] = param1;
         if(param1 is DisplayObject)
         {
            effectContainer.addChild(param1 as DisplayObject);
         }
      }
      
      override public function removePhysics(param1:IPhysics) : void
      {
         delete _physics[param1];
         if(param1 is DisplayObject)
         {
            (param1 as DisplayObject).parent.removeChild(param1 as DisplayObject);
         }
         param1 = null;
      }
      
      public function changeMap(param1:BattleMapData, param2:String = "asset") : void
      {
         var _loc3_:BattleBackGroundData = null;
         var _loc5_:int = 0;
         var _loc7_:RepeatBackGroundLayer = null;
         var _loc6_:RepeatBackGroundLayer = null;
         var _loc4_:RepeatBackGroundLayer = null;
         _mapData = param1;
         _loc5_ = 0;
         while(_loc5_ < param1.bg_back_arr.length)
         {
            _loc3_ = BattleBackGroundData(param1.bg_back_arr[_loc5_]);
            if(_loc3_.repeat)
            {
               _loc7_ = new RepeatBackGroundLayer(_loc3_[param2],_loc3_.normalAsset,_loc3_.transparent);
               _loc7_.moveSpeed = _loc3_.moveSpeed;
               _loc7_.mouseChildren = _loc7_.mouseEnabled = false;
               addLayerAt(_loc7_,_loc5_,_loc3_.moveCoefficient);
               _loc7_.setParaData(_loc3_);
               _mapLayers.push(_loc7_);
            }
            else if(SharedManager.instance.allowSceneEffect)
            {
               _loc6_ = new RepeatBackGroundLayer(_loc3_[param2]);
               _loc6_.mouseChildren = _loc6_.mouseEnabled = false;
               addLayerAt(_loc6_,_loc5_,_loc3_.moveCoefficient);
               _mapLayers.push(_loc6_);
               _sceneEffectLayers.push(_loc6_);
               _loc6_.setParaData(_loc3_);
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.bg_front_arr.length)
         {
            _loc3_ = BattleBackGroundData(param1.bg_front_arr[_loc5_]);
            if(_loc3_.repeat)
            {
               _loc4_ = new RepeatBackGroundLayer(_loc3_[param2],_loc3_.normalAsset,_loc3_.transparent);
               _loc4_.mouseEnabled = _loc4_.mouseChildren = false;
               addLayer(_loc4_,_loc3_.moveCoefficient);
               _mapLayers.push(_loc4_);
               _loc4_.setParaData(_loc3_);
            }
            else if(SharedManager.instance.allowSceneEffect)
            {
               _loc4_ = new RepeatBackGroundLayer(_loc3_[param2]);
               _loc4_.mouseEnabled = _loc4_.mouseChildren = false;
               addLayer(_loc4_,_loc3_.moveCoefficient);
               _mapLayers.push(_loc4_);
               _sceneEffectLayers.push(_loc4_);
               _loc4_.setParaData(_loc3_);
            }
            _loc5_++;
         }
         addLayer(_gasEffectContainer);
         if(!SharedManager.instance.allowSceneEffect)
         {
            stopMovingAllMembers();
         }
         draw();
      }
      
      private function removeSceneEffect() : void
      {
         var _loc1_:int = 0;
         if(_sceneEffectLayers)
         {
            for each(var _loc2_:DisplayObject in _sceneEffectLayers)
            {
               _loc2_.visible = false;
            }
         }
         stopMovingAllMembers();
      }
      
      private function showSceneEffect() : void
      {
         var _loc1_:int = 0;
         if(_sceneEffectLayers)
         {
            for each(var _loc2_:DisplayObject in _sceneEffectLayers)
            {
               _loc2_.visible = true;
            }
         }
         playMovingAllMembers();
      }
      
      public function addGasEffect(param1:BattleEffect, param2:int = 1) : void
      {
         var effect:BattleEffect = param1;
         var repeat:int = param2;
         var gasEnd:* = function():void
         {
            blendMode = "normal";
            _gasEffectContainer.blendMode = "normal";
         };
         if(!SharedManager.instance.allowAttactedEffect)
         {
            return;
         }
         blendMode = "layer";
         _gasEffectContainer.blendMode = "erase";
         NotificationManager.instance.sendNotification("REFRESH_BACK_BITMAP");
         _gasEffectContainer.addEffect(effect,repeat);
         effect.callBackComplete.addListener(gasEnd);
      }
      
      override public function dispose() : void
      {
         if(dieRoleInfoArr != null)
         {
            dieRoleInfoArr = null;
         }
         NotificationManager.instance.removeEventListener("sceneEffectClose",onSceneEffecCloseHandler);
         if(_battleModel)
         {
            _battleModel.removeEventListener("BATTLE_OTHER_LIVING_VISIBLE",__otherLivingVisibleHandler);
         }
         _battleModel = null;
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4680,clearDiedRole);
         for each(var _loc1_:DisplayObject in _mapLayers)
         {
            if(_loc1_ is RepeatBackGroundLayer)
            {
               RepeatBackGroundLayer(_loc1_).dispose();
            }
         }
         if(_mapLayers)
         {
            _mapLayers.length = 0;
         }
         _mapLayers = null;
         if(_mapData)
         {
            _mapData.dispose();
            _mapData = null;
         }
         ObjectUtils.disposeAllChildren(_gasEffectContainer);
         _gasEffectContainer = null;
         while(_sceneEffectLayers && _sceneEffectLayers.length > 0)
         {
            ObjectUtils.disposeObject(_sceneEffectLayers.pop());
         }
         _sceneEffectLayers = null;
         super.dispose();
      }
   }
}

