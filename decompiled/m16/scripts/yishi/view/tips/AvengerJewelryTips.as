package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class AvengerJewelryTips extends BaseTip
   {
      
      private var _item:BaseItemView;
      
      private var _nameText:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _propTitleText:FilterFrameText;
      
      private var _propBox:VBox;
      
      private var _skillTitleText:FilterFrameText;
      
      private var _skillDescText:FilterFrameText;
      
      private var _line1:Bitmap;
      
      private var _line2:Bitmap;
      
      private var _redBg:Scale9CornerImage;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      public function AvengerJewelryTips()
      {
         super();
         _item = ComponentFactory.Instance.creatCustomObject("tips.BaseItemView");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("AvengerJewelryTips.gradeTxt");
         _line1 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _propTitleText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.attText");
         _propBox = ComponentFactory.Instance.creatComponentByStylename("AvengerJewelryTips.propBox");
         _line2 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _skillTitleText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.attText");
         _skillDescText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitTempText");
         _redBg = ComponentFactory.Instance.creatComponentByStylename("core.redItemTipsBg");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         addChild(_redBg);
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         addChild(_item);
         addChild(_nameText);
         addChild(_gradeTxt);
         addChild(_line1);
         _line1.y = 65;
         addChild(_propTitleText);
         _propTitleText.y = 55;
         addChild(_propBox);
         _propBox.x = 14;
         _propBox.y = 80;
         addChild(_line2);
         addChild(_skillTitleText);
         addChild(_skillDescText);
         _skillDescText.x = 25;
         _skillDescText.width = 250;
         _propTitleText.text = LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.property");
         _skillTitleText.text = LanguageMgr.GetTranslation("HigherGradeOpenTipView.content2");
         _bg.width = 312;
         _nameText.width = 225;
         _item.x = 9;
         _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = _bg.width;
      }
      
      override protected function updateTransform() : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:FilterFrameText = null;
         var _loc1_:int = 0;
         var _loc6_:SkillTempInfo = null;
         if(tipData)
         {
            ObjectUtils.disposeAllChildren(_propBox);
            _propBox.beginChanges();
            _loc5_ = tipData as GoodsInfo;
            _item.data = _loc5_;
            setProfile(_loc5_.templateInfo.Profile);
            _nameText.text = _loc5_.templateInfo.TemplateName;
            _nameText.setFrame(_loc5_.templateInfo.Profile);
            _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_loc5_.templateInfo.Property1);
            _loc3_ = ["Attack","Defence","MagicDefence","Live"];
            _loc4_ = 1;
            while(_loc4_ <= _loc3_.length)
            {
               _loc7_ = int(_loc5_.templateInfo[_loc3_[_loc4_ - 1]]);
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("tips.simpleGoodSkillText");
               _loc2_.text = LanguageMgr.GetTranslation("AvengerBodyPropItem.propText1" + _loc4_,_loc7_);
               _propBox.addChild(_loc2_);
               _loc4_++;
            }
            _propBox.commitChanges();
            _loc1_ = int(_loc5_.templateInfo.Property4);
            _loc6_ = TempleteManager.instance.skillTemplateDic[_loc1_];
            if(_loc6_)
            {
               _skillDescText.text = _loc6_.Description;
            }
            _line2.y = _propBox.y + _propBox.height + 13;
            _skillTitleText.y = _line2.y - 7;
            _skillDescText.y = _skillTitleText.y + _skillTitleText.height + 5;
            _bg.height = _skillDescText.y + _skillDescText.height + 10;
            _redBg.height = _bg.height;
            _yellowBg.height = _bg.height;
            _purpleBg.height = _bg.height;
            _blueBg.height = _bg.height;
            _greenBg.height = _bg.height;
            _whiteBg.height = _bg.height;
            _redBg.y = _bg.y - 3;
            _yellowBg.y = _bg.y - 3;
            _purpleBg.y = _bg.y - 3;
            _blueBg.y = _bg.y - 3;
            _greenBg.y = _bg.y - 3;
            _whiteBg.y = _bg.y - 3;
         }
      }
      
      private function setProfile(param1:int) : void
      {
         _bg.visible = false;
         _redBg.visible = _yellowBg.visible = _purpleBg.visible = _blueBg.visible = _greenBg.visible = _whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               break;
            case 1:
               _greenBg.visible = true;
               break;
            case 2:
               _blueBg.visible = true;
               break;
            case 3:
               _purpleBg.visible = true;
               break;
            case 4:
               _yellowBg.visible = true;
               break;
            case 5:
               _redBg.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

