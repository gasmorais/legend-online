package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.children.NursingSpiritInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class ChildNSTalentItemTips extends BaseTip
   {
      
      private var nameText:FilterFrameText;
      
      private var curDescText:FilterFrameText;
      
      private var curAddValueText:FilterFrameText;
      
      private var nextVbox:VBox;
      
      private var lineImage:ScaleBitmapImage;
      
      private var nextText:FilterFrameText;
      
      private var nextDescText:FilterFrameText;
      
      public function ChildNSTalentItemTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 480;
         nameText = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemTips.nameText");
         curDescText = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemTips.curDescText");
         curAddValueText = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemTips.curAddValueText");
         nextVbox = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemTips.nextVbox");
         lineImage = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemTips.lineImage");
         nextText = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemTips.nextText");
         nextDescText = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemTips.nextDescText");
         addChild(nameText);
         addChild(curDescText);
         addChild(curAddValueText);
         addChild(nextVbox);
         nextText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.nextGrade");
      }
      
      override protected function updateTransform() : void
      {
         var _loc5_:int = 0;
         var _loc10_:NursingSpiritInfo = null;
         var _loc6_:int = 0;
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc8_:UpgradeTemplateInfo = null;
         var _loc1_:UpgradeTemplateInfo = null;
         var _loc9_:int = 0;
         var _loc7_:String = null;
         var _loc2_:int = 0;
         var _loc11_:int = 0;
         var _loc4_:int = 0;
         if(tipData)
         {
            nextVbox.removeAllChild();
            _loc5_ = int(tipData.type);
            _loc10_ = tipData.nsInfo as NursingSpiritInfo;
            if(_loc10_.lvlIndexDic && _loc10_.lvlIndexDic[_loc5_])
            {
               _loc6_ = int(_loc10_.lvlIndexDic[_loc5_]);
            }
            else
            {
               _loc6_ = 0;
            }
            _loc9_ = _loc5_ + 1;
            _loc7_ = LanguageMgr.GetTranslation("planesRewardTip.resistance.typeText" + _loc9_);
            _loc2_ = int(_loc10_.lifeWheelInfo.resiGradeArr[_loc5_]);
            _loc3_ = TempleteManager.instance.getTemplateByLevelAndType(_loc2_,133);
            _loc8_ = TempleteManager.instance.getTemplateByLevelAndType(_loc6_,132);
            _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(_loc6_ + 1,132);
            _loc11_ = 0;
            if(_loc8_)
            {
               _loc4_ = int(_loc8_.ActiveObject);
               _loc11_ = _loc3_.ActiveObject * _loc8_.ActiveObject / 100;
            }
            else
            {
               _loc11_ = _loc4_ = 0;
            }
            nameText.htmlText = LanguageMgr.GetTranslation("ChildNSTalentItemTips.nameText.text",_loc7_,LanguageMgr.GetTranslation("public.level2",_loc6_));
            curDescText.text = LanguageMgr.GetTranslation("ChildNSTalentItemTips.curDescText.text",_loc7_,_loc4_);
            curAddValueText.text = LanguageMgr.GetTranslation("ChildNSTalentItemTips.curAddValueText.text",_loc11_);
            if(_loc6_ < 80)
            {
               nextDescText.text = LanguageMgr.GetTranslation("ChildNSTalentItemTips.curDescText.text",_loc7_,_loc1_.ActiveObject);
               nextVbox.addChild(lineImage);
               nextVbox.addChild(nextText);
               nextVbox.addChild(nextDescText);
            }
            _bg.height = nextVbox.y + nextVbox.height + 20;
         }
      }
      
      override public function dispose() : void
      {
         if(nameText)
         {
            ObjectUtils.disposeObject(nameText);
         }
         nameText = null;
         if(curDescText)
         {
            ObjectUtils.disposeObject(curDescText);
         }
         curDescText = null;
         if(curAddValueText)
         {
            ObjectUtils.disposeObject(curAddValueText);
         }
         curAddValueText = null;
         if(nextVbox)
         {
            ObjectUtils.disposeObject(nextVbox);
         }
         nextVbox = null;
         if(lineImage)
         {
            ObjectUtils.disposeObject(lineImage);
         }
         lineImage = null;
         if(nextText)
         {
            ObjectUtils.disposeObject(nextText);
         }
         nextText = null;
         if(nextDescText)
         {
            ObjectUtils.disposeObject(nextDescText);
         }
         nextDescText = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

