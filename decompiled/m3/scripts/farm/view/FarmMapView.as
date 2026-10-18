package farm.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import water.view.WaterView;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.TweenDrag;
   
   public class FarmMapView extends Sprite implements Disposeable
   {
      
      private var _skinLayer:FarmSkinLayer;
      
      private var _waterLayer:WaterView;
      
      private var _landLayer:FarmLandLayer;
      
      private var _buildLayer:FarmBuildLayer;
      
      private var _walkLayer:FarmWalkLayer;
      
      private var _tweenDrag:TweenDrag;
      
      public function FarmMapView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _tweenDrag = new TweenDrag(this,this);
         _skinLayer = new FarmSkinLayer();
         _buildLayer = new FarmBuildLayer();
         _waterLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmWaterLayer");
         _landLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmLandLayer");
         _walkLayer = new FarmWalkLayer();
         _tweenDrag.onDraging = draggingCallBack;
         _tweenDrag.onTweening = draggingCallBack;
         addChild(_skinLayer);
         addChild(_waterLayer);
         addChild(_landLayer);
         addChild(_buildLayer);
         addChild(_walkLayer);
      }
      
      private function addEvent() : void
      {
         KeyBoardRegister.instance.registerMapKey(__leftMove,__rightMove,__upMove,__downMove);
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
      }
      
      private function removeEvent() : void
      {
         KeyBoardRegister.instance.removeMapKey(__leftMove,__rightMove,__upMove,__downMove);
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         draggingCallBack();
      }
      
      private function __leftMove() : void
      {
         x += 50;
         draggingCallBack();
      }
      
      private function __rightMove() : void
      {
         x -= 50;
         draggingCallBack();
      }
      
      private function __upMove() : void
      {
         y += 50;
         draggingCallBack();
      }
      
      private function __downMove() : void
      {
         y -= 50;
         draggingCallBack();
      }
      
      private function draggingCallBack() : void
      {
         if(x > 0 || _skinLayer.width < StageReferance.stageWidth)
         {
            x = 0;
         }
         else if(x < StageReferance.stageWidth - _skinLayer.width)
         {
            x = StageReferance.stageWidth - _skinLayer.width;
         }
         if(y > 0 || _skinLayer.height < StageReferance.stageHeight)
         {
            y = 0;
         }
         else if(y < StageReferance.stageHeight - _skinLayer.height)
         {
            y = StageReferance.stageHeight - _skinLayer.height;
         }
      }
      
      override public function get width() : Number
      {
         return 1500;
      }
      
      override public function get height() : Number
      {
         return 900;
      }
      
      public function get landLayer() : FarmLandLayer
      {
         return _landLayer;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_skinLayer)
         {
            _skinLayer.dispose();
         }
         _skinLayer = null;
         if(_buildLayer)
         {
            _buildLayer.dispose();
         }
         _buildLayer = null;
         if(_waterLayer)
         {
            _waterLayer.dispose();
         }
         _waterLayer = null;
         if(_landLayer)
         {
            _landLayer.dispose();
         }
         _landLayer = null;
         if(_tweenDrag)
         {
            _tweenDrag.dispose();
         }
         _tweenDrag = null;
         if(_walkLayer)
         {
            _walkLayer.dispose();
         }
         _walkLayer = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

