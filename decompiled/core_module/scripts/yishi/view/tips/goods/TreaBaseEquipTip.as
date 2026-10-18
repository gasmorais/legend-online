package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusSuitInfo;
   import mvc.module.theseus.TheseussoulModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TheseusEquipSuiteTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class TreaBaseEquipTip extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _type:FilterFrameText;
      
      private var _itemIcon:BaseIconView;
      
      private var _profieBack:ScaleFrameImage;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _splitLine01:Bitmap;
      
      private var _splitLine02:Bitmap;
      
      private var _totalBox:VBox;
      
      private var _subBox1:VBox;
      
      private var _subBox2:VBox;
      
      public function TreaBaseEquipTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _profieBack = ComponentFactory.Instance.creatComponentByStylename("tips.profileBack");
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
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
      }
      
      override protected function updateTransform() : void
      {
         var _loc16_:GoodsInfo = null;
         var _loc12_:TheseussoulModel = null;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc25_:SkillTipItem = null;
         var _loc1_:Array = null;
         var _loc23_:String = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc26_:String = null;
         var _loc18_:int = 0;
         var _loc3_:TheseusSuitInfo = null;
         var _loc22_:Array = null;
         var _loc14_:Array = null;
         var _loc4_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         var _loc15_:int = 0;
         var _loc13_:FilterFrameText = null;
         var _loc21_:FilterFrameText = null;
         var _loc24_:Sprite = null;
         var _loc17_:Array = null;
         var _loc2_:Array = null;
         var _loc11_:TheseusEquipSuiteTempInfo = null;
         var _loc19_:SkillTempInfo = null;
         var _loc7_:SkillPropertyTempInfo = null;
         var _loc20_:int = 0;
         if(tipData)
         {
            _loc16_ = tipData as GoodsInfo;
            _loc12_ = _loc16_.model;
            if(_loc12_ == null)
            {
               _loc12_ = TheseussoulManager.Instance.model;
            }
            _loc6_ = _loc16_.templateInfo;
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_loc16_.templateInfo.TemplateId);
            _profileImg.setFrame(_loc16_.templateInfo.Profile);
            _profieBack.setFrame(_loc16_.templateInfo.Profile);
            _title.setFrame(_loc16_.templateInfo.Profile);
            _title.text = _loc16_.templateInfo.TemplateName;
            _title.height = 42;
            _title.wordWrap = true;
            _type.text = LanguageMgr.GetTranslation("theseus.equip.part" + _loc6_.Property3);
            _profieBack.height = _totalBox.y + _totalBox.height + 10;
            _subBox1.removeAllChild();
            _subBox1.beginChanges();
            _loc1_ = _loc6_.hasValueAtt;
            _loc18_ = 0;
            _loc18_ = 0;
            while(_loc18_ < _loc1_.length)
            {
               _loc9_ = _loc1_[_loc18_];
               _loc23_ = AttributeUtils.getAttributeName(_loc9_);
               _loc8_ = int(_loc6_[_loc9_]);
               _loc25_ = new SkillTipItem();
               _loc26_ = _loc23_ + "  " + _loc8_;
               _loc25_.setTxtFrame(3);
               _loc25_.setSkillTxt(_loc26_);
               _subBox1.addChild(_loc25_);
               _loc18_++;
            }
            _loc1_ = _loc6_.hasValueAttResi;
            _loc18_ = 0;
            while(_loc18_ < _loc1_.length)
            {
               _loc9_ = _loc1_[_loc18_];
               _loc23_ = AttributeUtils.getAttributeName(_loc9_);
               _loc8_ = int(_loc6_[_loc9_]);
               _loc25_ = new SkillTipItem();
               _loc26_ = _loc23_ + "  " + _loc8_;
               _loc25_.setTxtFrame(3);
               _loc25_.setSkillTxt(_loc26_);
               _subBox1.addChild(_loc25_);
               _loc18_++;
            }
            _subBox1.commitChanges();
            _subBox2.removeAllChild();
            _loc3_ = _loc12_.suitInfo;
            _loc22_ = _loc3_.getParts(_loc6_.Property2);
            _loc14_ = _loc3_.getSuitArray(_loc6_.Property1);
            _loc4_ = _loc3_.getOneSuitMinLv(_loc6_.Property1,_loc6_.Property2);
            _loc10_ = int(_loc22_.length);
            _loc13_ = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
            _subBox2.addChild(_loc13_);
            _loc17_ = TheseussoulModel.SONTYPES;
            _loc18_ = 0;
            while(_loc18_ < _loc10_)
            {
               _loc15_ = int(_loc22_[_loc18_]);
               _loc21_ = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
               if(_loc18_ % 2 == 0)
               {
                  _loc24_ = new Sprite();
                  _subBox2.addChild(_loc24_);
               }
               else
               {
                  _loc21_.x = 100;
               }
               _loc21_.text = LanguageMgr.GetTranslation("theseus.equip.part" + _loc17_[_loc15_]);
               if(int(_loc14_[_loc15_]) > 0)
               {
                  _loc5_++;
                  _loc21_.setFrame(2);
               }
               else
               {
                  _loc21_.setFrame(1);
               }
               _loc24_.addChild(_loc21_);
               _loc18_++;
            }
            _loc2_ = TempleteManager.instance.theseusEquipSuitCate.getTempInfo(_loc6_.Property1,_loc6_.Property2,_loc4_);
            _loc11_ = _loc2_[0] != null ? _loc2_[0] : _loc2_[1];
            if(_loc11_)
            {
               _loc13_.text = _loc11_.SuiteName + "(" + _loc5_ + "/" + _loc10_ + ")";
               _loc19_ = TempleteManager.instance.skillTemplateDic[_loc11_.SkillId];
               if(_loc19_)
               {
                  _loc7_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc19_.TemplateId);
                  if(_loc7_)
                  {
                     _subBox2.beginChanges();
                     _loc1_ = _loc7_.hasValueAtt.concat(_loc7_.hasKanAtt);
                     _loc20_ = 1;
                     if(_loc5_ == _loc10_ && _loc4_ >= _loc11_.NeedMinLevel)
                     {
                        _loc20_ = 1;
                        _loc13_.setFrame(2);
                     }
                     else
                     {
                        _loc20_ = 2;
                        _loc13_.setFrame(1);
                     }
                     _loc18_ = 0;
                     while(_loc18_ < _loc1_.length)
                     {
                        _loc9_ = _loc1_[_loc18_];
                        _loc23_ = AttributeUtils.getAttributeName(_loc9_);
                        _loc8_ = int(_loc7_[_loc9_]);
                        _loc26_ = _loc23_ + "+" + _loc8_;
                        _loc25_ = new SkillTipItem();
                        _loc25_.setSkillTxt(_loc26_);
                        _loc25_.setTxtFrame(_loc20_);
                        _subBox2.addChild(_loc25_);
                        _loc18_++;
                     }
                     if(_loc19_.Description != null && _loc19_.Description.length > 1)
                     {
                        _loc25_ = new SkillTipItem();
                        _loc25_.setSkillTxt(_loc19_.Description);
                        _loc25_.setTxtFrame(_loc20_);
                        _subBox2.addChild(_loc25_);
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

