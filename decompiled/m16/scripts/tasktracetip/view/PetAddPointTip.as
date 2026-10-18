package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import mvc.module.pet.PetData;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetAddPointTip extends TaskTraceTipView
   {
      
      private var _icon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      public function PetAddPointTip()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _icon = ComponentFactory.Instance.creatCustomObject("taskTraceTips.PetIcon");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt02");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _contentTxt.htmlText = LanguageMgr.GetTranslation("PetAddPointTip.content");
         _textBtn.text = LanguageMgr.GetTranslation("PetAddPointTip.btnTxt");
         addChild(_icon);
         addChild(_contentTxt);
         addChild(_textBtn);
         var _loc1_:PetData = PlayerManager.instance.currentPlayerModel.playerInfo.enterWarPet;
         if(_loc1_)
         {
            _icon.icon = IconFactory.getPetHeadItemIcon(_loc1_.templateId);
            _icon.tipData = _loc1_;
         }
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
         if(!FrameControllerManager.instance.petController.isOpenedFrame)
         {
            FrameControllerManager.instance.openControllerByInfo("pet");
         }
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
   }
}

