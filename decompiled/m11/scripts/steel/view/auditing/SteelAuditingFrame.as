package steel.view.auditing
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import map.campaign.data.SteelModel;
   import mvc.controler.SteelController;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class SteelAuditingFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _titlebarImg:MutipleImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _apTxt:FilterFrameText;
      
      private var _operationTxt:FilterFrameText;
      
      private var _listBg:Scale9CornerImage;
      
      private var _applyList:SteelApplyPlayerList;
      
      private var _controller:SteelController = FrameControllerManager.instance.steelController;
      
      private var _model:SteelModel = _controller.model;
      
      public function SteelAuditingFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaAuditingFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingDescribeBackground");
         _titlebarImg = ComponentFactory.Instance.creatComponentByStylename("consortia.AuditingTitlebarBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrameNameTextStyle");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrameGradeTextStyle");
         _apTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrameAPTextStyle");
         _operationTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrameOperationTextStyle");
         _listBg = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaListBG2");
         _applyList = ComponentFactory.Instance.creatCustomObject("steel.SteelApplyPlayerList");
         _nameTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaAuditingFrame.nameTxtText");
         _gradeTxt.text = LanguageMgr.GetTranslation("public.grade");
         _apTxt.text = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _operationTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaAuditingFrame.operationTxtText");
         addToContent(_bg);
         addToContent(_listBg);
         addToContent(_titlebarImg);
         addToContent(_nameTxt);
         addToContent(_gradeTxt);
         addToContent(_apTxt);
         addToContent(_operationTxt);
         addToContent(_applyList);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         _controller.sendSteelListUsers();
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

