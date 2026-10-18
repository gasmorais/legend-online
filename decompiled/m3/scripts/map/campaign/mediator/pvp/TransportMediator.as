package map.campaign.mediator.pvp
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.MineralModel;
   import map.campaign.event.CampaignEvent;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.physics.GodsEveningArmyView;
   import map.campaign.view.physics.MineralArmyView;
   import map.campaign.view.physics.PvpWarFightArmyView;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicInfo;
   import map.internals.view.hero.AvatarBaseView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   
   public class TransportMediator implements IMediator
   {
      
      private var _data:CampaignArmy;
      
      private var _target:Object;
      
      private var _transport:Bitmap;
      
      private var _userId:int;
      
      private var armyView:Object;
      
      private var _lastTime:Number = getTimer();
      
      public function TransportMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         _data = param1.data;
         _userId = _data.userId;
         _data.addEventListener("IS_DIE",__isDieHandler);
         _data.addEventListener("ONLINE_STATE",__onlineStateHandler);
         _target.avatarView.addEventListener("sizeTypeChange",__onThaneInfoChange);
         if(isSelf)
         {
            thane.addEventListener("PLAYER_INFO_UPDATE",__onThaneInfoChange);
         }
         else
         {
            _data.baseHero.addEventListener("PLAYER_INFO_UPDATE",__onThaneInfoChange);
         }
         if(inMineral && mineralModel)
         {
            mineralModel.addEventListener("UPDATE_MINERAL_CAR",__mineralCarHandler);
         }
         __isDieHandler(null);
         checkMineralCar();
      }
      
      public function unregister(param1:Object) : void
      {
         _data.removeEventListener("IS_DIE",__isDieHandler);
         if(inMineral && mineralModel)
         {
            mineralModel.removeEventListener("UPDATE_MINERAL_CAR",__mineralCarHandler);
         }
         _data.removeEventListener("ONLINE_STATE",__onlineStateHandler);
         _target.avatarView.removeEventListener("sizeTypeChange",__onThaneInfoChange);
         if(isSelf)
         {
            thane.removeEventListener("PLAYER_INFO_UPDATE",__onThaneInfoChange);
         }
         else
         {
            _data.baseHero.removeEventListener("PLAYER_INFO_UPDATE",__onThaneInfoChange);
         }
         removeNpc();
         _target = null;
         _data = null;
      }
      
      private function get isSelf() : Boolean
      {
         if(_data == null)
         {
            return false;
         }
         if(mapModel.isCross)
         {
            return _data.userId == thane.userId && _data.baseHero.serviceName == PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         }
         return _data.userId == thane.userId;
      }
      
      protected function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      private function get inGodsEvening() : Boolean
      {
         return WorldBossHelper.checkGodsEvening(CampaignManager.instance.mapId);
      }
      
      private function get inMineral() : Boolean
      {
         return WorldBossHelper.checkMineral(CampaignManager.instance.mapId);
      }
      
      private function get inDuskArea() : Boolean
      {
         return WorldBossHelper.checkDuskArea(CampaignManager.instance.mapId);
      }
      
      private function get inIceFire() : Boolean
      {
         return WorldBossHelper.checkIceFireTemple(CampaignManager.instance.mapId);
      }
      
      private function get inPvpWar() : Boolean
      {
         return WorldBossHelper.checkPvp(CampaignManager.instance.mapId);
      }
      
      private function get mineralModel() : MineralModel
      {
         return CampaignManager.instance.mineralModel;
      }
      
      private function __onThaneInfoChange(param1:Event) : void
      {
         resize();
      }
      
      private function resize() : void
      {
         if(!_transport)
         {
            return;
         }
         if(!_target)
         {
            return;
         }
         _transport.y = _target.caluateTopPos();
      }
      
      private function __onlineStateHandler(param1:CampaignMapEvent) : void
      {
         if(!_data || !_data.online)
         {
            removeNpc();
         }
      }
      
      private function __mineralCarHandler(param1:CampaignEvent) : void
      {
         if(!param1 || param1.data != _data)
         {
            return;
         }
         checkMineralCar();
      }
      
      private function checkMineralCar() : void
      {
         if(inMineral)
         {
            if(mineralModel.carInfos[_data.baseHero.userId] && mineralModel.carInfos[_data.baseHero.userId].is_own == 1 && _data.online)
            {
               createNpc();
            }
            else
            {
               removeNpc();
            }
         }
      }
      
      private function __isDieHandler(param1:CampaignMapEvent) : void
      {
         switch(int(_data.isDie) - 1)
         {
            case 0:
               removeNpc();
               break;
            case 1:
            case 2:
            case 9:
            case 10:
               createNpc();
               break;
            default:
               removeNpc();
         }
      }
      
      private function createNpc() : void
      {
         if(_target == null)
         {
            return;
         }
         var _loc1_:CampaignNode = readNodeInfo();
         CampaignManager.instance.mapModel.addNode(_loc1_);
         if(_loc1_.followTarget != _data.id)
         {
            _loc1_.followTargetServiceName = _data.baseHero.serviceName;
            _loc1_.followTarget = _data.id;
         }
         transportState(true);
         if(isSelf && !inMineral)
         {
            NotificationManager.instance.sendNotification("TRANSPORT_STATE");
         }
      }
      
      private function removeNpc() : void
      {
         var _loc1_:CampaignNode = CampaignManager.instance.mapModel.getMapNodesById(nodeId);
         if(_loc1_)
         {
            CampaignManager.instance.mapModel.removeNode(_loc1_);
         }
         transportState(false);
         if(isSelf && !inMineral)
         {
            NotificationManager.instance.sendNotification("TRANSPORT_STATE");
         }
      }
      
      private function transportState(param1:Boolean) : void
      {
         var _loc4_:ThaneInfo = null;
         var _loc3_:Boolean = false;
         var _loc2_:AvatarBaseView = _target as AvatarBaseView;
         if(param1)
         {
            if(!_transport)
            {
               _transport = ComponentFactory.Instance.creatBitmap("asset.campaign.pvp.TransportAsset");
            }
            (_target as Sprite).addChild(_transport);
            _transport.x = -55;
            _transport.y = _target.caluateTopPos();
            if(_target is PvpWarFightArmyView)
            {
               _target.changeSpeedTo(0.5);
            }
            else if(_target is GodsEveningArmyView)
            {
               _target.changeSpeedTo(0.5);
            }
            _loc3_ = false;
            if(isSelf)
            {
               _loc4_ = thane;
               _loc3_ = _loc4_.mountAvata != "";
            }
            else
            {
               _loc4_ = _data.baseHero;
               _loc3_ = _data.mountTemplate != null;
            }
         }
         else
         {
            if(_transport && _transport.parent)
            {
               _transport.parent.removeChild(_transport);
            }
            if(_target is PvpWarFightArmyView || _target is MineralArmyView)
            {
               _target.changeSpeedTo(1);
            }
            if(inGodsEvening && _target is GodsEveningArmyView)
            {
               if(_data.isDie == 2 || _data.isDie == 3 || _data.isDie == 12 || _data.isDie == 10)
               {
                  _target.changeSpeedTo(0.5);
               }
               else
               {
                  _target.changeSpeedTo(1);
               }
            }
         }
      }
      
      private function readNodeInfo() : CampaignNode
      {
         var _loc1_:CampaignNode = null;
         var _loc6_:String = null;
         _loc1_ = CampaignManager.instance.mapModel.getMapNodesById(nodeId);
         if(!_loc1_)
         {
            _loc1_ = new CampaignNode();
         }
         var _loc5_:PhysicInfo = new PhysicInfo();
         _loc5_.id = nodeId;
         _loc1_.nodeId = _data.mapTempInfo.CampaignId;
         if(inPvpWar)
         {
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.mediator.pvp.TransportMediator.infoNameTip");
            _loc5_.names = _loc6_;
            _loc5_.types = 1101;
            _loc1_.sonType = 4999;
            _loc5_.state = CampaignManager.instance.mapModel.selfMemberData.teamId == _data.teamId ? 2 : 1;
         }
         else if(inMineral)
         {
            _loc5_.names = _data.baseHero.nickName;
            _loc5_.types = 1102;
            _loc1_.sonType = 5000;
            _loc5_.state = thane.userId == _data.baseHero.userId ? 2 : 1;
            _loc5_.occupyPlayerId = _data.baseHero.userId;
         }
         else if(inGodsEvening)
         {
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.mediator.pvp.TransportMediator.infoNameTip");
            _loc5_.names = _loc6_;
            _loc5_.types = 1101;
            _loc1_.sonType = 4999;
            _loc5_.state = CampaignManager.instance.mapModel.selfMemberData.teamId == _data.teamId ? 2 : 1;
         }
         else if(inDuskArea || inIceFire)
         {
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.mediator.pvp.TransportMediator.infoNameTip");
            _loc5_.names = _loc6_;
            _loc5_.types = 1101;
            _loc1_.sonType = 4999;
            _loc5_.state = CampaignManager.instance.mapModel.selfMemberData.teamId == _data.teamId ? 2 : 1;
         }
         var _loc2_:int = int(_target.x);
         var _loc4_:int = int(_target.y);
         _loc2_ = int(_loc2_ <= 0 ? _data.curPosX * 20 : _loc2_);
         _loc4_ = int(_loc4_ <= 0 ? _data.curPosY * 20 : _loc4_);
         _loc5_.posX = _loc2_ / 20;
         _loc5_.posY = _loc4_ / 20;
         _loc1_.curPosX = _loc2_ / 20;
         _loc1_.curPosY = _loc4_ / 20;
         _loc5_.grade = 0;
         _loc1_.attackTypes = 1;
         var _loc3_:int = int(CampaignManager.instance.mapModel.selfMemberData.teamId);
         _loc1_.nameColor = _loc3_ == _data.teamId ? 1 : 5;
         _loc1_.toward = 1;
         _loc1_.resource = 1;
         _loc1_.resetPosX = 0;
         _loc1_.resetPosY = 0;
         _loc1_.visitUserIds = [];
         _loc1_.fixX = _loc2_;
         _loc1_.fixY = _loc4_;
         _loc1_.handlerRange = 2;
         _loc1_.heroTemplateId = 1;
         _loc1_.sizeType = 1;
         _loc1_.fightCapaity = 0;
         _loc1_.param1 = _data.teamId;
         _loc1_.info = _loc5_;
         return _loc1_;
      }
      
      private function get nodeId() : int
      {
         return _userId + 10000000000;
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

