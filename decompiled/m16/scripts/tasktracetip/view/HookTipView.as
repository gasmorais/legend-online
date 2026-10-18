package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.HookRewardFrame;
   
   public class HookTipView extends TaskTraceTipView
   {
      
      private var _offLineTime:FilterFrameText;
      
      private var _totalExp:FilterFrameText;
      
      public function HookTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _offLineTime = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.HookOffLineTime");
         _totalExp = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.HookTotalExt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.HookTipView.text");
         addChild(_offLineTime);
         addChild(_totalExp);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _offLineTime.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.HookTipView.offLine",int(model.hookTime / 3600),int(model.hookTime % 3600 / 60));
         _totalExp.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.HookTipView.totalExp",model.hookGp);
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         var _loc2_:HookRewardFrame = ComponentFactory.Instance.creatComponentByStylename("core.HookRewardFrame");
         _loc2_.show();
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      private function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

