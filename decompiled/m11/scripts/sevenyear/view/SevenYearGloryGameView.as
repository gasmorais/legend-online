package sevenyear.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import managers.GloryGameManager;
   import sevenyear.view.gloryGame.SevenYearGloryGameForecastView;
   import sevenyear.view.gloryGame.SevenYearGloryGameScheduleView;
   import sevenyear.view.gloryGame.SevenYearGloryGameSignView;
   import yishi.view.base.TabPageUtil;
   
   public class SevenYearGloryGameView extends Component
   {
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _btnSign:SelectedIconButton;
      
      private var _btnSchedule:SelectedIconButton;
      
      private var _btnForecast:SelectedIconButton;
      
      private var _hboxBtn:HBox;
      
      public function SevenYearGloryGameView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _btnSign = ComponentFactory.Instance.creatComponentByStylename("SevenYear.gloryGame.signBtn");
         _btnSchedule = ComponentFactory.Instance.creatComponentByStylename("SevenYear.gloryGame.scheduleBtn");
         _btnForecast = ComponentFactory.Instance.creatComponentByStylename("SevenYear.gloryGame.forecastBtn");
         _hboxBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYear.gloryGame.hbox");
         _hboxBtn.addChild(_btnSign);
         _hboxBtn.addChild(_btnSchedule);
         _hboxBtn.addChild(_btnForecast);
         addChild(_hboxBtn);
         _tabPageUtil = new TabPageUtil();
         _tabPageUtil.addItemPage(_btnSign,createSignPage);
         _tabPageUtil.addItemPage(_btnSchedule,createSchedulePage);
         _tabPageUtil.addItemPage(_btnForecast,createForecastPage);
         if(GloryGameManager.instance.model.isJumpToBet)
         {
            _tabPageUtil.selectIndex = 2;
            GloryGameManager.instance.model.isJumpToBet = false;
         }
         else if(GloryGameManager.instance.model.isJumpToSchedule)
         {
            _tabPageUtil.selectIndex = 1;
            GloryGameManager.instance.model.isJumpToSchedule = false;
         }
         else
         {
            _tabPageUtil.selectIndex = 0;
         }
      }
      
      private function createForecastPage() : SevenYearGloryGameForecastView
      {
         var _loc1_:SevenYearGloryGameForecastView = ComponentFactory.Instance.creatCustomObject("SevenYearGloryGameForecastView");
         addChild(_loc1_);
         addChild(_hboxBtn);
         return _loc1_;
      }
      
      private function createSchedulePage() : SevenYearGloryGameScheduleView
      {
         var _loc1_:SevenYearGloryGameScheduleView = ComponentFactory.Instance.creatCustomObject("SevenYearGloryGameScheduleView");
         addChild(_loc1_);
         addChild(_hboxBtn);
         return _loc1_;
      }
      
      private function createSignPage() : SevenYearGloryGameSignView
      {
         var _loc1_:SevenYearGloryGameSignView = ComponentFactory.Instance.creatCustomObject("SevenYearGloryGameSignView");
         addChild(_loc1_);
         addChild(_hboxBtn);
         return _loc1_;
      }
      
      public function refreshView() : void
      {
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeSelf(_btnSign);
         _btnSign = null;
         ObjectUtils.disposeSelf(_btnSchedule);
         _btnSchedule = null;
         ObjectUtils.disposeSelf(_btnForecast);
         _btnForecast = null;
         ObjectUtils.disposeSelf(_hboxBtn);
         _hboxBtn = null;
         ObjectUtils.disposeSelf(_tabPageUtil);
         _tabPageUtil = null;
         super.dispose();
      }
   }
}

