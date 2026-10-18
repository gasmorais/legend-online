package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   
   public class PawnCharacteristicsTipView extends TaskTraceTipView
   {
      
      protected var _contentTxt:FilterFrameText;
      
      private var _pawnList:Array;
      
      public function PawnCharacteristicsTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.PawnCharacteristicsTipView.content");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.PawnCharacteristicsTipView.text");
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         super.__btnHandler(param1);
         var _loc3_:Array = ArmyManager.instance.casernPawnList.getList();
         _loc2_ = _loc3_.length - 1;
         while(_loc2_ >= 0)
         {
            if(_loc3_[_loc2_].templateInfo.Level >= 10)
            {
               FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.PAWNUPGRADE,_loc3_[_loc2_]);
               if(FrameControllerManager.instance.armyController.getPawnUpgradeFrame())
               {
                  FrameControllerManager.instance.armyController.getPawnUpgradeFrame()["setApperceiveEffect"]();
               }
               break;
            }
            _loc2_--;
         }
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         isDie = true;
         _contentTxt = null;
         _pawnList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

