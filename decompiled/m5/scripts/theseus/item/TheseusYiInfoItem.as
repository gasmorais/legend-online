package theseus.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusYiCellInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TheseusRageSuiteTempInfo;
   import yishi.datas.templates.TheseusRageTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   
   public class TheseusYiInfoItem extends TheseusInfoItem
   {
      
      private var _allInfo:TheseusRageTempInfo = new TheseusRageTempInfo();
      
      public function TheseusYiInfoItem(param1:int)
      {
         super(param1);
      }
      
      override protected function initData() : void
      {
         if(_sontype == 1)
         {
            showAllInfos();
         }
         else
         {
            showRewards();
         }
      }
      
      private function showAllInfos() : void
      {
         var _loc5_:TheseusYiCellInfo = null;
         var _loc7_:TheseusRageTempInfo = null;
         var _loc2_:FilterFrameText = null;
         _infoName.text = LanguageMgr.GetTranslation("theseus.yi.allAdd");
         var _loc6_:Array = model.yiDic.getList();
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc4_];
            _loc7_ = TempleteManager.instance.theseusRageTempCate.getOneTempInfo(_loc5_.pos,_loc5_.level);
            _allInfo.add(_loc7_);
            _loc4_++;
         }
         var _loc3_:Array = _allInfo.attNames;
         var _loc1_:Array = _allInfo.attValues;
         _totalVbox.beginChanges();
         _infoTVbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoTName");
            _loc2_.text = _loc3_[_loc4_];
            _infoTVbox.addChild(_loc2_);
            _loc4_++;
         }
         _infoTVbox.commitChanges();
         _infoVvbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoVaule");
            _loc2_.text = "" + _loc1_[_loc4_];
            _infoVvbox.addChild(_loc2_);
            _loc4_++;
         }
         _infoVvbox.commitChanges();
         _totalVbox.commitChanges();
      }
      
      private function showRewards() : void
      {
         var _loc15_:TheseusYiCellInfo = null;
         var _loc9_:SkillPropertyTempInfo = null;
         var _loc16_:String = null;
         var _loc10_:int = 0;
         var _loc5_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:String = null;
         var _loc1_:Array = null;
         var _loc2_:FilterFrameText = null;
         _infoName.text = LanguageMgr.GetTranslation("theseus.yi.allRewardAdd");
         var _loc8_:Array = model.yiDic.getList();
         var _loc6_:int = 0;
         var _loc13_:int = 99999;
         _loc6_ = 0;
         while(_loc6_ < _loc8_.length)
         {
            _loc15_ = _loc8_[_loc6_];
            if(_loc15_.level < _loc13_)
            {
               _loc13_ = int(_loc15_.level);
               if(_loc13_ == 0)
               {
                  break;
               }
            }
            _loc6_++;
         }
         var _loc3_:Array = TempleteManager.instance.theseusRageSuitTempCate.getTempInfo(_loc13_);
         var _loc14_:TheseusRageSuiteTempInfo = _loc3_[0] != null ? _loc3_[0] : _loc3_[1];
         var _loc4_:TheseusRageSuiteTempInfo = _loc3_[1];
         if(_loc3_[0] == null)
         {
            this.filters = [UIFilter.getGrayFilter()];
         }
         else
         {
            this.filters = null;
         }
         var _loc7_:SkillTempInfo = TempleteManager.instance.skillTemplateDic[_loc14_.SkillId];
         if(_loc7_)
         {
            _loc9_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc7_.TemplateId);
            if(_loc9_)
            {
               _loc5_ = [];
               _loc11_ = [];
               _loc1_ = _loc9_.hasValueAtt.concat(_loc9_.hasKanAtt);
               _loc6_ = 0;
               while(_loc6_ < _loc1_.length)
               {
                  _loc12_ = _loc1_[_loc6_];
                  _loc16_ = AttributeUtils.getAttributeName(_loc12_);
                  _loc10_ = int(_loc9_[_loc12_]);
                  _loc5_.push(_loc16_);
                  _loc11_.push(_loc10_);
                  _loc6_++;
               }
               _totalVbox.beginChanges();
               _infoTVbox.beginChanges();
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoTName");
                  _loc2_.text = _loc5_[_loc6_];
                  _infoTVbox.addChild(_loc2_);
                  _loc6_++;
               }
               _infoTVbox.commitChanges();
               _infoVvbox.beginChanges();
               _loc6_ = 0;
               while(_loc6_ < _loc11_.length)
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoVaule");
                  _loc2_.text = "" + _loc11_[_loc6_];
                  _infoVvbox.addChild(_loc2_);
                  _loc6_++;
               }
               _infoVvbox.commitChanges();
               if(_loc7_.Description != null && _loc7_.Description.length > 1)
               {
                  _infoDes.htmlText = _loc7_.Description;
                  _infoDes.height = _infoDes.numLines * 18;
                  _totalVbox.addChild(_infoDes);
               }
               if(_loc4_ && _loc4_ != _loc3_[0])
               {
                  _infoNext.text = LanguageMgr.GetTranslation("theseus.yi.allNextReward",_loc4_.MinLevel);
                  _totalVbox.addChild(_infoNext);
               }
               _totalVbox.commitChanges();
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _allInfo = null;
      }
   }
}

