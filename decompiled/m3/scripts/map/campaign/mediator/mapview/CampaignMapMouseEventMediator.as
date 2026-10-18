package map.campaign.mediator.mapview
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import managers.MarryManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.house.FurnitureLayer;
   import map.campaign.view.layer.CampaignMainBuidingLayer;
   import map.campaign.view.layer.CampaignWalkLayer;
   import map.campaign.view.layer.NpcLayer;
   import mvc.module.maze.MazeModel;
   import yishi.interfaces.IMediator;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.component.MovieButton;
   import yishi.view.tips.MessageTipManager;
   
   public class CampaignMapMouseEventMediator implements IMediator
   {
      
      private var _target:Object;
      
      private var _controller:*;
      
      private var _mapModel:CampaignMapModel;
      
      private var npcLayer:NpcLayer;
      
      private var mainBuidingLayer:CampaignMainBuidingLayer;
      
      private var walkLayer:CampaignWalkLayer;
      
      private var furnitureLayer:FurnitureLayer;
      
      private var _gameLayer:Sprite;
      
      private var _mouseDownPoint:Point;
      
      private var _mouseDownTimeId:int;
      
      private var _isDown:Boolean;
      
      public function CampaignMapMouseEventMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         _controller = CampaignManager.instance.controller;
         _mapModel = CampaignManager.instance.mapModel;
         npcLayer = CampaignManager.instance.mapView.npcLayer;
         mainBuidingLayer = CampaignManager.instance.mapView.mainBuidingLayer;
         walkLayer = CampaignManager.instance.mapView.walkLayer;
         _target.addEventListener("rollOut",__rollOutHandler);
         _target.addEventListener("mouseOut",__mouseOutHandler);
         _target.addEventListener("mouseMove",__mouseMoveHandler);
         _target.addEventListener("mouseOver",__mouseOverHandler);
         _target.addEventListener("click",__onClickHandler);
         _target.addEventListener("mouseDown",__mouseDownHandler);
         _target.addEventListener("mouseUp",__mouseUpHandler);
         _target.addEventListener("deactivate",__deactiveteHandler);
         _controller.addEventListener("rollOut",__mouseParentOutHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         _target.removeEventListener("rollOut",__rollOutHandler);
         param1.removeEventListener("mouseOut",__mouseOutHandler);
         param1.removeEventListener("mouseMove",__mouseMoveHandler);
         param1.removeEventListener("mouseOver",__mouseOverHandler);
         param1.removeEventListener("click",__onClickHandler);
         param1.removeEventListener("mouseDown",__mouseDownHandler);
         param1.removeEventListener("mouseUp",__mouseUpHandler);
         param1.removeEventListener("deactivate",__deactiveteHandler);
         _controller.removeEventListener("rollOut",__mouseParentOutHandler);
         _target = null;
         _controller = null;
         _mapModel = null;
         npcLayer = null;
         mainBuidingLayer = null;
         walkLayer = null;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _mouseDownPoint = null;
         var _loc2_:SimpleBitmapButton = param1.target as SimpleBitmapButton;
         if(_loc2_)
         {
            return;
         }
         mainBuidingLayer.mouseOutHandler(param1);
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleBitmapButton = param1.target as SimpleBitmapButton;
         if(_loc2_)
         {
            return;
         }
         npcLayer.mouseOverHandler(param1);
         if(furnitureLayer == null)
         {
            furnitureLayer = CampaignManager.instance.mapView.furnitureLayer;
         }
         if(furnitureLayer)
         {
            furnitureLayer.mouseMoveHandler(param1);
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         mainBuidingLayer.mouseOverHandler(param1);
      }
      
      private function __deactiveteHandler(param1:Event) : void
      {
         _isDown = false;
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
      }
      
      private function __mouseParentOutHandler(param1:Event) : void
      {
         if(param1.currentTarget == _target.parent)
         {
            __deactiveteHandler(param1);
         }
      }
      
      private function isFarmLayerChild(param1:DisplayObject) : Boolean
      {
         if(param1 && param1.parent)
         {
            if(param1.parent == _target)
            {
               return false;
            }
            if(_target.hasOwnProperty("farmLayer") && param1.parent == _target["farmLayer"])
            {
               return true;
            }
            return isFarmLayerChild(param1.parent as DisplayObject);
         }
         return false;
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(MarryManager.instance.model.lockScreen == true)
         {
            return;
         }
         if(param1.target is SimpleBitmapButton || isMovieButtonChild(param1.target as DisplayObject))
         {
            return;
         }
         var _loc3_:int = int(_mapModel.mapId);
         if(WorldBossHelper.checkFarm(_loc3_) && isFarmLayerChild(param1.target as DisplayObject))
         {
            return;
         }
         CampaignManager.instance.mapModel.selectNode = null;
         PlayerManager.instance.currentPlayerModel.reinforce = null;
         if(WorldBossHelper.checkMarket(_loc3_))
         {
            PlayerManager.instance.currentPlayerModel.selectTarget = null;
         }
         if(WorldBossHelper.checkInHouse(_loc3_) || Boolean(WorldBossHelper.checkInHome(_loc3_)))
         {
            if(furnitureLayer == null)
            {
               furnitureLayer = CampaignManager.instance.mapView.furnitureLayer;
            }
            if(furnitureLayer)
            {
               furnitureLayer.onClickHandler(param1);
            }
            if(HomeManager.instance.model.inFixUp)
            {
               return;
            }
         }
         if(WorldBossHelper.checkMarket(_loc3_))
         {
            if(_mapModel.selfMemberData.sellState > 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("mediator.mapview.CampaignMapMouseEventMediator.inSell");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         if(!mainBuidingLayer.onClickHandler(param1))
         {
            walkLayer.onClickHandler(param1);
            if(WorldBossHelper.checkInAnyMaze(_loc3_))
            {
               MazeModel.instance.isAuto = false;
            }
         }
         TweenLite.killTweensOf(_target,false);
         _mouseDownPoint = new Point(param1.stageX,param1.stageY);
         _isDown = true;
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         _mouseDownTimeId = setInterval(clickWalk,500);
      }
      
      private function isMovieButtonChild(param1:DisplayObject) : Boolean
      {
         if(param1 is MovieButton)
         {
            return true;
         }
         if(param1 && param1.parent)
         {
            if(param1.parent == _target)
            {
               return false;
            }
            return isMovieButtonChild(param1.parent as DisplayObject);
         }
         return false;
      }
      
      private function clickWalk() : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         if(!_target || !(_target as Sprite).mouseEnabled)
         {
            return;
         }
         if(_isDown && SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE" && _mapModel.onCollectionId == 0)
         {
            _mouseDownTimeId = setInterval(clickWalk,500);
            walkLayer.onClickHandler(null);
            if(WorldBossHelper.checkInAnyMaze(_mapModel.mapId))
            {
               MazeModel.instance.isAuto = false;
            }
         }
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         _isDown = false;
         if(!_mouseDownPoint)
         {
            return;
         }
         _mouseDownPoint = null;
      }
   }
}

