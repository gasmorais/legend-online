package armyII.viewII.stone.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.RuneFsgainTempInfo;
   import yishi.datas.templates.RuneHoleTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.FlickerHelper;
   import yishi.utils.SimpleDictionary;
   
   public class StoneGroupItem extends Sprite
   {
      
      private var _dkvbox:VBox;
      
      private var _opspanel:ScrollPanel;
      
      private var _equipHbox:HBox;
      
      private var _dkft:Image;
      
      private var _equipItemList:Array = [];
      
      private var _type:int;
      
      private var _txtbg:ScaleBitmapImage;
      
      private const OP_TYPE_0:int = 0;
      
      private const OP_TYPE_2:int = 2;
      
      private var _effctTxtDic:Dictionary;
      
      public function StoneGroupItem(param1:int = 0)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:StoneBagCell = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(_type == 0)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("army.stone.equipInStoneItem");
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("army.stone.equipInStoneItem2");
            }
            _equipItemList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _dkvbox = ComponentFactory.Instance.creatCustomObject("ui.army.dkvbox");
         if(_type == 0)
         {
            _opspanel = ComponentFactory.Instance.creatComponentByStylename("ui.army.opspanel");
         }
         else
         {
            _opspanel = ComponentFactory.Instance.creatComponentByStylename("ui.army.opspanel2");
            _txtbg = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.ggTxtBg2");
         }
         _equipHbox = ComponentFactory.Instance.creatComponentByStylename("army.runeEquipbag.hbox");
         _dkft = ComponentFactory.Instance.creatComponentByStylename("ui.army.dkft");
         addChild(_equipHbox);
         if(_txtbg)
         {
            addChild(_txtbg);
         }
         addChild(_opspanel);
         addChild(_dkft);
         _opspanel.setView(_dkvbox);
      }
      
      public function updateView(param1:String, param2:int) : void
      {
         var _loc9_:int = 0;
         _loc9_ = 10;
         var _loc13_:int = 0;
         var _loc17_:GoodsInfo = null;
         var _loc3_:StoneBagCell = null;
         var _loc8_:int = 0;
         var _loc18_:int = 0;
         var _loc5_:RuneHoleTempInfo = null;
         var _loc4_:* = null;
         var _loc15_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:int = 0;
         _effctTxtDic = new Dictionary();
         var _loc10_:Array = param1.split("|");
         var _loc19_:Array = _loc10_ ? _loc10_[0].split(",") : [];
         var _loc6_:Array = _loc10_ ? _loc10_[1].split(",") : [];
         var _loc16_:SimpleDictionary = GoodsManager.instance.getRuneEquipBagList(param2);
         var _loc12_:int = int(_loc6_.length);
         _equipHbox.removeAllChild();
         _equipHbox.beginChanges();
         var _loc14_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc12_)
         {
            _loc3_ = _equipItemList[_loc7_];
            _loc3_.isSuit = false;
            _loc11_ = int(_loc6_[_loc7_]);
            _loc3_.xing = _loc11_;
            _loc13_ = (param2 - 1) * 10 + _loc7_;
            _loc17_ = _loc16_[_loc13_];
            if(_type == 0)
            {
               _loc3_.data = _loc17_;
            }
            _loc3_.pos = _loc7_;
            if(_loc14_ < _loc7_ + 1)
            {
               _loc18_ = int(_loc19_[_loc8_]);
               _loc8_++;
               _loc5_ = TempleteManager.instance.runeHoleInfoCate.getInfoById(_loc18_);
               if(_loc14_ == 0)
               {
                  _dkvbox.removeAllChild();
                  _dkvbox.beginChanges();
                  if(_loc5_.GainEffectID1 > 0)
                  {
                     createEffectTxt(_loc5_.GainEffectID1,1);
                  }
                  if(_loc5_.GainEffectID2 > 0)
                  {
                     createEffectTxt(_loc5_.GainEffectID2,2);
                  }
                  _dkvbox.commitChanges();
                  _opspanel.invalidateViewport();
               }
               _loc15_ = int(_loc5_.Length);
               _loc14_ += _loc15_;
               _loc15_--;
            }
            if(_loc15_ > 0)
            {
               _loc15_--;
               _loc3_.isSuit = true;
            }
            _equipHbox.addChild(_loc3_);
            _loc7_++;
         }
         _equipHbox.commitChanges();
         if(_type == 0)
         {
            updateGrades();
         }
      }
      
      public function playEff(param1:int) : void
      {
         var _loc2_:StoneBagCell = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _equipHbox.numChildren)
         {
            _loc2_ = _equipHbox.getChildAt(_loc3_) as StoneBagCell;
            if(_loc2_.xing == param1)
            {
               FlickerHelper.setFilcker(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function stopEff() : void
      {
         for each(var _loc1_:StoneBagCell in _equipItemList)
         {
            FlickerHelper.clearFilcker(_loc1_);
         }
      }
      
      public function playOpenEffect(param1:Boolean = false) : void
      {
         var _loc2_:StoneBagCell = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:Number = 0.4;
         var _loc4_:int = int(_equipHbox.numChildren);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc2_ = _equipHbox.getChildAt(_loc6_) as StoneBagCell;
            if(_loc6_ == _loc4_ - 1)
            {
               _loc2_.playEffect(_loc6_ * _loc5_,param1);
            }
            else
            {
               _loc2_.playEffect(_loc6_ * _loc5_);
            }
            _loc6_++;
         }
      }
      
      public function updateItemCell(param1:int, param2:GoodsInfo) : void
      {
         var _loc3_:StoneBagCell = _equipHbox.getChildAt(param1) as StoneBagCell;
         if(_loc3_)
         {
            _loc3_.data = param2;
            updateGrades();
         }
      }
      
      private function updateGrades() : void
      {
         var _loc2_:StoneBagCell = null;
         var _loc5_:int = 0;
         var _loc1_:FilterFrameText = null;
         var _loc3_:Dictionary = new Dictionary();
         var _loc6_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _equipHbox.numChildren)
         {
            _loc2_ = _equipHbox.getChildAt(_loc5_) as StoneBagCell;
            if(_loc2_ && _loc2_.data)
            {
               if(!_loc3_[_loc2_.data.templateInfo.Property1])
               {
                  _loc3_[_loc2_.data.templateInfo.Property1] = _loc2_.data.strengthenGrade;
               }
               else
               {
                  _loc3_[_loc2_.data.templateInfo.Property1] += _loc2_.data.strengthenGrade;
               }
               _loc6_ += _loc2_.data.strengthenGrade;
            }
            _loc5_++;
         }
         _loc3_[99] = _loc6_;
         var _loc7_:int = 0;
         for each(var _loc4_:Array in _effctTxtDic)
         {
            _loc7_ = int(_loc3_[_loc4_[2]]);
            _loc1_ = _loc4_[0];
            if(_loc7_ >= _loc4_[1])
            {
               _loc1_.setFrame(1);
            }
            else
            {
               _loc1_.setFrame(2);
            }
         }
      }
      
      private function createEffectTxt(param1:int, param2:int) : void
      {
         var _loc16_:String = null;
         var _loc9_:String = null;
         var _loc8_:Array = null;
         var _loc5_:String = null;
         var _loc17_:String = null;
         var _loc7_:Array = null;
         var _loc15_:int = 0;
         var _loc12_:String = null;
         var _loc11_:int = 0;
         var _loc4_:String = null;
         var _loc14_:SkillTempInfo = null;
         var _loc3_:String = "";
         var _loc10_:String = "";
         var _loc6_:RuneFsgainTempInfo = TempleteManager.instance.runeFsgainInfoCate.getInfoById(param1);
         var _loc13_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("army.stone.propertyTxt");
         _loc13_.width = _opspanel.width - 20;
         _effctTxtDic[param1] = [_loc13_,_loc6_.ConditionParam,_loc6_.Condition];
         if(_loc6_.Condition > 0)
         {
            _loc16_ = LanguageMgr.GetTranslation("army.stone.group.grade" + _loc6_.Condition,_loc6_.ConditionParam);
            _loc3_ = LanguageMgr.GetTranslation("army.stone.activeFlg",_loc16_);
         }
         if(_loc6_.EffectType == 1)
         {
            _loc9_ = LanguageMgr.GetTranslation("army.stone.property" + _loc6_.AttributeType);
            if(_loc6_.ValueType == 0)
            {
               _loc9_ += "+" + _loc6_.ValueParam;
            }
            else if(_loc6_.ValueType == 1)
            {
               _loc8_ = _loc6_.ValueParam.split(",");
               _loc5_ = LanguageMgr.GetTranslation("army.stone.px" + _loc8_[0],_loc8_[1]);
               _loc9_ += _loc5_;
            }
            if(_loc6_.RuneType != null && _loc6_.RuneType != "" && _loc6_.RuneType != "0")
            {
               _loc17_ = LanguageMgr.GetTranslation("army.stone.dot");
               _loc7_ = _loc6_.RuneType.split(",");
               _loc15_ = int(_loc7_.length);
               _loc12_ = "";
               _loc11_ = 0;
               while(_loc11_ < _loc15_)
               {
                  if(_loc11_ < _loc15_ - 1)
                  {
                     _loc12_ += LanguageMgr.GetTranslation("army.stone.ot" + _loc7_[_loc11_]) + _loc17_;
                  }
                  else
                  {
                     _loc12_ += LanguageMgr.GetTranslation("army.stone.ot" + _loc7_[_loc11_]);
                  }
                  _loc11_++;
               }
               _loc4_ = LanguageMgr.GetTranslation("army.stone.ot0",_loc12_);
               _loc9_ += _loc4_;
            }
            _loc10_ = LanguageMgr.GetTranslation("army.stone.activeXiao",_loc9_);
         }
         else if(_loc6_.EffectType == 2)
         {
            if(_loc6_.NewRuneSkill > 0)
            {
               _loc14_ = TempleteManager.instance.getSkillById(_loc6_.NewRuneSkill);
               _loc10_ = LanguageMgr.GetTranslation("army.stone.activeXiao",_loc14_.Description);
            }
         }
         _loc13_.setFrame(2);
         _loc13_.htmlText = param2 + "." + _loc3_ + _loc10_;
         _loc13_.height = _loc13_.numLines * 20;
         _dkvbox.addChild(_loc13_);
      }
      
      public function dispose() : void
      {
         stopEff();
         ObjectUtils.disposeObject(_opspanel);
         _opspanel = null;
         ObjectUtils.disposeObject(_dkvbox);
         _dkvbox = null;
         ObjectUtils.disposeObject(_dkft);
         _dkft = null;
         LogicUtils.disposeDisplayCollection(_equipItemList);
         _equipItemList = null;
         ObjectUtils.disposeObject(_equipHbox);
         _equipHbox = null;
         ObjectUtils.disposeObject(_txtbg);
         _txtbg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

