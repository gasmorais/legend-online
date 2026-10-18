package armyII.viewII.stone.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.templates.RuneFsgainTempInfo;
   import yishi.datas.templates.RuneHoleTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class StonePreGroupItem extends Sprite implements IManualSize
   {
      
      private var _dkvbox:VBox;
      
      private var _opspanel:ScrollPanel;
      
      private var _equipHbox:HBox;
      
      private var _temp:RuneHoleTempInfo;
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:Bitmap;
      
      public function StonePreGroupItem()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,370,126);
      }
      
      private function initView() : void
      {
         _dkvbox = ComponentFactory.Instance.creatCustomObject("ui.army.dkvbox");
         _equipHbox = ComponentFactory.Instance.creatComponentByStylename("army.runeEquipbag.hbox");
         _opspanel = ComponentFactory.Instance.creatComponentByStylename("ui.army.opspanel4");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.preTxtBg");
         _line = ComponentFactory.Instance.creatBitmap("asset.army.stone.line");
         addChild(_equipHbox);
         addChild(_bg);
         addChild(_opspanel);
         addChild(_line);
         _equipHbox.x = 182;
         _equipHbox.y = 5;
         _opspanel.setView(_dkvbox);
      }
      
      public function set temp(param1:RuneHoleTempInfo) : void
      {
         var _loc4_:Array = null;
         var _loc2_:StonePreCell = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         _temp = param1;
         if(_temp)
         {
            _loc4_ = [];
            if(_temp.Hole1 > 0)
            {
               _loc4_.push(_temp.Hole1);
            }
            if(_temp.Hole2 > 0)
            {
               _loc4_.push(_temp.Hole2);
            }
            if(_temp.Hole3 > 0)
            {
               _loc4_.push(_temp.Hole3);
            }
            if(_temp.Hole4 > 0)
            {
               _loc4_.push(_temp.Hole4);
            }
            if(_temp.Hole5 > 0)
            {
               _loc4_.push(_temp.Hole5);
            }
            _equipHbox.removeAllChild();
            _equipHbox.beginChanges();
            _loc3_ = int(_loc4_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               if(_loc5_ < _loc3_ - 1)
               {
                  _loc2_ = new StonePreCell();
               }
               else
               {
                  _loc2_ = new StonePreCell(false);
               }
               _loc2_.xing = _loc4_[_loc5_];
               _equipHbox.addChild(_loc2_);
               _loc5_++;
            }
            _dkvbox.removeAllChild();
            _dkvbox.beginChanges();
            if(_temp.GainEffectID1 > 0)
            {
               createEffectTxt(_temp.GainEffectID1,1);
            }
            if(_temp.GainEffectID2 > 0)
            {
               createEffectTxt(_temp.GainEffectID2,2);
            }
            _dkvbox.commitChanges();
            _opspanel.invalidateViewport();
            _equipHbox.commitChanges();
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
         _loc13_.setFrame(1);
         _loc13_.htmlText = param2 + "." + _loc3_ + _loc10_;
         _loc13_.height = _loc13_.numLines * 20;
         _dkvbox.addChild(_loc13_);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_dkvbox);
         _dkvbox = null;
         ObjectUtils.disposeObject(_equipHbox);
         _equipHbox = null;
         ObjectUtils.disposeObject(_opspanel);
         _opspanel = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
      }
   }
}

