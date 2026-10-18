package consortia.view.myConsortia.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaQuestInfo;
   import mvc.module.consortia.ConsortiaViewHelper;
   import yishi.datas.templates.ConsortiaQuestConditionTempInfo;
   import yishi.datas.templates.ConsortiaQuestTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   
   public class ConsortiaActiveRewardItem extends Component
   {
      
      private var _rewardImage:ScaleFrameImage;
      
      private var _activeText:FilterFrameText;
      
      private var _lightImage:Bitmap;
      
      private var _hasGetImage:Bitmap;
      
      private var _tempInfo:ConsortiaQuestTempInfo;
      
      private var conditionTempInfo:ConsortiaQuestConditionTempInfo;
      
      private var questInfo:ConsortiaQuestInfo;
      
      private var viewType:int;
      
      public function ConsortiaActiveRewardItem(param1:int)
      {
         super();
         viewType = param1;
         initView();
      }
      
      private function initView() : void
      {
         _rewardImage = ComponentFactory.Instance.creatComponentByStylename("ConsortiaActiveRewardItem.rewardImage");
         _activeText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaActiveRewardItem.activeText");
         _lightImage = ComponentFactory.Instance.creatBitmap("asset.ConsortiaActiveRewardItem.lightImage");
         _hasGetImage = ComponentFactory.Instance.creatBitmap("asset.ConsortiaActiveRewardItem.hasGetImage");
         addChild(_rewardImage);
         addChild(_lightImage);
         addChild(_hasGetImage);
         addChild(_activeText);
         _rewardImage.setFrame(viewType);
      }
      
      public function get tempInfo() : ConsortiaQuestTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:ConsortiaQuestTempInfo) : void
      {
         var _loc2_:int = 0;
         _tempInfo = param1;
         if(_tempInfo)
         {
            conditionTempInfo = TempleteManager.instance.consortiaQuestConditionTempCate.getTemplateByID(tempInfo.TemplateId);
            if(!conditionTempInfo)
            {
               return;
            }
            _loc2_ = int(model.getRewardState(tempInfo,false));
            if(_loc2_ == 0)
            {
               _lightImage.visible = true;
               _hasGetImage.visible = true;
               this.filters = [];
            }
            else
            {
               _lightImage.visible = false;
               _hasGetImage.visible = false;
               this.filters = [UIFilter.getGrayFilter()];
            }
            if(viewType == 2)
            {
               _activeText.htmlText = conditionTempInfo.Target + "";
            }
            else
            {
               _activeText.htmlText = LanguageMgr.GetTranslation("consortiaActiveRewardItem.activeText.text",conditionTempInfo.Param1,conditionTempInfo.Target);
            }
            this.tipData = ConsortiaViewHelper.instance.getRewardTipString(tempInfo);
         }
         else
         {
            _lightImage.visible = false;
            _hasGetImage.visible = false;
            this.filters = [UIFilter.getGrayFilter()];
            this.tipData = null;
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rewardImage);
         _rewardImage = null;
         ObjectUtils.disposeObject(_activeText);
         _activeText = null;
         ObjectUtils.disposeObject(_lightImage);
         _lightImage = null;
         ObjectUtils.disposeObject(_hasGetImage);
         _hasGetImage = null;
         super.dispose();
      }
   }
}

