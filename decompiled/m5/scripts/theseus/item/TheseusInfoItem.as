package theseus.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusSuitInfo;
   import mvc.module.theseus.TheseussoulModel;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TheseusEquipSuiteTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   
   public class TheseusInfoItem extends Sprite
   {
      
      public var _infoTitleBg:Bitmap;
      
      public var _infoName:FilterFrameText;
      
      public var _infoTVbox:VBox;
      
      public var _infoVvbox:VBox;
      
      public var _infoDes:FilterFrameText;
      
      public var _infoNext:FilterFrameText;
      
      protected var _totalVbox:VBox;
      
      protected var _sontype:int;
      
      public function TheseusInfoItem(param1:int)
      {
         super();
         _sontype = param1;
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _infoTitleBg = ComponentFactory.Instance.creatBitmap("asset.thteseus.infoTitleBg");
         _infoName = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoName");
         _infoTVbox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.infoTVbox");
         _infoVvbox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.infoVvbox");
         _infoDes = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoDes");
         _infoNext = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoNext");
         _totalVbox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.totalVbox");
         var _loc1_:Sprite = new Sprite();
         addChild(_infoTitleBg);
         addChild(_infoName);
         addChild(_totalVbox);
         _loc1_.addChild(_infoTVbox);
         _loc1_.addChild(_infoVvbox);
         _totalVbox.addChild(_loc1_);
      }
      
      protected function initData() : void
      {
         var _loc20_:String = null;
         var _loc14_:int = 0;
         var _loc16_:String = null;
         var _loc2_:Array = null;
         var _loc12_:int = 0;
         var _loc23_:int = 0;
         var _loc21_:int = 0;
         var _loc10_:SkillTempInfo = null;
         var _loc13_:SkillPropertyTempInfo = null;
         var _loc3_:FilterFrameText = null;
         var _loc5_:TheseusEquipSuiteTempInfo = null;
         _totalVbox.beginChanges();
         var _loc8_:TheseusSuitInfo = model.suitInfo;
         var _loc1_:int = int(model.currSuitIdx);
         var _loc6_:Array = _loc8_.getSuitArray(_loc1_);
         var _loc19_:Array = _loc8_.getParts(_sontype);
         var _loc22_:Array = _loc8_.getSuitArray(_loc1_);
         var _loc11_:int = int(_loc8_.getOneSuitMinLv(_loc1_,_sontype));
         var _loc7_:Array = [];
         var _loc15_:Array = [];
         var _loc9_:int = 0;
         var _loc17_:int = int(_loc19_.length);
         _loc9_ = 0;
         while(_loc9_ < _loc17_)
         {
            _loc23_ = int(_loc19_[_loc9_]);
            if(int(_loc22_[_loc23_]) > 0)
            {
               _loc12_++;
            }
            _loc9_++;
         }
         var _loc4_:Array = TempleteManager.instance.theseusEquipSuitCate.getTempInfo(_loc1_,_sontype,_loc11_);
         var _loc18_:TheseusEquipSuiteTempInfo = _loc4_[0] != null ? _loc4_[0] : _loc4_[1];
         if(_loc18_)
         {
            if(_loc12_ == _loc17_ && _loc11_ >= _loc18_.NeedMinLevel)
            {
               this.filters = null;
               _loc21_ = 1;
            }
            else
            {
               this.filters = [UIFilter.getGrayFilter()];
            }
            _infoName.text = _loc18_.SuiteName + "(" + _loc12_ + "/" + _loc17_ + ")";
            _loc10_ = TempleteManager.instance.skillTemplateDic[_loc18_.SkillId];
            if(_loc10_)
            {
               _loc13_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc10_.TemplateId);
               if(_loc13_)
               {
                  _loc2_ = _loc13_.hasValueAtt.concat(_loc13_.hasKanAtt);
                  _loc9_ = 0;
                  while(_loc9_ < _loc2_.length)
                  {
                     _loc16_ = _loc2_[_loc9_];
                     _loc20_ = AttributeUtils.getAttributeName(_loc16_);
                     _loc14_ = int(_loc13_[_loc16_]);
                     _loc7_.push(_loc20_);
                     _loc15_.push(_loc14_);
                     _loc9_++;
                  }
                  _infoTVbox.beginChanges();
                  _loc9_ = 0;
                  while(_loc9_ < _loc7_.length)
                  {
                     _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoTName");
                     _loc3_.text = _loc7_[_loc9_];
                     _infoTVbox.addChild(_loc3_);
                     _loc9_++;
                  }
                  _infoTVbox.commitChanges();
                  _infoVvbox.beginChanges();
                  _loc9_ = 0;
                  while(_loc9_ < _loc15_.length)
                  {
                     _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoVaule");
                     _loc3_.text = "" + _loc15_[_loc9_];
                     _infoVvbox.addChild(_loc3_);
                     _loc9_++;
                  }
                  _infoVvbox.commitChanges();
                  if(_loc10_.Description != null && _loc10_.Description.length > 1)
                  {
                     _infoDes.htmlText = _loc10_.Description;
                     _infoDes.height = _infoDes.numLines * 18;
                     _totalVbox.addChild(_infoDes);
                  }
                  _loc5_ = _loc4_[1];
                  _totalVbox.addChild(_infoNext);
                  if(_loc5_)
                  {
                     if(_loc5_ != _loc4_[0])
                     {
                        if(_loc21_ == 1)
                        {
                           _infoNext.text = LanguageMgr.GetTranslation("theseus.equip.suitNextTip2",_loc5_.NeedMinLevel);
                        }
                        else
                        {
                           _infoNext.text = LanguageMgr.GetTranslation("theseus.equip.suitNextTip1",_loc5_.NeedMinLevel);
                        }
                     }
                     else
                     {
                        _infoNext.text = LanguageMgr.GetTranslation("theseus.equip.suitNextTip3");
                     }
                  }
                  else
                  {
                     _infoNext.text = LanguageMgr.GetTranslation("theseus.equip.suitNextTip3");
                  }
               }
            }
         }
         _totalVbox.commitChanges();
      }
      
      protected function get model() : TheseussoulModel
      {
         return TheseussoulManager.Instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_infoTitleBg);
         _infoTitleBg = null;
         ObjectUtils.disposeObject(_infoName);
         _infoName = null;
         ObjectUtils.disposeObject(_infoTVbox);
         _infoTVbox = null;
         ObjectUtils.disposeObject(_infoVvbox);
         _infoVvbox = null;
         ObjectUtils.disposeObject(_infoDes);
         _infoDes = null;
         ObjectUtils.disposeObject(_infoNext);
         _infoNext = null;
         ObjectUtils.disposeObject(_totalVbox);
         _totalVbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

