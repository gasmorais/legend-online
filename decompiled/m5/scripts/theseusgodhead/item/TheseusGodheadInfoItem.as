package theseusgodhead.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class TheseusGodheadInfoItem extends Sprite
   {
      
      protected var _sontype:int;
      
      protected var _infoName:FilterFrameText;
      
      protected var _infoTVbox:VBox;
      
      protected var _infoVvbox:VBox;
      
      protected var _totalVbox:VBox;
      
      protected var _infoDes:FilterFrameText;
      
      protected var _infoNext:FilterFrameText;
      
      public function TheseusGodheadInfoItem(param1:int)
      {
         super();
         _sontype = param1;
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _infoName = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoName");
         _infoTVbox = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoTVbox");
         _infoVvbox = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoVvbox");
         _totalVbox = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.totalVbox");
         _infoDes = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoDes");
         _infoNext = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoNext");
         addChild(_infoName);
         addChild(_totalVbox);
      }
      
      protected function initData() : void
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
         var _loc2_:FilterFrameText = null;
         var _loc4_:int = 0;
         _infoName.text = LanguageMgr.GetTranslation("theseusgodhead.allAdd");
         var _loc3_:Array = ["攻击{invalid_utf8=229}{invalid_utf8=138}?","防御{invalid_utf8=229}{invalid_utf8=138}?","生命{invalid_utf8=229}{invalid_utf8=128}?"];
         var _loc1_:Array = [100,50,200];
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
         var _loc2_:FilterFrameText = null;
         var _loc4_:int = 0;
         _infoName.text = LanguageMgr.GetTranslation("theseusgodhead.allRewardAdd");
         var _loc3_:Array = ["{invalid_utf8=230}{invalid_utf8=138}?能伤{invalid_utf8=229}{invalid_utf8=174}?","暴击{invalid_utf8=231}{invalid_utf8=142}?"];
         var _loc1_:Array = [20,5];
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
         _infoDes.htmlText = "神格石板奖励描述";
         _infoDes.height = _infoDes.numLines * 18;
         _totalVbox.addChild(_infoDes);
         _infoNext.text = LanguageMgr.GetTranslation("theseusgodhead.allNextReward",5);
         _totalVbox.addChild(_infoNext);
         _totalVbox.commitChanges();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_infoName);
         ObjectUtils.disposeObject(_infoTVbox);
         ObjectUtils.disposeObject(_infoVvbox);
         ObjectUtils.disposeObject(_totalVbox);
         ObjectUtils.disposeObject(_infoDes);
         ObjectUtils.disposeObject(_infoNext);
         _infoName = null;
         _infoTVbox = null;
         _infoVvbox = null;
         _totalVbox = null;
         _infoDes = null;
         _infoNext = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

