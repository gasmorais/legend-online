package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.WarSoulReformTempInfo;
   import yishi.datas.templates.WarSoulStarTempInfo;
   import yishi.datas.templates.WarSoulStrengthenTempInfo;
   import yishi.datas.templates.WarSoulTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.goods.SkillTipItem;
   
   public class TheseusWarsoulEquipTip extends BaseTip
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
      
      private var _gemTxt1:FilterFrameText;
      
      private var _gemTxt2:FilterFrameText;
      
      private var _gemTxt3:FilterFrameText;
      
      private var _gemTxt4:FilterFrameText;
      
      private var _gemTxt5:FilterFrameText;
      
      private var _line1:Bitmap;
      
      private var _line2:Bitmap;
      
      private var _line3:Bitmap;
      
      private var _line4:Bitmap;
      
      private var attBox:VBox;
      
      private var attList:Array = [];
      
      private var refreshBox:VBox;
      
      private var refreshList:Array = [];
      
      private var bskBox:VBox;
      
      private var bSkList:Array = [];
      
      private var zhYiPanel:SimpleTileList;
      
      private var zhYiList:Array = [];
      
      private var _starNum:int = -1;
      
      public function TheseusWarsoulEquipTip()
      {
         super();
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
         _gemTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         _gemTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         _gemTxt3 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         _gemTxt4 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         _gemTxt5 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         _gemTxt1.text = LanguageMgr.GetTranslation("theseus.war.tipxl");
         _gemTxt2.text = LanguageMgr.GetTranslation("theseus.war.tipzy");
         _gemTxt3.text = LanguageMgr.GetTranslation("theseus.war.tipzsk");
         _gemTxt4.text = LanguageMgr.GetTranslation("theseus.war.tipbsk");
         _gemTxt0.x = 145;
         _gemTxt0.y = 75;
         _gemTxt0.width = 200;
         _typeTxt.x = -14;
         _typeTxt.y = 55;
         _typeTxt.width = 90;
         _gzTxt.x = 81;
         attBox = ComponentFactory.Instance.creatComponentByStylename("theseuswarTip.TipsVBox");
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new TheseusAttributeItem();
            attList[_loc2_] = _loc1_;
            _loc2_++;
         }
         refreshBox = ComponentFactory.Instance.creatComponentByStylename("theseuswarTip.TipsVBox");
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new TheseusAttributeItem();
            refreshList[_loc2_] = _loc1_;
            _loc2_++;
         }
         bskBox = ComponentFactory.Instance.creatComponentByStylename("theseuswarTip.TipsVBox");
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc1_ = new TheseusAttributeItem();
            bSkList[_loc2_] = _loc1_;
            _loc2_++;
         }
         zhYiPanel = new SimpleTileList(2);
         zhYiPanel.hSpace = -180;
         zhYiPanel.vSpace = 0;
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = new TheseusAttributeItem();
            zhYiList[_loc2_] = _loc1_;
            _loc2_++;
         }
         addChild(_equipIcon);
         addChild(_profileImg);
         _profileImg.setFrame(1);
         addChild(_addImg);
         addChild(_strengNumSprite);
         addChild(_title);
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
         var _loc6_:int = (param1 - 1) / 5 + 1;
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
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.core.profie.star" + _loc6_);
               _starContaint.addChild(_loc2_);
            }
            _loc5_++;
         }
         _starContaint.commitChanges();
      }
      
      private function updateAttItem(param1:TheseusWarsoulItemInfo, param2:TheseusAttributeItem, param3:String) : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:String = "    ";
         if(param1.warStartempInfo)
         {
            _loc5_ = int(param1.warStartempInfo[param3]);
            _loc8_ = param1.warTempInfo[param3] * _loc5_ / 100;
            _loc9_ = AttributeUtils.getAttributeName(param3,2) + _loc7_ + _loc8_;
            _loc9_ = AttributeUtils.getColorStr(_loc9_,"#B3B3B3");
         }
         if(param1.warStrengthTempInfo)
         {
            _loc6_ = int(param1.warStrengthTempInfo[param3]);
            if(param1.strengthen > 0 && _loc6_ > 0)
            {
               _loc8_ = _loc6_ * _loc5_ / 100;
               _loc9_ += _loc7_ + LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text01") + "+" + _loc8_;
            }
            _loc4_ = int(param1.warReformTempInfo[param3]);
            if(param1.reform > 0 && _loc4_ > 0)
            {
               _loc9_ += _loc7_ + LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text05") + "+" + _loc4_;
            }
         }
         if(_loc9_)
         {
            param2.setTextValue(_loc9_);
         }
      }
      
      override protected function updateTransform() : void
      {
         var _loc34_:Array = null;
         var _loc26_:WarSoulTempInfo = null;
         var _loc31_:WarSoulStarTempInfo = null;
         var _loc23_:WarSoulReformTempInfo = null;
         var _loc7_:WarSoulStrengthenTempInfo = null;
         var _loc13_:Array = null;
         var _loc32_:String = null;
         var _loc24_:String = null;
         var _loc2_:String = null;
         var _loc18_:String = null;
         var _loc14_:int = 0;
         var _loc3_:int = 0;
         var _loc33_:int = 0;
         var _loc28_:int = 0;
         var _loc8_:int = 0;
         var _loc22_:TheseusAttributeItem = null;
         var _loc9_:* = null;
         var _loc1_:SkillTempInfo = null;
         var _loc29_:int = 0;
         var _loc11_:int = 0;
         var _loc37_:Array = null;
         var _loc36_:Boolean = false;
         var _loc27_:int = 0;
         var _loc20_:String = null;
         var _loc25_:Array = null;
         var _loc15_:Array = null;
         var _loc16_:String = null;
         var _loc17_:Array = null;
         var _loc30_:int = 0;
         var _loc6_:String = null;
         var _loc10_:int = 0;
         var _loc19_:SkillTempInfo = null;
         var _loc35_:Array = null;
         var _loc12_:SkillTempInfo = null;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc21_:TheseusWarsoulItemInfo = tipData as TheseusWarsoulItemInfo;
         if(_loc21_)
         {
            _loc34_ = ["ui.theseussoul.posUp","ui.theseussoul.posMid","ui.theseussoul.posDown"];
            _loc26_ = _loc21_.warTempInfo;
            _loc31_ = _loc21_.warStartempInfo;
            _loc23_ = _loc21_.warReformTempInfo;
            _loc7_ = _loc21_.warStrengthTempInfo;
            _loc13_ = ["#59cd41","#33a6ff","#1aecff"];
            _loc32_ = AttributeUtils.getColorStr(LanguageMgr.GetTranslation("theseus.war.type" + _loc26_.MainType),_loc13_[_loc26_.MainType - 1]);
            _loc24_ = LanguageMgr.GetTranslation(_loc34_[_loc26_.Rank - 1 >= 0 ? _loc26_.Rank - 1 : 0]);
            _typeTxt.htmlText = _loc24_ + " " + _loc32_;
            _loc2_ = GoodsHelp.getGoodColorString(_loc21_.reform);
            _loc18_ = AttributeUtils.getColorStr(LanguageMgr.GetTranslation("theseus.war.gz" + _loc21_.reform),_loc2_,false);
            _gzTxt.htmlText = _loc18_;
            _equipIcon.icon = IconFactory.getTheseusWarSoulIcon(_loc26_.Icon);
            _profileImg.setFrame(_loc26_.Profile);
            _title.setFrame(_loc26_.Profile);
            _title.text = _loc26_.Name;
            if(_loc21_.warStartempInfo)
            {
               _gemTxt0.text = LanguageMgr.GetTranslation("goddess.equip.tipMax",_loc21_.warStartempInfo.MaxGrade);
            }
            showStar(_loc21_.star);
            _strengNumSprite.x = _addImg.x + 15;
            _loc14_ = int(_loc21_.warTempInfo.Attack);
            _loc3_ = int(_loc21_.warTempInfo.Defence);
            _loc33_ = int(_loc21_.warTempInfo.MagicAttack);
            _loc28_ = int(_loc21_.warTempInfo.MagicDefence);
            _loc8_ = int(_loc21_.warTempInfo.Live);
            if(_loc21_.strengthen > 0 && _loc7_)
            {
               _addImg.visible = true;
               _strengNumSprite.visible = true;
               setStrengNum(_loc21_.strengthen);
               _loc14_ += _loc7_.Attack;
               _loc3_ += _loc7_.Defence;
               _loc33_ += _loc7_.MagicAttack;
               _loc28_ += _loc7_.MagicDefence;
               _loc8_ += _loc7_.Live;
            }
            else
            {
               _addImg.visible = false;
               _strengNumSprite.visible = false;
            }
            if(_loc21_.reform > 0 && _loc23_)
            {
               _loc14_ += _loc23_.Attack;
               _loc3_ += _loc23_.Defence;
               _loc33_ += _loc23_.MagicAttack;
               _loc28_ += _loc23_.MagicDefence;
               _loc8_ += _loc23_.Live;
            }
            _totalBox.beginChanges();
            _totalBox.removeAllChild();
            attBox.beginChanges();
            attBox.removeAllChild();
            if(_loc14_ > 0)
            {
               _loc22_ = attList[0];
               updateAttItem(_loc21_,_loc22_,"Attack");
               attBox.addChild(_loc22_);
            }
            if(_loc3_ > 0)
            {
               _loc22_ = attList[1];
               updateAttItem(_loc21_,_loc22_,"Defence");
               attBox.addChild(_loc22_);
            }
            if(_loc33_ > 0)
            {
               _loc22_ = attList[2];
               updateAttItem(_loc21_,_loc22_,"MagicAttack");
               attBox.addChild(_loc22_);
            }
            if(_loc28_ > 0)
            {
               _loc22_ = attList[3];
               updateAttItem(_loc21_,_loc22_,"MagicDefence");
               attBox.addChild(_loc22_);
            }
            if(_loc8_ > 0)
            {
               _loc22_ = attList[4];
               updateAttItem(_loc21_,_loc22_,"Live");
               attBox.addChild(_loc22_);
            }
            attBox.commitChanges();
            _totalBox.addChild(_line1);
            _totalBox.addChild(attBox);
            if(_loc21_.learnSkill > 0)
            {
               _loc1_ = TempleteManager.instance.getSkillById(_loc21_.learnSkill);
               _gemTxt5.text = _loc1_.TemplateName;
               _totalBox.addChild(_gemTxt5);
               _loc22_ = attList[5];
               _loc22_.setTextValue(_loc1_.Description);
               _totalBox.addChild(_loc22_);
            }
            _loc29_ = 0;
            if(_loc21_.ramdomSkills)
            {
               _loc37_ = _loc21_.ramdomSkills.split(",");
               _loc11_ = int(_loc37_.length);
               _loc29_ = 0;
               while(_loc29_ < _loc11_)
               {
                  _loc27_ = int(_loc37_[_loc29_]);
                  if(_loc27_ > 0)
                  {
                     _loc36_ = true;
                     break;
                  }
                  _loc29_++;
               }
               if(_loc36_)
               {
                  _totalBox.addChild(_line2);
                  _totalBox.addChild(_gemTxt1);
                  refreshBox.beginChanges();
                  refreshBox.removeAllChild();
                  _loc29_ = 0;
                  while(_loc29_ < _loc11_)
                  {
                     _loc27_ = int(_loc37_[_loc29_]);
                     if(_loc27_ > 0)
                     {
                        _loc1_ = TempleteManager.instance.getSkillById(_loc27_);
                        if(_loc1_)
                        {
                           _loc22_ = refreshList[_loc29_];
                           if(_loc22_ == null)
                           {
                              _loc22_ = new TheseusAttributeItem();
                              refreshList[_loc29_] = _loc22_;
                           }
                           if(_loc1_.Parameter3 <= 0)
                           {
                              _loc20_ = _loc1_.Description + LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades1",_loc1_.Grades);
                           }
                           else
                           {
                              _loc20_ = _loc1_.Description + LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades2",_loc1_.Grades);
                           }
                           _loc22_.setTextValue(_loc20_);
                           refreshBox.addChild(_loc22_);
                        }
                     }
                     _loc29_++;
                  }
                  refreshBox.commitChanges();
                  _totalBox.addChild(refreshBox);
               }
            }
            if(_loc21_.reformBuffList && _loc21_.reformBuffList.length > 0)
            {
               _totalBox.addChild(_gemTxt2);
               zhYiPanel.beginChanges();
               zhYiPanel.removeAllChild();
               _loc25_ = [1,3,4,5,2,6,9,10,11,12,7,8];
               _loc15_ = [0,2,3,4,1,5,8,8,9,9,6,7];
               _loc29_ = 0;
               while(_loc29_ < _loc21_.reformBuffList.length)
               {
                  _loc16_ = _loc21_.reformBuffList[_loc29_];
                  _loc17_ = _loc16_.split(",");
                  _loc30_ = int(_loc17_[0]);
                  _loc10_ = _loc25_.indexOf(_loc30_);
                  _loc6_ = LanguageMgr.GetTranslation("theseus.equip.part" + _loc15_[_loc10_]) + "+" + _loc17_[1];
                  _loc22_ = zhYiList[_loc29_];
                  _loc22_.setTextValue(_loc6_);
                  zhYiPanel.addChild(_loc22_);
                  _loc29_++;
               }
               zhYiPanel.commitChanges();
               _totalBox.addChild(zhYiPanel);
            }
            if(_loc7_)
            {
               _loc19_ = TempleteManager.instance.getSkillById(_loc7_.OpenActiveSkill);
               if(_loc19_)
               {
                  _totalBox.addChild(_line4);
                  _totalBox.addChild(_gemTxt3);
                  _loc22_ = attList[6];
                  _loc22_.setTextValue(_loc19_.Description);
                  _totalBox.addChild(_loc22_);
               }
               _loc35_ = _loc7_.OpenPassiveSkill.split(",");
               _loc11_ = int(_loc35_.length);
               bskBox.beginChanges();
               bskBox.removeAllChild();
               _loc29_ = 0;
               while(_loc29_ < _loc11_)
               {
                  _loc4_ = int(_loc35_[_loc29_]);
                  if(_loc4_ > 0)
                  {
                     if(!_loc5_)
                     {
                        _loc5_ = true;
                        _totalBox.addChild(_gemTxt4);
                     }
                     _loc12_ = TempleteManager.instance.getSkillById(_loc4_);
                     if(_loc12_)
                     {
                        _loc22_ = bSkList[_loc29_];
                        if(_loc22_ == null)
                        {
                           _loc22_ = new TheseusAttributeItem();
                           bSkList[_loc29_] = _loc22_;
                        }
                        _loc22_.setTextValue(_loc12_.Description);
                        bskBox.addChild(_loc22_);
                     }
                  }
                  _loc29_++;
               }
               bskBox.commitChanges();
               _totalBox.addChild(bskBox);
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
         for each(_loc1_ in refreshList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         refreshList = null;
         for each(_loc1_ in bSkList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         bSkList = null;
         for each(_loc1_ in zhYiList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         zhYiList = null;
         ObjectUtils.disposeObject(attBox);
         attBox = null;
         ObjectUtils.disposeObject(refreshBox);
         refreshBox = null;
         ObjectUtils.disposeObject(bskBox);
         bskBox = null;
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
         ObjectUtils.disposeObject(_gemTxt0);
         _gemTxt0 = null;
         ObjectUtils.disposeObject(_gemTxt1);
         _gemTxt1 = null;
         ObjectUtils.disposeObject(_gemTxt2);
         _gemTxt2 = null;
         ObjectUtils.disposeObject(_gemTxt3);
         _gemTxt3 = null;
         ObjectUtils.disposeObject(_gemTxt4);
         _gemTxt4 = null;
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

