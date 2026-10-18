package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import mvc.module.theseus.TheseusSlateAssetHelper;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.goods.SkillTipItem;
   
   public class TheseusGodheadEquipTip extends BaseTip
   {
      
      private var _profileImg:ScaleFrameImage;
      
      private var _equipIcon:BaseIconView;
      
      private var _title:FilterFrameText;
      
      private var _typeTxt:FilterFrameText;
      
      private var _gzTxt:FilterFrameText;
      
      private var _addImg:Bitmap;
      
      private var _strengImg:BitmapData;
      
      private var _strengNumSprite:Sprite;
      
      private var _totalBox:VBox;
      
      private var _starContaint:HBox;
      
      private var _skill01:SkillTipItem;
      
      private var _skill02:SkillTipItem;
      
      private var _skill03:SkillTipItem;
      
      private var _gemTxt0:FilterFrameText;
      
      private var _line1:Bitmap;
      
      private var _line2:Bitmap;
      
      private var _line3:Bitmap;
      
      private var _line4:Bitmap;
      
      private var attBox:VBox;
      
      private var attList:Array = [];
      
      private var refreshBox:VBox;
      
      protected var _stoneIcon:Bitmap;
      
      private var _starNum:int = -1;
      
      public function TheseusGodheadEquipTip()
      {
         super();
      }
      
      private function updateStoneIcon() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(_stoneIcon)
         {
            ObjectUtils.disposeObject(_stoneIcon);
            _stoneIcon = null;
         }
         if(_data && _data.shape > 0)
         {
            _stoneIcon = TheseusSlateAssetHelper.getSlateDisplay(_data.shape,_data.rotate);
            if(_stoneIcon)
            {
               _loc2_ = _stoneIcon.width;
               _loc1_ = _stoneIcon.height;
               _stoneIcon.scaleX = 0.3;
               _stoneIcon.scaleY = 0.3;
               _stoneIcon.x = 30 - _loc2_ * 0.3 / 2;
               _stoneIcon.y = 20 - _loc1_ * 0.3 / 2;
               addChildAt(_stoneIcon,1);
            }
         }
      }
      
      override protected function init() : void
      {
         var _loc1_:TheseusAttributeItem = null;
         super.init();
         _bg.x = -15;
         _bg.y = -25;
         _bg.width = 372;
         _equipIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _addImg = ComponentFactory.Instance.creatBitmap("asset.tips.addImg");
         _strengNumSprite = new Sprite();
         _strengNumSprite.y = 3;
         _strengImg = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _starContaint = ComponentFactory.Instance.creatCustomObject("xmlui.theseuswarequipTip.hbox");
         _line1 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line2 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line3 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line4 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _typeTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         _gzTxt = ComponentFactory.Instance.creatComponentByStylename("tips.castSelectedTxt");
         _gemTxt0 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText");
         _gemTxt0.x = 145;
         _gemTxt0.y = 75;
         _gemTxt0.width = 200;
         _typeTxt.x = 150;
         _typeTxt.y = 55;
         _typeTxt.width = 182;
         _gzTxt.x = 81;
         attBox = ComponentFactory.Instance.creatComponentByStylename("theseuswarTip.TipsVBox");
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new TheseusAttributeItem();
            attList[_loc2_] = _loc1_;
            _loc2_++;
         }
         addChild(_equipIcon);
         addChild(_profileImg);
         _profileImg.setFrame(1);
         addChild(_addImg);
         addChild(_strengNumSprite);
         addChild(_title);
         addChild(_typeTxt);
         addChild(_typeTxt);
         addChild(_gzTxt);
         addChild(_starContaint);
         addChild(_gemTxt0);
         addChild(_totalBox);
         _addImg.x = 270;
         _addImg.y = 0;
         _title.y = 5;
         _totalBox.y = 100;
      }
      
      private function setStrengNum(param1:int) : void
      {
         NumberViewUtils.refreshValue(param1,_strengNumSprite,_strengImg,19,22,15,19,"0123456789");
      }
      
      private function showStar(param1:int) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         if(_starNum == param1)
         {
            return;
         }
         _starNum = param1;
         var _loc6_:int = 1;
         ObjectUtils.disposeAllChildren(_starContaint);
         _starContaint.beginChanges();
         var _loc4_:int = _loc6_ * 5;
         var _loc7_:int = (_loc6_ - 1) * 5;
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc3_ = _loc7_ + _loc5_;
            if(param1 > _loc3_ && _loc6_ > 0)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.theseus.warStar3");
               _starContaint.addChild(_loc2_);
            }
            _loc5_++;
         }
         _starContaint.commitChanges();
      }
      
      private function updateAttItem(param1:int, param2:TheseusAttributeItem, param3:String) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = "    ";
         var _loc6_:String = "";
         _loc6_ = _loc6_ + (AttributeUtils.getAttributeName(param3,2) + param1);
         if(_loc6_ && param2)
         {
            param2.setTextValue(_loc6_);
         }
      }
      
      override protected function updateTransform() : void
      {
         var _loc16_:Array = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc17_:int = 0;
         var _loc5_:int = 0;
         var _loc18_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:int = 0;
         var _loc14_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc9_:Object = null;
         var _loc1_:TheseusAttributeItem = null;
         var _loc12_:* = null;
         var _loc4_:SkillTempInfo = null;
         var _loc15_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc19_:TheseusGodheadStoneInfo = tipData as TheseusGodheadStoneInfo;
         if(_loc19_)
         {
            _loc16_ = ["#59cd41","#33a6ff","#1aecff"];
            _loc2_ = AttributeUtils.getColorStr(_loc19_.name,_loc16_[_loc19_.quality - 1]);
            updateStoneIcon();
            _profileImg.setFrame(_loc19_.quality);
            _title.setFrame(_loc19_.quality);
            _title.text = _loc19_.name;
            if(_loc19_.maxLevel)
            {
               _gemTxt0.text = LanguageMgr.GetTranslation("goddess.equip.tipMax",_loc19_.maxLevel);
            }
            _loc3_ = int(_loc19_.SlateType);
            _typeTxt.text = TheseussoulManager.Instance.modelGodhead.getNamebySlateType(_loc3_);
            showStar(_loc19_.star);
            _strengNumSprite.x = _addImg.x + 15;
            _loc17_ = int(_loc19_.baseAttributes.Attack);
            _loc5_ = int(_loc19_.baseAttributes.Defence);
            _loc18_ = int(_loc19_.baseAttributes.ForceHit);
            _loc13_ = int(_loc19_.baseAttributes.Parry);
            _loc10_ = int(_loc19_.baseAttributes.Penetrate);
            _loc14_ = int(_loc19_.baseAttributes.MagicAttack);
            _loc6_ = int(_loc19_.baseAttributes.MagicDefence);
            _loc11_ = int(_loc19_.baseAttributes.Live);
            _loc9_ = _loc19_.getLevelAttributes();
            if(_loc19_.level > 0)
            {
               _addImg.visible = true;
               _strengNumSprite.visible = true;
               setStrengNum(_loc19_.level);
               _loc17_ += _loc9_.Attack || 0;
               _loc5_ += _loc9_.Defence || 0;
               _loc14_ += _loc9_.MagicAttack || 0;
               _loc6_ += _loc9_.MagicDefence || 0;
               _loc11_ += _loc9_.Live || 0;
               _loc18_ += _loc9_.ForceHit || 0;
               _loc13_ += _loc9_.Parry || 0;
               _loc10_ += _loc9_.Penetrate || 0;
            }
            else
            {
               _addImg.visible = false;
               _strengNumSprite.visible = false;
            }
            _totalBox.beginChanges();
            _totalBox.removeAllChild();
            attBox.beginChanges();
            attBox.removeAllChild();
            if(_loc17_ > 0)
            {
               _loc1_ = attList[0];
               updateAttItem(_loc17_,_loc1_,"Attack");
               attBox.addChild(_loc1_);
            }
            if(_loc5_ > 0)
            {
               _loc1_ = attList[1];
               updateAttItem(_loc5_,_loc1_,"Defence");
               attBox.addChild(_loc1_);
            }
            if(_loc14_ > 0)
            {
               _loc1_ = attList[2];
               updateAttItem(_loc14_,_loc1_,"MagicAttack");
               attBox.addChild(_loc1_);
            }
            if(_loc6_ > 0)
            {
               _loc1_ = attList[3];
               updateAttItem(_loc6_,_loc1_,"MagicDefence");
               attBox.addChild(_loc1_);
            }
            if(_loc11_ > 0)
            {
               _loc1_ = attList[4];
               updateAttItem(_loc11_,_loc1_,"Live");
               attBox.addChild(_loc1_);
            }
            if(_loc18_ > 0)
            {
               _loc1_ = attList[5];
               updateAttItem(_loc18_,_loc1_,"ForceHit");
               attBox.addChild(_loc1_);
            }
            if(_loc13_ > 0)
            {
               _loc1_ = attList[6];
               updateAttItem(_loc13_,_loc1_,"Parry");
               attBox.addChild(_loc1_);
            }
            if(_loc10_ > 0)
            {
               _loc1_ = attList[7];
               updateAttItem(_loc10_,_loc1_,"Penetrate");
               attBox.addChild(_loc1_);
            }
            attBox.commitChanges();
            _totalBox.addChild(_line1);
            _totalBox.addChild(attBox);
            _loc15_ = _loc19_.SkillID;
            _loc7_ = int(_loc15_.length);
            _totalBox.addChild(_line2);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc4_ = TempleteManager.instance.getSkillById(_loc15_[_loc8_]);
               if(_loc4_ && _loc4_.Description != "")
               {
                  _loc1_ = attList[8 + _loc8_];
                  _loc1_.setTextValue(_loc4_.Description);
                  _totalBox.addChild(_loc1_);
               }
               _loc8_++;
            }
            _totalBox.commitChanges();
            _bg.height = _totalBox.y + _totalBox.height + 35;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in attList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         attList = null;
         ObjectUtils.disposeObject(attBox);
         attBox = null;
         ObjectUtils.disposeObject(refreshBox);
         refreshBox = null;
         ObjectUtils.disposeObject(_profileImg);
         _profileImg = null;
         ObjectUtils.disposeObject(_addImg);
         _addImg = null;
         ObjectUtils.disposeObject(_strengNumSprite);
         _strengNumSprite = null;
         ObjectUtils.disposeObject(_strengImg);
         _strengImg = null;
         ObjectUtils.disposeObject(_equipIcon);
         _equipIcon = null;
         ObjectUtils.disposeObject(_totalBox);
         _totalBox = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_skill01);
         _skill01 = null;
         ObjectUtils.disposeObject(_skill02);
         _skill02 = null;
         ObjectUtils.disposeObject(_skill03);
         _skill03 = null;
         ObjectUtils.disposeObject(_stoneIcon);
         _stoneIcon = null;
         ObjectUtils.disposeObject(_line1);
         _line1 = null;
         ObjectUtils.disposeObject(_line2);
         _line2 = null;
         ObjectUtils.disposeObject(_line3);
         _line3 = null;
         ObjectUtils.disposeObject(_line4);
         _line4 = null;
         ObjectUtils.disposeObject(_starContaint);
         _starContaint = null;
         ObjectUtils.disposeObject(_gzTxt);
         _gzTxt = null;
         ObjectUtils.disposeObject(_typeTxt);
         _typeTxt = null;
         super.dispose();
      }
   }
}

