package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonSoulTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      public function DragonSoulTipView()
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
         _textBtn.width = 140;
         _textBtn.x = 40;
         _icon.tipStyle = "yishi.view.tips.OneLineTip";
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.DragonSoulTipView.btnText");
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
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         dispose();
         var _loc2_:String = checkLimit;
         if(_loc2_)
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.DRAGON_SOUL_PANEL);
      }
      
      private function get checkLimit() : String
      {
         if(MopupManager.instance.model.isMopup)
         {
            return LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
         }
         return null;
      }
   }
}

