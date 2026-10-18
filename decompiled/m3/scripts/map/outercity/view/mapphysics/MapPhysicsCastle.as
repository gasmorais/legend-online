package map.outercity.view.mapphysics
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.internals.data.BaseCastle;
   import map.internals.event.OuterCityEvent;
   import map.internals.view.displaye.PhysicsMenu;
   import map.internals.view.physics.PhysicsCastleView;
   import map.outercity.OuterCityModel;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.manager.OuterFrameManager;
   import map.outercity.view.frame.AttackAlertFrame;
   import mvc.module.armyII.UserArmy;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.playerinfo.PlayerEffectInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MapPhysicsCastle extends PhysicsCastleView
   {
      
      private var _alert:BaseAlerFrame;
      
      private var _attackAlert:AttackAlertFrame;
      
      public function MapPhysicsCastle()
      {
         super();
      }
      
      override protected function setFireView() : void
      {
         super.setFireView();
         _attacking.y = -110;
         addChild(_attacking);
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:String = null;
         if(!mouseHitTest())
         {
            return false;
         }
         if(ArmyManager.instance.thane.grades < 8 && castleInfo.info.occupyPlayerId != PlayerManager.instance.currentPlayerModel.userInfo.userId)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command01");
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         var _loc3_:Object = {};
         _loc3_["BTN_ATTACK"] = attack;
         _loc3_["BTN_MOVE"] = moveArmy;
         _loc3_["BTN_INFO"] = showInfo;
         _loc3_["BTN_PORTAL"] = portal;
         _loc3_["BTN_ENTER"] = enterCastle;
         _loc3_["FRIEND"] = addFriend;
         _loc3_["WRITE_EMAIL"] = writeEmail;
         PhysicsMenu.getInstance().showPhysicsMenu(info,_loc3_);
         return true;
      }
      
      private function addFriend() : void
      {
         FriendManager.getInstance().sendAddFriendRequest(info.info.occupyPlayerName,1);
      }
      
      private function writeEmail() : void
      {
         FrameControllerManager.instance.openControllerByInfo("writeemail","email.WriteEmailFrame",info.info.occupyPlayerName);
      }
      
      private function enterCastle() : void
      {
         SceneManager.instance.setScene("CASTLE_SCENE");
      }
      
      private function portal() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.RiverView.txt.TransmitHandler.content");
         _alert = AlertManager.Instance.simpleAlert(_loc1_,_loc2_);
         _alert.enterEnable = false;
         KeyBoardRegister.instance.keyEnable = false;
         _alert.addEventListener("response",__transferHandler);
      }
      
      private function __transferHandler(param1:FrameEvent) : void
      {
         var _loc6_:BuildInfo = null;
         var _loc8_:ConfigInfosTempInfo = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc12_:String = null;
         KeyBoardRegister.instance.keyEnable = true;
         if(param1.responseCode == 3)
         {
            _loc6_ = BuildingManager.instance.model.buildingListByID[-11];
            _loc8_ = TempleteManager.instance.getConfigInfoByConfigName("transport_charge_cost");
            _loc7_ = int(playerEffect.getTransferPowerLimitAddition(_loc6_.templeteInfo.Property2));
            _loc5_ = int(_loc6_.property1);
            _loc9_ = _loc7_ - _loc5_;
            _loc11_ = int(info.posX);
            _loc10_ = int(info.posY);
            if(100 <= _loc5_)
            {
               PlayerManager.instance.sendMoveCastle(info.info.mapId,_loc11_,_loc10_,1);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.TransmitHandler.command02",_loc8_.ConfigValue);
               _loc3_ = LanguageMgr.GetTranslation("public.confirm");
               _loc4_ = LanguageMgr.GetTranslation("public.cancel");
               _loc12_ = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.PORTAL");
               SimpleAlertHelper.instance.data = [transferBack];
               SimpleAlertHelper.instance.popAlerFrame(_loc12_,_loc2_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc8_.ConfigValue);
            }
         }
         _alert.removeEventListener("response",__transferHandler);
         _alert.dispose();
         _alert = null;
      }
      
      private function transferBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 2) : void
      {
         if(param1)
         {
            if(!param2)
            {
               param4 = 1;
            }
            PlayerManager.instance.sendMoveCastle(info.info.mapId,info.posX,info.posY,param4);
         }
      }
      
      private function showInfo() : void
      {
         OuterFrameManager.getInstance().open(1,info);
      }
      
      private function attack() : void
      {
         var _loc5_:int = int(ArmyManager.instance.thane.grades);
         var _loc1_:String = "";
         if(info.info.occupyPlayerId == 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command07");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(Math.abs(_loc5_ - info.info.grade) >= 10)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command02");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(castleInfo.defenceLeftTime > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command03");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         var _loc2_:String = PlayerManager.instance.currentPlayerModel.playerInfo.consortiaName;
         if(_loc2_ != "" && _loc2_ != null && castleInfo.info && castleInfo.info.occupyLeagueName == _loc2_)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command04");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(info.info.state == 4)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command05");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         var _loc4_:OuterCityModel = OuterCityManager.instance.model;
         if(_loc4_.walkTargerData && info.info.id == _loc4_.walkTargerData.info.id)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command06");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         var _loc6_:BaseCastle = PlayerManager.instance.currentPlayerModel.mapNodeInfo;
         if(_loc6_.defenceLeftTime > 0 && showAttackAlert())
         {
            return;
         }
         var _loc3_:UserArmy = _loc4_.checkArmy(info,1);
         if(_loc3_)
         {
            _attackAlert = ComponentFactory.Instance.creatComponentByStylename("outercity.AttackAlertFrame");
            _attackAlert.data = info;
            _attackAlert.addEventListener("response",__responseHandler);
            _attackAlert.show();
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         var _loc2_:String = null;
         _attackAlert.removeEventListener("response",__responseHandler);
         _attackAlert.dispose();
         _attackAlert = null;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.attackCount == 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("map.outercity.view.frame.AttackAlertFrame.command03");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",info));
         }
      }
      
      private function showAttackAlert(param1:Function = null) : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:Date = SharedManager.instance.attackCastleCheckDate;
         var _loc5_:Date = new Date();
         var _loc2_:Boolean = false;
         var _loc6_:Boolean = Boolean(SharedManager.instance.attackCastleCheck);
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("outercity.AttackCastleAlertFrame");
            _loc7_ = LanguageMgr.GetTranslation("yishi.view.base.AttackAlertFrame.content");
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc3_,startAlertBack);
         }
         return _loc2_;
      }
      
      private function startAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.attackCastleCheck = param1;
         SharedManager.instance.attackCastleCheckDate = new Date();
         SharedManager.instance.saveAttackCastleCheck();
         var _loc3_:OuterCityModel = OuterCityManager.instance.model;
         var _loc2_:UserArmy = _loc3_.checkArmy(info,1);
         if(_loc2_)
         {
            _attackAlert = ComponentFactory.Instance.creatComponentByStylename("outercity.AttackAlertFrame");
            _attackAlert.data = info;
            _attackAlert.addEventListener("response",__responseHandler);
            _attackAlert.show();
         }
      }
      
      private function moveArmy() : void
      {
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",new Point(info.x,info.y)));
      }
      
      private function get playerEffect() : PlayerEffectInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerEffect;
      }
   }
}

