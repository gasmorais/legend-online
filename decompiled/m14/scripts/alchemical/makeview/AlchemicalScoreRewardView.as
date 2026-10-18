package alchemical.makeview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.alchemical.AlchemicalModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.AlchemicalManager;
   
   public class AlchemicalScoreRewardView extends Component
   {
      
      private var back:ScaleBitmapImage;
      
      private var rewardVBox:VBox;
      
      private var rewardPanel:ScrollPanel;
      
      private var scoreRewardArr:Array;
      
      public function AlchemicalScoreRewardView()
      {
         super();
         scoreRewardArr = ConfigInfoManager.instance.getAlchemicalFullScoreReward();
         initView();
         initRewardView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("AlchemicalScoreRewardView.commonTipBg");
         rewardVBox = ComponentFactory.Instance.creatComponentByStylename("AlchemicalScoreRewardView.vbox");
         rewardPanel = ComponentFactory.Instance.creatComponentByStylename("AlchemicalScoreRewardView.scrollPanel");
         addChild(back);
         addChild(rewardPanel);
         rewardPanel.setView(rewardVBox);
      }
      
      private function initRewardView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:Component = null;
         var _loc3_:FilterFrameText = null;
         var _loc6_:FilterFrameText = null;
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc1_:int = int(model.scoreUpgradeTempArr.length);
         _loc4_ = 0;
         while(_loc4_ <= _loc1_)
         {
            _loc2_ = new Component();
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("AlchemicalScoreRewardView.rewardTitleText");
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("AlchemicalScoreRewardView.rewardDescText");
            if(_loc4_ == _loc1_)
            {
               _loc5_ = model.scoreUpgradeTempArr[_loc4_ - 1];
               _loc3_.htmlText = LanguageMgr.GetTranslation("AlchemicalScoreRewardView.rewardText.titleFull",_loc5_.Data,scoreRewardArr[0],scoreRewardArr[1]);
               _loc3_.height = _loc3_.textHeight + 5;
               _loc6_.text = "";
               _loc6_.x = 0;
            }
            else
            {
               _loc5_ = model.scoreUpgradeTempArr[_loc4_];
               _loc3_.text = LanguageMgr.GetTranslation("AlchemicalScoreRewardView.rewardText.title",_loc5_.Data);
               _loc6_.text = _loc5_.TemplateName;
               _loc6_.x = _loc3_.textWidth + 15;
               _loc6_.height = _loc6_.textHeight + 5;
            }
            _loc2_.addChild(_loc3_);
            _loc2_.addChild(_loc6_);
            rewardVBox.addChild(_loc2_);
            _loc4_++;
         }
         rewardVBox.commitChanges();
         rewardPanel.invalidateViewport();
         rewardPanel.commitChanges();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(rewardVBox);
         rewardVBox = null;
         ObjectUtils.disposeObject(rewardPanel);
         rewardPanel = null;
         super.dispose();
      }
   }
}

