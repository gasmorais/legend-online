package timevortex
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TimeVortexEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TimeVortexManager;
   import mvc.ModuleFrameInfo;
   import mvc.controler.TimeVortexController;
   import mvc.module.timevortex.TimeVortexModel;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TimeVortexFrame extends Frame implements IManualSize
   {
      
      private var _mapBorder:DisplayObject;
      
      private var _titleImg:ScaleFrameImage;
      
      private var _backImg:Image;
      
      private var _selectedBtn01:SelectedIconButton;
      
      private var _selectedBtn02:SelectedIconButton;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _controller:TimeVortexController = FrameControllerManager.instance.timeVortexController;
      
      private var _currentView:Component;
      
      public function TimeVortexFrame()
      {
         super();
         initView();
         addEvent();
         _tabGroup.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,945,550);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _mapBorder = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexMapView.frameBorder");
         _backImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexFrame.bragonViewBg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexFrame.titleMc");
         _selectedBtn01 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexFrame.SelectedTab01");
         _selectedBtn02 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexFrame.SelectedTab02");
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_selectedBtn01);
         _tabGroup.addSelectItem(_selectedBtn02);
         addToContent(_backImg);
         addToContent(_mapBorder);
         addToContent(_titleImg);
         addToContent(_selectedBtn01);
         addToContent(_selectedBtn02);
         _titleImg.setFrame(1);
         initInfo();
      }
      
      private function initInfo() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         _selectedBtn02.enable = true;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = model.dragonOpenInfo["dragontalker" + (_loc2_ + 1)] == 0 ? false : true;
            if(!_loc1_)
            {
               _selectedBtn02.enable = false;
               return;
            }
            _loc2_ += 1;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_mapBorder);
         _mapBorder = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_backImg);
         _backImg = null;
         ObjectUtils.disposeObject(_selectedBtn01);
         _selectedBtn01 = null;
         ObjectUtils.disposeObject(_selectedBtn02);
         _selectedBtn02 = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tabGroup.addEventListener("change",__panelChangeHandler);
         model.addEventListener("DRAGON_OPEN_INFO",__openInfoHander);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _tabGroup.removeEventListener("change",__panelChangeHandler);
         model.removeEventListener("DRAGON_OPEN_INFO",__openInfoHander);
      }
      
      private function __openInfoHander(param1:TimeVortexEvent) : void
      {
         initInfo();
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         SoundManager.instance.play("022");
         if(_tabGroup.selectIndex == 1)
         {
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               _loc2_ = model.dragonOpenInfo["dragontalker" + (_loc3_ + 1)] == 0 ? false : true;
               if(!_loc2_)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt12"));
                  return;
               }
               _loc3_ += 1;
            }
         }
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         if(_tabGroup.selectIndex == 0)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexFrame.dragonView");
            _backImg.visible = true;
            _titleImg.setFrame(1);
         }
         else if(_tabGroup.selectIndex == 1)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexFrame.areaView");
            _backImg.visible = false;
            _titleImg.setFrame(2);
         }
         addToContentAt(_currentView,1);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _controller.isOpenMainFrame = false;
               dispose();
         }
      }
      
      private function get model() : TimeVortexModel
      {
         return TimeVortexManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         _controller.isOpenMainFrame = true;
         if(param1)
         {
            _tabGroup.selectIndex = int(param1.openType);
         }
      }
      
      override public function dispose() : void
      {
         _controller.closeSecondaryFrame();
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

