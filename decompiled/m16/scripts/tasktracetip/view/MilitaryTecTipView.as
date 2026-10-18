package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import mvc.controler.BuildingControler;
   import mvc.module.buildings.BuildInfo;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   
   public class MilitaryTecTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function MilitaryTecTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _contentTxt.text = LanguageMgr.GetTranslation("tasktracetip.view.MilitaryTecTipView.content");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.MilitaryTecTipView.text");
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         var _loc2_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(501);
         FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc2_),null,_loc2_);
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
   }
}

