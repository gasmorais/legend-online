package landmine
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.ComponentGroupManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import mainBar.TimeBoxView;
   import manager.LanguageMgr;
   import mvc.controler.LandMineController;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.view.tips.MessageTipManager;
   
   public class LandMineFrame extends Frame
   {
      
      private var _sprite:Sprite;
      
      private var _view:LandMineView;
      
      private var _isInit:Boolean = true;
      
      private var _controller:LandMineController = FrameControllerManager.instance.landMineController;
      
      public function LandMineFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["FULL_SCREEN_FRAME"];
      }
      
      private function initView() : void
      {
         ComponentGroupManager.Instance.disposeAllOpenFrame();
         _sprite = new Sprite();
         _view = new LandMineView(dispose);
         addToContent(_sprite);
         addToContent(_view);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_sprite);
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         NotificationManager.instance.addEventListener("CLOSE_LANDMINE_FRAME",__closeFrameHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__closeFrameHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         NotificationManager.instance.removeEventListener("CLOSE_LANDMINE_FRAME",__closeFrameHandler);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__closeFrameHandler);
      }
      
      private function __closeFrameHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         var _loc3_:int = int(StageReferance.stageWidth);
         var _loc4_:int = int(StageReferance.stageHeight);
         setShape(_loc3_,_loc4_);
         x = 0;
         y = 0;
         width = _loc3_;
         height = _loc4_;
         var _loc2_:int = (_loc3_ - _view.width) / 2;
         var _loc5_:int = (_loc4_ - _view.height) / 2;
         if(_isInit)
         {
            _isInit = false;
            if(_loc2_ < 0)
            {
               _view.x = 0;
            }
            else
            {
               _view.x = _loc2_;
            }
            if(_loc4_ - _view.height > 0)
            {
               _view.y = _loc5_;
            }
            else
            {
               _view.y = _loc4_ - _view.height;
            }
         }
         else
         {
            _view.x = _loc2_;
            _view.y = _loc5_;
         }
      }
      
      private function setShape(param1:int, param2:int) : void
      {
         _sprite.graphics.clear();
         _sprite.graphics.beginFill(0,1);
         _sprite.graphics.drawRect(0,0,param1,param1);
         _sprite.graphics.endFill();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function hideTool() : void
      {
         TopToolsBar.instance.hide();
         QueueBar.instance.hide();
         ResourcesBar.instance.hide();
         MainToolBar.instance.switchToolsBarState(3);
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         TimeBoxView.instance.hide();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",true));
      }
      
      public function showToolView() : void
      {
         TopToolsBar.instance.show();
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            QueueBar.instance.show();
         }
         ResourcesBar.instance.show();
         MainToolBar.instance.switchToolsBarState(4);
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         MainToolBar.instance.recommendBtnIsExist(null);
         TimeBoxView.instance.show();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",false));
      }
      
      private function showTips() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("landmine.LandMineFrame.TipsTxt01");
         MessageTipManager.instance().show(_loc1_);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,6,true,true);
         KeyBoardRegister.instance.keyEnable = false;
         __resizeHanlder(null);
         hideTool();
         _controller.isInLandMineFrame = true;
         SceneManager.instance.isEnterFullScene = true;
         showTips();
      }
      
      override public function dispose() : void
      {
         SceneManager.instance.isEnterFullScene = false;
         _controller.isInLandMineFrame = false;
         KeyBoardRegister.instance.keyEnable = true;
         showToolView();
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

