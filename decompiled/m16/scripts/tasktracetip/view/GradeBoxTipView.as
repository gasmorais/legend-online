package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class GradeBoxTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseItemView;
      
      private var _contentTxt:FilterFrameText;
      
      public function GradeBoxTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _icon = ComponentFactory.Instance.creatCustomObject("taskTraceTips.ItemView");
         _icon.iconBack = iconLoadComplete;
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _contentTxt.text = LanguageMgr.GetTranslation("tasktracetip.view.GradeBoxTipView.tips");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.GradeBoxTipView.text");
         addChild(_icon);
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _textBtn.enable = false;
         _icon.data = param1.goods;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      private function iconLoadComplete(param1:BaseItemView = null) : void
      {
         _textBtn.enable = true;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         super.__btnHandler(param1);
         if(GoodsManager.instance.getGoodsByGoodsIdFromGeneralBag(data.goods.id))
         {
            FrameControllerManager.instance.openControllerByInfo("gradebox",null,data.goods);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("tasktracetip.view.GradeBoxTipView.command01");
            MessageTipManager.instance().show(_loc2_);
         }
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
   }
}

