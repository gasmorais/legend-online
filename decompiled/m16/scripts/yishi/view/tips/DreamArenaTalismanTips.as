package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaTalismanTips extends BaseTip
   {
      
      private var back:Bitmap;
      
      private var profileBack:ScaleFrameImage;
      
      private var talismanIcon:BaseIconView;
      
      private var nameText:FilterFrameText;
      
      private var splitLine:Bitmap;
      
      private var suitText:FilterFrameText;
      
      private var suitVbox:VBox;
      
      private var _iconSprite:Sprite;
      
      public function DreamArenaTalismanTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 237;
         profileBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.profileBack");
         talismanIcon = ComponentFactory.Instance.creatCustomObject("DragonTalkerTalismanTips.talismanIcon");
         nameText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.nameText");
         suitText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitText");
         suitVbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitVbox");
         splitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         addChild(talismanIcon);
         addChild(profileBack);
         addChild(nameText);
         addChild(splitLine);
         addChild(suitText);
         addChild(suitVbox);
         talismanIcon.y = 12;
         profileBack.y = 10;
         nameText.y = 25;
         suitText.y = 85;
         suitVbox.y = 115;
         splitLine.x = -7;
         splitLine.y = 90;
         splitLine.scaleX = 0.95;
         talismanIcon.mask = createSprite();
         suitText.text = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.suitText.text");
      }
      
      private function createSprite() : Sprite
      {
         _iconSprite = new Sprite();
         _iconSprite.graphics.beginFill(16777215,1);
         _iconSprite.graphics.drawCircle(50,45,28);
         _iconSprite.graphics.endFill();
         addChild(_iconSprite);
         _iconSprite.mouseChildren = _iconSprite.mouseEnabled = false;
         return _iconSprite;
      }
      
      override protected function updateTransform() : void
      {
         var _loc7_:SkillTempInfo = null;
         var _loc4_:SkillTempInfo = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc3_:Array = null;
         var _loc6_:SkillTempInfo = null;
         var _loc1_:FilterFrameText = null;
         var _loc8_:String = null;
         suitVbox.removeAllChild();
         var _loc5_:int = 0;
         if(tipData && tipData is DreamArenaTempInfo)
         {
            _loc2_ = (tipData as DreamArenaTempInfo).typeTempInfo as GoodsTemplateInfo;
            _loc7_ = TempleteManager.instance.skillTemplateDic[(tipData as DreamArenaTempInfo).Skill1];
            _loc4_ = TempleteManager.instance.skillTemplateDic[(tipData as DreamArenaTempInfo).Skill2];
            if(_loc2_)
            {
               profileBack.setFrame(_loc2_.Profile);
               talismanIcon.icon = IconFactory.getGoodsIconByTID(_loc2_.TemplateId);
               nameText.text = _loc2_.TemplateName;
               nameText.setFrame(_loc2_.Profile);
            }
            _loc3_ = [_loc7_,_loc4_];
            _loc8_ = "";
            _loc5_ = 0;
            while(_loc5_ < 2)
            {
               _loc6_ = _loc3_[_loc5_] as SkillTempInfo;
               if(_loc6_)
               {
                  _loc8_ = _loc5_ == 0 ? "(2/2)" : "(4/4)";
                  _loc1_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitTempText");
                  _loc1_.text = _loc8_ + _loc6_.Description;
                  _loc1_.height = _loc1_.textHeight + 8;
                  suitVbox.addChild(_loc1_);
                  _loc1_.setFrame(2);
               }
               _loc5_++;
            }
            _bg.height = int(suitVbox.y + suitVbox.height + 5);
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

