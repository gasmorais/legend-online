package svs.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.ComponentGroupManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import mainBar.SmallMapBar;
   import mainBar.TimeBoxView;
   import map.campaign.data.SvsModel;
   import map.campaign.event.SvsEvent;
   import mvc.controler.SvsController;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   
   public class SvsFrame extends Frame
   {
      
      private var _sprite:Sprite;
      
      private var _bg:Bitmap;
      
      private var _view:SvsView;
      
      private var _controller:SvsController;
      
      private var _model:SvsModel;
      
      public function SvsFrame()
      {
         super();
         _controller = FrameControllerManager.instance.svsController;
         _model = _controller.model;
         initView();
         addEvent();
         _controller.sendSvsLocalGroupReq();
         _controller.sendSvsUserInfoReq();
      }
      
      override public function get groups() : Array
      {
         return ["FULL_SCREEN_FRAME"];
      }
      
      private function initView() : void
      {
         ComponentGroupManager.Instance.disposeAllOpenFrame();
         _sprite = new Sprite();
         _bg = ComponentFactory.Instance.creatBitmap("asset.svsmap.svsFrameBg");
         _view = new SvsView();
         addToContent(_sprite);
         addToContent(_bg);
         addToContent(_view);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         NotificationManager.instance.addEventListener("CLOSE_SVS_FRAME",__closeFrameHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__closeFrameHandler);
         _model.addEventListener("SVS_INFO_CHANGE",__svsInfoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         NotificationManager.instance.removeEventListener("CLOSE_SVS_FRAME",__closeFrameHandler);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__closeFrameHandler);
         _model.removeEventListener("SVS_INFO_CHANGE",__svsInfoChangeHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         var _loc2_:int = StageReferance.stageWidth;
         var _loc3_:int = StageReferance.stageHeight;
         setShape(_loc2_,_loc3_);
         x = 0;
         y = 0;
         width = _loc2_;
         height = _loc3_;
         _bg.x = (_loc2_ - _bg.width) / 2;
         _bg.y = -(900 - _loc3_) / 2;
         _view.x = _bg.x + 250;
         _view.y = _bg.y + 150;
      }
      
      private function __closeFrameHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function __svsInfoChangeHandler(param1:SvsEvent) : void
      {
         _view.refreshView();
      }
      
      private function setShape(param1:int, param2:int) : void
      {
         _sprite.graphics.clear();
         _sprite.graphics.beginFill(0,1);
         _sprite.graphics.drawRect(0,0,param1,param1);
         _sprite.graphics.endFill();
      }
      
      public function hideTool() : void
      {
         TopToolsBar.instance.hide();
         TaskTraceBar.instance.hide();
         QueueBar.instance.hide();
         ResourcesBar.instance.hide();
         SmallMapBar.instance.hide();
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
         TaskTraceBar.instance.show();
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            QueueBar.instance.show();
         }
         ResourcesBar.instance.show();
         SmallMapBar.instance.show();
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         MainToolBar.instance.recommendBtnIsExist(null);
         TimeBoxView.instance.show();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",false));
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,6,true,true);
         KeyBoardRegister.instance.keyEnable = false;
         __resizeHanlder(null);
         hideTool();
         _controller.isInSvsFrame = true;
         SceneManager.instance.isEnterFullScene = true;
      }
      
      override public function dispose() : void
      {
         SceneManager.instance.isEnterFullScene = false;
         _controller.isInSvsFrame = false;
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         showToolView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

