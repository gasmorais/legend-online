package yishi.view.tips.rune
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.armyII.RuneInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.RuneFsgainTempInfo;
   import yishi.datas.templates.RuneHoleTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class RuneStoneGroupContent extends Sprite
   {
      
      private var _vbox:VBox;
      
      private var _hbox:HBox;
      
      private var _itemList:Array = [];
      
      private var _proList:Array = [];
      
      private var _title:FilterFrameText;
      
      private var _line0:Bitmap;
      
      private var _line:Bitmap;
      
      private var _effectList:Array = [];
      
      private var _effctTxtDic:Dictionary;
      
      public function RuneStoneGroupContent()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc1_:RuneProItem = null;
         var _loc3_:int = 0;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _line = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line0 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _effectList[0] = ComponentFactory.Instance.creatComponentByStylename("army.stone.propertyTxt");
         _effectList[1] = ComponentFactory.Instance.creatComponentByStylename("army.stone.propertyTxt");
         _title.text = LanguageMgr.GetTranslation("runetip.title.eff");
         _effectList[0].width = 320;
         _effectList[1].width = 320;
         _vbox = new VBox();
         _hbox = new HBox();
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.tip.stone.equipInStoneItem");
            _itemList[_loc3_] = _loc2_;
            _loc1_ = new RuneProItem();
            _proList[_loc3_] = _loc1_;
            _loc3_++;
         }
         addChild(_vbox);
         _vbox.x = 10;
         _vbox.spacing = 5;
         _hbox.spacing = -5;
      }
      
      public function updateView(param1:RuneInfo) : void
      {
         _vbox.removeAllChild();
         _vbox.beginChanges();
         _vbox.addChild(_line0);
         _vbox.addChild(_title);
         _vbox.addChild(_hbox);
         updateContents(param1.runeHole,param1.templateInfo.RuneType);
         _vbox.commitChanges();
      }
      
      public function updateContents(param1:String, param2:int) : void
      {
         var _loc10_:int = 0;
         _loc10_ = 10;
         var _loc15_:int = 0;
         var _loc19_:GoodsInfo = null;
         var _loc4_:RuneXingItem = null;
         var _loc9_:int = 0;
         var _loc20_:int = 0;
         var _loc6_:RuneHoleTempInfo = null;
         var _loc5_:* = null;
         var _loc17_:int = 0;
         var _loc13_:int = 0;
         var _loc3_:RuneProItem = null;
         var _loc8_:int = 0;
         var _loc11_:FilterFrameText = null;
         _effctTxtDic = new Dictionary();
         var _loc12_:Array = param1.split("|");
         var _loc21_:Array = _loc12_ ? _loc12_[0].split(",") : [];
         var _loc7_:Array = _loc12_ ? _loc12_[1].split(",") : [];
         var _loc18_:SimpleDictionary = GoodsManager.instance.getRuneEquipBagList(param2);
         var _loc14_:int = int(_loc7_.length);
         _hbox.removeAllChild();
         _hbox.beginChanges();
         var _loc16_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc14_)
         {
            _loc4_ = _itemList[_loc8_];
            _loc3_ = _proList[_loc8_];
            _loc4_.isSuit = false;
            _loc13_ = int(_loc7_[_loc8_]);
            _loc4_.xing = _loc13_;
            _loc3_.xing = _loc13_;
            _loc15_ = (param2 - 1) * 10 + _loc8_;
            _loc19_ = _loc18_[_loc15_];
            _loc4_.data = _loc19_;
            _loc4_.pos = _loc8_;
            if(_loc16_ < _loc8_ + 1)
            {
               _loc20_ = int(_loc21_[_loc9_]);
               _loc9_++;
               _loc6_ = TempleteManager.instance.runeHoleInfoCate.getInfoById(_loc20_);
               if(_loc16_ == 0)
               {
                  if(_loc6_.GainEffectID1 > 0)
                  {
                     _loc11_ = _effectList[0];
                     createEffectTxt(_loc6_.GainEffectID1,1,_loc11_);
                  }
                  if(_loc6_.GainEffectID2 > 0)
                  {
                     _loc11_ = _effectList[1];
                     createEffectTxt(_loc6_.GainEffectID2,2,_loc11_);
                  }
               }
               _loc17_ = int(_loc6_.Length);
               _loc16_ += _loc17_;
               _loc17_--;
            }
            if(_loc17_ > 0)
            {
               _loc17_--;
               _loc4_.isSuit = true;
            }
            _hbox.addChild(_loc4_);
            _loc8_++;
         }
         _hbox.commitChanges();
         updateGrades();
      }
      
      private function createEffectTxt(param1:int, param2:int, param3:FilterFrameText) : void
      {
         var _loc16_:String = null;
         var _loc10_:String = null;
         var _loc9_:Array = null;
         var _loc6_:String = null;
         var _loc17_:String = null;
         var _loc8_:Array = null;
         var _loc15_:int = 0;
         var _loc13_:String = null;
         var _loc12_:int = 0;
         var _loc5_:String = null;
         var _loc14_:SkillTempInfo = null;
         var _loc4_:String = "";
         var _loc11_:String = "";
         var _loc7_:RuneFsgainTempInfo = TempleteManager.instance.runeFsgainInfoCate.getInfoById(param1);
         _effctTxtDic[param1] = [param3,_loc7_.ConditionParam,_loc7_.Condition];
         if(_loc7_.Condition > 0)
         {
            _loc16_ = LanguageMgr.GetTranslation("army.stone.group.grade" + _loc7_.Condition,_loc7_.ConditionParam);
            _loc4_ = LanguageMgr.GetTranslation("army.stone.activeFlg",_loc16_);
         }
         if(_loc7_.EffectType == 1)
         {
            _loc10_ = LanguageMgr.GetTranslation("army.stone.property" + _loc7_.AttributeType);
            if(_loc7_.ValueType == 0)
            {
               _loc10_ += "+" + _loc7_.ValueParam;
            }
            else if(_loc7_.ValueType == 1)
            {
               _loc9_ = _loc7_.ValueParam.split(",");
               _loc6_ = LanguageMgr.GetTranslation("army.stone.px" + _loc9_[0],_loc9_[1]);
               _loc10_ += _loc6_;
            }
            if(_loc7_.RuneType != null && _loc7_.RuneType != "" && _loc7_.RuneType != "0")
            {
               _loc17_ = LanguageMgr.GetTranslation("army.stone.dot");
               _loc8_ = _loc7_.RuneType.split(",");
               _loc15_ = int(_loc8_.length);
               _loc13_ = "";
               _loc12_ = 0;
               while(_loc12_ < _loc15_)
               {
                  if(_loc12_ < _loc15_ - 1)
                  {
                     _loc13_ += LanguageMgr.GetTranslation("army.stone.ot" + _loc8_[_loc12_]) + _loc17_;
                  }
                  else
                  {
                     _loc13_ += LanguageMgr.GetTranslation("army.stone.ot" + _loc8_[_loc12_]);
                  }
                  _loc12_++;
               }
               _loc5_ = LanguageMgr.GetTranslation("army.stone.ot0",_loc13_);
               _loc10_ += _loc5_;
            }
            _loc11_ = LanguageMgr.GetTranslation("army.stone.activeXiao",_loc10_);
         }
         else if(_loc7_.EffectType == 2)
         {
            if(_loc7_.NewRuneSkill > 0)
            {
               _loc14_ = TempleteManager.instance.getSkillById(_loc7_.NewRuneSkill);
               _loc11_ = LanguageMgr.GetTranslation("army.stone.activeXiao",_loc14_.Description);
            }
         }
         param3.setFrame(2);
         param3.text = param2 + ". " + _loc4_ + _loc11_;
         param3.height = param3.numLines * 20;
      }
      
      private function updateGrades() : void
      {
         var _loc4_:RuneXingItem = null;
         var _loc2_:RuneProItem = null;
         var _loc8_:int = 0;
         var _loc3_:FilterFrameText = null;
         var _loc6_:FilterFrameText = null;
         var _loc5_:Dictionary = new Dictionary();
         var _loc9_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _hbox.numChildren)
         {
            _loc4_ = _hbox.getChildAt(_loc8_) as RuneXingItem;
            _loc2_ = _proList[_loc8_];
            if(_loc4_ && _loc4_.data)
            {
               if(!_loc5_[_loc4_.data.templateInfo.Property1])
               {
                  _loc5_[_loc4_.data.templateInfo.Property1] = _loc4_.data.strengthenGrade;
               }
               else
               {
                  _loc5_[_loc4_.data.templateInfo.Property1] += _loc4_.data.strengthenGrade;
               }
               _loc9_ += _loc4_.data.strengthenGrade;
               _loc2_.data = _loc4_.data;
               _vbox.addChild(_loc2_);
            }
            _loc8_++;
         }
         _vbox.addChild(_line);
         _loc5_[99] = _loc9_;
         var _loc1_:int = 0;
         var _loc10_:int = 0;
         for each(var _loc7_:Array in _effctTxtDic)
         {
            _loc3_ = _loc7_[0];
            _loc10_ = int(_loc5_[_loc7_[2]]);
            if(_loc10_ >= _loc7_[1])
            {
               _loc3_.setFrame(1);
            }
            else
            {
               _loc3_.setFrame(2);
            }
            _loc1_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc1_)
         {
            _loc6_ = _effectList[_loc8_];
            _vbox.addChild(_loc6_);
            _loc8_++;
         }
      }
      
      public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         LogicUtils.disposeDisplayCollection(_proList);
         _proList = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _effctTxtDic = null;
      }
   }
}

