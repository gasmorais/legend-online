package war2023.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import mvc.module.war2023.SecretWarModel;
   import mvc.module.war2023.info.SecretWarNodeInfo;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import war2023.layer.SecretwarFightLayer;
   import war2023.layer.SecretwarMaskLayer;
   import war2023.layer.SecretwarNodeLayer;
   import war2023.layer.SecretwarWalkLayer;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.CursorManagerII;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SecretWarManager;
   import yishi.utils.TweenDrag;
   
   public class SecretWarMapView extends Sprite implements IEnterFrame
   {
      
      private var _showContainer:Sprite;
      
      private var _nodeLayer:SecretwarNodeLayer;
      
      private var _walkLayer:SecretwarWalkLayer;
      
      private var _fightLayer:SecretwarFightLayer;
      
      private var _maskLayer:SecretwarMaskLayer;
      
      private var _showMask:Shape;
      
      private var _bg:Bitmap;
      
      private var _roadTipMc:MovieClip;
      
      private var _topView:SecretwarTopView;
      
      private var _rightView:SecretwarRightView;
      
      private var _dragObj:TweenDrag;
      
      private var _isDraging:Boolean;
      
      private var _mapWidth:int = 2250;
      
      private var _mapHeight:int = 1497;
      
      private const MAP_WIDTH:int = 1920;
      
      private const MAP_HEIGHT:int = 1080;
      
      public function SecretWarMapView()
      {
         super();
         initView();
         initEvent();
         resizeHandler();
         updateRoadHandler();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.secretwar.map");
         _roadTipMc = ComponentFactory.Instance.creatCustomObject("asset.secretwar.tiproad");
         _mapWidth = _bg.width;
         _mapHeight = _bg.height;
         _topView = new SecretwarTopView();
         _showContainer = new Sprite();
         _nodeLayer = new SecretwarNodeLayer();
         _walkLayer = new SecretwarWalkLayer();
         _fightLayer = new SecretwarFightLayer();
         _maskLayer = new SecretwarMaskLayer();
         _rightView = new SecretwarRightView();
         _showMask = new Shape();
         _showMask.graphics.beginFill(16711680,0);
         _showMask.graphics.drawRect(0,0,1920,1080);
         _showMask.graphics.endFill();
         addChild(_showContainer);
         addChild(_rightView);
         addChild(_showMask);
         addChild(_maskLayer);
         _showContainer.addChild(_bg);
         _showContainer.addChild(_roadTipMc);
         _showContainer.addChild(_nodeLayer);
         _showContainer.addChild(_fightLayer);
         _showContainer.addChild(_walkLayer);
         _showContainer.mask = _showMask;
         _rightView.y = 320;
         _dragObj = new TweenDrag(_showContainer,this as InteractiveObject);
         _dragObj.onDragStart = dragStartCallBack;
         _dragObj.onDraging = dragingCallBack;
         _dragObj.onDragDrop = dropCallBack;
         _dragObj.upNoMove = true;
      }
      
      public function enterFrame() : void
      {
         _nodeLayer.enterFrame();
         _walkLayer.enterFrame();
         _fightLayer.enterFrame();
         _maskLayer.enterFrame();
         updateRoadHandler();
      }
      
      private function dragStartCallBack() : void
      {
         CursorManagerII.instance.showCursorByType("DRAG_CURSOR");
      }
      
      private function dragingCallBack() : void
      {
         mapMoveCheck(_showContainer.x,_showContainer.y);
      }
      
      private function dropCallBack() : void
      {
         if(CursorManagerII.instance.currentState == "DRAG_CURSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         EnterFrameManager.instance.registeEnterFrame(this);
         NotificationManager.instance.addEventListener("Secretwar.initMapPos",trackSelfHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         NotificationManager.instance.removeEventListener("Secretwar.initMapPos",trackSelfHandler);
      }
      
      private function updateRoadHandler(param1:Event = null) : void
      {
         var _loc7_:String = null;
         var _loc8_:SecretWarNodeInfo = null;
         var _loc11_:String = null;
         var _loc10_:DisplayObject = null;
         var _loc9_:SecretwarPlayInfo = model.selfPlay;
         var _loc3_:SecretWarNodeInfo = model.nodeInfos[_loc9_.curNodeId];
         var _loc2_:Array = _loc3_.connects;
         var _loc4_:int = int(_loc2_.length);
         var _loc6_:int = 0;
         var _loc5_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc8_ = model.nodeInfos[_loc2_[_loc6_]];
            if(_loc3_.camp == _loc9_.camp)
            {
               if(_loc8_.nodeId > _loc3_.nodeId)
               {
                  _loc7_ = "nd" + _loc3_.nodeId + "_" + _loc8_.nodeId;
               }
               else
               {
                  _loc7_ = "nd" + _loc8_.nodeId + "_" + _loc3_.nodeId;
               }
               if(_loc8_.type == 3 || _loc8_.type == 4)
               {
                  if(_loc8_.camp == _loc9_.camp)
                  {
                     _loc5_.push(_loc7_);
                  }
               }
               else
               {
                  _loc5_.push(_loc7_);
               }
            }
            else if(_loc8_.camp == _loc9_.camp)
            {
               if(_loc8_.nodeId > _loc3_.nodeId)
               {
                  _loc7_ = "nd" + _loc3_.nodeId + "_" + _loc8_.nodeId;
               }
               else
               {
                  _loc7_ = "nd" + _loc8_.nodeId + "_" + _loc3_.nodeId;
               }
               _loc5_.push(_loc7_);
            }
            _loc6_++;
         }
         if(_loc9_.curNodeId > _loc9_.toNodeId)
         {
            _loc11_ = "nd" + _loc9_.toNodeId + "_" + _loc9_.curNodeId;
         }
         else
         {
            _loc11_ = "nd" + _loc9_.curNodeId + "_" + _loc9_.toNodeId;
         }
         _loc4_ = _roadTipMc.numChildren;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc10_ = _roadTipMc.getChildAt(_loc6_);
            if(_loc5_.indexOf(_loc10_.name) == -1)
            {
               _loc10_.visible = false;
            }
            else if(_loc9_.state == 3)
            {
               if(_loc10_.name == _loc11_)
               {
                  _loc10_.visible = true;
               }
               else
               {
                  _loc10_.visible = false;
               }
            }
            else
            {
               _loc10_.visible = true;
            }
            _loc6_++;
         }
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         _rightView.x = StageReferance.stage.stageWidth - 172;
         initMoveMap();
      }
      
      private function trackSelfHandler(param1:Event) : void
      {
         initMoveMap();
      }
      
      public function initMoveMap() : void
      {
         var _loc3_:int = StageReferance.stage.stageWidth * 0.5;
         var _loc1_:int = StageReferance.stage.stageHeight * 0.5;
         var _loc5_:SecretWarNodeInfo = model.nodeInfos[model.selfPlay.curNodeId];
         var _loc4_:int = _loc3_ - _loc5_.x;
         var _loc2_:int = _loc1_ - _loc5_.y;
         mapMoveCheck(_loc4_,_loc2_);
      }
      
      private function mapMoveCheck(param1:int, param2:int) : void
      {
         var _loc3_:int = StageReferance.stage.stageWidth - _mapWidth;
         var _loc4_:int = StageReferance.stage.stageHeight - _mapHeight;
         if(param1 >= 0)
         {
            param1 = 0;
         }
         else if(param1 <= _loc3_)
         {
            param1 = _loc3_;
         }
         if(param2 >= 0)
         {
            param2 = 0;
         }
         else if(param2 <= _loc4_)
         {
            param2 = _loc4_;
         }
         _showContainer.x = param1;
         _showContainer.y = param2;
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_dragObj);
         _dragObj = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeViolentMc(_roadTipMc);
         _roadTipMc = null;
         ObjectUtils.disposeObject(_walkLayer);
         _walkLayer = null;
         ObjectUtils.disposeObject(_nodeLayer);
         _nodeLayer = null;
         ObjectUtils.disposeObject(_fightLayer);
         _fightLayer = null;
         ObjectUtils.disposeObject(_maskLayer);
         _maskLayer = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_showContainer);
         _showContainer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

