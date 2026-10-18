package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
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
   import mvc.module.theseus.TheseusSuitInfo;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TheseusEquipSuiteTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class TheseusEquipTip extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _type:FilterFrameText;
      
      private var _itemIcon:BaseIconView;
      
      private var _profieBack:ScaleFrameImage;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _splitLine01:Bitmap;
      
      private var _splitLine02:Bitmap;
      
      private var _splitLine03:Bitmap;
      
      private var _totalBox:VBox;
      
      private var _subBox1:VBox;
      
      private var _subBox2:VBox;
      
      private var _addImg:Bitmap;
      
      private var _strengNumSprite:Sprite;
      
      private var _strengImg:BitmapData;
      
      private var _gzTxt:FilterFrameText;
      
      private var _zjTxt:FilterFrameText;
      
      private var _gemTxt0:FilterFrameText;
      
      public function TheseusEquipTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText1_3");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _profieBack = ComponentFactory.Instance.creatComponentByStylename("tips.profileBack");
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine03 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _subBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox2 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         addChild(_profieBack);
         addChild(_itemIcon);
         _itemIcon.x = 19;
         _itemIcon.y = 21;
         addChild(_profileImg);
         _profileImg.x = 18;
         _profileImg.y = 30;
         addChild(_title);
         _title.x = 81;
         _title.y = 35;
         addChild(_type);
         _type.x = 18;
         _type.y = 83;
         addChild(_totalBox);
         _totalBox.x = 14;
         _totalBox.y = 100;
         _profieBack.width = 327;
         _strengNumSprite = new Sprite();
         _strengNumSprite.y = 3;
         _strengImg = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
         _gemTxt0 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText");
         _gzTxt = ComponentFactory.Instance.creatComponentByStylename("tips.castSelectedTxt");
         _addImg = ComponentFactory.Instance.creatBitmap("asset.tips.addImg");
         _addImg.x = 260;
         _addImg.y = 35;
         _gzTxt.x = 81;
         _gzTxt.y = 56;
         addChild(_addImg);
         addChild(_strengNumSprite);
         _gemTxt0.x = 125;
         _gemTxt0.y = 80;
         _gemTxt0.width = 200;
         addChild(_gzTxt);
         _zjTxt = ComponentFactory.Instance.creatComponentByStylename("tips.simpleGoodSkillText");
         addChild(_gemTxt0);
      }
      
      private function setStrengNum(param1:int) : void
      {
         _strengNumSprite.x = _addImg.x + 15;
         _strengNumSprite.y = _addImg.y;
         NumberViewUtils.refreshValue(param1,_strengNumSprite,_strengImg,19,22,15,19,"0123456789");
      }
      
      override protected function updateTransform() : void
      {
         var _loc18_:WarFrameItemInfo = null;
         var _loc13_:TheseussoulModel = null;
         var _loc7_:GoodsTemplateInfo = null;
         var _loc3_:String = null;
         var _loc14_:String = null;
         var _loc29_:SkillTipItem = null;
         var _loc1_:Array = null;
         var _loc27_:String = null;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc30_:String = null;
         var _loc20_:int = 0;
         var _loc22_:int = 0;
         var _loc31_:Array = null;
         var _loc32_:Array = null;
         var _loc21_:Array = null;
         var _loc4_:TheseusSuitInfo = null;
         var _loc26_:Array = null;
         var _loc16_:Array = null;
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         var _loc17_:int = 0;
         var _loc15_:FilterFrameText = null;
         var _loc25_:FilterFrameText = null;
         var _loc28_:Sprite = null;
         var _loc19_:Array = null;
         var _loc2_:Array = null;
         var _loc12_:TheseusEquipSuiteTempInfo = null;
         var _loc23_:SkillTempInfo = null;
         var _loc8_:SkillPropertyTempInfo = null;
         var _loc24_:int = 0;
         if(tipData)
         {
            _loc18_ = tipData as WarFrameItemInfo;
            _loc13_ = TheseussoulManager.Instance.model;
            _loc7_ = _loc18_.warTempInfo;
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_loc18_.warTempInfo.TemplateId);
            _profileImg.setFrame(_loc18_.reform);
            _profieBack.setFrame(_loc18_.reform);
            _title.setFrame(_loc18_.reform);
            _title.text = _loc18_.warTempInfo.TemplateName;
            _title.height = 42;
            _title.wordWrap = true;
            _type.text = LanguageMgr.GetTranslation("theseus.equip.part" + _loc7_.Property3);
            _zjTxt.y = _totalBox.y + _totalBox.height + 10;
            _profieBack.height = _zjTxt.y + _zjTxt.height + 10;
            _loc3_ = GoodsHelp.getGoodColorString(_loc18_.reform);
            _loc14_ = AttributeUtils.getColorStr(LanguageMgr.GetTranslation("theseus.war.gz" + _loc18_.reform),_loc3_,false);
            _gzTxt.htmlText = _loc14_;
            if(!_loc18_.warReformTempInfo)
            {
               return;
            }
            _gemTxt0.text = LanguageMgr.GetTranslation("goddess.equip.tipMax",_loc18_.warReformTempInfo.StrengthenLimit);
            _zjTxt.text = LanguageMgr.GetTranslation("TheseusEquipTip.desc1") + _loc13_.getEquipZhangjValue(_loc18_);
            if(_loc18_.strengthen > 0)
            {
               _addImg.visible = true;
               _strengNumSprite.visible = true;
               setStrengNum(_loc18_.strengthen);
            }
            else
            {
               _addImg.visible = false;
               _strengNumSprite.visible = false;
            }
            _subBox1.removeAllChild();
            _subBox1.beginChanges();
            _loc1_ = _loc7_.hasValueAtt;
            _loc20_ = 0;
            _loc22_ = 0;
            _loc20_ = 0;
            while(_loc20_ < _loc1_.length)
            {
               _loc10_ = _loc1_[_loc20_];
               _loc27_ = AttributeUtils.getAttributeName(_loc10_);
               _loc21_ = [];
               _loc9_ = int(_loc7_[_loc10_]);
               _loc29_ = new SkillTipItem();
               if(_loc18_.warStrengthTempInfo)
               {
                  _loc31_ = _loc18_.warStrengthTempInfo.Attr.split("|");
                  _loc22_ = 0;
                  while(_loc22_ < _loc31_.length)
                  {
                     _loc21_ = _loc31_[_loc22_].split(",");
                     if(AttributeUtils.getzjAttribute(_loc21_[0]) == _loc10_)
                     {
                        _loc9_ += int(_loc21_[1]);
                     }
                     _loc22_++;
                  }
               }
               if(_loc18_.warReformTempInfo)
               {
                  _loc32_ = _loc18_.warReformTempInfo.Attr.split("|");
                  _loc22_ = 0;
                  while(_loc22_ < _loc32_.length)
                  {
                     _loc21_ = _loc32_[_loc22_].split(",");
                     if(AttributeUtils.getzjAttribute(_loc21_[0]) == _loc10_)
                     {
                        _loc9_ += int(_loc21_[1]);
                     }
                     _loc22_++;
                  }
               }
               _loc30_ = _loc27_ + "  " + _loc9_;
               _loc29_.setTxtFrame(3);
               _loc29_.setSkillTxt(_loc30_);
               _subBox1.addChild(_loc29_);
               _loc20_++;
            }
            _loc1_ = _loc7_.hasValueAttResi;
            _loc20_ = 0;
            while(_loc20_ < _loc1_.length)
            {
               _loc10_ = _loc1_[_loc20_];
               _loc27_ = AttributeUtils.getAttributeName(_loc10_);
               _loc9_ = int(_loc7_[_loc10_]);
               _loc29_ = new SkillTipItem();
               _loc30_ = _loc27_ + "  " + _loc9_;
               _loc29_.setTxtFrame(3);
               _loc29_.setSkillTxt(_loc30_);
               _subBox1.addChild(_loc29_);
               _loc20_++;
            }
            _subBox1.commitChanges();
            _subBox2.removeAllChild();
            _loc4_ = _loc13_.suitInfo;
            _loc26_ = _loc4_.getParts(_loc7_.Property2);
            _loc16_ = _loc4_.getSuitArray(_loc7_.Property1);
            _loc5_ = _loc4_.getOneSuitMinLv(_loc7_.Property1,_loc7_.Property2);
            _loc11_ = int(_loc26_.length);
            _loc15_ = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
            _subBox2.addChild(_loc15_);
            _loc19_ = TheseussoulModel.SONTYPES;
            _loc20_ = 0;
            while(_loc20_ < _loc11_)
            {
               _loc17_ = int(_loc26_[_loc20_]);
               _loc25_ = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
               if(_loc20_ % 2 == 0)
               {
                  _loc28_ = new Sprite();
                  _subBox2.addChild(_loc28_);
               }
               else
               {
                  _loc25_.x = 100;
               }
               _loc25_.text = LanguageMgr.GetTranslation("theseus.equip.part" + _loc19_[_loc17_]);
               if(int(_loc16_[_loc17_]) > 0)
               {
                  _loc6_++;
                  _loc25_.setFrame(2);
               }
               else
               {
                  _loc25_.setFrame(1);
               }
               _loc28_.addChild(_loc25_);
               _loc20_++;
            }
            _loc2_ = TempleteManager.instance.theseusEquipSuitCate.getTempInfo(_loc7_.Property1,_loc7_.Property2,_loc5_);
            _loc12_ = _loc2_[0] != null ? _loc2_[0] : _loc2_[1];
            if(_loc12_)
            {
               _loc15_.text = _loc12_.SuiteName + "(" + _loc6_ + "/" + _loc11_ + ")";
               _loc23_ = TempleteManager.instance.skillTemplateDic[_loc12_.SkillId];
               if(_loc23_)
               {
                  _loc8_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc23_.TemplateId);
                  if(_loc8_)
                  {
                     _subBox2.beginChanges();
                     _loc1_ = _loc8_.hasValueAtt.concat(_loc8_.hasKanAtt);
                     _loc24_ = 1;
                     if(_loc6_ == _loc11_ && _loc5_ >= _loc12_.NeedMinLevel)
                     {
                        _loc24_ = 1;
                        _loc15_.setFrame(2);
                     }
                     else
                     {
                        _loc24_ = 2;
                        _loc15_.setFrame(1);
                     }
                     _loc20_ = 0;
                     while(_loc20_ < _loc1_.length)
                     {
                        _loc10_ = _loc1_[_loc20_];
                        _loc27_ = AttributeUtils.getAttributeName(_loc10_);
                        _loc9_ = int(_loc8_[_loc10_]);
                        _loc30_ = _loc27_ + "+" + _loc9_;
                        _loc29_ = new SkillTipItem();
                        _loc29_.setSkillTxt(_loc30_);
                        _loc29_.setTxtFrame(_loc24_);
                        _subBox2.addChild(_loc29_);
                        _loc20_++;
                     }
                     if(_loc23_.Description != null && _loc23_.Description.length > 1)
                     {
                        _loc29_ = new SkillTipItem();
                        _loc29_.setSkillTxt(_loc23_.Description);
                        _loc29_.setTxtFrame(_loc24_);
                        _subBox2.addChild(_loc29_);
                     }
                     _subBox2.commitChanges();
                  }
               }
            }
            ObjectUtils.removeChildAllChildrenFromStage(_totalBox);
            _totalBox.beginChanges();
            _totalBox.addChild(_splitLine01);
            _totalBox.addChild(_subBox1);
            _totalBox.addChild(_splitLine02);
            _totalBox.addChild(_subBox2);
            _totalBox.addChild(_splitLine03);
            _totalBox.addChild(_zjTxt);
            _totalBox.commitChanges();
            _profieBack.height = _totalBox.y + _totalBox.height + 10;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_itemIcon);
         _itemIcon = null;
         ObjectUtils.disposeObject(_profieBack);
         _profieBack = null;
         ObjectUtils.disposeObject(_profileImg);
         _profileImg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_splitLine01);
         _splitLine01 = null;
         ObjectUtils.disposeObject(_splitLine02);
         _splitLine02 = null;
         ObjectUtils.disposeObject(_splitLine03);
         _splitLine03 = null;
         ObjectUtils.disposeObject(_totalBox);
         _totalBox = null;
         ObjectUtils.disposeObject(_subBox1);
         _subBox1 = null;
         ObjectUtils.disposeObject(_subBox2);
         _subBox2 = null;
         super.dispose();
      }
   }
}

