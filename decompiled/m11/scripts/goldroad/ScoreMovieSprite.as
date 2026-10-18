package goldroad
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.GoldRoadEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.GoldRoadManager;
   import mvc.module.goldroad.GoldRoadModel;
   import yishi.manager.ConfigManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.view.tips.MessageTipManager;
   
   public class ScoreMovieSprite extends Sprite implements Disposeable
   {
      
      private var scoreMcContainer:Component;
      
      private var scoreMc:MovieClip;
      
      private var diceAppearMc:MovieClip;
      
      private var dicedisAppearMc:MovieClip;
      
      private var canUseBack:Bitmap;
      
      private var superDiceBtn:TextButton;
      
      private var _superDiceBtnStripView:StripView;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _isAutoSelect:Boolean = false;
      
      public function ScoreMovieSprite()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         scoreMcContainer = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.scoreMcContainer");
         scoreMc = ComponentFactory.Instance.creatCustomObject("goldRoadFrame.scoreMc");
         diceAppearMc = ComponentFactory.Instance.creatCustomObject("goldRoadFrame.diceAppearMc");
         dicedisAppearMc = ComponentFactory.Instance.creatCustomObject("goldRoadFrame.dicedisAppearMc");
         canUseBack = ComponentFactory.Instance.creatBitmap("asset.goldRoadFrame.canUseBack");
         superDiceBtn = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.superDiceBtn");
         _superDiceBtnStripView = ComponentFactory.Instance.creatComponentByStylename("core.tipsStripView");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.scoreTxt");
         scoreMcContainer.addChild(scoreMc);
         addChild(scoreMcContainer);
         addChild(canUseBack);
         addChild(_superDiceBtnStripView);
         addChild(_scoreTxt);
         _superDiceBtnStripView.addChild(superDiceBtn);
         _superDiceBtnStripView.x = superDiceBtn.x;
         _superDiceBtnStripView.y = superDiceBtn.y;
         superDiceBtn.x = 0;
         superDiceBtn.y = 0;
         scoreMcContainer.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.scoreMcTipdata");
         _scoreTxt.text = model.score % 100 + "/100";
         scoreMc.gotoAndStop(model.score % 100);
         superDiceBtn.text = (int(model.score / 100)).toString() + "/10";
         _superDiceBtnStripView.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.superDiceBtnTipdata");
         superDiceBtn.enable = int(model.score / 100) >= 1 ? true : false;
      }
      
      private function addEvent() : void
      {
         GoldRoadManager.instance.addEventListener("GOLDROADRE_FRESH",refreshView);
         superDiceBtn.addEventListener("click",__useScoreHandler);
         StageReferance.stage.addEventListener("click",__checkIsHideSuperMc);
      }
      
      private function removeEvent() : void
      {
         GoldRoadManager.instance.removeEventListener("GOLDROADRE_FRESH",refreshView);
         superDiceBtn.removeEventListener("click",__useScoreHandler);
         StageReferance.stage.removeEventListener("click",__checkIsHideSuperMc);
         removeDiceAppearMcEvent();
      }
      
      private function removeDiceAppearMcEvent() : void
      {
         if(diceAppearMc && diceAppearMc["onePoint"])
         {
            diceAppearMc["onePoint"].removeEventListener("click",__throwDiceHandler);
         }
         if(diceAppearMc && diceAppearMc["twoPoint"])
         {
            diceAppearMc["twoPoint"].removeEventListener("click",__throwDiceHandler);
         }
         if(diceAppearMc && diceAppearMc["threePoint"])
         {
            diceAppearMc["threePoint"].removeEventListener("click",__throwDiceHandler);
         }
         if(diceAppearMc && diceAppearMc["fourPoint"])
         {
            diceAppearMc["fourPoint"].removeEventListener("click",__throwDiceHandler);
         }
         if(diceAppearMc && diceAppearMc["fivePoint"])
         {
            diceAppearMc["fivePoint"].removeEventListener("click",__throwDiceHandler);
         }
         if(diceAppearMc && diceAppearMc["sixPoint"])
         {
            diceAppearMc["sixPoint"].removeEventListener("click",__throwDiceHandler);
         }
      }
      
      private function __checkIsHideSuperMc(param1:MouseEvent) : void
      {
         if(!diceAppearMc || !diceAppearMc.parent)
         {
            return;
         }
         if(param1.target != diceAppearMc)
         {
            playDiceDisAppear();
         }
      }
      
      private function playDiceDisAppear() : void
      {
         ObjectUtils.disposeViolentMc(diceAppearMc);
         removeDiceAppearMcEvent();
         if(dicedisAppearMc && !dicedisAppearMc.parent)
         {
            addChild(dicedisAppearMc);
            dicedisAppearMc.gotoAndPlay(1);
            dicedisAppearMc.addFrameScript(dicedisAppearMc.totalFrames - 1,function():void
            {
               ObjectUtils.disposeViolentMc(dicedisAppearMc);
            });
         }
      }
      
      private function __useScoreHandler(param1:MouseEvent) : void
      {
         if(diceAppearMc.parent)
         {
            playDiceDisAppear();
         }
         else
         {
            addChild(diceAppearMc);
            diceAppearMc.gotoAndPlay(1);
            diceAppearMc.addEventListener("onePointComplete",__diceCanClickHandler);
            diceAppearMc.addEventListener("twoPointComplete",__diceCanClickHandler);
            diceAppearMc.addEventListener("threePointComplete",__diceCanClickHandler);
            diceAppearMc.addEventListener("fourPointComplete",__diceCanClickHandler);
            diceAppearMc.addEventListener("fivePointComplete",__diceCanClickHandler);
            diceAppearMc.addEventListener("sixPointComplete",__diceCanClickHandler);
            param1.stopPropagation();
         }
      }
      
      private function __diceCanClickHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case "onePointComplete":
               if(diceAppearMc && diceAppearMc["onePoint"])
               {
                  diceAppearMc["onePoint"].addEventListener("click",__throwDiceHandler);
               }
               break;
            case "twoPointComplete":
               if(diceAppearMc && diceAppearMc["twoPoint"])
               {
                  diceAppearMc["twoPoint"].addEventListener("click",__throwDiceHandler);
               }
               break;
            case "threePointComplete":
               if(diceAppearMc && diceAppearMc["threePoint"])
               {
                  diceAppearMc["threePoint"].addEventListener("click",__throwDiceHandler);
               }
               break;
            case "fourPointComplete":
               if(diceAppearMc && diceAppearMc["fourPoint"])
               {
                  diceAppearMc["fourPoint"].addEventListener("click",__throwDiceHandler);
               }
               break;
            case "fivePointComplete":
               if(diceAppearMc && diceAppearMc["fivePoint"])
               {
                  diceAppearMc["fivePoint"].addEventListener("click",__throwDiceHandler);
               }
               break;
            case "sixPointComplete":
               if(diceAppearMc && diceAppearMc["sixPoint"])
               {
                  diceAppearMc["sixPoint"].addEventListener("click",__throwDiceHandler);
               }
         }
      }
      
      private function __throwDiceHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         switch(param1.target)
         {
            case diceAppearMc["onePoint"]:
               _loc3_ = 1;
               break;
            case diceAppearMc["twoPoint"]:
               _loc3_ = 2;
               break;
            case diceAppearMc["threePoint"]:
               _loc3_ = 3;
               break;
            case diceAppearMc["fourPoint"]:
               _loc3_ = 4;
               break;
            case diceAppearMc["fivePoint"]:
               _loc3_ = 5;
               break;
            case diceAppearMc["sixPoint"]:
               _loc3_ = 6;
               break;
            default:
               _loc3_ = 1;
         }
         if(GoodsManager.instance.getGoldRoadBagList().getList().length >= 8 * 7)
         {
            _loc2_ = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.diceBagTipData");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.nowDate > ConfigManager.info.GOLDROAD_END_DATE.time)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < model.mutiCount * 10)
         {
            RechargeAlertMannager.show();
            return;
         }
         model.dispatchEvent(new GoldRoadEvent("GOLDROADRE_SUPERDICE",true));
         GoldRoadManager.instance.throwDice(2,_loc3_,false);
         playDiceDisAppear();
         param1.stopPropagation();
      }
      
      public function refreshView(param1:GoldRoadEvent) : void
      {
         if(scoreMc)
         {
            scoreMc.gotoAndStop(model.score % 100);
         }
         superDiceBtn.text = (int(model.score / 100)).toString() + "/10";
         superDiceBtn.enable = int(model.score / 100) >= 1 ? true : false;
         _scoreTxt.text = model.score % 100 + "/100";
         if(scoreMcContainer)
         {
            scoreMcContainer.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.scoreMcTipdata");
         }
      }
      
      private function get model() : GoldRoadModel
      {
         return GoldRoadManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(scoreMc)
         {
            ObjectUtils.disposeViolentMc(scoreMc);
         }
         scoreMc = null;
         if(scoreMcContainer)
         {
            ObjectUtils.disposeObject(scoreMcContainer);
         }
         scoreMcContainer = null;
         if(diceAppearMc)
         {
            ObjectUtils.disposeViolentMc(diceAppearMc);
         }
         diceAppearMc = null;
         if(dicedisAppearMc)
         {
            ObjectUtils.disposeViolentMc(dicedisAppearMc);
         }
         dicedisAppearMc = null;
         if(canUseBack)
         {
            ObjectUtils.disposeObject(canUseBack);
         }
         canUseBack = null;
         if(superDiceBtn)
         {
            ObjectUtils.disposeObject(superDiceBtn);
         }
         superDiceBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

