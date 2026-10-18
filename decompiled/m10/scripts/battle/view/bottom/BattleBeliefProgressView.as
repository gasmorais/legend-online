package battle.view.bottom
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   
   public class BattleBeliefProgressView extends Component
   {
      
      private var _progressMc:MovieClip;
      
      private var _beliefContiner:Component;
      
      private var _numberBitmap:Bitmap;
      
      private var beliefMax:int;
      
      private var _preBelief:int = 999;
      
      public function BattleBeliefProgressView()
      {
         super();
         initView();
         addEvent();
         __updateGoddessBeliefHandler(null,null);
      }
      
      private function initView() : void
      {
         _progressMc = ComponentFactory.Instance.creatCustomObject("BattleBeliefProgressView.progressMc");
         _numberBitmap = ComponentFactory.Instance.creatBitmap("asset.BattleBeliefProgressView.numberBitmap");
         _beliefContiner = ComponentFactory.Instance.creatComponentByStylename("BattleBeliefProgressView.beliefContiner");
         addChild(_progressMc);
         addChild(_beliefContiner);
         beliefMax = ConfigInfoManager.instance.getBattleGoddessMaxBelief();
         _progressMc.gotoAndStop(1);
         _progressMc["progress"].gotoAndStop(1);
         _progressMc["fullMc1"].visible = false;
         _progressMc["fullMc2"].visible = false;
         _progressMc["fullMc1"].gotoAndStop(1);
         _progressMc["fullMc2"].gotoAndStop(1);
         NumberViewUtils.getNumberView(0,_beliefContiner,_numberBitmap.bitmapData,13,18,10,13,"0123456789",0);
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("GODDESS_BELIEF_CHANGE",this,__updateGoddessBeliefHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("GODDESS_BELIEF_CHANGE",this,__updateGoddessBeliefHandler);
      }
      
      private function __updateGoddessBeliefHandler(param1:String, param2:Object) : void
      {
         var beliefValue:int;
         var frame:int;
         var msg:String = param1;
         var obj:Object = param2;
         if(!selfInfo.goddessRoleInfo || _preBelief == selfInfo.goddessRoleInfo.belief)
         {
            return;
         }
         beliefValue = int(selfInfo.goddessRoleInfo.belief > beliefMax ? 120 : selfInfo.goddessRoleInfo.belief);
         frame = int(int(beliefValue / 2) > 0 ? int(beliefValue / 2) : 1);
         NumberViewUtils.getNumberView(selfInfo.goddessRoleInfo.belief,_beliefContiner,_numberBitmap.bitmapData,13,18,10,13,"0123456789",0);
         _beliefContiner.x = selfInfo.goddessRoleInfo.belief < 10 ? 85 : 78;
         if(selfInfo.goddessRoleInfo.belief < _preBelief)
         {
            _progressMc["progress"].gotoAndStop(frame);
         }
         else
         {
            _progressMc["progress"].addFrameScript(frame - 1,function():void
            {
               _progressMc["progress"].stop();
               _progressMc["progress"].addFrameScript(frame - 1,null);
            });
            _progressMc.play();
            _progressMc["progress"].play();
         }
         _preBelief = selfInfo.goddessRoleInfo.belief;
         if(selfInfo.goddessRoleInfo.belief >= 100)
         {
            _progressMc["fullMc1"].visible = true;
            _progressMc["fullMc2"].visible = true;
            _progressMc["fullMc1"].gotoAndPlay(1);
            _progressMc["fullMc2"].gotoAndPlay(1);
         }
         else
         {
            _progressMc["fullMc1"].visible = false;
            _progressMc["fullMc2"].visible = false;
            _progressMc["fullMc1"].gotoAndStop(1);
            _progressMc["fullMc2"].gotoAndStop(1);
         }
      }
      
      private function get selfInfo() : HeroRoleInfo
      {
         return BattleManager.getInstance().battleModel.selfHero;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_progressMc);
         _progressMc = null;
         ObjectUtils.disposeObject(_beliefContiner);
         _beliefContiner = null;
         ObjectUtils.disposeObject(_numberBitmap);
         _numberBitmap = null;
         super.dispose();
      }
   }
}

