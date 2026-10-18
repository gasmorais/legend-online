package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class RegressionTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      public function RegressionTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _icon = ComponentFactory.Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         _icon.icon = ComponentFactory.Instance.creatBitmap("asset.taskTraceTips.RegressionIcon");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _icon.tipStyle = "yishi.view.tips.OneLineTip";
         _icon.tipData = LanguageMgr.GetTranslation("tasktracetip.view.RegressionTipView.IconTipTxt");
         _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.RegressionTipView.content");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.RegressionTipView.text");
         addChild(_icon);
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         super.__btnHandler(param1);
         if(thane.grades < 6)
         {
            _loc2_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.dayGuideBtn.underLevel");
            MessageTipManager.instance().show(_loc2_);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("funny");
         }
         dispose();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

