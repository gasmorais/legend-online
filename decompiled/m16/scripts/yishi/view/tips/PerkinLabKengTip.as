package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.PerkinLabManager;
   import mvc.module.perkinlab.PerkinLabModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class PerkinLabKengTip extends BaseTip
   {
      
      private var titleText:FilterFrameText;
      
      private var line:ScaleBitmapImage;
      
      private var timeText:FilterFrameText;
      
      private var rewardText:FilterFrameText;
      
      public function PerkinLabKengTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabKengTip.titleText");
         line = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         timeText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabKengTip.timeText");
         rewardText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabKengTip.rewardText");
         addChild(titleText);
         addChild(line);
         line.width = 200;
         addChild(rewardText);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc7_:int = 0;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc6_:GoodsTemplateInfo = null;
         cleanData();
         if(_data)
         {
            titleText.text = LanguageMgr.GetTranslation("PerkinLabEventItem.event.sizeText");
            _loc1_ = _data.reward.split("|");
            _loc5_ = int(_loc1_.length);
            _loc2_ = LanguageMgr.GetTranslation("PerkinLabKengTip.rewardText.text");
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc3_ = _loc1_[_loc7_];
               _loc4_ = _loc3_.split(",");
               _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_[0]);
               if(_loc6_)
               {
                  _loc2_ += _loc6_.TemplateName + " x" + _loc4_[1] + ",";
               }
               _loc7_++;
            }
            _loc2_ = _loc2_.substring(0,_loc2_.lastIndexOf(","));
            rewardText.text = _loc2_;
            line.y = titleText.y + titleText.textHeight + 10;
            rewardText.height = rewardText.textHeight + 5;
            if(_data.type == 1)
            {
               rewardText.y = titleText.y + titleText.textHeight + 15;
            }
            else
            {
               addChild(timeText);
               timeText.text = _data.time;
               timeText.y = titleText.y + titleText.textHeight + 15;
               rewardText.y = timeText.y + timeText.textHeight + 5;
            }
         }
         _bg.height = titleText.textHeight + timeText.textHeight + rewardText.textHeight + 40;
         _bg.width = 220;
      }
      
      private function cleanData() : void
      {
         if(timeText && timeText.parent)
         {
            timeText.parent.removeChild(timeText);
         }
         titleText.text = "";
         rewardText.text = "";
      }
      
      private function get model() : PerkinLabModel
      {
         return PerkinLabManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(titleText)
         {
            ObjectUtils.disposeObject(titleText);
         }
         titleText = null;
         if(line)
         {
            ObjectUtils.disposeObject(line);
         }
         line = null;
         if(timeText)
         {
            ObjectUtils.disposeObject(timeText);
         }
         timeText = null;
         if(rewardText)
         {
            ObjectUtils.disposeObject(rewardText);
         }
         rewardText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

