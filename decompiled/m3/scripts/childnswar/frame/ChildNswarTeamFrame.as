package childnswar.frame
{
   import childnswar.item.ChildNswarTeamUI;
   import childnswar.view.ChildNswarChooseView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildNswarManager;
   import mvc.module.childnswar.ChildNswarUserInfo;
   import mvc.module.children.ChildData;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNswarTeamFrame extends Frame implements IManualSize
   {
      
      private var _ui:ChildNswarTeamUI;
      
      private var _chooseView:ChildNswarChooseView;
      
      private var _currOpIdx:int;
      
      private var _cancelBtn:IconButton;
      
      private var _confirmBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _lastchooseIdx:int = -1;
      
      public function ChildNswarTeamFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _ui = new ChildNswarTeamUI();
         _chooseView = ComponentFactory.Instance.creatComponentByStylename("childnswar.ChildNswarChooseView");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.cancelBtn");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.confirmBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("childnswar.team.helpBtn");
         addToContent(_ui);
         addToContent(_chooseView);
         addToContent(_cancelBtn);
         addToContent(_confirmBtn);
         addToContent(_helpBtn);
         _chooseView.visible = false;
         _confirmBtn.enable = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,600,510);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         StageReferance.stage.addEventListener("mouseUp",__stageMouseDown);
         _cancelBtn.addEventListener("click",cancelHandler);
         _confirmBtn.addEventListener("click",confirmHandler);
         NotificationManager.instance.addEventListener("ChildNswar.Evnet.ShowChooseView",showChooseHandler);
         NotificationManager.instance.addEventListener("ChildNswar.Event.ItemClick",itemClickHandler);
         _helpBtn.addEventListener("click",_helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         StageReferance.stage.removeEventListener("mouseUp",__stageMouseDown);
         _cancelBtn.removeEventListener("click",cancelHandler);
         _confirmBtn.removeEventListener("click",confirmHandler);
         NotificationManager.instance.removeEventListener("ChildNswar.Evnet.ShowChooseView",showChooseHandler);
         NotificationManager.instance.removeEventListener("ChildNswar.Event.ItemClick",itemClickHandler);
         _helpBtn.removeEventListener("click",_helpClickHandler);
      }
      
      private function _helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("chilsnswar.team.helpFrame");
         _loc2_.show();
      }
      
      private function cancelHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function confirmHandler(param1:MouseEvent) : void
      {
         if(!_ui.hasMainPos)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childnswar.match.needTeam"));
            return;
         }
         ChildNswarManager.Instance.doSomething(9,0,0,_ui.fightIdsStr);
         dispose();
      }
      
      private function showChooseHandler(param1:NotificationEvent) : void
      {
         if(!_chooseView.visible)
         {
            _chooseView.updatePosView(_ui.fightIdsStr);
         }
         _chooseView.visible = true;
         _currOpIdx = int(param1.data);
         _ui.currOpIdx = _currOpIdx;
         if(_lastchooseIdx != _currOpIdx)
         {
            _ui.clearLastFlash(_lastchooseIdx);
         }
         _lastchooseIdx = _currOpIdx;
      }
      
      private function itemClickHandler(param1:NotificationEvent) : void
      {
         var _loc3_:ChildData = param1.data as ChildData;
         _ui.updateAvatar(_loc3_);
         var _loc2_:ChildNswarUserInfo = ChildNswarManager.Instance.model.selfUserInfo;
         if(_ui.fightIdsStr == _loc2_.fightInfo)
         {
            _confirmBtn.enable = false;
         }
         else
         {
            _confirmBtn.enable = true;
            if(_ui.fightIdsStr == "-1,-1,-1")
            {
               _confirmBtn.enable = false;
            }
         }
         _ui.clearLastFlash(_lastchooseIdx);
      }
      
      private function __stageMouseDown(param1:MouseEvent) : void
      {
         if(_chooseView.visible)
         {
            _chooseView.visible = false;
            _ui.clearLastFlash(_lastchooseIdx);
         }
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_ui);
         _ui = null;
         ObjectUtils.disposeObject(_chooseView);
         _chooseView = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
      }
      
      public function show(param1:Object = null) : void
      {
         titleText = LanguageMgr.GetTranslation("childnswar.teamframe.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
   }
}

