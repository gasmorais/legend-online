package magicspring
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import magicspring.item.MagicSpringFormulaLeftItem;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringModel;
   import utils.LogicUtils;
   import yishi.datas.templates.MagicSpringFormulaTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.PageBar;
   
   public class MagicSpringFormulaLeftView extends Component
   {
      
      private var _pageBar:PageBar;
      
      private var _itemVbox:VBox;
      
      private var itemList:Vector.<MagicSpringFormulaLeftItem>;
      
      private var curPageData:Array;
      
      public function MagicSpringFormulaLeftView()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("MagicSpringFormulaLeftView.pageBar");
         _itemVbox = ComponentFactory.Instance.creatComponentByStylename("MagicSpringFormulaLeftView.itemVbox");
         addChild(_itemVbox);
         addChild(_pageBar);
         _pageBar.mouseEnabled = false;
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MagicSpringFormulaLeftItem = null;
         var _loc3_:Array = TempleteManager.instance.magicSpringTempCate.getTemplatesArray();
         _pageBar.setAutoPagingData(_loc3_,4);
         _pageBar.setCurPage(1);
         curPageData = _pageBar.getCurPageDatas();
         if(curPageData.length > 0)
         {
            model.selectFormula = curPageData[0];
         }
         itemList = new Vector.<MagicSpringFormulaLeftItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new MagicSpringFormulaLeftItem();
            _loc1_.data = curPageData[_loc2_];
            _itemVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         _itemVbox.commitChanges();
      }
      
      private function addEvent() : void
      {
         _pageBar.addEventListener("change",_pageChangeHandler);
         MsgMan.addObserver("SELECT_FORMULA_CHANGE",this,__selectFormulaItemHandler);
      }
      
      private function removeEvent() : void
      {
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",_pageChangeHandler);
         }
         MsgMan.removeObserver("SELECT_FORMULA_CHANGE",this,__selectFormulaItemHandler);
      }
      
      private function _pageChangeHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:MagicSpringFormulaLeftItem = null;
         var _loc2_:Array = _pageBar.getCurPageDatas();
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = itemList[_loc4_];
            _loc3_.data = _loc2_[_loc4_];
            _loc4_++;
         }
      }
      
      private function __selectFormulaItemHandler(param1:String, param2:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:MagicSpringFormulaLeftItem = null;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = itemList[_loc4_];
            if(_loc3_.data && model.selectFormula && _loc3_.data.TemplateId == model.selectFormula.TemplateId)
            {
               _loc3_.select = true;
            }
            else
            {
               _loc3_.select = false;
            }
            _loc4_++;
         }
      }
      
      private function get model() : MagicSpringModel
      {
         return MagicSpringManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_itemVbox);
         _itemVbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

