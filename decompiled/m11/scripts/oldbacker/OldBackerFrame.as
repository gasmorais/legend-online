package oldbacker
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.OldBackerEvents;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.OldBackerManager;
   import mvc.module.oldbacker.OldBackerModel;
   import yishi.datas.ComponentGroupType;
   
   public class OldBackerFrame extends Frame
   {
      
      private var _backImage:Scale9CornerImage;
      
      private var _backMc:ScaleFrameImage;
      
      private var _tabBtn01:SelectedIconButton;
      
      private var _tabBtn02:SelectedIconButton;
      
      private var _tabBtn03:SelectedIconButton;
      
      private var _tabBtn04:SelectedIconButton;
      
      private var _tabBtn05:SelectedIconButton;
      
      private var _tab:SelectedButtonGroup;
      
      private var _currentView:Component;
      
      private var _infoType:Array = [0,1,2,3,4];
      
      public function OldBackerFrame()
      {
         super();
         initView();
         addEvent();
         _tab.selectIndex = 0;
         OldBackerManager.instance.sendInfo(0);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _backImage = ComponentFactory.Instance.creatComponentByStylename("oldbacker.9CornerBg");
         _backMc = ComponentFactory.Instance.creatComponentByStylename("oldbacker.backMc");
         _tabBtn01 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.frameTabBtn01");
         _tabBtn02 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.frameTabBtn02");
         _tabBtn03 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.frameTabBtn03");
         _tabBtn04 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.frameTabBtn05");
         _tabBtn05 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.frameTabBtn06");
         _tab = new SelectedButtonGroup();
         _tab.addSelectItem(_tabBtn01);
         _tab.addSelectItem(_tabBtn02);
         _tab.addSelectItem(_tabBtn03);
         _tab.addSelectItem(_tabBtn04);
         _tab.addSelectItem(_tabBtn05);
         addToContent(_backImage);
         addToContent(_backMc);
         addToContent(_tabBtn01);
         addToContent(_tabBtn02);
         addToContent(_tabBtn03);
         addToContent(_tabBtn04);
         addToContent(_tabBtn05);
         _backMc.setFrame(1);
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(model.viewInfoList.length > 0)
         {
            _tabBtn02.visible = _tabBtn03.visible = _tabBtn04.visible = _tabBtn05.visible = true;
         }
         else
         {
            _tabBtn02.visible = _tabBtn03.visible = _tabBtn04.visible = _tabBtn05.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tab.addEventListener("change",__panelChangeHandler);
         model.addEventListener("REFRESH_VIEW_INFO",__updataInfos);
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
      
      private function __updataInfos(param1:OldBackerEvents) : void
      {
         refreshView();
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         model.currentType = _infoType[_tab.selectIndex];
         if(_tab.selectIndex == 0)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("oldbacker.OldBackerMsgView");
            _backMc.setFrame(1);
         }
         else
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("oldbacker.OldBackerRewardView");
            _backMc.setFrame(2);
         }
         addToContent(_currentView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_tab)
         {
            _tab.removeEventListener("change",__panelChangeHandler);
         }
         model.removeEventListener("REFRESH_VIEW_INFO",__updataInfos);
      }
      
      private function get model() : OldBackerModel
      {
         return OldBackerManager.instance.model;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("oldback.OldBackFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_backImage);
         _backImage = null;
         ObjectUtils.disposeObject(_backMc);
         _backMc = null;
         ObjectUtils.disposeObject(_tabBtn01);
         _tabBtn01 = null;
         ObjectUtils.disposeObject(_tabBtn02);
         _tabBtn02 = null;
         ObjectUtils.disposeObject(_tabBtn03);
         _tabBtn03 = null;
         ObjectUtils.disposeObject(_tabBtn04);
         _tabBtn04 = null;
         ObjectUtils.disposeObject(_tabBtn05);
         _tabBtn05 = null;
         ObjectUtils.disposeObject(_tab);
         _tab = null;
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         super.dispose();
      }
   }
}

