package gamehall.room
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallAutoView;
   import mvc.module.gamehall.GameHallModel;
   
   public class GameHallEastTopAutoView extends Component
   {
      
      private var _eastAutoView:GameHallAutoView;
      
      private var _eastMask:Sprite;
      
      public function GameHallEastTopAutoView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _eastMask = new Sprite();
         addChild(_eastMask);
         _eastAutoView = new GameHallAutoView();
         _eastAutoView.y = 20;
         addChild(_eastAutoView);
      }
      
      public function resize(param1:int, param2:int) : void
      {
         if(_eastAutoView)
         {
            _eastAutoView.x = (param1 - _eastAutoView.displayWidth) / 2;
         }
      }
      
      private function drawEastMask(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 400;
         var _loc4_:int = param2 - 400;
         _eastMask.graphics.clear();
         _eastMask.graphics.beginFill(0,0.3);
         if(_loc4_ > 0)
         {
            _eastMask.graphics.drawRect(0,0,param1,_loc4_);
            _eastMask.graphics.drawRect(312,_loc4_,param1,400);
         }
         else
         {
            _eastMask.graphics.drawRect(312,0,param1,param2);
         }
         _eastMask.graphics.endFill();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3);
         if(model.selfTeam && model.gameId == 4)
         {
            this.visible = model.selfTeam.autoType != 0;
         }
         else
         {
            this.visible = false;
         }
      }
      
      private function get model() : GameHallModel
      {
         return GameHallManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_eastAutoView);
         _eastAutoView = null;
         ObjectUtils.disposeObject(_eastMask);
         _eastMask = null;
         super.dispose();
      }
   }
}

