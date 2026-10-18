package year2023.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class YearActive4UI extends Sprite
   {
      
      protected var _enterItemBg4:MovieClip;
      
      protected var _actBtn4:BaseButton;
      
      protected var _dayInfo4:YearActiveXUI;
      
      private var _stopDate:Date;
      
      private var _resetDates:Array = [];
      
      public function YearActive4UI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         var _loc2_:Array = null;
         var _loc4_:Date = null;
         var _loc6_:int = 0;
         _enterItemBg4 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.enterItemBg4");
         _actBtn4 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.actBtn4");
         _dayInfo4 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayInfo4");
         addChild(_enterItemBg4);
         addChild(_actBtn4);
         addChild(_dayInfo4);
         _dayInfo4.actName = LanguageMgr.GetTranslation("yearactivity.type4");
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("dark_maze_config_time");
         var _loc1_:Array = _loc3_.ConfigValue.split("|");
         var _loc7_:String = _loc1_[2];
         _stopDate = DateFormatter.parse(_loc7_,"YYYY-MM-DD hh:mm:ss");
         var _loc5_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("dark_maze_reset_time");
         if(_loc5_)
         {
            _loc2_ = _loc5_.ConfigValue.split("|");
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               _loc4_ = DateFormatter.parse(_loc2_[_loc6_],"YYYY-MM-DD hh:mm:ss");
               _resetDates.push(_loc4_);
               _loc6_++;
            }
            _resetDates.sortOn("time",16);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function setRemainTime() : void
      {
         var _loc2_:Date = null;
         var _loc1_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:Number = _stopDate.time / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc4_ >= 60)
         {
            _dayInfo4.actStartTime = LanguageMgr.GetTranslation("yearactive.darkmaze.over",DateFormatter.getFullTimeString(_loc4_));
         }
         else if(_loc4_ > 0)
         {
            _dayInfo4.actStartTime = LanguageMgr.GetTranslation("yearactive.darkmaze.over",DateFormatter.getFullDateString(_loc4_));
         }
         else
         {
            _dayInfo4.actStartTime = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
         _dayInfo4.actStopTime = "";
         _loc3_ = 0;
         while(_loc3_ < _resetDates.length)
         {
            _loc2_ = _resetDates[_loc3_];
            _loc1_ = _loc2_.time / 1000 - playerModel.sysCurTimeBySecond;
            if(_loc1_ > 0)
            {
               if(_loc1_ >= 60)
               {
                  _dayInfo4.actStopTime = LanguageMgr.GetTranslation("yearactive.darkmaze.refresh",DateFormatter.getFullTimeString(_loc1_));
               }
               else if(_loc1_ > 0)
               {
                  _dayInfo4.actStopTime = LanguageMgr.GetTranslation("yearactive.darkmaze.refresh",DateFormatter.getFullDateString(_loc1_));
               }
               break;
            }
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         _actBtn4.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _actBtn4.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(DarkMazeManager.instance.model.checkDarkMaze())
         {
            SwitchPageHelp.openDarkMaze();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_enterItemBg4);
         _enterItemBg4 = null;
         ObjectUtils.disposeObject(_actBtn4);
         _actBtn4 = null;
         ObjectUtils.disposeObject(_dayInfo4);
         _dayInfo4 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _stopDate = null;
         _resetDates = null;
      }
   }
}

