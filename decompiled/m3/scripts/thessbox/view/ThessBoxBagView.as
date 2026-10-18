package thessbox.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.ThessboxFightInfo;
   import thessbox.ui.ThessBoxBagUI;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.manager.TempleteManager;
   
   public class ThessBoxBagView extends ThessBoxBagUI
   {
      
      private var _pos1Cell:ThessBoxSkillCell;
      
      private var _pos2Cell:ThessBoxSkillCell;
      
      private var _pos3Cell:ThessBoxSkillCell;
      
      private var _panel:ScrollPanel;
      
      private var _panelList:SimpleTileList;
      
      private var _itemList:Array = [];
      
      private var _tName1:GradientText;
      
      private var _tName2:GradientText;
      
      private var _pro:Bitmap;
      
      private var _desTxt:FilterFrameText;
      
      private var _desPanel:ScrollPanel;
      
      private var _reg:RegExp = /[0-9%]+/g;
      
      public function ThessBoxBagView()
      {
         super();
         addView();
         updateView();
      }
      
      private function addView() : void
      {
         _pos1Cell = ComponentFactory.Instance.creatCustomObject("ui.thessbox.skCell1",[2]);
         _pos2Cell = ComponentFactory.Instance.creatCustomObject("ui.thessbox.skCell2",[2]);
         _pos3Cell = ComponentFactory.Instance.creatCustomObject("ui.thessbox.skCell3",[2]);
         _panel = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skBagPanel");
         _panelList = ComponentFactory.Instance.creatCustomObject("ui.thessbox.skBagList",[4]);
         _tName1 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skNameTxt1");
         _tName2 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skNameTxt2");
         _pro = ComponentFactory.Instance.creatBitmap("asset.thessbox.proFt");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skdesBigTxt");
         _desPanel = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skDesBigPanel");
         _panel.setView(_panelList);
         _desPanel.setView(_desTxt);
         addChild(_pos1Cell);
         addChild(_pos2Cell);
         addChild(_pos3Cell);
         addChild(_tName1);
         addChild(_tName2);
         addChild(_panel);
         addChild(_pro);
         addChild(_desPanel);
         _tName1.text = LanguageMgr.GetTranslation("thessbox.skT1");
         _tName2.text = LanguageMgr.GetTranslation("thessbox.skT2");
      }
      
      public function updateView() : void
      {
         var _loc9_:ThessBoxSkillCell = null;
         var _loc5_:int = 0;
         var _loc8_:Array = null;
         var _loc12_:SkillPropertyTempInfo = null;
         var _loc4_:int = 0;
         _loc4_ = 36;
         var _loc6_:Boolean = false;
         var _loc10_:int = 0;
         var _loc14_:ThessboxFightInfo = TheseussoulManager.Instance.thessboxInInfo;
         var _loc11_:Array = _loc14_.equipSkills.split(",");
         _pos1Cell.data = int(_loc11_[0]);
         _pos2Cell.data = int(_loc11_[1]);
         _pos3Cell.data = int(_loc11_[2]);
         _panelList.beginChanges();
         var _loc15_:int = int(_loc14_.allSkills.length);
         var _loc7_:int = 0;
         var _loc18_:String = "";
         var _loc2_:Dictionary = new Dictionary();
         var _loc16_:Dictionary = new Dictionary();
         var _loc17_:Array = [];
         var _loc3_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc15_)
         {
            _loc5_ = int(_loc14_.allSkills[_loc7_]);
            _loc12_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc5_);
            if(_loc12_)
            {
               _loc8_ = _loc12_.allAttName;
               for each(var _loc1_:String in _loc8_)
               {
                  if(_loc12_.AddType == 0)
                  {
                     if(_loc16_[_loc1_])
                     {
                        var _loc19_:* = _loc1_;
                        var _loc20_:* = _loc16_[_loc19_] + _loc12_[_loc1_];
                        _loc16_[_loc19_] = _loc20_;
                     }
                     else
                     {
                        _loc16_[_loc1_] = _loc12_[_loc1_];
                        if(_loc17_.indexOf(_loc1_) == -1)
                        {
                           _loc17_.push(_loc1_);
                        }
                     }
                  }
                  else if(_loc12_.AddType == 1)
                  {
                     if(_loc2_[_loc1_])
                     {
                        _loc20_ = _loc1_;
                        _loc19_ = _loc2_[_loc20_] + _loc12_[_loc1_];
                        _loc2_[_loc20_] = _loc19_;
                     }
                     else
                     {
                        _loc2_[_loc1_] = _loc12_[_loc1_];
                        if(_loc17_.indexOf(_loc1_) == -1)
                        {
                           _loc17_.push(_loc1_);
                        }
                     }
                  }
               }
            }
            else
            {
               _loc3_.push(_loc5_);
            }
            _loc7_++;
         }
         _loc15_ = int(_loc3_.length);
         _loc7_ = 0;
         while(_loc7_ < 36)
         {
            _loc9_ = new ThessBoxSkillCell(2);
            if(_loc7_ < _loc15_)
            {
               _loc5_ = int(_loc3_[_loc7_]);
            }
            else
            {
               _loc5_ = -1;
            }
            _loc9_.data = _loc5_;
            _panelList.addChild(_loc9_);
            _itemList.push(_loc9_);
            _loc7_++;
         }
         for each(var _loc13_:String in _loc17_)
         {
            _loc6_ = false;
            _loc10_ = int(_loc2_[_loc13_]);
            if(_loc10_ != 0)
            {
               _loc6_ = true;
               _loc18_ += AttributeUtils.getAtrributeByKey(_loc13_,_loc10_,"#00FF00");
            }
            _loc10_ = int(_loc16_[_loc13_]);
            if(_loc10_ != 0)
            {
               if(_loc6_)
               {
                  _loc18_ += AttributeUtils.getColorStr(_loc10_ > 0 ? ",+" + _loc10_ + "%" : "," + _loc10_ + "%","#00FF00") + "\n\n";
               }
               else
               {
                  _loc18_ += AttributeUtils.getAtrributeByKey(_loc13_,_loc16_[_loc13_],"#00FF00","%") + "\n\n";
               }
            }
            else if(_loc6_)
            {
               _loc18_ += "\n\n";
            }
         }
         _desTxt.htmlText = _loc18_;
         _desTxt.height = _desTxt.numLines * 18;
         _desPanel.invalidateViewport();
         _panelList.commitChanges();
         _panel.invalidateViewport();
      }
      
      private function changeNumColor(param1:String) : String
      {
         return param1.replace(_reg,regFun);
      }
      
      private function regFun() : String
      {
         return "<font color=\'#00ff00\'>" + arguments[0] + "</font>";
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_pos1Cell);
         _pos1Cell = null;
         ObjectUtils.disposeObject(_pos2Cell);
         _pos2Cell = null;
         ObjectUtils.disposeObject(_pos3Cell);
         _pos3Cell = null;
         ObjectUtils.disposeObject(_tName1);
         _tName1 = null;
         ObjectUtils.disposeObject(_tName2);
         _tName2 = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_panelList);
         _panelList = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_pro);
         _pro = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_desPanel);
         _desPanel = null;
         super.dispose();
      }
   }
}

