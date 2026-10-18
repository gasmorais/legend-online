package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import dragontalker.DragonTalkerViewHelper;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.SuiteTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   
   public class DragonTalkerTalismanTips extends BaseTip
   {
      
      private var back:Bitmap;
      
      private var talismanBack:ScaleFrameImage;
      
      private var profileBack:ScaleFrameImage;
      
      private var talismanIcon:BaseIconView;
      
      private var nameText:FilterFrameText;
      
      private var intensifyContiner:Component;
      
      private var numImage:BitmapData;
      
      private var addImg:Bitmap;
      
      private var equipText:FilterFrameText;
      
      private var attText:FilterFrameText;
      
      private var attVbox:VBox;
      
      private var suitText:FilterFrameText;
      
      private var suitVbox:VBox;
      
      private var _iconSprite:Sprite;
      
      private var tipType:int;
      
      public function DragonTalkerTalismanTips(param1:int = 1)
      {
         super();
         tipType = param1;
      }
      
      override protected function init() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerTalismanTips.back");
         talismanBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.talismanBack");
         profileBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.profileBack");
         talismanIcon = ComponentFactory.Instance.creatCustomObject("DragonTalkerTalismanTips.talismanIcon");
         nameText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.nameText");
         intensifyContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.intensifyContiner");
         addImg = ComponentFactory.Instance.creatBitmap("asset.tips.addImg");
         numImage = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
         equipText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.equipText");
         attText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.attText");
         attVbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.attVbox");
         suitText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitText");
         suitVbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitVbox");
         addChild(back);
         addChild(talismanBack);
         addChild(talismanIcon);
         addChild(profileBack);
         addChild(nameText);
         addChild(addImg);
         addChild(intensifyContiner);
         addChild(equipText);
         addChild(attText);
         addChild(attVbox);
         addChild(suitText);
         addChild(suitVbox);
         talismanIcon.mask = createSprite();
         addImg.visible = intensifyContiner.visible = false;
         addImg.x = 180;
         addImg.y = 60;
         attText.text = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.attText.text");
         suitText.text = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.suitText.text");
      }
      
      private function createSprite() : Sprite
      {
         _iconSprite = new Sprite();
         _iconSprite.graphics.beginFill(16777215,1);
         _iconSprite.graphics.drawCircle(50,60,28);
         _iconSprite.graphics.endFill();
         addChild(_iconSprite);
         _iconSprite.mouseChildren = _iconSprite.mouseEnabled = false;
         return _iconSprite;
      }
      
      override protected function updateTransform() : void
      {
         var _loc22_:SuiteTempInfo = null;
         var _loc1_:GoodsTemplateInfo = null;
         var _loc27_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc15_:DragonTalkerTalismanInfo = null;
         var _loc10_:Boolean = false;
         var _loc13_:Array = null;
         var _loc18_:int = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc24_:int = 0;
         var _loc5_:FilterFrameText = null;
         var _loc8_:int = 0;
         var _loc21_:FilterFrameText = null;
         var _loc6_:Array = null;
         var _loc2_:Array = null;
         var _loc23_:int = 0;
         var _loc17_:int = 0;
         var _loc7_:int = 0;
         var _loc26_:String = null;
         var _loc9_:int = 0;
         var _loc20_:String = null;
         var _loc14_:int = 0;
         var _loc3_:String = null;
         var _loc19_:FilterFrameText = null;
         var _loc25_:SkillTempInfo = null;
         attVbox.removeAllChild();
         suitVbox.removeAllChild();
         var _loc16_:int = 0;
         if(tipData is DragonTalkerTalismanInfo)
         {
            _loc15_ = tipData as DragonTalkerTalismanInfo;
            if(_loc15_.isNew)
            {
               DragonTalkerManager.instance.sendDragonTalkerTalismanReq(4,_loc15_.id);
            }
            _loc1_ = _loc15_.goodsTempInfo;
            _loc22_ = _loc15_.suitTempInfo;
            _loc27_ = Boolean(_loc15_.isSelf);
            _loc4_ = _loc15_.isEquip && _loc27_;
            if(_loc15_.grade > 0)
            {
               addImg.visible = intensifyContiner.visible = true;
               NumberViewUtils.refreshValue(_loc15_.grade,intensifyContiner,numImage,19,22,15,19,"0123456789");
            }
            else
            {
               addImg.visible = intensifyContiner.visible = false;
            }
            _loc10_ = tipType != 1;
            DragonTalkerViewHelper.SetPropTextView(1,attVbox,_loc15_,_loc10_);
         }
         else if(tipData is GoodsInfo)
         {
            _loc1_ = (tipData as GoodsInfo).templateInfo;
            _loc22_ = TempleteManager.instance.suitTemplateCate.getTemplateByID(_loc1_.SuiteId);
            _loc4_ = false;
            _loc27_ = false;
            addImg.visible = intensifyContiner.visible = false;
            _loc13_ = _loc1_.hasValueAtt;
            _loc18_ = int(_loc13_.length);
            _loc11_ = "";
            _loc16_ = 0;
            while(_loc16_ < _loc18_)
            {
               _loc12_ = _loc13_[_loc16_];
               _loc24_ = int(_loc1_[_loc12_]);
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.mainAttText");
               _loc11_ = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc12_,_loc24_);
               _loc5_.htmlText = _loc11_;
               _loc5_.setFrame(_loc1_.Profile);
               attVbox.addChild(_loc5_);
               _loc16_++;
            }
            _loc16_ = 0;
            while(_loc16_ < 3)
            {
               _loc8_ = _loc16_ + 4;
               _loc12_ = "Property" + _loc8_;
               _loc24_ = int(_loc1_[_loc12_]);
               _loc21_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.randomText");
               if(_loc24_ != 0)
               {
                  _loc21_.htmlText = "???";
                  _loc21_.setFrame(_loc1_.Profile);
               }
               else
               {
                  _loc21_.htmlText = LanguageMgr.GetTranslation("DragonTalkerIntensifyView.randomText.typeText" + _loc16_);
                  _loc21_.setFrame(7);
               }
               attVbox.addChild(_loc21_);
               _loc16_++;
            }
         }
         if(_loc1_)
         {
            talismanBack.setFrame(_loc1_.SonType - 400);
            profileBack.setFrame(_loc1_.Profile);
            talismanIcon.icon = IconFactory.getGoodsIconByTID(_loc1_.TemplateId);
            nameText.text = _loc1_.TemplateName;
            nameText.setFrame(_loc1_.Profile);
            _loc4_ ? (equipText.text = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.equipText.equip")) : (equipText.text = "");
         }
         if(_loc22_)
         {
            _loc6_ = _loc22_.tempArr;
            _loc2_ = _loc22_.propertyArr;
            _loc23_ = int(_loc6_.length);
            _loc17_ = int(_loc2_.length);
            _loc7_ = 0;
            _loc16_ = 0;
            while(_loc16_ < _loc23_)
            {
               _loc26_ = _loc6_[_loc16_];
               _loc9_ = int(_loc22_[_loc26_]);
               if(_loc4_ && _loc27_ && Boolean(model.getIsEquipByTempId(_loc9_)))
               {
                  _loc7_++;
               }
               _loc16_++;
            }
            _loc16_ = 0;
            while(_loc16_ < _loc17_)
            {
               _loc20_ = _loc2_[_loc16_];
               _loc14_ = int(_loc22_[_loc20_]);
               _loc3_ = _loc20_.substring(_loc20_.length - 1);
               _loc19_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitTempText");
               _loc25_ = TempleteManager.instance.skillTemplateDic[_loc14_];
               _loc19_.text = "(" + _loc7_ + "/" + _loc3_ + ")" + _loc25_.Description;
               _loc19_.height = _loc19_.textHeight + 8;
               suitVbox.addChild(_loc19_);
               _loc7_ < int(_loc3_) || !_loc27_ || !_loc4_ ? _loc19_.setFrame(1) : _loc19_.setFrame(2);
               _loc16_++;
            }
         }
      }
      
      override public function get height() : Number
      {
         if(back)
         {
            return back.height;
         }
         return super.height;
      }
      
      override public function get width() : Number
      {
         if(back)
         {
            return back.width;
         }
         return super.width;
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

