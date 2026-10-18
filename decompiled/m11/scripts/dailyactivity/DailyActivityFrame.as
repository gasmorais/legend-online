package dailyactivity
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dayguide.DailyTabView;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.DayGuideSocketOutManager;
   import yishi.manager.FrameControllerManager;
   
   public class DailyActivityFrame extends Frame implements IManualSize
   {
      
      private var _dailyTabView:DailyTabView;
      
      private var _stagesActivityBtn:SelectedIconButton;
      
      private var _dayActivityBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _buttonHbox:HBox;
      
      public function DailyActivityFrame()
      {
         super();
         DayGuideSocketOutManager.sendDailyCount();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,680,460);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("dayGuide.view.DailyActivityFrame.title");
         _dailyTabView = ComponentFactory.Instance.creatCustomObject("dayGuide.DailyTabView");
         _stagesActivityBtn = ComponentFactory.Instance.creatComponentByStylename("dayGuide.stagesActivity.selectedIconButton");
         _dayActivityBtn = ComponentFactory.Instance.creatComponentByStylename("dayGuide.dayActivity.selectedIconButton");
         _buttonHbox = ComponentFactory.Instance.creatComponentByStylename("dayGuide.SelectedIconButtonHbox");
         _buttonHbox.addChild(_stagesActivityBtn);
         _buttonHbox.addChild(_dayActivityBtn);
         addToContent(_dailyTabView);
         _buttonHbox.addChild(_stagesActivityBtn);
         _buttonHbox.addChild(_dayActivityBtn);
         addToContent(_buttonHbox);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_stagesActivityBtn);
         _btnGroup.addSelectItem(_dayActivityBtn);
         DayGuideManager.instance.isShowNoActive = true;
         if(DayGuideManager.instance.page >= 0 && DayGuideManager.instance.page < 2)
         {
            _btnGroup.selectIndex = DayGuideManager.instance.page;
         }
         else
         {
            DayGuideManager.instance.page = 0;
            _btnGroup.selectIndex = 0;
         }
         __selectedChangHandler(null);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnGroup.addEventListener("change",__selectedChangHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__selectedChangHandler);
         }
      }
      
      private function __onexpbackclickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("expback");
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_btnGroup.getSelectedItem())
         {
            case _stagesActivityBtn:
               DayGuideManager.instance.page = 0;
               break;
            case _dayActivityBtn:
               DayGuideManager.instance.page = 1;
         }
         _dailyTabView.changePanelView();
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         DayGuideManager.instance.isShowNoActive = false;
         ObjectUtils.disposeObject(_dayActivityBtn);
         _dayActivityBtn = null;
         ObjectUtils.disposeObject(_stagesActivityBtn);
         _stagesActivityBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_buttonHbox);
         _buttonHbox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

