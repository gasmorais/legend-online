package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.manager.FrameControllerManager;
   
   public class UseWearyTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function UseWearyTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.UseWearyTipView.content");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.UseWearyTipView.text");
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
         super.__btnHandler(param1);
         FrameControllerManager.instance.armyController.model.currentPage = int(_data.goods.pos / 56) + 1;
         var _loc2_:Frame = FrameControllerManager.instance.armyController.frame;
         if(!_loc2_)
         {
            FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL,back);
         }
         else
         {
            _loc2_["defaultContent"] = ArmyPanelEnum.EQUIP_PANEL;
            _loc2_["equipBag"].showEffectByPos(_data.goods.pos);
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
      }
      
      private function back() : void
      {
         var _loc1_:Frame = FrameControllerManager.instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_["equipBag"].showEffectByPos(_data.goods.pos);
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
      }
   }
}

