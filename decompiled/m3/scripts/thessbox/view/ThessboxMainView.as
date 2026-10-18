package thessbox.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.ThessBoxInfo;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   import yishi.view.base.HRollItemPanel;
   
   public class ThessboxMainView extends Sprite
   {
      
      private var maxNum:int;
      
      private var _numTxt:FilterFrameText;
      
      private var _hRoll:HRollItemPanel;
      
      private var _itemList:Array = [];
      
      public function ThessboxMainView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:ThessBoxCapterItem = null;
         var _loc4_:int = 0;
         maxNum = TempleteManager.instance.getConfigValue("Storehouse_count");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.numTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.numTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.numTxt");
         _hRoll = ComponentFactory.Instance.creatCustomObject("ui.thessbox.mainRoll");
         _hRoll.initParams("ui.thessbox.mainRollHbox","ui.thessbox.chapter.leftBtn","ui.thessbox.chapter.rightBtn",3,265,435);
         addChild(_hRoll);
         addChild(_numTxt);
         var _loc3_:Array = TempleteManager.instance.thessBoxCate.getAllCapters();
         var _loc2_:int = int(_loc3_ ? _loc3_.length : 0);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = new ThessBoxCapterItem();
            _loc1_.data = _loc3_[_loc4_];
            _itemList.push(_loc1_);
            _loc4_++;
         }
         _hRoll.updateList(_itemList);
      }
      
      public function updateView() : void
      {
         var _loc3_:ThessBoxCapterItem = null;
         var _loc4_:int = 0;
         var _loc1_:ThessBoxInfo = TheseussoulManager.Instance.thessboxOutInfo;
         var _loc2_:int = maxNum - _loc1_.count;
         _loc2_ = int(_loc2_ < 0 ? 0 : _loc2_);
         _numTxt.htmlText = LanguageMgr.GetTranslation("thessbox.leftTime",_loc2_,maxNum);
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            _loc3_ = _itemList[_loc4_];
            _loc3_.updateView(_loc1_,maxNum);
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_hRoll);
         _hRoll = null;
      }
   }
}

