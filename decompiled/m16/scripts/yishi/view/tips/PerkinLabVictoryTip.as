package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class PerkinLabVictoryTip extends BaseTip
   {
      
      private var descText:FilterFrameText;
      
      private var line1:ScaleBitmapImage;
      
      private var victoryCountText:FilterFrameText;
      
      private var rewardAlertText:FilterFrameText;
      
      private var rewardText:FilterFrameText;
      
      private var rewardItem:BaseItemView;
      
      public function PerkinLabVictoryTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         descText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabVictoryTip.descText");
         line1 = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         victoryCountText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabVictoryTip.victoryCountText");
         rewardAlertText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabVictoryTip.rewardAlertText");
         rewardText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabVictoryTip.rewardText");
         rewardItem = ComponentFactory.Instance.creatCustomObject("tips.BaseItemView");
         addChild(descText);
         addChild(line1);
         addChild(victoryCountText);
         addChild(rewardAlertText);
         addChild(rewardItem);
         addChild(rewardText);
         line1.width = 180;
         rewardItem.x = 75;
         rewardItem.y = 100;
         descText.text = LanguageMgr.GetTranslation("PerkinLabVictoryTip.descText.text");
         line1.y = descText.y + descText.textHeight + 5;
         victoryCountText.y = line1.y + 5;
         _bg.width = 200;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc2_:GoodsInfo = null;
         rewardItem.visible = false;
         rewardText.visible = false;
         if(_data)
         {
            victoryCountText.text = LanguageMgr.GetTranslation("PerkinLabVictoryTip.victoryCountText.text",_data.victoryCount);
            rewardAlertText.y = victoryCountText.y + victoryCountText.textHeight + 5;
            if(_data.victoryCount <= 0)
            {
               rewardAlertText.text = LanguageMgr.GetTranslation("PerkinLabVictoryTip.rewardAlertText.text1");
               _bg.height = rewardAlertText.y + rewardAlertText.textHeight + 5;
            }
            else
            {
               rewardItem.visible = true;
               rewardText.visible = true;
               rewardAlertText.text = LanguageMgr.GetTranslation("PerkinLabVictoryTip.rewardAlertText.text2");
               _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.tempId);
               if(_loc1_)
               {
                  rewardText.text = _loc1_.TemplateName + "×" + _data.count;
               }
               _loc2_ = new GoodsInfo();
               _loc2_.templateId = _data.tempId;
               rewardItem.data = _loc2_;
               rewardItem.y = rewardAlertText.y + rewardAlertText.textHeight + 5;
               rewardText.y = rewardItem.y + 50;
               _bg.height = rewardText.y + rewardText.textHeight + 5;
            }
         }
      }
      
      override public function dispose() : void
      {
         if(line1)
         {
            ObjectUtils.disposeObject(line1);
         }
         line1 = null;
         if(descText)
         {
            ObjectUtils.disposeObject(descText);
         }
         descText = null;
         if(rewardAlertText)
         {
            ObjectUtils.disposeObject(rewardAlertText);
         }
         rewardAlertText = null;
         if(rewardText)
         {
            ObjectUtils.disposeObject(rewardText);
         }
         rewardText = null;
         if(rewardItem)
         {
            ObjectUtils.disposeObject(rewardItem);
         }
         rewardItem = null;
         if(victoryCountText)
         {
            ObjectUtils.disposeObject(victoryCountText);
         }
         victoryCountText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

