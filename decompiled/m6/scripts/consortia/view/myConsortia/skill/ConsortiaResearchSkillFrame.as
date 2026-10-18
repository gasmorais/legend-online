package consortia.view.myConsortia.skill
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaResearchSkillFrame extends Frame implements IManualSize
   {
      
      private var _bg1:ScaleBitmapImage;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _tipTxt:FilterFrameText;
      
      private var _studyBtn:IconButton;
      
      private var _researchSkillVBox:VBox;
      
      private var _skillPanel:ScrollPanel;
      
      private var _data:ConsortiaModel;
      
      public function ConsortiaResearchSkillFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,573,390);
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.consortiaController.model;
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("consortia.ResearchSkillFrameDescribeBackground1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("consortia.ResearchSkillFrameDescribeBackground2");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ResearchSkillTipsTextStyle");
         _studyBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ResearchFrameStudySkillBtn");
         _researchSkillVBox = ComponentFactory.Instance.creatComponentByStylename("consortia.ResearchSkillvbox");
         _skillPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.ResearchSkillScrollPanel");
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaResearchSkillFrame.title",_data.consortiaInfo.schoolLevel);
         addToContent(_bg1);
         addToContent(_bg2);
         _tipTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaResearchSkillFrame.tip");
         addToContent(_tipTxt);
         addToContent(_studyBtn);
         addToContent(_skillPanel);
         _skillPanel.setView(_researchSkillVBox);
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.consortiaController.getShowSkills();
      }
      
      private function setResearchSkill() : void
      {
         var _loc4_:int = 0;
         var _loc2_:ConsortiaResearchSkillItem = null;
         _skillPanel.beginChanges();
         var _loc1_:Array = _data.baseSkillList.getList().sortOn("type",16);
         var _loc3_:int = int(_loc1_.length > 4 ? _loc1_.length : 4);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new ConsortiaResearchSkillItem();
            if(_loc4_ < _loc1_.length)
            {
               _loc2_.data = _loc1_[_loc4_];
            }
            _researchSkillVBox.addChild(_loc2_);
            _loc4_++;
         }
         _skillPanel.commitChanges();
         _skillPanel.invalidateViewport();
      }
      
      private function uninit() : void
      {
         _data = null;
         if(_bg1)
         {
            _bg1.dispose();
         }
         _bg1 = null;
         if(_bg2)
         {
            _bg2.dispose();
         }
         _bg2 = null;
         if(_tipTxt)
         {
            _tipTxt.dispose();
         }
         _tipTxt = null;
         if(_studyBtn)
         {
            _studyBtn.dispose();
         }
         _studyBtn = null;
         if(_researchSkillVBox)
         {
            _researchSkillVBox.dispose();
         }
         _researchSkillVBox = null;
         if(_skillPanel)
         {
            _skillPanel.dispose();
         }
         _skillPanel = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("UPDA_CONSORTIA_SKILL_LIST",__onSkillListUpdata);
         _studyBtn.addEventListener("click",__onStudyBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_data)
         {
            _data.removeEventListener("UPDA_CONSORTIA_SKILL_LIST",__onSkillListUpdata);
         }
         if(_studyBtn)
         {
            _studyBtn.removeEventListener("click",__onStudyBtnClickHandler);
         }
      }
      
      private function __onSkillListUpdata(param1:ConsortiaEvent) : void
      {
         setResearchSkill();
      }
      
      private function __onStudyBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.showSkillFrame(2);
         dispose();
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
      
      public function show(param1:Boolean = false) : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

