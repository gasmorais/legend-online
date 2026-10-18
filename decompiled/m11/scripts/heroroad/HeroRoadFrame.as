package heroroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.VersionSwitch;
   
   public class HeroRoadFrame extends Frame implements IManualSize
   {
      
      private var _courseView:HeroRoadCourseView;
      
      private var _achievementView:HeroRoadAchievementView;
      
      private var _btn1:SelectedButton;
      
      private var _btn2:SelectedButton;
      
      private var _group:SelectedButtonGroup;
      
      public function HeroRoadFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,950,615);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadFrame.btn1");
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadFrame.btn2");
         _group = new SelectedButtonGroup();
         addToContent(_btn1);
         _group.addSelectItem(_btn1);
         if(VersionSwitch.ACHIEVEMENT)
         {
            titleText = LanguageMgr.GetTranslation("heroroad.HeroRoadFrame.titleText2");
            addToContent(_btn2);
            _group.addSelectItem(_btn2);
            _group.selectIndex = 1;
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("heroroad.HeroRoadFrame.titleText");
            _group.selectIndex = 0;
         }
         __panelChangeHandler(null);
      }
      
      private function addEvent() : void
      {
         _group.addEventListener("change",__panelChangeHandler);
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         _group.removeEventListener("change",__panelChangeHandler);
         removeEventListener("response",__frameResponse);
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ISelectable = _group.getSelectedItem();
         switch(_loc2_)
         {
            case _btn1:
               initCourseView();
               break;
            case _btn2:
               initAchievementView();
         }
      }
      
      private function initCourseView() : void
      {
         if(_achievementView)
         {
            ObjectUtils.disposeObject(_achievementView);
            _achievementView = null;
         }
         if(_courseView)
         {
            return;
         }
         _courseView = new HeroRoadCourseView();
         addToContent(_courseView);
      }
      
      private function initAchievementView() : void
      {
         if(_courseView)
         {
            ObjectUtils.disposeObject(_courseView);
            _courseView = null;
         }
         if(_achievementView)
         {
            return;
         }
         _achievementView = new HeroRoadAchievementView();
         addToContent(_achievementView);
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
         ObjectUtils.disposeObject(_courseView);
         _courseView = null;
         ObjectUtils.disposeObject(_achievementView);
         _achievementView = null;
         ObjectUtils.disposeObject(_btn1);
         _btn1 = null;
         ObjectUtils.disposeObject(_btn2);
         _btn2 = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         super.dispose();
      }
   }
}

