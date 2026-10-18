package godpvpenter.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import managers.TheseusPvpManager;
   import mvc.module.theseuspvp.TheseusPvpModel;
   import mvc.module.theseuspvp.TheseusPvpSeasonInfo;
   import mvc.module.theseuspvp.TheseusPvpUserInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.TheseusPvpTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.TimerUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusPvpEnterItem extends Sprite
   {
      
      public var _theseuspvp:Bitmap;
      
      public var _stepNameTxt:FilterFrameText;
      
      public var _sortNameTxt:FilterFrameText;
      
      public var _stepIdxTxt:FilterFrameText;
      
      public var _sortIdxTxt:FilterFrameText;
      
      public var _timeTxt:FilterFrameText;
      
      private var _title:GradientText;
      
      private var _currTimeDate:Date;
      
      private var _currLanKey:String;
      
      private var _red:Image;
      
      private var isCanEnter:Boolean = true;
      
      public function TheseusPvpEnterItem()
      {
         super();
         initView();
         refreshView();
         initEvent();
      }
      
      private function initView() : void
      {
         _theseuspvp = ComponentFactory.Instance.creatBitmap("asset.godpvpenter.theseuspvp");
         _stepNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.godpvpenter.stepNameTxt");
         _sortNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.godpvpenter.sortNameTxt");
         _stepIdxTxt = ComponentFactory.Instance.creatComponentByStylename("ui.godpvpenter.stepIdxTxt");
         _sortIdxTxt = ComponentFactory.Instance.creatComponentByStylename("ui.godpvpenter.sortIdxTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.godpvpenter.timeTxt");
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.godpvpenter.theseusPT");
         _red = ComponentFactory.Instance.creatComponentByStylename("ui.godpvp.theseuspvpred");
         addChild(_theseuspvp);
         addChild(_stepNameTxt);
         addChild(_sortNameTxt);
         addChild(_stepIdxTxt);
         addChild(_sortIdxTxt);
         addChild(_timeTxt);
         addChild(_title);
         addChild(_red);
         _title.text = LanguageMgr.GetTranslation("theseuspvp.title");
         _stepNameTxt.text = LanguageMgr.GetTranslation("pvp.stepTitle");
         this.buttonMode = true;
         _red.visible = false;
      }
      
      private function refreshView(param1:int = -1) : void
      {
         var _loc3_:TheseusPvpUserInfo = null;
         var _loc4_:TheseusPvpTempInfo = null;
         TimerUtils.removeSecendTimer("TIME");
         TimerUtils.addSecendTimer("TIME",1,99999,setRemainTime);
         var _loc2_:int = int(TempleteManager.instance.royaltyTempCate.getPvpLv(1));
         if(RoyaltyBossManager.instance.model.royaltyLevel < _loc2_)
         {
            return;
         }
         var _loc6_:TheseusPvpSeasonInfo = model.seasonTimeInfo;
         var _loc5_:Date = DateFormatter.parse(_loc6_.startDate,"YYYY-MM-DD hh:mm:ss");
         if(_loc5_.time / 1000 - playerModel.sysCurTimeBySecond > 0)
         {
            _currLanKey = "theseuspvp.nextTime";
            _currTimeDate = _loc5_;
            _stepIdxTxt.text = "";
            _sortIdxTxt.text = "";
            _red.visible = false;
         }
         else
         {
            _currLanKey = "theseuspvp.timeEnd";
            _currTimeDate = DateFormatter.parse(_loc6_.closeDate,"YYYY-MM-DD hh:mm:ss");
            _loc3_ = model.selfUserInfo;
            _loc4_ = TempleteManager.instance.theseusPvpTempCate.getTempById(_loc3_.pvpId);
            if(_loc4_)
            {
               _stepIdxTxt.text = _loc4_.Name;
            }
            _red.visible = _loc3_.redReport || Boolean(_loc3_.redReward);
         }
         setRemainTime(param1);
      }
      
      private function get model() : TheseusPvpModel
      {
         return TheseusPvpManager.Instance.model;
      }
      
      public function setRemainTime(param1:int = -1) : void
      {
         if(_currTimeDate == null)
         {
            return;
         }
         var _loc2_:Number = _currTimeDate.time / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc2_ >= 60)
         {
            _timeTxt.htmlText = LanguageMgr.GetTranslation(_currLanKey,DateFormatter.getFullTimeString(_loc2_));
         }
         else if(_loc2_ > 0)
         {
            _timeTxt.htmlText = LanguageMgr.GetTranslation(_currLanKey,DateFormatter.getFullDateString(_loc2_));
         }
         else
         {
            _timeTxt.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
            if(param1 == -1)
            {
               refreshView(99999);
            }
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",clickHandler);
         NotificationManager.instance.addEventListener("thesepvpUpdateEnterTime",updateHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",clickHandler);
         NotificationManager.instance.removeEventListener("thesepvpUpdateEnterTime",updateHandler);
         TimerUtils.removeSecendTimer("TIME");
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(DragonTalkerManager.instance.model.isDragonTalker)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuspvp.enter.dragonTip"));
            return;
         }
         var _loc2_:int = int(TempleteManager.instance.royaltyTempCate.getPvpLv(1));
         if(RoyaltyBossManager.instance.model.royaltyLevel < _loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poseidon.shop.openLv",_loc2_));
            return;
         }
         if(_currLanKey == "theseuspvp.nextTime")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuspvp.inCounting"));
            return;
         }
         TheseusPvpManager.Instance.doSomething(1);
         SceneManager.instance.setScene("THESE_PVP_SCENE");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_theseuspvp);
         _theseuspvp = null;
         ObjectUtils.disposeObject(_stepNameTxt);
         _stepNameTxt = null;
         ObjectUtils.disposeObject(_sortNameTxt);
         _sortNameTxt = null;
         ObjectUtils.disposeObject(_stepIdxTxt);
         _stepIdxTxt = null;
         ObjectUtils.disposeObject(_sortIdxTxt);
         _sortIdxTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

