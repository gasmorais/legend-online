package map.campaign.mediator.mapview
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.CampaignNode;
   import map.internals.view.hero.helper.HeroAvatarViewHelper;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   
   public class NodeGuideMediator implements IMediator, IEnterFrame
   {
      
      private var _timeId:int;
      
      private var _arrow:MovieClip;
      
      private var _aInfo:CampaignArmy;
      
      private var _aView:Object;
      
      private var _count:int;
      
      public function NodeGuideMediator()
      {
         super();
         _arrow = ComponentFactory.Instance.creatCustomObject("campaign.GuideArrowAsset");
      }
      
      public function register(param1:Object) : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         NotificationManager.instance.addEventListener("sendCampaignArrive",__resetTimeHandler);
         NotificationManager.instance.addEventListener("campaignGuide",__campaignGuideHandler);
         NotificationManager.instance.addEventListener("WORK_NEXT_NODE",__walkNextNodeHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         NotificationManager.instance.removeEventListener("sendCampaignArrive",__resetTimeHandler);
         NotificationManager.instance.removeEventListener("campaignGuide",__campaignGuideHandler);
         NotificationManager.instance.removeEventListener("WORK_NEXT_NODE",__walkNextNodeHandler);
         if(_arrow)
         {
            _arrow.stop();
            if(_arrow.parent)
            {
               _arrow.parent.removeChild(_arrow);
            }
         }
         _arrow = null;
         _aInfo = null;
         _aView = null;
      }
      
      private function walkNextNodeHandler() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:CampaignNode = CampaignManager.instance.mapModel.getToAttackNode();
         if(!_loc1_)
         {
            _loc1_ = CampaignManager.instance.mapModel.mapNodeEndPoint;
         }
         if(_loc1_)
         {
            _aInfo = CampaignManager.instance.mapModel.selfMemberData;
            if(!_aInfo)
            {
               return;
            }
            _loc2_ = CampaignManager.instance.mapView.getNpcNodeById(_loc1_.info.id);
            CampaignManager.instance.mapModel.selectNode = _loc1_;
            (CampaignManager.instance.controller as CampaignMapController).moveArmyByPos(_loc2_.x,_loc2_.y,true,true);
         }
      }
      
      private function checkNodeGuide() : void
      {
         var _loc5_:DisplayObject = null;
         var _loc1_:int = 0;
         var _loc6_:Boolean = false;
         var _loc4_:int = 0;
         var _loc2_:CampaignMapModel = CampaignManager.instance.mapModel;
         var _loc3_:CampaignNode = _loc2_ ? _loc2_.getToAttackNode() : null;
         if(_loc3_)
         {
            _aInfo = CampaignManager.instance.mapModel.selfMemberData;
            if(!_aInfo)
            {
               return;
            }
            _aView = CampaignManager.instance.controller.getArmyView(_aInfo);
            _loc5_ = CampaignManager.instance.mapModel.getNodeById(_loc3_.info.id);
            if(_loc5_)
            {
               _loc1_ = Point.distance(new Point(_aView.x,_aView.y),new Point(_loc5_.x,_loc5_.y));
               _loc6_ = true;
               if(CampaignManager.instance.mapView.fogLayer)
               {
                  _loc6_ = Boolean(CampaignManager.instance.mapView.fogLayer.checkFogEmpty(_loc5_.x,_loc5_.y));
               }
               if((_loc5_["isPlaying"] && !_loc6_ || _loc1_ < 320) && PlayerManager.instance.newbieProcess > 19000)
               {
                  if(_arrow.parent)
                  {
                     _arrow.parent.removeChild(_arrow);
                  }
                  return;
               }
               _loc4_ = HeroAvatarViewHelper.twoPointAngle(_loc5_.x,_loc5_.y,_aView.x,_aView.y);
               if(!_arrow.parent)
               {
                  _aView.addChildAt(_arrow,0);
               }
               _arrow["arrow"].rotation = _loc4_;
            }
         }
      }
      
      private function updateAngle() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:int = 0;
         if(!_arrow.parent)
         {
            return;
         }
         var _loc1_:CampaignNode = CampaignManager.instance.mapModel.getToAttackNode();
         if(_loc1_)
         {
            _loc3_ = CampaignManager.instance.mapView.getNpcNodeById(_loc1_.info.id);
            _loc2_ = HeroAvatarViewHelper.twoPointAngle(_loc3_.x,_loc3_.y,_aView.x,_aView.y);
            _arrow["arrow"].rotation = _loc2_;
         }
      }
      
      private function __resetTimeHandler(param1:Event) : void
      {
         _count = 0;
         if(_arrow)
         {
            if(_arrow.parent)
            {
               _arrow.parent.removeChild(_arrow);
            }
         }
      }
      
      private function __campaignGuideHandler(param1:Event) : void
      {
         _count = 500;
         checkNodeGuide();
      }
      
      private function __walkNextNodeHandler(param1:Event) : void
      {
         _count = 500;
         walkNextNodeHandler();
      }
      
      public function enterFrame() : void
      {
         if(GameBaseQueueManager.instance.actionsLength > 0)
         {
            __resetTimeHandler(null);
            return;
         }
         _count = _count + 1;
         if(_count > 500 || PlayerManager.instance.newbieProcess < 19000 || Boolean(WorldBossHelper.checkForbiddenBoss(CampaignManager.instance.mapModel.mapId)))
         {
            if(_count % 10 == 0)
            {
               checkNodeGuide();
            }
            else
            {
               updateAngle();
            }
         }
      }
   }
}

