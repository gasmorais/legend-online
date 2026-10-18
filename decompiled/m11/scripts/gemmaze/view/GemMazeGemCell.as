package gemmaze.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import events.GemMazeEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mvc.module.gemmaze.info.GemMazeGemInfoVO;
   import yishi.view.tools.SimpleMovie;
   
   public class GemMazeGemCell extends Sprite implements Disposeable
   {
      
      private static const MOVE_TIME:Number = 0.3;
      
      private var _gem:MovieClip;
      
      private var _selectedBitmap:Bitmap;
      
      private var _selectedLightMc:MovieClip;
      
      private var _gemInfo:GemMazeGemInfoVO;
      
      private var _selected:Boolean;
      
      public function GemMazeGemCell()
      {
         super();
         initView();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(this.contains(_selectedBitmap))
         {
            removeChild(_selectedBitmap);
         }
         if(this.contains(_selectedLightMc))
         {
            _selectedLightMc.stop();
            removeChild(_selectedLightMc);
         }
         if(selected)
         {
            addChild(_selectedBitmap);
            addChild(_selectedLightMc);
            _selectedLightMc.play();
         }
      }
      
      public function get gemInfo() : GemMazeGemInfoVO
      {
         return _gemInfo;
      }
      
      public function set gemInfo(param1:GemMazeGemInfoVO) : void
      {
         _gemInfo = param1;
         updateView();
      }
      
      private function initView() : void
      {
         _selectedBitmap = ComponentFactory.Instance.creatBitmap("asset.GemMaze.GemSelected");
      }
      
      public function updateView() : void
      {
         _gem = ComponentFactory.Instance.creatCustomObject("GemMaze.GemAction_" + gemInfo.type);
         _gem.stop();
         addChild(_gem);
         _selectedLightMc = ComponentFactory.Instance.creatCustomObject("GemMaze.GemLight_" + gemInfo.type);
         _selectedLightMc.stop();
         _gem.addFrameScript(7,bomb);
      }
      
      public function removeSelf() : void
      {
         _gem.play();
      }
      
      public function action(param1:Number, param2:Number) : void
      {
         TweenMax.to(this,0.3,{
            "x":param1,
            "y":param2,
            "onComplete":onMoveComplete
         });
      }
      
      private function onMoveComplete() : void
      {
         dispatchEvent(new GemMazeEvent("GEMMAZE_GEM_ACTION_COMPLETE",null));
      }
      
      private function bomb() : void
      {
         var _loc1_:MovieClip = ClassUtils.CreatInstance("asset.GemMaze.BomB");
         var _loc2_:SimpleMovie = new SimpleMovie(_loc1_,onRemoveComplete);
         addChild(_loc2_);
         _loc2_.x = _loc2_.y = 30;
      }
      
      private function onRemoveComplete() : void
      {
         dispatchEvent(new GemMazeEvent("GEMMAZE_REMOVE_COMPLETE",null));
         dispose();
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

