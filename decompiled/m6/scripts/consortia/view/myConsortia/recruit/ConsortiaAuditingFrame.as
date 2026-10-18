package consortia.view.myConsortia.recruit
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TitleButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConsortiaManager;
   
   public class ConsortiaAuditingFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _titlebarImg:MutipleImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeBtn:TitleButton;
      
      private var _apBtn:TitleButton;
      
      private var _operationTxt:FilterFrameText;
      
      private var _listBg:Scale9CornerImage;
      
      private var _applyList:ApplyPlayerList;
      
      private var _curSelectBtn:TitleButton;
      
      public function ConsortiaAuditingFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaAuditingFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingDescribeBackground");
         _titlebarImg = ComponentFactory.Instance.creatComponentByStylename("consortia.AuditingTitlebarBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrameNameTextStyle");
         _gradeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrame.gradeBtn");
         _apBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrame.apBtn");
         _operationTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrameOperationTextStyle");
         _listBg = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaListBG2");
         _applyList = ComponentFactory.Instance.creatCustomObject("consortia.ApplyPlayerList");
         addToContent(_bg);
         addToContent(_listBg);
         addToContent(_titlebarImg);
         addToContent(_nameTxt);
         addToContent(_gradeBtn);
         addToContent(_apBtn);
         addToContent(_operationTxt);
         addToContent(_applyList);
         _gradeBtn.buttonMode = true;
         _gradeBtn.addMouseEffect();
         _apBtn.buttonMode = true;
         _apBtn.addMouseEffect();
         _nameTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaAuditingFrame.nameTxtText");
         _gradeBtn.text = LanguageMgr.GetTranslation("public.grade");
         _apBtn.text = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _operationTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaAuditingFrame.operationTxtText");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         ConsortiaManager.instance.model.addEventListener("IS_CONSORTIA_EXIST",__existHandler);
         _gradeBtn.addEventListener("click",__sortSelectedHandler);
         _apBtn.addEventListener("click",__sortSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         ConsortiaManager.instance.model.removeEventListener("IS_CONSORTIA_EXIST",__existHandler);
         _gradeBtn.removeEventListener("click",__sortSelectedHandler);
         _apBtn.removeEventListener("click",__sortSelectedHandler);
      }
      
      private function __sortSelectedHandler(param1:MouseEvent) : void
      {
         var _loc2_:TitleButton = param1.currentTarget as TitleButton;
         _gradeBtn.setFrame = 0;
         _apBtn.setFrame = 0;
         if(_curSelectBtn == _loc2_)
         {
            _loc2_.setFrame = 2;
            _curSelectBtn = null;
            if(_loc2_ == _gradeBtn)
            {
               model.applyConsortiaList.sortOn("grades",16);
            }
            else
            {
               model.applyConsortiaList.sort(model.sortListByGradeUp);
            }
         }
         else
         {
            _loc2_.setFrame = 1;
            _curSelectBtn = _loc2_;
            if(_loc2_ == _gradeBtn)
            {
               model.applyConsortiaList.sortOn("grades",2);
            }
            else
            {
               model.applyConsortiaList.sort(model.sortListByGradeDown);
            }
         }
         _applyList.sortList();
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
      
      private function __existHandler(param1:ConsortiaEvent) : void
      {
         dispose();
      }
      
      private function __onCloseHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __onRecruitHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ConsortiaRecruitFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaRecruitFrame");
         _loc2_.show();
      }
      
      public function show() : void
      {
         ConsortiaManager.instance.isRecruitFrameOpen = true;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ConsortiaManager.instance.isRecruitFrameOpen = false;
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_titlebarImg)
         {
            ObjectUtils.disposeObject(_titlebarImg);
         }
         _titlebarImg = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_operationTxt)
         {
            ObjectUtils.disposeObject(_operationTxt);
         }
         _operationTxt = null;
         if(_listBg)
         {
            ObjectUtils.disposeObject(_listBg);
         }
         _listBg = null;
         if(_gradeBtn)
         {
            ObjectUtils.disposeObject(_gradeBtn);
         }
         _gradeBtn = null;
         if(_apBtn)
         {
            ObjectUtils.disposeObject(_apBtn);
         }
         _apBtn = null;
         if(_applyList)
         {
            ObjectUtils.disposeObject(_applyList);
         }
         _applyList = null;
         super.dispose();
      }
   }
}

