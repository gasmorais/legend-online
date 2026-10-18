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
   
   public class FateGuardTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function FateGuardTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _textBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.skipNow");
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _textBtn.enable = true;
         _contentTxt.width = 120;
         _contentTxt.text = param1.content;
         _contentTxt.x = 44;
         _contentTxt.y = 52;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         var _loc2_:Frame = FrameControllerManager.instance.armyController.frame;
         if(!_loc2_)
         {
            FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL,back);
         }
         else
         {
            _loc2_["defaultContent"] = ArmyPanelEnum.EQUIP_PANEL;
            _loc2_["playFirstOpen"]();
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
      }
      
      private function back() : void
      {
         var _loc1_:Frame = FrameControllerManager.instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_["playFirstOpen"]();
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
      }
   }
}

