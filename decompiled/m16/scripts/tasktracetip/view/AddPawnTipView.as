package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import map.campaign.CampaignManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.manager.FrameControllerManager;
   
   public class AddPawnTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function AddPawnTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.AddPawnTipView.txt");
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.htmlText = _data.content;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         if(CampaignManager.instance.mapModel && (CampaignManager.instance.mapModel.mapId == 10001 || CampaignManager.instance.mapModel.mapId == 10002))
         {
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
         else
         {
            FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.RECRUIT_PAWN);
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
   }
}

