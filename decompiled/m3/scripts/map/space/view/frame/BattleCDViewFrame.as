package map.space.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.BattleViewManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.DateFormatter;
   import yishi.utils.TimerUtils;
   
   public class BattleCDViewFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _cdTitle:Bitmap;
      
      private var _exitCDBtn:IconButton;
      
      private var _cdNumTxt:FilterFrameText;
      
      private var _curTotalTime:int;
      
      private const MY_TIME_NAME:String = "BattleCDViewFrameTime";
      
      public function BattleCDViewFrame(param1:uint)
      {
         super();
         initView();
         addEvent();
         setTimeData(param1);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.space.SpaceDialogFrame.FrameBg1");
         _cdTitle = ComponentFactory.Instance.creatBitmap("asset.space.BattleViewCDFrame.cdTitle");
         _exitCDBtn = ComponentFactory.Instance.creatComponentByStylename("map.space.view.frame.BattleCDViewBtn");
         _cdNumTxt = ComponentFactory.Instance.creatComponentByStylename("map.space.view.frame.BattleCDViewTxt");
         addToContent(_cdTitle);
         addToContent(_exitCDBtn);
         addToContent(_cdNumTxt);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function addEvent() : void
      {
         _exitCDBtn.addEventListener("click",onExitCDHandler);
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         _exitCDBtn.removeEventListener("click",onExitCDHandler);
         TimerUtils.removeSecendTimer("BattleCDViewFrameTime");
         removeEventListener("response",__frameResponse);
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
      
      private function onExitCDHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function setTimeData(param1:int) : void
      {
         _curTotalTime = param1;
         TimerUtils.removeSecendTimer("BattleCDViewFrameTime");
         TimerUtils.addSecendTimer("BattleCDViewFrameTime",1,param1,refreshCDNumTxt);
         refreshCDNumTxt();
      }
      
      private function refreshCDNumTxt() : void
      {
         _curTotalTime = TimerUtils.getTime("BattleCDViewFrameTime");
         _cdNumTxt.text = DateFormatter.getCountDateByMS(_curTotalTime);
         if(_curTotalTime <= 0)
         {
            BattleViewManager.instance.CDFinishHanlder();
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

