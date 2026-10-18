package dreamarena
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class DreamArenaMatchingView extends Component
   {
      
      public static const MATCH_MAX_TIME:int = 180;
      
      private var _matchingImage:MutipleImage;
      
      private var _matchTime:TimeDownView;
      
      private var _cancelBtn:IconButton;
      
      public function DreamArenaMatchingView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _matchingImage = ComponentFactory.Instance.creatComponentByStylename("DreamArenaMatchingView.matchingImage");
         _matchTime = ComponentFactory.Instance.creatComponentByStylename("DreamArenaMatchingView.matchTime");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaMatchingView.cancelBtn");
         addChild(_matchingImage);
         addChild(_matchTime);
         addChild(_cancelBtn);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         _matchTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         _cancelBtn.addEventListener("click",__cancelClickHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_matchTime)
         {
            _matchTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelClickHandler);
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         this.x = (StageReferance.stageWidth - 529) / 2;
         this.y = (StageReferance.stageHeight - 100) / 2;
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaMatchingView.timeOut.alert"));
         DreamArenaManager.instance.sendDreamArenaRequest(12);
         dispose();
      }
      
      private function __cancelClickHandler(param1:MouseEvent) : void
      {
         DreamArenaManager.instance.sendDreamArenaRequest(12);
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         __resizeHandler(null);
         _matchTime.timeCount = 180;
         FrameControllerManager.instance.dreamArenaController.dreamArenaMatching = true;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         FrameControllerManager.instance.dreamArenaController.dreamArenaMatching = false;
         ObjectUtils.disposeObject(_matchingImage);
         _matchingImage = null;
         ObjectUtils.disposeObject(_matchTime);
         _matchTime = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

