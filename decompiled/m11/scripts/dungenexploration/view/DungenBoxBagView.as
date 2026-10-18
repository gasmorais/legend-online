package dungenexploration.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import dungenexploration.UI.DungenBoxBagUI;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DungeonExploManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.dungeon.TheseusDungeonModel;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.manager.TempleteManager;
   
   public class DungenBoxBagView extends DungenBoxBagUI
   {
      
      private var _panel:ScrollPanel;
      
      private var _panelList:SimpleTileList;
      
      private var _itemList:Array = [];
      
      private var _tName2:GradientText;
      
      private var _pro:Bitmap;
      
      private var _desTxt:FilterFrameText;
      
      private var _desPanel:ScrollPanel;
      
      private var _reg:RegExp = /[0-9%]+/g;
      
      public function DungenBoxBagView()
      {
         super();
         addView();
         updateView();
      }
      
      private function addView() : void
      {
         _panel = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skBagPanel");
         _panelList = ComponentFactory.Instance.creatCustomObject("ui.thessbox.skBagList",[4]);
         _tName2 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skNameTxt2");
         _pro = ComponentFactory.Instance.creatBitmap("asset.thessbox.proFt");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skdesBigTxt");
         _desPanel = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skDesBigPanel");
         _tName2.y = 60;
         _panel.y = 86;
         _desPanel.y = 42;
         _desPanel.height = 352;
         _panel.setView(_panelList);
         _desPanel.setView(_desTxt);
         addChild(_tName2);
         addChild(_panel);
         addChild(_pro);
         addChild(_desPanel);
         _tName2.text = LanguageMgr.GetTranslation("thessbox.skT2");
      }
      
      public function updateView() : void
      {
         var _loc9_:DungenBoxSkillCell = null;
         var _loc5_:int = 0;
         var _loc8_:Array = null;
         var _loc11_:SkillPropertyTempInfo = null;
         var _loc4_:int = 0;
         _loc4_ = 36;
         var _loc6_:Boolean = false;
         var _loc10_:int = 0;
         _panelList.beginChanges();
         var _loc13_:int = int(model.skillIdList.length);
         var _loc7_:int = 0;
         var _loc16_:String = "";
         var _loc2_:Dictionary = new Dictionary();
         var _loc14_:Dictionary = new Dictionary();
         var _loc15_:Array = [];
         var _loc3_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc13_)
         {
            _loc5_ = int(model.skillIdList[_loc7_]);
            _loc11_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc5_);
            if(_loc11_)
            {
               _loc8_ = _loc11_.allAttName;
               for each(var _loc1_:String in _loc8_)
               {
                  if(_loc11_.AddType == 0)
                  {
                     if(_loc14_[_loc1_])
                     {
                        var _loc17_:* = _loc1_;
                        var _loc18_:* = _loc14_[_loc17_] + _loc11_[_loc1_];
                        _loc14_[_loc17_] = _loc18_;
                     }
                     else
                     {
                        _loc14_[_loc1_] = _loc11_[_loc1_];
                        if(_loc15_.indexOf(_loc1_) == -1)
                        {
                           _loc15_.push(_loc1_);
                        }
                     }
                  }
                  else if(_loc11_.AddType == 1)
                  {
                     if(_loc2_[_loc1_])
                     {
                        _loc18_ = _loc1_;
                        _loc17_ = _loc2_[_loc18_] + _loc11_[_loc1_];
                        _loc2_[_loc18_] = _loc17_;
                     }
                     else
                     {
                        _loc2_[_loc1_] = _loc11_[_loc1_];
                        if(_loc15_.indexOf(_loc1_) == -1)
                        {
                           _loc15_.push(_loc1_);
                        }
                     }
                  }
               }
               _loc3_.push(_loc5_);
            }
            else
            {
               _loc3_.push(_loc5_);
            }
            _loc7_++;
         }
         _loc13_ = int(_loc3_.length);
         _loc7_ = 0;
         while(_loc7_ < 36)
         {
            _loc9_ = new DungenBoxSkillCell(2);
            if(_loc7_ < _loc13_)
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
         for each(var _loc12_:String in _loc15_)
         {
            _loc6_ = false;
            _loc10_ = int(_loc2_[_loc12_]);
            if(_loc10_ != 0)
            {
               _loc6_ = true;
               _loc16_ += AttributeUtils.getAtrributeByKey(_loc12_,_loc10_,"#00FF00");
            }
            _loc10_ = int(_loc14_[_loc12_]);
            if(_loc10_ != 0)
            {
               if(_loc6_)
               {
                  _loc16_ += AttributeUtils.getColorStr(_loc10_ > 0 ? ",+" + _loc10_ + "%" : "," + _loc10_ + "%","#00FF00") + "\n\n";
               }
               else
               {
                  _loc16_ += AttributeUtils.getAtrributeByKey(_loc12_,_loc14_[_loc12_],"#00FF00","%") + "\n\n";
               }
            }
            else if(_loc6_)
            {
               _loc16_ += "\n\n";
            }
         }
         _desTxt.htmlText = _loc16_;
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
      
      private function get model() : TheseusDungeonModel
      {
         return DungeonExploManager.instance.model;
      }
      
      override public function dispose() : void
      {
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
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

