package map.campaign.mediator.house
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.Event;
   import flash.geom.Point;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import mvc.module.home.HomeModel;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.utils.MsgMan;
   
   public class HouseMoveMediator implements IMediator, IEnterFrame
   {
      
      private const STEP:int = 20;
      
      private const CHECK:int = 60;
      
      private var _mapModel:CampaignMapModel;
      
      private var _homeModel:HomeModel;
      
      private var _targetPoint:Point;
      
      private var _count:int = 0;
      
      public function HouseMoveMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _mapModel = CampaignManager.instance.mapModel;
         _homeModel = HomeManager.instance.model;
         _targetPoint = new Point();
         EnterFrameManager.instance.registeEnterFrame(this);
         MsgMan.addObserver("ChildEvent.FIX_CHANGE",this,__fixChangeHandler);
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         MsgMan.removeObserver("ChildEvent.FIX_CHANGE",this,__fixChangeHandler);
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
      }
      
      public function enterFrame() : void
      {
         if(!_mapModel)
         {
            return;
         }
         if(!inFixUp)
         {
            return;
         }
         if(StageReferance.stage.mouseX < 60)
         {
            __leftMove();
         }
         if(StageReferance.stage.mouseX > StageReferance.stageWidth - 60)
         {
            __rightMove();
         }
         if(StageReferance.stage.mouseY < 60)
         {
            __upMove();
         }
         if(StageReferance.stage.mouseY > StageReferance.stageHeight - 60)
         {
            __downMove();
         }
      }
      
      private function __fixChangeHandler(param1:String, param2:Object) : void
      {
         resetTargetPoint();
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         resetTargetPoint();
      }
      
      private function resetTargetPoint() : void
      {
         var _loc2_:Object = null;
         var _loc1_:CampaignArmy = null;
         if(!_mapModel)
         {
            return;
         }
         _loc1_ = _mapModel.selfMemberData;
         if(_loc1_)
         {
            _loc2_ = CampaignManager.instance.controller.getArmyView(_loc1_);
         }
         if(_loc2_)
         {
            _targetPoint.x = _loc2_.x;
            _targetPoint.y = _loc2_.y;
         }
         if(!inFixUp && CampaignManager.instance.mapView)
         {
            CampaignManager.instance.mapView.moveCenterPoint(new Point(_targetPoint.x,_targetPoint.y));
         }
      }
      
      private function __leftMove() : void
      {
         _targetPoint.x -= 20;
         draggingCallBack();
      }
      
      private function __rightMove() : void
      {
         _targetPoint.x += 20;
         draggingCallBack();
      }
      
      private function __upMove() : void
      {
         _targetPoint.y -= 20;
         draggingCallBack();
      }
      
      private function __downMove() : void
      {
         _targetPoint.y += 20;
         draggingCallBack();
      }
      
      private function draggingCallBack() : void
      {
         if(!_mapModel)
         {
            return;
         }
         var _loc2_:Number = StageReferance.stageWidth * 0.5;
         var _loc1_:Number = StageReferance.stageHeight * 0.5;
         if(_targetPoint.x < _loc2_)
         {
            _targetPoint.x = _loc2_;
         }
         else if(_targetPoint.x > _mapModel.mapTempInfo.Width - _loc2_)
         {
            _targetPoint.x = _mapModel.mapTempInfo.Width - _loc2_;
         }
         if(_targetPoint.y < _loc1_)
         {
            _targetPoint.y = _loc1_;
         }
         else if(_targetPoint.y > _mapModel.mapTempInfo.Height - _loc1_)
         {
            _targetPoint.y = _mapModel.mapTempInfo.Height - _loc1_;
         }
         if(inFixUp && CampaignManager.instance.mapView)
         {
            CampaignManager.instance.mapView.moveCenterPoint(new Point(_targetPoint.x,_targetPoint.y));
         }
      }
      
      private function get inFixUp() : Boolean
      {
         if(_homeModel && _homeModel.inFixUp && _mapModel)
         {
            return true;
         }
         return false;
      }
   }
}

