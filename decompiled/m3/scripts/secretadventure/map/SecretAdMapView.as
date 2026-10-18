package secretadventure.map
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretMapInfo;
   import mvc.module.secret.SecretSecenInfo;
   import yishi.datas.templates.SecretMapDataTemplate;
   import yishi.datas.templates.SecretMapLevelTemplate;
   import yishi.datas.templates.SecretSonLevelTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.TweenDrag;
   
   public class SecretAdMapView extends Sprite
   {
      
      private var _bgShape:Shape;
      
      private var _showContainer:Sprite;
      
      private var _showMask:Shape;
      
      private var _warkLayer:SecretAdWarkLayer;
      
      private var _rightView:SecretAdMapRightView;
      
      private var _sonMapContainer:Sprite;
      
      private var _dragObj:TweenDrag;
      
      private var _isDraging:Boolean;
      
      private var _mapWidth:int = 2659;
      
      private var _mapHeight:int = 2320;
      
      private const SCREEN_WIDTH:int = 1920;
      
      private const SCREEN_HEIGHT:int = 1080;
      
      private const ONE_MAP_WW:int = 1200;
      
      private const ONE_MAP_HH:int = 1200;
      
      private var mapOffSetX:int = 305;
      
      private var mapOffSetY:int = 90;
      
      private var _backPointBtn:BaseButton;
      
      private var _currMapSprite:SecretSonMapView;
      
      public function SecretAdMapView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgShape = new Shape();
         _bgShape.graphics.beginFill(0);
         _bgShape.graphics.drawRect(0,0,1920,1080);
         _bgShape.graphics.endFill();
         addChild(_bgShape);
         _showContainer = new Sprite();
         _showMask = new Shape();
         _showMask.graphics.beginFill(16711680,0);
         _showMask.graphics.drawRect(0,0,1920,1080);
         _showMask.graphics.endFill();
         addChild(_showContainer);
         addChild(_showMask);
         _showContainer.mask = _showMask;
         _sonMapContainer = new Sprite();
         _showContainer.addChild(_sonMapContainer);
         initMapNodes();
         _warkLayer = new SecretAdWarkLayer();
         _showContainer.addChild(_warkLayer);
         _dragObj = new TweenDrag(_showContainer,this);
         _dragObj.onDragStart = dragStartCallBack;
         _dragObj.onDraging = dragingCallBack;
         _dragObj.onDragDrop = dropCallBack;
         _dragObj.upNoMove = true;
         _dragObj.afterTime = 200;
         _backPointBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secret.backpointBtn");
         addChild(_backPointBtn);
         _rightView = new SecretAdMapRightView();
         var _loc1_:SecretMapInfo = model.secenInfo.getMapInfo(model.secenInfo.currMapDataId);
         if(_loc1_ && _loc1_.hasGetTask)
         {
            _rightView.refreshView(_loc1_.mapDataId);
            addChild(_rightView);
         }
         initMoveMap();
      }
      
      private function initMapNodes() : void
      {
         var _loc1_:int = 0;
         var _loc12_:SecretMapDataTemplate = null;
         var _loc9_:SecretMapLevelTemplate = null;
         var _loc8_:SecretMapInfo = null;
         var _loc4_:SecretSonMapView = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:SecretSecenInfo = model.secenInfo;
         var _loc11_:int = int(_loc7_.levelId);
         var _loc5_:Array = _loc7_.getMapIds();
         var _loc13_:SecretSonLevelTemplate = TempleteManager.instance.secretsonLvCate.getTempInfo(_loc11_);
         var _loc10_:int = int(_loc5_.length);
         var _loc3_:int = _loc10_ / 2 + 1;
         _loc6_ = 0;
         while(_loc6_ < _loc10_)
         {
            _loc1_ = int(_loc5_[_loc6_]);
            _loc9_ = TempleteManager.instance.secretMapCate.getTempInfo(_loc13_.MapId);
            _loc4_ = new SecretSonMapView(_loc9_.Type);
            _loc8_ = model.secenInfo.getMapInfo(_loc1_);
            _loc4_.mapInfo = _loc8_;
            if(!_loc8_)
            {
               _loc12_ = TempleteManager.instance.secretSonDataCate.getTempInfo(_loc1_);
               if(model.isTest)
               {
                  _loc4_.setMapTemp(_loc12_,true);
               }
               else
               {
                  _loc4_.setMapTemp(_loc12_);
               }
            }
            if(_loc6_ < _loc3_)
            {
               _loc4_.x = mapOffSetX + _loc6_ * 1200;
               _loc4_.y = mapOffSetY;
            }
            else
            {
               _loc2_ = _loc6_ % _loc3_;
               _loc4_.x = mapOffSetX + 1200 / 2 + _loc2_ * 1200;
               _loc4_.y = mapOffSetY + 1200;
            }
            _sonMapContainer.addChild(_loc4_);
            _loc6_++;
         }
         _mapWidth = _loc3_ * 1200;
         if(_loc10_ > 2)
         {
            _mapHeight = 2 * 1200;
         }
         else
         {
            _mapHeight = 1200;
         }
         _currMapSprite = _loc4_;
      }
      
      public function initMoveMap() : void
      {
         var _loc8_:Point = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = StageReferance.stage.stageWidth * 0.5;
         var _loc1_:int = StageReferance.stage.stageHeight * 0.5;
         var _loc7_:int = int(model.secenInfo.currMapDataId);
         var _loc5_:int = int(model.pinfo.lastStandNodeId);
         var _loc6_:DisplayObject = model.getNode(_loc7_,_loc5_);
         if(_loc6_ && _loc6_.parent)
         {
            _loc8_ = new Point(_loc6_.parent.x + _loc6_.x,_loc6_.parent.y + _loc6_.y);
            _loc4_ = _loc3_ - _loc8_.x;
            _loc2_ = _loc1_ - _loc8_.y;
            mapMoveCheck(_loc4_,_loc2_);
         }
      }
      
      private function mapMoveCheck(param1:int, param2:int) : void
      {
         var _loc3_:int = _mapWidth - (StageReferance.stage.stageWidth - mapOffSetX);
         var _loc4_:int = _mapHeight - (StageReferance.stage.stageHeight - mapOffSetY);
         if(_loc3_ > 0)
         {
            if(param1 < -_loc3_)
            {
               param1 = -_loc3_;
            }
            else if(param1 > 0)
            {
               param1 = 0;
            }
         }
         else
         {
            param1 = 0;
         }
         if(_loc4_ > 0)
         {
            if(param2 < -_loc4_)
            {
               param2 = -_loc4_;
            }
            else if(param2 > 0)
            {
               param2 = 0;
            }
         }
         else
         {
            param2 = 0;
         }
         _showContainer.x = param1;
         _showContainer.y = param2;
      }
      
      private function dragStartCallBack() : void
      {
      }
      
      private function dragingCallBack() : void
      {
      }
      
      private function dropCallBack() : void
      {
         mapMoveCheck(_showContainer.x,_showContainer.y);
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         NotificationManager.instance.addEventListener("SecretAdEvent.transMap",transMapHandler);
         _backPointBtn.addEventListener("click",backHandler);
         NotificationManager.instance.addEventListener("SecretAdEvent.getTask",showTaskHandler);
         model.addEventListener("SecretAdEvent.mapEventUpadate",mapEventHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         NotificationManager.instance.removeEventListener("SecretAdEvent.transMap",transMapHandler);
         _backPointBtn.removeEventListener("click",backHandler);
         NotificationManager.instance.removeEventListener("SecretAdEvent.getTask",showTaskHandler);
         model.removeEventListener("SecretAdEvent.mapEventUpadate",mapEventHandler);
      }
      
      private function mapEventHandler(param1:NotificationEvent) : void
      {
         var _loc4_:Array = param1.data as Array;
         var _loc2_:int = int(_loc4_[0]);
         var _loc5_:Array = _loc4_[1];
         var _loc3_:SecretSonMapView = model.getMap(_loc2_) as SecretSonMapView;
         if(_loc3_)
         {
            _loc3_.updateNodeSState(_loc2_,_loc5_);
         }
      }
      
      private function showTaskHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         _rightView.refreshView(_loc2_);
         if(_rightView.parent == null)
         {
            addChild(_rightView);
         }
      }
      
      private function backHandler(param1:Event) : void
      {
         initMoveMap();
      }
      
      private function transMapHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = int(param1.data);
         clearLastMapView(_loc4_);
         initMoveMap();
         if(_rightView && _rightView.parent)
         {
            _rightView.parent.removeChild(_rightView);
         }
         var _loc5_:int = int(model.secenInfo.currMapDataId);
         var _loc2_:SecretMapInfo = model.secenInfo.getMapInfo(_loc5_);
         var _loc3_:SecretSonMapView = model.getMap(_loc5_) as SecretSonMapView;
         if(_loc3_)
         {
            _loc3_.mapInfo = _loc2_;
         }
      }
      
      private function clearLastMapView(param1:int) : void
      {
         var _loc2_:SecretSonMapView = model.getMap(param1) as SecretSonMapView;
         if(_loc2_)
         {
            _loc2_.clearToGray();
         }
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         initMoveMap();
      }
      
      private function selfMoveMapHandler(param1:Event = null) : void
      {
         initMoveMap();
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_warkLayer);
         _warkLayer = null;
         ObjectUtils.disposeAllChildren(_sonMapContainer);
         _sonMapContainer = null;
         ObjectUtils.disposeObject(_showContainer);
         _showContainer = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_dragObj);
         _dragObj = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

