package theseusgodhead
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import theseus.item.TheseusInfoItem;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseusHeadInfoItem extends TheseusInfoItem
   {
      
      public function TheseusHeadInfoItem(param1:int)
      {
         super(param1);
      }
      
      override protected function initData() : void
      {
         showAllInfos();
      }
      
      private function showAllInfos() : void
      {
         var _loc6_:Array = null;
         var _loc11_:Array = null;
         var _loc2_:FilterFrameText = null;
         var _loc13_:String = null;
         var _loc5_:Array = null;
         var _loc1_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:FilterFrameText = null;
         var _loc14_:TheseusGodheadStoneInfo = null;
         var _loc3_:SkillTempInfo = null;
         var _loc12_:Array = null;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         if(_sontype == 1)
         {
            _infoName.text = LanguageMgr.GetTranslation("theseus.yi.allAdd");
            _loc6_ = TheseussoulManager.Instance.modelGodhead.attNames;
            _loc11_ = TheseussoulManager.Instance.modelGodhead.attValues;
            _totalVbox.beginChanges();
            _infoTVbox.beginChanges();
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoTName");
               _loc2_.text = _loc6_[_loc8_];
               _infoTVbox.addChild(_loc2_);
               _loc8_++;
            }
            _infoTVbox.commitChanges();
            _infoVvbox.beginChanges();
            _loc8_ = 0;
            while(_loc8_ < _loc11_.length)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoVaule");
               _loc2_.text = "" + _loc11_[_loc8_];
               _infoVvbox.addChild(_loc2_);
               _loc8_++;
            }
            _infoVvbox.commitChanges();
            _totalVbox.commitChanges();
         }
         else
         {
            _infoName.text = LanguageMgr.GetTranslation("theseusgodhead.txt21");
            _loc13_ = "";
            _totalVbox.beginChanges();
            _loc5_ = TheseussoulManager.Instance.modelGodhead.getEquipedStoneInfo();
            _loc1_ = int(_loc5_.length);
            _loc9_ = 0;
            _infoTVbox.beginChanges();
            _loc8_ = 0;
            while(_loc8_ < _loc1_)
            {
               _loc14_ = _loc5_[_loc8_];
               if(_loc14_)
               {
                  _loc12_ = _loc14_.SkillID;
                  _loc7_ = int(_loc12_.length);
                  _loc10_ = 0;
                  while(_loc10_ < _loc7_)
                  {
                     _loc3_ = TempleteManager.instance.getSkillById(_loc12_[_loc10_]);
                     if(_loc3_)
                     {
                        _loc4_ = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoTName");
                        _loc4_.wordWrap = true;
                        _loc4_.width = 230;
                        _loc4_.text = _loc3_.Description;
                        _loc4_.height = _loc4_.textHeight + 10;
                        _infoTVbox.addChild(_loc4_);
                     }
                     _loc10_++;
                  }
               }
               _loc8_++;
            }
            _infoTVbox.x = 10;
            _infoTVbox.y = 5;
            _infoTVbox.commitChanges();
            _totalVbox.addChild(_infoNext);
            _totalVbox.commitChanges();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

