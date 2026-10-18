package map.campaign.view.ui.emedream
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ConsortiaManager;
   
   public class EmeDreamTaskItem extends Component
   {
      
      private var _taskIcon:ScaleFrameImage;
      
      private var _titleText:FilterFrameText;
      
      private var _conditionText:FilterFrameText;
      
      private var _type:int;
      
      private var currentProcess:int;
      
      private var maxProcess:int;
      
      private var skillId:int;
      
      private var skillTemp:SkillTempInfo;
      
      public function EmeDreamTaskItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _taskIcon = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossTaskItem.ItemTitleIcon");
         _titleText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossTaskItem.ItemTitleTxt");
         _conditionText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossTaskItem.ItemDescribeTxt");
         addChild(_taskIcon);
         addChild(_titleText);
      }
      
      public function refreshView() : void
      {
         if(_conditionText && _conditionText.parent)
         {
            _conditionText.parent.removeChild(_conditionText);
         }
         if(model.emeDreamInfo.taskProcessArr)
         {
            currentProcess = model.emeDreamInfo.taskProcessArr[_type];
         }
         if(model.emeDreamInfo.taskMaxProcessArr)
         {
            maxProcess = model.emeDreamInfo.taskMaxProcessArr[_type];
         }
         if(model.emeDreamInfo.taskSkillIdProcessArr)
         {
            skillId = model.emeDreamInfo.taskSkillIdProcessArr[_type];
         }
         this.tipData = LanguageMgr.GetTranslation("ConsortiaEmeDream.ConsortiaEmeDreamTaskItem.rewardTips" + _type);
         if(currentProcess >= maxProcess)
         {
            _taskIcon.setFrame(2);
            _titleText.setFrame(2);
            _titleText.text = LanguageMgr.GetTranslation("ConsortiaEmeDream.ConsortiaEmeDreamTaskItem.ItemTitleTxt" + _type) + LanguageMgr.GetTranslation("ConsortiaEmeDream.ConsortiaEmeDreamTaskItem.completeText");
         }
         else
         {
            _taskIcon.setFrame(1);
            _titleText.setFrame(1);
            addChild(_conditionText);
            _titleText.text = LanguageMgr.GetTranslation("ConsortiaEmeDream.ConsortiaEmeDreamTaskItem.ItemTitleTxt" + _type);
            _conditionText.text = LanguageMgr.GetTranslation("ConsortiaEmeDream.ConsortiaEmeDreamTaskItem.ItemDescribeTxt" + _type,currentProcess,maxProcess);
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(_taskIcon)
         {
            ObjectUtils.disposeObject(_taskIcon);
         }
         _taskIcon = null;
         if(_titleText)
         {
            ObjectUtils.disposeObject(_titleText);
         }
         _titleText = null;
         if(_conditionText)
         {
            ObjectUtils.disposeObject(_conditionText);
         }
         _conditionText = null;
         super.dispose();
      }
   }
}

