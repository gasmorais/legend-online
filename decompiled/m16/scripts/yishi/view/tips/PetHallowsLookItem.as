package yishi.view.tips
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import yishi.datas.templates.PetHallowsTemplateInfo;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.TempleteManager;
   
   public class PetHallowsLookItem extends Component implements IManualSize
   {
      
      private var nameText:FilterFrameText;
      
      private var gradeText:FilterFrameText;
      
      private var fightText:FilterFrameText;
      
      private var _type:int;
      
      private var _data:PetHallowsInfo;
      
      public function PetHallowsLookItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         nameText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLookItem.nameText");
         gradeText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLookItem.gradeText");
         fightText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLookItem.fightText");
         addChild(nameText);
         addChild(gradeText);
         addChild(fightText);
         nameText.text = petHallowsTempInfoGrade.TemplateName;
         nameText.y = 5 - (nameText.numLines - 1) * 7;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,220,30);
      }
      
      public function set data(param1:PetHallowsInfo) : void
      {
         var _loc2_:PetHallowsTemplateInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = TempleteManager.instance.petHallowsTemplateCate.getTemplateById(_data.hallowTempId);
            if(!_loc2_)
            {
               return;
            }
            gradeText.text = LanguageMgr.GetTranslation("public.level2",_loc2_.Grades);
            fightText.text = _data.lookFightPower + "";
            gradeText.setFrame(1);
            fightText.setFrame(1);
         }
         else
         {
            gradeText.text = LanguageMgr.GetTranslation("faterotary.LevelMin");
            fightText.text = LanguageMgr.GetTranslation("groupfb.GroupfbTeamItem.wait");
            gradeText.setFrame(2);
            fightText.setFrame(2);
         }
      }
      
      private function get petHallowsModel() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      private function get petHallowsTempInfoGrade() : PetHallowsTemplateInfo
      {
         return petHallowsModel.getHallowsTempInfoByTypeAndGrade(_type,1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         ObjectUtils.disposeObject(fightText);
         fightText = null;
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         super.dispose();
      }
   }
}

