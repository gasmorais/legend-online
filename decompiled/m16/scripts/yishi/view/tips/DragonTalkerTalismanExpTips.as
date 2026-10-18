package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DragonTalkerTalismanExpTips extends BaseTip
   {
      
      private var back:Bitmap;
      
      private var talismanBack:ScaleFrameImage;
      
      private var profileBack:ScaleFrameImage;
      
      private var talismanIcon:BaseIconView;
      
      private var nameText:FilterFrameText;
      
      private var descText:FilterFrameText;
      
      private var _iconSprite:Sprite;
      
      public function DragonTalkerTalismanExpTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerTalismanExpTips.back");
         talismanBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.talismanBack");
         profileBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.profileBack");
         talismanIcon = ComponentFactory.Instance.creatCustomObject("DragonTalkerTalismanTips.talismanIcon");
         nameText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.nameText");
         descText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.descText");
         addChild(back);
         addChild(talismanBack);
         addChild(talismanIcon);
         addChild(profileBack);
         addChild(nameText);
         addChild(descText);
         back.width = 249;
         talismanIcon.mask = createSprite();
         descText.text = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.descText.text");
      }
      
      private function createSprite() : Sprite
      {
         _iconSprite = new Sprite();
         _iconSprite.graphics.beginFill(16777215,1);
         _iconSprite.graphics.drawCircle(52,62,28);
         _iconSprite.graphics.endFill();
         addChild(_iconSprite);
         _iconSprite.mouseChildren = _iconSprite.mouseEnabled = false;
         return _iconSprite;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         if(tipData is DragonTalkerTalismanInfo)
         {
            _loc1_ = (tipData as DragonTalkerTalismanInfo).goodsTempInfo;
         }
         else if(tipData is GoodsInfo)
         {
            _loc1_ = (tipData as GoodsInfo).templateInfo;
         }
         if(_loc1_)
         {
            talismanBack.setFrame(_loc1_.SonType - 401);
            profileBack.setFrame(_loc1_.Profile);
            talismanIcon.icon = IconFactory.getGoodsIconByTID(_loc1_.TemplateId);
            nameText.text = _loc1_.TemplateName;
            nameText.setFrame(_loc1_.Profile);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

