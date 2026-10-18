package map.campaign.mediator.flametemple
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import map.campaign.view.ui.duskarea.DuskAreaSelfInfoView;
   import map.campaign.view.ui.flametemple.FlameTempleTopInfoView;
   import yishi.datas.PathInfo;
   import yishi.interfaces.IMediator;
   
   public class FlameTempleUIMediator implements IMediator
   {
      
      private var _topCenterUI:FlameTempleTopInfoView;
      
      private var _rightUI:DuskAreaSelfInfoView;
      
      public function FlameTempleUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _topCenterUI = new FlameTempleTopInfoView();
         _rightUI = new DuskAreaSelfInfoView();
         LayerManager.Instance.addToLayer(_topCenterUI,4,false,false,0,3);
         LayerManager.Instance.addToLayer(_rightUI,4,false);
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         align();
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_topCenterUI)
         {
            _topCenterUI.dispose();
         }
         _topCenterUI = null;
         if(_rightUI)
         {
            _rightUI.dispose();
         }
         _rightUI = null;
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         align();
      }
      
      private function align() : void
      {
         _topCenterUI.y = 0;
         _topCenterUI.x = (StageReferance.stageWidth - _topCenterUI.width) / 2 >> 0;
         _rightUI.x = StageReferance.gameStageWidth - _rightUI.viewWidth;
         _rightUI.y = 270;
         var _loc1_:int = 332;
         if(_topCenterUI.x < _loc1_)
         {
            _topCenterUI.x = _loc1_;
         }
         if(_rightUI.x < PathInfo.GAME_WIDTH - _rightUI.width)
         {
            _rightUI.x = StageReferance.gameStageWidth - _rightUI.viewWidth;
            _rightUI.y = 270;
         }
      }
   }
}

