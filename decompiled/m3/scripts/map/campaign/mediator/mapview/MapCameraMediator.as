package map.campaign.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.MouseData;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.helper.mapview.CampaignMapCenterCheckHelper;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.CampaignArmyView;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   
   public class MapCameraMediator extends Sprite implements IMediator, IEnterFrame
   {
      
      private var _role:*;
      
      private var _target:Object;
      
      private var _isLocked:Boolean;
      
      private var _updatePoint:Point = new Point();
      
      private var _model:CampaignMapModel;
      
      private var _xLimen:int = 10;
      
      private var _yLimen:int = 10;
      
      private var _yLimenOff:int = 0;
      
      private var _bevelSpeed:int;
      
      private var _tweenValue:Number = 0.2;
      
      private var _unLockTime:int;
      
      private var _mapWidth:int;
      
      private var _mapHeight:int;
      
      public function MapCameraMediator()
      {
         super();
         setMapSize();
         MouseData.instance.curState = "Normal";
      }
      
      private function setMapSize() : void
      {
         _model = CampaignManager.instance.mapModel;
         var _loc1_:int = int(_model ? _model.mapTempInfo.Width : 100000);
         var _loc2_:int = int(_model ? _model.mapTempInfo.Height : 100000);
         _mapWidth = _xLimen + bevelSpeed + _loc1_;
         _mapHeight = _yLimen + bevelSpeed + _loc2_;
      }
      
      private function get bevelSpeed() : int
      {
         var _loc1_:CampaignArmy = _model.selfMemberData;
         var _loc2_:Object = CampaignManager.instance.controller.getArmyView(_loc1_);
         if(_loc1_ && _loc2_)
         {
            if(_loc2_ is CampaignArmyView)
            {
               return _loc2_.aiInfo.speed;
            }
            return 7;
         }
         return 7;
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         EnterFrameManager.instance.registeEnterFrame(this);
         param1.addEventListener("render",__onScreenRend);
         param1.addEventListener("LOOK_AT_ROLE",__lookAtRoleHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _target.removeEventListener("render",__onScreenRend);
         _target.removeEventListener("LOOK_AT_ROLE",__lookAtRoleHandler);
      }
      
      protected function upDateNextRend() : void
      {
         if(_target.stage)
         {
            _target.stage.invalidate();
         }
      }
      
      protected function __onScreenRend(param1:Event) : void
      {
         if(_updatePoint.x != 10000)
         {
            _updatePoint = CampaignMapCenterCheckHelper.checkOutScene(_updatePoint);
            if(_target.x != _updatePoint.x || _target.y != _updatePoint.y)
            {
               _updatePoint.x = 10000;
               _target.dispatchEvent(new CampaignMapEvent("MOVE_SCENET_END",_target));
            }
         }
      }
      
      public function locked() : void
      {
         _isLocked = true;
      }
      
      public function unLocked() : void
      {
         _isLocked = false;
      }
      
      private function moveTweenEnd() : void
      {
         unLocked();
         if(_unLockTime > 0)
         {
            clearInterval(_unLockTime);
            _unLockTime = 0;
         }
         _target.dispatchEvent(new CampaignMapEvent("MOVE_SCENET_END",_target));
      }
      
      private function __lookAtRoleHandler(param1:CampaignMapEvent) : void
      {
         setMapSize();
         _role = param1.data as Object;
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc3_:int = int(StageReferance.stageHeight);
         var _loc7_:int = _role.x - _loc2_ / 2;
         var _loc5_:int = _role.y - _loc3_ / 2 - _yLimenOff;
         var _loc4_:int = int(_target.x);
         var _loc6_:int = int(_target.y);
         if(_loc7_ + _loc2_ > mapWidth)
         {
            _loc7_ = mapWidth - _loc2_;
         }
         if(_loc5_ + _loc3_ > mapHeight)
         {
            _loc5_ = mapHeight - _loc3_;
         }
         _loc7_ = -_loc7_;
         _loc5_ = -_loc5_;
         if(_loc7_ > 0)
         {
            _loc7_ = 0;
         }
         if(_loc5_ > 0)
         {
            _loc5_ = 0;
         }
         _loc7_ = Math.abs(_loc7_ - _loc4_) < _xLimen + bevelSpeed ? _loc4_ : _loc7_;
         _loc5_ = Math.abs(_loc5_ - _loc6_) < _yLimen + bevelSpeed ? _loc6_ : _loc5_;
         _updatePoint.x = _loc7_;
         _updatePoint.y = _loc5_;
         _updatePoint = CampaignMapCenterCheckHelper.checkOutScene(_updatePoint);
         (_target as CampaignMapView).setPosition(_updatePoint.x,_updatePoint.y);
      }
      
      public function enterFrame() : void
      {
         if(MouseData.instance.curState == "Normal")
         {
            moveXY();
         }
      }
      
      public function moveXY(param1:Boolean = false) : void
      {
         if(_isLocked || !_role)
         {
            return;
         }
         if(CampaignManager.instance.mapView.isLockMove)
         {
            return;
         }
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc10_:int = int(StageReferance.stageHeight);
         var _loc5_:int = _role.x - (_loc2_ >> 1);
         var _loc4_:int = _role.y - (_loc10_ >> 1) - _yLimenOff;
         var _loc11_:int = int(_target.x);
         var _loc12_:int = int(_target.y);
         if(_loc5_ + _loc2_ > mapWidth)
         {
            _loc5_ = mapWidth - _loc2_;
         }
         if(_loc4_ + _loc10_ > mapHeight)
         {
            _loc4_ = mapHeight - _loc10_;
         }
         var _loc8_:Point = new Point(_loc5_,_loc4_);
         if(_loc8_.x < 0)
         {
            _loc8_.x = 0;
         }
         if(_loc8_.y < 0)
         {
            _loc8_.y = 0;
         }
         _loc5_ = -_loc5_;
         _loc4_ = -_loc4_;
         if(_loc5_ > 0)
         {
            _loc5_ = 0;
         }
         if(_loc4_ > 0)
         {
            _loc4_ = 0;
         }
         _loc5_ = getAbs(_loc5_ - _loc11_) < _xLimen + bevelSpeed ? _loc11_ : _loc5_;
         _loc4_ = getAbs(_loc4_ - _loc12_) < _yLimen + bevelSpeed ? _loc12_ : _loc4_;
         var _loc15_:int = _loc5_ - _loc11_;
         var _loc16_:int = _loc4_ - _loc12_;
         if(getAbs(_loc15_) < _xLimen && getAbs(_loc16_) < _yLimen)
         {
            return;
         }
         var _loc6_:int = 10;
         var _loc13_:int = _loc11_;
         var _loc14_:int = _loc12_;
         var _loc7_:CampaignMapModel = _model;
         var _loc3_:int = int(_loc7_.mapTempInfo.Width);
         var _loc17_:int = int(_loc7_.mapTempInfo.Height);
         var _loc9_:Point = new Point(_target.x,_target.y);
         if(_loc13_ + _loc8_.x > _loc6_)
         {
            if(_loc2_ - _target.x >= _loc3_)
            {
               if(_loc2_ > _loc3_)
               {
                  _loc9_.x = (_loc2_ - _loc3_) / 2;
               }
               else
               {
                  _loc9_.x = _loc2_ - _loc3_;
               }
            }
            else
            {
               _loc13_ -= (_loc13_ + _loc8_.x - _loc6_) * _tweenValue;
               _loc9_.x = _loc13_ + 0.5 >> 0;
            }
         }
         else if(_loc9_.x >= -10)
         {
            _loc9_.x = -10;
         }
         else if(_loc13_ + _loc8_.x < -_loc6_)
         {
            _loc13_ -= (_loc13_ + _loc8_.x + _loc6_) * _tweenValue;
            _loc9_.x = _loc13_ + 0.5 >> 0;
         }
         if(_loc14_ + _loc8_.y > _loc6_)
         {
            if(_loc10_ - _target.y >= _loc17_)
            {
               if(_loc10_ > _loc17_)
               {
                  _loc9_.y = (_loc10_ - _loc17_) / 2;
               }
               else
               {
                  _loc9_.y = _loc10_ - _loc17_;
               }
            }
            else
            {
               _loc14_ -= (_loc14_ + _loc8_.y - _loc6_) * _tweenValue;
               _loc9_.y = _loc14_ + 0.5 >> 0;
            }
         }
         else if(_loc9_.y >= -10)
         {
            _loc9_.y = -10;
         }
         else if(_loc14_ + _loc8_.y < -_loc6_)
         {
            _loc14_ -= (_loc14_ + _loc8_.y + _loc6_) * _tweenValue;
            _loc9_.y = _loc14_ + 0.5 >> 0;
         }
         (_target as CampaignMapView).setPosition(_loc9_.x,_loc9_.y);
      }
      
      private function getAbs(param1:int) : int
      {
         return (param1 ^ param1 >> 31) - (param1 >> 31);
      }
      
      protected function get mapWidth() : int
      {
         return _mapWidth;
      }
      
      protected function get mapHeight() : int
      {
         return _mapHeight;
      }
   }
}

