package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import farm.FarmManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import ui.maintoolbar.MainToolBar;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryTreeTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      public function MarryTreeTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _icon = ComponentFactory.Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         _icon.icon = IconFactory.getMarryTreeIcon();
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _icon.tipStyle = "yishi.view.tips.OneLineTip";
         _icon.tipData = LanguageMgr.GetTranslation("tasktracetip.view.MarryTreeTipView.iconTip");
         _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.MarryTreeTipView.contentTxt");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.CanPickTipView.text");
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
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FarmManager.instance.model.preMapId > 0)
         {
            MainToolBar.instance.returnFromHookRoom();
            FarmManager.instance.model.preMapId = 0;
         }
         FrameControllerManager.instance.openControllerByInfo("farm","HOME_NEW_FRAME",2);
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
   }
}

