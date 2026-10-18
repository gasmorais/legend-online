package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.PerkinLabManager;
   import mvc.module.perkinlab.PerkinLabModel;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class PerkinLabExpTips extends BaseTip
   {
      
      private var curImage:Bitmap;
      
      private var curRewardText:FilterFrameText;
      
      private var nextVbox:VBox;
      
      private var nextImage:Bitmap;
      
      private var nextRewardText:FilterFrameText;
      
      public function PerkinLabExpTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 450;
         curImage = ComponentFactory.Instance.creatBitmap("asset.PerkinLabExpTips.curImage");
         curRewardText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabExpTips.curRewardText");
         nextVbox = ComponentFactory.Instance.creatComponentByStylename("PerkinLabExpTips.nextVbox");
         nextImage = ComponentFactory.Instance.creatBitmap("asset.PerkinLabExpTips.nextImage");
         nextRewardText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabExpTips.nextRewardText");
         addChild(curImage);
         addChild(curRewardText);
         addChild(nextVbox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:int = 0;
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc10_:UpgradeTemplateInfo = null;
         var _loc17_:String = null;
         var _loc9_:Array = null;
         var _loc1_:Array = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc12_:String = null;
         var _loc16_:String = null;
         var _loc19_:String = null;
         var _loc13_:String = null;
         var _loc7_:Array = null;
         var _loc11_:Array = null;
         var _loc15_:String = null;
         var _loc8_:String = null;
         var _loc18_:String = null;
         var _loc6_:String = null;
         var _loc14_:String = null;
         if(tipData)
         {
            nextVbox.removeAllChild();
            _loc3_ = int(model.curGrade);
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(_loc3_,134);
            _loc10_ = TempleteManager.instance.getTemplateByLevelAndType(_loc3_ + 1,134);
            _loc17_ = _loc2_.TemplateName;
            _loc9_ = _loc17_.split(";")[0].split("|");
            _loc1_ = _loc17_.split(";")[1].split(",");
            _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc9_[0].split(",")[0]).TemplateName;
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc9_[1].split(",")[0]).TemplateName;
            _loc12_ = LanguageMgr.GetTranslation("PerkinLabExpTips.curRewardText.text",_loc5_,_loc9_[0].split(",")[1]);
            _loc16_ = LanguageMgr.GetTranslation("PerkinLabExpTips.curRewardText.text",_loc4_,_loc9_[1].split(",")[1]);
            _loc19_ = LanguageMgr.GetTranslation("PerkinLabExpTips.curRewardText.text2",_loc1_[0],_loc1_[1],_loc4_);
            curRewardText.htmlText = _loc12_ + "\n" + _loc16_ + "\n" + _loc19_;
            if(_loc10_)
            {
               _loc13_ = _loc10_.TemplateName;
               _loc7_ = _loc13_.split(";")[0].split("|");
               _loc11_ = _loc13_.split(";")[1].split(",");
               _loc15_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_[0].split(",")[0]).TemplateName;
               _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_[1].split(",")[0]).TemplateName;
               _loc18_ = LanguageMgr.GetTranslation("PerkinLabExpTips.curRewardText.text",_loc15_,_loc7_[0].split(",")[1]);
               _loc6_ = LanguageMgr.GetTranslation("PerkinLabExpTips.curRewardText.text",_loc8_,_loc7_[1].split(",")[1]);
               _loc14_ = LanguageMgr.GetTranslation("PerkinLabExpTips.curRewardText.text2",_loc11_[0],_loc11_[1],_loc8_);
               nextRewardText.htmlText = _loc18_ + "\n" + _loc6_ + "\n" + _loc14_;
               nextVbox.addChild(nextImage);
               nextVbox.addChild(nextRewardText);
            }
            _bg.height = nextVbox.y + nextVbox.height + 20;
         }
      }
      
      private function get model() : PerkinLabModel
      {
         return PerkinLabManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(curImage)
         {
            ObjectUtils.disposeObject(curImage);
         }
         curImage = null;
         if(curRewardText)
         {
            ObjectUtils.disposeObject(curRewardText);
         }
         curRewardText = null;
         if(nextImage)
         {
            ObjectUtils.disposeObject(nextImage);
         }
         nextImage = null;
         if(nextRewardText)
         {
            ObjectUtils.disposeObject(nextRewardText);
         }
         nextRewardText = null;
         if(nextVbox)
         {
            ObjectUtils.disposeObject(nextVbox);
         }
         nextVbox = null;
         super.dispose();
      }
   }
}

