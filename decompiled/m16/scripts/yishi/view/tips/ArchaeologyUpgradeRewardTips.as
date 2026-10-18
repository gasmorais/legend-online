package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.archeology.ArchaeologyModel;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.ArchaeologyBookTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.TempleteManager;
   
   public class ArchaeologyUpgradeRewardTips extends BaseTip
   {
      
      private var nextLevelAlertText:FilterFrameText;
      
      private var nextLevelText:FilterFrameText;
      
      private var canGetText:FilterFrameText;
      
      private var appellText:FilterFrameText;
      
      private var mountText:FilterFrameText;
      
      private var appellTemp:AppellInfoTemplate;
      
      private var itemTemp:GoodsTemplateInfo;
      
      private var appellName:String = "";
      
      private var mountName:String = "";
      
      private var nextBookTemp:ArchaeologyBookTemplate;
      
      public function ArchaeologyUpgradeRewardTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         nextLevelAlertText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.nextLevelAlertText");
         nextLevelText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.nextLevelText");
         canGetText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.canGetText");
         appellText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.appellText");
         mountText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.mountText");
         addChild(nextLevelAlertText);
         addChild(nextLevelText);
         addChild(canGetText);
         addChild(appellText);
         addChild(mountText);
         nextLevelAlertText.text = LanguageMgr.GetTranslation("ArchaeologyUpgradeRewardTips.nextLevelAlertText.text");
         canGetText.text = LanguageMgr.GetTranslation("ArchaeologyUpgradeRewardTips.canGetText.text");
         _bg.width = 220;
         _bg.height = 105;
      }
      
      override protected function updateTransform() : void
      {
         cleanData();
         if(_data)
         {
            nextLevelText.text = LanguageMgr.GetTranslation("ArchaeologyFrame.levelText.text" + _data.Collection1);
            appellTemp = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(_data.RewardAppell);
            itemTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.RewardId1);
            if(appellTemp)
            {
               appellName = appellTemp.Title;
            }
            if(itemTemp)
            {
               mountName = itemTemp.TemplateName;
            }
            appellText.htmlText = LanguageMgr.GetTranslation("ArchaeologyUpgradeRewardTips.appellText.text",appellName);
            mountText.htmlText = LanguageMgr.GetTranslation("ArchaeologyUpgradeRewardTips.mountText.text",mountName);
            _bg.width = Math.max(appellText.x + appellText.textWidth + 10,mountText.x + mountText.textWidth + 10);
            _bg.width = Math.max(220,_bg.width);
         }
      }
      
      private function cleanData() : void
      {
         nextLevelText.text = "";
         appellText.text = "";
         mountText.text = "";
         appellTemp = null;
         itemTemp = null;
         appellName = "";
         mountName = "";
      }
      
      private function get model() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(nextLevelAlertText)
         {
            ObjectUtils.disposeObject(nextLevelAlertText);
         }
         nextLevelAlertText = null;
         if(nextLevelText)
         {
            ObjectUtils.disposeObject(nextLevelText);
         }
         nextLevelText = null;
         if(canGetText)
         {
            ObjectUtils.disposeObject(canGetText);
         }
         canGetText = null;
         if(appellText)
         {
            ObjectUtils.disposeObject(appellText);
         }
         appellText = null;
         if(mountText)
         {
            ObjectUtils.disposeObject(mountText);
         }
         mountText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

