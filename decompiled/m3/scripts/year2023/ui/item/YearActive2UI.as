package year2023.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.YearActiveManager;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.event.StarareaEvent;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class YearActive2UI extends Sprite
   {
      
      protected var _enterItemBg2:MovieClip;
      
      protected var _actBtn2:BaseButton;
      
      protected var _dayInfo2:YearActiveXUI;
      
      protected var _enterGet2:BaseButton;
      
      protected var _enter2NumTxt:FilterFrameText;
      
      protected var _day2gold:Image;
      
      protected var _hasGetFlg:Bitmap;
      
      private var _openDate:Date;
      
      private var _stopDate:Date;
      
      public function YearActive2UI()
      {
         super();
         initView();
         initEvent();
         updateView();
      }
      
      protected function initView() : void
      {
         _enterItemBg2 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.enterItemBg2");
         _actBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.actBtn2");
         _dayInfo2 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayInfo2");
         _enterGet2 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.enterGet2");
         _enter2NumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.enter2NumTxt");
         _day2gold = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.day2gold");
         _hasGetFlg = ComponentFactory.Instance.creatBitmap("asset.yearactive.hasGetFlg");
         addChild(_enterItemBg2);
         addChild(_actBtn2);
         addChild(_dayInfo2);
         addChild(_hasGetFlg);
         addChild(_enterGet2);
         addChild(_enter2NumTxt);
         addChild(_day2gold);
         _hasGetFlg.visible = false;
         _enter2NumTxt.text = "" + TempleteManager.instance.getConfigValue("year_game_score");
         _dayInfo2.actName = LanguageMgr.GetTranslation("yearactivity.type2");
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("year_game_time");
         var _loc1_:Array = _loc2_.ConfigValue.split("|");
         var _loc4_:String = _loc1_[0];
         var _loc3_:String = _loc1_[1];
         _openDate = DateFormatter.parse(_loc4_,"YYYY-MM-DD hh:mm:ss");
         _stopDate = DateFormatter.parse(_loc3_,"YYYY-MM-DD hh:mm:ss");
      }
      
      public function updateView() : void
      {
         if(YearActiveManager.ins.isGamePassed && YearActiveManager.ins.model.miniGameState == 0)
         {
            _enterGet2.visible = true;
            _enterGet2.enable = true;
         }
         else
         {
            if(YearActiveManager.ins.model.miniGameState > 0)
            {
               _hasGetFlg.visible = true;
               _enterGet2.visible = false;
            }
            else
            {
               _hasGetFlg.visible = false;
               _enterGet2.visible = true;
            }
            _enterGet2.enable = false;
         }
      }
      
      private function initEvent() : void
      {
         _actBtn2.addEventListener("click",clickHandler);
         _enterGet2.addEventListener("click",getHandler);
         StarareaManager.instance.addEventListener("GAME_PASS",miniGamePass);
      }
      
      private function removeEvent() : void
      {
         _actBtn2.removeEventListener("click",clickHandler);
         _enterGet2.removeEventListener("click",getHandler);
         StarareaManager.instance.removeEventListener("GAME_PASS",miniGamePass);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function setRemainTime() : void
      {
         var _loc1_:Number = _stopDate.time / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc1_ >= 60)
         {
            _dayInfo2.actStartTime = LanguageMgr.GetTranslation("yearactive.darkmaze.over",DateFormatter.getFullTimeString(_loc1_));
         }
         else if(_loc1_ > 0)
         {
            _dayInfo2.actStartTime = LanguageMgr.GetTranslation("yearactive.darkmaze.over",DateFormatter.getFullDateString(_loc1_));
         }
         else
         {
            _dayInfo2.actStartTime = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         StarareaManager.instance.model.gameRoadId = -1;
         StarareaManager.instance.startMiniGame();
      }
      
      private function getHandler(param1:MouseEvent) : void
      {
         YearActiveManager.ins.doSomething(6);
      }
      
      private function miniGamePass(param1:StarareaEvent) : void
      {
         if(YearActiveManager.ins.isGamePassed)
         {
            return;
         }
         YearActiveManager.ins.isGamePassed = true;
         if(YearActiveManager.ins.model.miniGameState == 0)
         {
            _enterGet2.enable = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_enterItemBg2);
         _enterItemBg2 = null;
         ObjectUtils.disposeObject(_actBtn2);
         _actBtn2 = null;
         ObjectUtils.disposeObject(_dayInfo2);
         _dayInfo2 = null;
         ObjectUtils.disposeObject(_enterGet2);
         _enterGet2 = null;
         ObjectUtils.disposeObject(_enter2NumTxt);
         _enter2NumTxt = null;
         ObjectUtils.disposeObject(_day2gold);
         _day2gold = null;
         ObjectUtils.disposeObject(_hasGetFlg);
         _hasGetFlg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _openDate = null;
         _stopDate = null;
      }
   }
}

