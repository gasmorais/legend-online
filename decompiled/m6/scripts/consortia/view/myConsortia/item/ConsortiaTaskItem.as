package consortia.view.myConsortia.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaQuestInfo;
   import mvc.module.consortia.ConsortiaViewHelper;
   import yishi.datas.templates.ConsortiaQuestConditionTempInfo;
   import yishi.datas.templates.ConsortiaQuestTempInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   
   public class ConsortiaTaskItem extends Component
   {
      
      private var _rewardText:FilterFrameText;
      
      private var _conditionText:FilterFrameText;
      
      private var _titleText:FilterFrameText;
      
      private var _hasGetImage:Image;
      
      private var _itemBg:Image;
      
      private var _tobedownBtn:IconButton;
      
      private var _getBtn:IconButton;
      
      private var _tempInfo:ConsortiaQuestTempInfo;
      
      private var conditionTempInfo:ConsortiaQuestConditionTempInfo;
      
      private var questInfo:ConsortiaQuestInfo;
      
      private var viewType:int;
      
      public function ConsortiaTaskItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _rewardText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskItem.rewardText");
         _conditionText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskItem.conditionText");
         _titleText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskItem.titleText");
         _hasGetImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskItem.hasGetImage");
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskItem.itemBg");
         _tobedownBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskItem.tobedownBtn");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskItem.getBtn");
         addChild(_itemBg);
         addChild(_titleText);
         addChild(_conditionText);
         addChild(_rewardText);
         addChild(_hasGetImage);
         addChild(_tobedownBtn);
         addChild(_getBtn);
         _tobedownBtn.enable = false;
      }
      
      private function addEvent() : void
      {
         _getBtn.addEventListener("click",_getBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",_getBtnClickHandler);
         }
      }
      
      private function _getBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ConsortiaSocketOutManager.sendGetQuestReward(tempInfo.TemplateId);
      }
      
      public function get tempInfo() : ConsortiaQuestTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:ConsortiaQuestTempInfo) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:int = 0;
         _tempInfo = param1;
         if(_tempInfo)
         {
            conditionTempInfo = TempleteManager.instance.consortiaQuestConditionTempCate.getTemplateByID(tempInfo.TemplateId);
            if(!conditionTempInfo)
            {
               return;
            }
            questInfo = model.getQuestInfoById(conditionTempInfo.ConditionId);
            _loc3_ = questInfo ? "(" + questInfo.process + "/" + conditionTempInfo.Target + ")" : "(0/" + conditionTempInfo.Target + ")";
            _conditionText.htmlText = LanguageMgr.GetTranslation("ConsortiaTaskItem.conditionText.text",conditionTempInfo.ConditionDetail,_loc3_);
            _loc2_ = ConsortiaViewHelper.instance.getRewardTipString(tempInfo);
            _rewardText.htmlText = LanguageMgr.GetTranslation("ConsortiaTaskItem.rewardText.text",_loc2_);
            _loc4_ = int(model.getRewardState(tempInfo,true));
            if(_loc4_ == 0)
            {
               _hasGetImage.visible = true;
               _tobedownBtn.visible = false;
               _getBtn.visible = false;
            }
            else if(_loc4_ == 2)
            {
               _hasGetImage.visible = false;
               _tobedownBtn.visible = false;
               _getBtn.visible = true;
            }
            else
            {
               _hasGetImage.visible = false;
               _tobedownBtn.visible = true;
               _getBtn.visible = false;
            }
         }
         else
         {
            _titleText.text = "";
            _conditionText.text = "";
            _rewardText.text = "";
            _hasGetImage.visible = false;
            _tobedownBtn.visible = false;
            _getBtn.visible = false;
         }
      }
      
      public function setIndex(param1:int) : void
      {
         if(tempInfo)
         {
            _titleText.text = LanguageMgr.GetTranslation("ConsortiaTaskItem.titleText.text",param1);
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rewardText);
         _rewardText = null;
         ObjectUtils.disposeObject(_conditionText);
         _conditionText = null;
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_hasGetImage);
         _hasGetImage = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_tobedownBtn);
         _tobedownBtn = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         super.dispose();
      }
   }
}

