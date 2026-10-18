package map.campaign.mediator.npcai
{
   import flash.geom.Point;
   import logging.LoggerSys;
   import map.campaign.CampaignManager;
   import map.campaign.view.physics.NpcAvatarView;
   import map.campaign.view.physics.physicsview.CampaignNpcView;
   import map.internals.constant.NpcEffectiveState;
   import map.internals.data.CampaignNode;
   import map.net.MapSocketOuterManager;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerManager;
   
   public class NpcArriveMediator implements IMediator, IEnterFrame
   {
      
      private var _npc:CampaignNpcView;
      
      private var _count:int;
      
      private var _npcPoint:Point = new Point();
      
      private var _targetPoint:Point = new Point();
      
      private var _errorCount:int = 0;
      
      public function NpcArriveMediator()
      {
         super();
      }
      
      public function enterFrame() : void
      {
         var _loc1_:int = 0;
         _count = _count + 1;
         if(!_npc || _count % 30 != 0)
         {
            return;
         }
         _npcPoint.x = _npc.x;
         _npcPoint.y = _npc.y;
         var _loc3_:Array = CampaignManager.instance.mapModel.mapNodesData;
         for each(var _loc2_:CampaignNode in _loc3_)
         {
            if(!(_loc2_.info.types != 42 && _loc2_.info.types != 151 || _loc2_.info.state != 1))
            {
               _targetPoint.x = _loc2_.nodeView.x;
               _targetPoint.y = _loc2_.nodeView.y;
               if(Point.distance(_npcPoint,_targetPoint) < NpcEffectiveState.TOWER_RADIUS)
               {
                  (_loc2_.nodeView as NpcAvatarView).aiInfo.pathInfo = [];
                  if(isNaN(_loc2_.createTime) || PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond - _loc2_.createTime / 1000 > 30)
                  {
                     _loc2_.nodeView.x = int(_loc2_.param3) * 20;
                     _loc2_.nodeView.y = int(_loc2_.param4) * 20;
                     MapSocketOuterManager.sendNpcArrive(_loc2_.nodeId,_loc2_.uid);
                  }
                  else if(_errorCount < 1)
                  {
                     _loc1_ = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond - _loc2_.createTime / 1000;
                     LoggerSys.info("＝＝魔神祭坛error：consortiaId" + PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID + "{invalid_utf8=239}{invalid_utf8=188}?" + _loc2_.info.names + "createTime" + _loc2_.createTime + "，移动到祭坛耗时" + _loc1_ + "秒＝{invalid_utf8=239}{invalid_utf8=188}?");
                     _errorCount = _errorCount + 1;
                  }
               }
            }
         }
      }
      
      public function register(param1:Object) : void
      {
         _npc = param1 as CampaignNpcView;
         if(_npc && _npc.info && _npc.info.info.types == 141)
         {
            EnterFrameManager.instance.registeEnterFrame(this);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _npc = null;
      }
   }
}

