package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.gamehall.GameHallBlessInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class SkillShowCurrentGradeTips extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _sp1:Sprite;
      
      private var _line01:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _describe1:FilterFrameText;
      
      private var _title1:FilterFrameText;
      
      private var _level1:FilterFrameText;
      
      private var _method:FilterFrameText;
      
      public function SkillShowCurrentGradeTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.SkillTotalBox");
         _icon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _method = ComponentFactory.Instance.creatComponentByStylename("tips.skillCostTxt");
         _title1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNameText_2");
         _level1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _line01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _describe1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillDescribe1");
         _sp1 = new Sprite();
         addChild(_totalBox);
         addChild(_icon);
         _bg.width = 300;
      }
      
      private function clean() : void
      {
         _totalBox.removeAllChild();
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:GameHallBlessInfo = null;
         var _loc1_:SkillTempInfo = null;
         var _loc3_:String = null;
         clean();
         if(tipData is GameHallBlessInfo)
         {
            _loc2_ = tipData as GameHallBlessInfo;
            _loc1_ = _loc2_.skillTempInfo;
            _icon.x = 11;
            _icon.y = -11;
            _icon.icon = IconFactory.getTecIconByIcon(_loc1_.Icons);
            _loc3_ = _loc2_.level + "/" + _loc1_.Grades;
            _level1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",_loc3_);
            _title1.htmlText = _loc1_.TemplateName;
            _method.text = getSkillType(_loc1_);
            _sp1.addChild(_title1);
            _sp1.addChild(_method);
            _method.y = 41;
            _sp1.addChild(_level1);
            _level1.y = 41;
            _sp1.addChild(_line01);
            _line01.y = 65;
            _describe1.text = _loc1_.Description;
            _describe1.height = _describe1.textHeight + 8;
            _sp1.addChild(_describe1);
            _describe1.y = _line01.y + 11;
            _totalBox.addChild(_sp1);
            _bg.height = _totalBox.height + 20;
         }
      }
      
      private function getSkillType(param1:SkillTempInfo) : String
      {
         if(param1.UseWay == 2)
         {
            return "[" + LanguageMgr.GetTranslation("yishi.datas.templates.SkillTempInfo.UseWay02") + "]";
         }
         switch(param1.AcceptObject)
         {
            case 1:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type01");
            case 2:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type02");
            case 3:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type03");
            case 4:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type04");
            case 5:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type05");
            case 6:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type06");
            case 7:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type07");
            case 8:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type08");
            case 9:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type09");
            case 10:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type10");
            case 11:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type11");
            case 12:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type12");
            case 13:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type13");
            case 14:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type14");
            case 15:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type15");
            case 16:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type16");
            case 17:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type17");
            case 18:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type18");
            case 19:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type19");
            case 20:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type20");
            case 21:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type21");
            default:
               return "";
         }
      }
   }
}

