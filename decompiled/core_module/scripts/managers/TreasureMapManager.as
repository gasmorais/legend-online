package managers
{
   import com.road.yishi.proto.treasuremap.PlayerTreasureMsg;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.marry.MarrySender;
   import mvc.module.treasuremap.TreasureMapModel;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureMapManager
   {
      
      private static var _instance:TreasureMapManager;
      
      private var _model:TreasureMapModel;
      
      public function TreasureMapManager()
      {
         super();
         _model = new TreasureMapModel();
      }
      
      public static function get instance() : TreasureMapManager
      {
         if(!_instance)
         {
            _instance = new TreasureMapManager();
         }
         return _instance;
      }
      
      public function get model() : TreasureMapModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.listener(4633,__treasureMapInfoHandler);
         SocketManager.instance.listener(4634,__treasureMapRewardHandler);
      }
      
      private function __treasureMapInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerTreasureMsg = new PlayerTreasureMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlayerTreasureMsg;
         _model.joinCount = _loc2_.joinCount;
         _model.rewardCount = _loc2_.rewardCount;
         _model.index = _loc2_.index;
         _model.templateIds = _loc2_.templateIds;
         _model.isFirstQuest = _loc2_.isFirstQuest;
         _model.isFirstGet = _loc2_.isFirstGet;
         _model.isFirstUse = _loc2_.isFirstUse;
         _model.commit();
      }
      
      private function __treasureMapRewardHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:String = LanguageMgr.GetTranslation("managers.TreasureMapManager.TipTxt1");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [__requestFrameCloseHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function __requestFrameCloseHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            TreasureMapSocketOutManager.sendReceiveTreasureMap(_model.lastTreasureMap.pos,true);
         }
         else
         {
            TreasureMapSocketOutManager.sendReceiveTreasureMap(_model.lastTreasureMap.pos,false);
         }
      }
      
      public function get needShowTip() : Boolean
      {
         var _loc1_:int = getTimer();
         if(_model.lastGetTime != 0 && _loc1_ - _model.lastGetTime <= 1000 * 60)
         {
            return false;
         }
         _model.lastGetTime = _loc1_;
         return true;
      }
      
      public function isCurrentTreasureMap(param1:GoodsInfo) : Boolean
      {
         if(param1 && param1.id == SharedManager.instance.currentTreasureMapId)
         {
            return true;
         }
         return false;
      }
      
      public function useTreasureMap(param1:GoodsInfo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = param1.templateInfo.SonType;
         if(_loc2_ == 320)
         {
            if(checkTreasureMap(param1))
            {
               MarrySender.useTaskGoods(param1.pos);
            }
            else
            {
               MarryManager.instance.creatTaskMapFrame(param1);
            }
         }
      }
      
      private function digBtnAlertCallBack(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         if(param1)
         {
            TreasureMapSocketOutManager.sendUseTreasureMap(param3.pos);
         }
      }
      
      public function checkTreasureMap(param1:GoodsInfo) : Boolean
      {
         var _loc7_:Object = null;
         if(!param1)
         {
            return false;
         }
         var _loc2_:int = param1.templateInfo.SonType;
         var _loc3_:String = LanguageMgr.GetTranslation("managers.TreasureMapManager.secretWay");
         if(_loc2_ == 320)
         {
            if(param1.templateInfo.Property1 == 1)
            {
               _loc3_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.monster");
            }
            else if(param1.templateInfo.Property1 == 2)
            {
               _loc3_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.fireWay");
            }
         }
         var _loc4_:String = "";
         if(!army || army.mapId != param1.randomSkill1)
         {
            _loc4_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.TipTxt2",_loc3_);
            MessageTipManager.instance().show(_loc4_);
            return false;
         }
         if(army is SpaceArmy)
         {
            _loc7_ = SpaceManager.instance.controller.getArmyView(army);
         }
         else if(army is CampaignArmy)
         {
            _loc7_ = CampaignManager.instance.controller.getArmyView(army);
         }
         var _loc6_:Point = new Point(_loc7_.x,_loc7_.y);
         var _loc8_:Point = new Point(param1.randomSkill2,param1.randomSkill3);
         var _loc5_:Number = getDistance(_loc6_,_loc8_);
         var _loc9_:String = getDirection(_loc6_,_loc8_);
         if(_loc5_ > 80 * 20)
         {
            _loc4_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.TipTxt3",_loc3_,_loc9_);
            MessageTipManager.instance().show(_loc4_);
            return false;
         }
         if(eqOrLittleFloat(_loc5_,80 * 20) && _loc5_ > 40 * 20)
         {
            _loc4_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.TipTxt4",_loc3_,_loc9_);
            MessageTipManager.instance().show(_loc4_);
            return false;
         }
         if(eqOrLittleFloat(_loc5_,40 * 20) && _loc5_ > 15 * 20)
         {
            _loc4_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.TipTxt5",_loc3_,_loc9_);
            MessageTipManager.instance().show(_loc4_);
            return false;
         }
         return true;
      }
      
      private function getDistance(param1:Point, param2:Point) : int
      {
         var _loc3_:int = 0;
         var _loc5_:int = Math.abs(param2.x - param1.x);
         var _loc4_:int = Math.abs(param2.y - param1.y);
         if(_loc5_ > _loc4_)
         {
            _loc3_ = _loc5_;
         }
         else
         {
            _loc3_ = _loc4_;
         }
         return _loc3_;
      }
      
      private function getDirection(param1:Point, param2:Point) : String
      {
         var _loc6_:String = LanguageMgr.GetTranslation("managers.TreasureMapManager.DirectionTxt1");
         var _loc4_:Number = param2.y - param1.y;
         var _loc3_:Number = param2.x - param1.x;
         var _loc7_:Number = Math.atan2(_loc4_,_loc3_);
         var _loc5_:Number = _loc7_ * 180 / 3.141592653589793;
         if(eqOrBigFloat(_loc5_,-25) && eqOrLittleFloat(_loc5_,25))
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.DirectionTxt1");
         }
         else if(-65 < _loc5_ && _loc5_ < -25)
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.DirectionTxt2");
         }
         else if(eqOrBigFloat(_loc5_,-115) && eqOrLittleFloat(_loc5_,-65))
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.DirectionTxt3");
         }
         else if(-155 < _loc5_ && _loc5_ < -115)
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.DirectionTxt4");
         }
         else if(eqOrBigFloat(_loc5_,155) || eqOrLittleFloat(_loc5_,-155))
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.DirectionTxt5");
         }
         else if(115 < _loc5_ && _loc5_ < 155)
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.DirectionTxt6");
         }
         else if(eqOrBigFloat(_loc5_,65) && eqOrLittleFloat(_loc5_,115))
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.DirectionTxt7");
         }
         else if(25 < _loc5_ && _loc5_ < 65)
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.TreasureMapManager.DirectionTxt8");
         }
         return _loc6_;
      }
      
      public function eqOrBigFloat(param1:Number, param2:Number, param3:Number = 1e-12) : Boolean
      {
         return param1 > param2 || eqFloat(param1,param2,param3);
      }
      
      public function eqOrLittleFloat(param1:Number, param2:Number, param3:Number = 1e-12) : Boolean
      {
         return param1 < param2 || eqFloat(param1,param2,param3);
      }
      
      public function eqFloat(param1:Number, param2:Number, param3:Number = 1e-12) : Boolean
      {
         return Math.abs(param1 - param2) < param3;
      }
      
      private function updateTarget(param1:Point) : void
      {
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            SpaceManager.instance.model.updateWalkTarget(param1);
         }
         else if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            CampaignManager.instance.mapModel.updateWalkTarget(param1);
         }
      }
      
      private function get army() : BaseArmy
      {
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return SpaceManager.instance.model.selfArmy as BaseArmy;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            return CampaignManager.instance.mapModel.selfMemberData as BaseArmy;
         }
         return null;
      }
      
      public function checkReinforce() : Boolean
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:Object = null;
         var _loc4_:Point = null;
         var _loc9_:Point = null;
         var _loc3_:Number = NaN;
         if(PlayerManager.instance.currentPlayerModel.reinforce)
         {
            _loc8_ = PlayerManager.instance.currentPlayerModel.reinforce.userId;
            if(!FreedomTeamManager.instance.inMyTeam(_loc8_))
            {
               return false;
            }
            _loc7_ = PlayerManager.instance.currentPlayerModel.reinforce.state;
            if(_loc7_ != 2)
            {
               return false;
            }
            PlayerManager.instance.currentPlayerModel.reinforce = null;
            return true;
         }
         if(model.reinforceTarget)
         {
            _loc8_ = int(model.reinforceTarget.userId);
            if(!FreedomTeamManager.instance.inMyTeam(_loc8_))
            {
               return false;
            }
            _loc6_ = int(model.reinforceTarget.mapId);
            if(army.mapId != _loc6_)
            {
               return false;
            }
            _loc1_ = int(model.reinforceTarget.posX);
            _loc2_ = int(model.reinforceTarget.posY);
            if(army is SpaceArmy)
            {
               _loc5_ = SpaceManager.instance.controller.getArmyView(army);
            }
            else if(army is CampaignArmy)
            {
               _loc5_ = CampaignManager.instance.controller.getArmyView(army);
            }
            _loc4_ = new Point(_loc5_.x,_loc5_.y);
            _loc9_ = new Point(_loc1_,_loc2_);
            _loc3_ = getDistance(_loc4_,_loc9_);
            if(_loc3_ >= 40)
            {
               return false;
            }
            model.reinforceTarget = null;
            return true;
         }
         return false;
      }
   }
}

