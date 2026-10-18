package map.campaign.mediator.monopoly
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import map.campaign.view.ui.monopoly.MonopolyBottomView;
   import map.campaign.view.ui.monopoly.MonopolyTopView;
   import yishi.interfaces.IMediator;
   
   public class MonopolyUIMediator implements IMediator
   {
      
      private var _topView:MonopolyTopView;
      
      private var _bottomView:MonopolyBottomView;
      
      public function MonopolyUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         initUI();
         addEvent();
         align();
      }
      
      public function unregister(param1:Object) : void
      {
         removeEvent();
         uninitUI();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         align();
      }
      
      private function align() : void
      {
         _topView.x = (StageReferance.stageWidth - _topView.width) / 2 >> 0;
         _topView.y = 0;
         _bottomView.x = (StageReferance.stageWidth - _bottomView.width) / 2 >> 0;
         _bottomView.y = StageReferance.stageHeight - _bottomView.height - 75 >> 0;
         var _loc1_:int = 332;
         if(_topView.x < _loc1_)
         {
            _topView.x = _loc1_;
         }
         if(_bottomView.x < _loc1_)
         {
            _bottomView.x = _loc1_;
         }
      }
      
      private function initUI() : void
      {
         _topView = new MonopolyTopView();
         _bottomView = new MonopolyBottomView();
         LayerManager.Instance.addToLayer(_topView,4,false,false,0,0);
         LayerManager.Instance.addToLayer(_bottomView,4,false,false,0,2);
      }
      
      private function uninitUI() : void
      {
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
      }
   }
}

