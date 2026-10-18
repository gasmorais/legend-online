package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import flash.text.TextField;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import managers.MopupManager;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class SecretTreeTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      public function SecretTreeTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _icon = ComponentFactory.Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _icon.tipStyle = "yishi.view.tips.OneLineTip";
         addChild(_icon);
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         if(_data)
         {
            _icon.icon = ComponentFactory.Instance.creatBitmap(_data.icon);
            _icon.tipData = _data.name;
            _contentTxt.htmlText = _data.content;
            _textBtn.text = _data.btnTxt;
         }
         if(_textBtn)
         {
            if((_textBtn.textField as TextField).textWidth > 92)
            {
               (_textBtn.textField as TextField).width = (_textBtn.textField as TextField).textWidth + 3;
               _textBtn.width = (_textBtn.textField as TextField).width + 30;
               (_textBtn.textField as TextField).x = 15;
               _textBtn.x = (214 - _textBtn.width) * 0.5;
            }
         }
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         var _loc2_:String = checkLimit;
         if(_loc2_ != "")
         {
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         if(checkScene())
         {
            ConsortiaSocketOutManager.sendEnterSecretLand();
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
      }
      
      private function get checkLimit() : String
      {
         if(MopupManager.instance.model.isMopup)
         {
            return LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
         }
         return WorldBossHelper.getCampaignTips();
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:String = WorldBossHelper.getCampaignTips();
         if(StringHelper.isNullOrEmpty(_loc1_))
         {
            return true;
         }
         MessageTipManager.instance().show(_loc1_);
         return false;
      }
   }
}

