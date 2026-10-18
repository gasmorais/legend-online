package yishi.actions.castle
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.Frame;
   import flash.display.Sprite;
   import flash.display.Stage;
   import mvc.module.buildings.BuildInfo;
   import yishi.actions.map.MapBaseAction;
   import yishi.manager.FrameControllerManager;
   import yishi.scene.SceneManager;
   
   public class NewBuildAction extends MapBaseAction
   {
      
      private var _completeCallBack:Function;
      
      private var _info:BuildInfo;
      
      private var _map:Sprite;
      
      private var _toX:int;
      
      private var _toY:int;
      
      private var _isRun:Boolean;
      
      public function NewBuildAction(param1:Sprite, param2:BuildInfo, param3:int, param4:int, param5:Function)
      {
         _completeCallBack = param5;
         _map = param1;
         _info = param2;
         _toX = param3;
         _toY = param4;
         super();
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         var _loc1_:Frame = null;
         if(SceneManager.instance.currentType != "CASTLE_SCENE")
         {
            _isRun = true;
            TweenMax.killChildTweensOf(_map,false);
            dispose();
            return;
         }
         if(!_isRun)
         {
            TweenMax.to(_map,1,{
               "x":_toX,
               "y":_toY,
               "onComplete":backCall
            });
            _isRun = true;
            _loc1_ = FrameControllerManager.instance.taskControler.frame;
            if(_loc1_ && _loc1_.parent)
            {
               _loc1_.dispose();
            }
         }
      }
      
      private function get stage() : Stage
      {
         return StageReferance.stage;
      }
      
      private function backCall() : void
      {
         if(_completeCallBack != null)
         {
            _info ? _completeCallBack(_info) : _completeCallBack();
         }
         dispose();
         TweenMax.killTweensOf(_map);
         _completeCallBack = null;
         _info = null;
         _map = null;
      }
   }
}

